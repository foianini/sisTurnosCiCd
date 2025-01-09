//IMPORTAMOS LOS MODULOS NECESARIOS
const session = require('express-session');
const MySQLStore = require('express-mysql-session')(session);
const si = require('systeminformation');
const promClient = require('prom-client');
const os = require('os');
const fs = require('fs');
const logTxt = './log.txt';
const express = require('express');
//const session = require('express-session');
const https = require('https');
const pool = require('./keys');
const {database} = require('./keys');
const socketIo = require('socket.io');
const cors = require('cors');
const exphbs = require('express-handlebars');
const http = require('http');
const path = require('path');
const axios = require('axios');
const flash = require('connect-flash');
//CONFIGURACION DE PROMETHEUS
const register = new promClient.Registry();
const regErrorTxt ='./error.txt';
var archivoCalenturaSys = ('/sys/class/thermal/thermal_zone0/temp');
const { exec } = require('child_process');

const reiniciarServer =() =>{ exec('pm2 restart equipoRb', (error, stdout, stderr) =>{
        if(error){
		console.log('no reinicion por que --> '+error);
	}else{
	      
           console.log('reiniciando');
	}
}); };

//REGISTRO DE ERRORES EN EL LOG.TXT--------------------------->
const apagarEquipo = ()=>{
  server.close(()=>{
    process.exit(0);
  });
};
const regError = (errorLog)=>{
	fs.appendFile(regErrorTxt,errorLog,(err)=>{
           if(err){
	     return(err);
	   }else{
             console.log('exito regError');
	   };
	});
};

//FUNCION PARA VER LA TEMPERATURA DEL DISPOSITIVO ----------------->
function  verCalentura (){
    fs.readFile(archivoCalenturaSys,(err,resultado)=>{
       if(resultado){
          resultado = resultado / 1000;
	  if(resultado > 50){
	     let fechaError = new Date();
	     console.log('antes');
	     regError('demasiado caliente, apagando... fecha: ' +  fechaError +  `\n` );
             //setTimeout(apagarEquipo,200);
	  };
       }else{
          console.log(err);
       };
    });
};


//FUNCION PARA ACTUALIZAR Y ENVIAR METRICAS------------------------->
async function actualizarMetricas(){
	try{
	   verCalentura();
	   const monitor = 'http://192.168.30.46:4000/acontecimientoReg/registro/';
	   const memoriaTotal = os.totalmem();
	   const memoriaUsada = process.memoryUsage();
           const porcentaje = ((memoriaUsada.rss/memoriaTotal)*100).toFixed(2);
	   var metricas = {};
	   //var fechaError = new Date();
           var fechaMetrica = new Date();
	       fechaMetrica = formatearFechaHora(fechaMetrica);
	   metricas.tipoError = 'nuevaConexion';
           fs.readFile(archivoCalenturaSys,async(err,resultado)=>{
              if(err){
                console.log(err);
	      }else{
		//console.log(session);
		metricas.ipRb = session.ip;
		metricas.macRb = session.macAddress;
		metricas.hostName = session.hostName;
                metricas.calentura = resultado / 1000;
		metricas.memoriaUsada = (memoriaUsada.rss/(1024)**3).toFixed(2);
		metricas.totalMemoria = (memoriaTotal / (1024)**3).toFixed(2);
		metricas.porcentajeMemoria = (metricas.memoriaUsada/metricas.totalMemoria)*100;
		console.log(metricas.porcentajeMemoria);
		if(metricas.calentura > 50){
		  console.log('calentura --> '+ metricas.calentura);
	          let fechaError = new Date();
                  fechaError = formatearFechaHora(fechaError);
		  metricas.acontecimiento ='se apago';
		   regError('apagando por calentamiento ' + fechaError + `\n`);
		   metricas.tipoError = 'calentura';
		  // setTimeout(apagarEquipo,200);
                }
		if(metricas.memoriaUsada > (metricas.totalMemoria / 2)){
                   fechaError = formatearFechaHora(fechaError);
		   metricas.tipoError ='usoAltoRam';
		   regError('cuidado, uso alto de  ram ' + fechaError + `\n`);
		   //setTimeout(apagarEquipo,200);
		};
		if(metricas.porcentajeMemoria > 3){
		   metricas.tipoError='apagadoRam';
		  // fechaError = formatearFechaHora(fechaError);
		   regError('apagando servidor por saturacion de ram ' + fechaMetrica + `\n`);
		   apagarEquipo();
		};
		metricas.fechaAct = fechaMetrica;
		if(metricas.tipoError === 'nuevaConexion'){
                //console.log('metricas-----------------------' + metricas);
                metricas.acontecimiento = 'cambio de ip';
		};
		console.log('metricas--------------------------------------' + JSON.stringify(metricas) );
	        await axios ({
                   method:'post',
		   url: monitor,
		   data:metricas
		}).catch(error => {
                   console.log('falla envio de metricas a monitor por : ' + error);
		})

	      };
	   });
	    
	}catch(error){
          console.log('error -- ' + error );
	};
};
setInterval(actualizarMetricas,15000);


//VARIABLE CON FECHA ACTUAL Y FUNCION PARA DARLE FORMATO 

function formatearFechaHora(date) {
    const año = date.getFullYear();
    const mes = String(date.getMonth() + 1).padStart(2, '0'); // Meses empiezan desde 0
    const día = String(date.getDate()).padStart(2, '0');
    const horas = String(date.getHours()).padStart(2, '0');
    const minutos = String(date.getMinutes()).padStart(2, '0');
    const segundos = String(date.getSeconds()).padStart(2, '0');

    return `${año}-${mes}-${día} ${horas}:${minutos}:${segundos}`;
};


//REGISTRO DEL LOG  IP

const regLog =  async (info,update) => { 
  const actualizarDb = {
    EquiposClinicaFechaActualizaci : update.fecha,
    EquiposClinicaEstado : update.conexion,
  }
  
  var fechaActual = new Date();
	fechaActual = formatearFechaHora(fechaActual);
  fs.appendFile( logTxt, info, async (err) =>{
    
     if (err){
       return(err);
     }else{
       const registro = { ipRb:session.ip, tipoError: 'nuevaConexion', macRb : session.macAddress, hostName: session.hostName, fechaAct:fechaActual};
       console.log('-------- registroDis --------' +  JSON.stringify(registro));
       try{
	  await axios({
            method:'post',
	    url:'http://192.168.30.46:4000/acontecimientoReg/registroDis/',
	    data:registro
	    
	  }).catch(error =>{
             console.log('error primer registro en monitor por : '+ error);
	  });
	       
	  console.log(session);
          await pool.query('update equiposCli set  ?  where equiposClinicaMacaddress = ?',[actualizarDb,update.mac]);
          console.log('actualizo');
        }catch(error){
          console.log('noActualizo '+error);
       }
      }
   });
};

//LEVANTANDO VSERVER

const app = express();
const server = http.createServer(app);
const io = socketIo(server);

//SETEANDO CORS ALLOW ORIGIN

app.use(cors({
   origin: '*',
}));

app.set('port', process.env.PORT || 4000);
app.set('views', path.join(__dirname, 'views'));
app.engine('.hbs', exphbs.engine({
	layout: 'main',
	layoutsDir: path.join(app.get('views'), 'layouts'),
	partialsDir: path.join(app.get('views'), 'partials'),
	helpers: require('./helpers'),
	extname:'.hbs',

}));



//CONFIGURACION DE SESSIONES EN LA BASE DE DATOS ---------------->

const sessionStore = new MySQLStore({},pool);

app.use(session({
	secret: 'cualquierCosa',
	resave: false,
	saveUninitialized: true,
	store: sessionStore
}));

app.use(flash());
app.use((req,res,next)=>{
  app.locals.message = req.flash('message'),
  next();
});

app.use(require("./routes/prueba")(io));
app.use(express.static(path.join(__dirname, './public')));
app.set('view engine','.hbs');


//INFO VSERVER -------------------------------------------

 server.listen(app.get('port'),()=>{
   console.log('vservidor en puerto : ', app.get('port'));
   actualizarMetricas();
});
//RUTAS----------------------------------------------------

//app.use(require("./routes/prueba"));


//DETECCION DE IP - MACADDRES - HOSTNAME  RB
const ifaces = os.networkInterfaces();
Object.keys(ifaces).forEach(function async (ifname) {
   //variable guarda la informacion de las interfaces
    var aux = (ifaces[ifname]);
   //iteramos sobre las interfaces buscando la que tiene conexion y sea ipv4
    aux.forEach( function async (minhaIp){
    if (minhaIp.internal === false &&  minhaIp.family === 'IPv4' ) {
	//guardamos la informacion ip y mac del rapsberry en una local sesion
         session.macAddress = minhaIp.mac;
	 session.hostName = os.hostname();
	 session.ip = minhaIp.address;
         session.rev = 0;
	 session.conexion = 0;
	 console.log('IP : ' + session.ip + '  Mac : ' + session.macAddress);
         return;
   }
  });
});

//REGISTRANDO INFO EN SESSION DE FORMA GLOBAL
const infoEnSession = ('HOST : ' +  session.hostName + ' //  IP : ' + session.ip + ' //  MAC : ' + session.macAddress  );

//REGISTRO DE LA IP Y MAC EN DB
(async  function ingresar(){
    const equiposClinicaDescripcion = session.hostName;
    const equiposClinicaMacAddress = session.macAddress;
    const equiposClinicaIp = session.ip;
    const equiposClinicaEstado = 'conectado';
    const equiposClinicaFecha  = new Date();
    const novo = {equiposClinicaMacAddress, equiposClinicaIp, equiposClinicaDescripcion, equiposClinicaEstado};
    // variable trae la informacion de esa mac en la tabla
    const verificar = await pool.query('select equiposClinicaMacAddress from equiposCli where equiposClinicaMacaddress = ?',[equiposClinicaMacAddress]);
	//verificamos si la mac ya tiene registro )
	  if (verificar[0].length === 0 ){
	    await  pool.query('insert into equiposCli set  ?',[novo]);      
	    console.log('fue agregado' + novo);
         //si ya tiene  modificamos  ip        
	  }else{
            console.log('verifica');
            await pool.query('update equiposCli set equiposClinicaIp = ?  where equiposClinicaMacaddress = ?',[equiposClinicaIp,equiposClinicaMacAddress]);   
          }
  return;
 })();


//COMPROBAR SI LA RB  TIENE CONEXION A INTERNET
const url = 'https://www.google.com/'; 
( async function comprobarConexion(){
//seteamos intervalo de tiempo para la funcion que hace ping a la url
   setInterval( async ()=>{
      https.get(url, async (res)=>{
       if (res.statusCode >= 200 && res.statusCode < 300){
        if( session.conexion === 0 ){
	    try{
	      let fechaActual = new Date(); 
	      let fechaActualFormato = formatearFechaHora(fechaActual);
              session.conexion = 1;
              session.rev = 0;
	      const update = { conexion:'conectado', mac: session.macAddress, fecha:fechaActualFormato };
              const conectadoLog =( infoEnSession + ' // FECHA-REV : ' + fechaActualFormato + `\n` );
              regLog(conectadoLog,update);
            }catch(e){
                console.log(' tiene conexion pero : ' + e );	  
            };
         }
	 }}).on('error', (e) => {
          if(session.rev === 0){
          session.conexion = 0;
          let fechaActual = new Date();
          let fechaActualFormato = formatearFechaHora(fechaActual);
          const update = { conexion:'desconectado',  mac: session.macAddress, fecha:fechaActualFormato };
          const desconectadoLog = ( infoEnSession + ' // FECHA-CAIDA : ' + fechaActualFormato + `\n`);
          session.rev = 1;
          regLog(desconectadoLog,update).then(result => {
            console.log('sin internet  - actualizo datos correctamente en el log.txt');
        }).catch(error => {
            console.error('Error en ctualizar datos del log.txt:', error);
        });
        };
       });
  },1200);
  return;
})();


