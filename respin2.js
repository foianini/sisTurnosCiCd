const express = require('express');
const http = require('http');
const os = require('os');
const fs = require('fs');
const session = require('express-session');
const MySQLStore = require('express-mysql-session')(session);
const { Server } = require('socket.io');
const Singleton = require('./singleton');
const cors = require('cors');
const exphbs = require('express-handlebars');
const path = require('path');
const axios = require('axios');
const flash = require('connect-flash');
const regErrorTxt ='./error.txt';
var archivoCalenturaSys = ('/sys/class/thermal/thermal_zone0/temp');
const { exec } = require('child_process');
const https = require('https');
const pool = require('./keys');
const pantallaRouter = require('./routes/prueba');

//FUNCION PARA REINICIAR SERVIDOR CON PM2 --------------------------------------------->

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





//VARIABLE CON FECHA ACTUAL Y FUNCION PARA DARLE FORMATO 

function formatearFechaHora(date) {
    const anho = date.getFullYear();
    const mes = String(date.getMonth() + 1).padStart(2, '0'); // Meses empiezan desde 0
    const dia = String(date.getDate()).padStart(2, '0');
    const horas = String(date.getHours()).padStart(2, '0');
    const minutos = String(date.getMinutes()).padStart(2, '0');
    const segundos = String(date.getSeconds()).padStart(2, '0');

    return `${anho}-${mes}-${dia} ${horas}:${minutos}:${segundos}`;
};


 //FUNCION PARA ACTUALIZAR Y ENVIAR METRICAS------------------------->
async function actualizarMetricas(){
	try{
	   verCalentura();
	   const memoriaTotal = os.totalmem();
	   const memoriaUsada = process.memoryUsage();
	   var metricas = {};
           var fechaMetrica = new Date();
	   fechaMetrica = formatearFechaHora(fechaMetrica);
	   metricas.acontecimiento = 'handShake';
           fs.readFile(archivoCalenturaSys,async(err,resultado)=>{
         if(err){
            console.log('error leyendo temperatura ' + err);
	     }else{
                metricas.ipRb = session.ip;
                metricas.macRb = session.macAddress;
                metricas.hostName = session.hostName;
                metricas.calentura = resultado / 1000;
                metricas.memoriaUsada = (memoriaUsada.rss/(1024)**3).toFixed(2);
                metricas.totalMemoria = (memoriaTotal / (1024)**3).toFixed(2);
                metricas.porcentajeMemoria = (metricas.memoriaUsada/metricas.totalMemoria)*100;
                console.log('memoria usada => ' + metricas.porcentajeMemoria);
                
		//si la temperatura supera los 55 graus
	        if(metricas.calentura > 55){
                  console.log('apagando por exeso de calor  (TEMP) => (' + metricas.calentura + ')');
                  let fechaError = new Date();
                  fechaError = formatearFechaHora(fechaError);
                  metricas.acontecimiento ='apagado';
                  regError('apagando por temperatura ' + fechaError + ' temperatura ' + metricas.calentura + `\n`);
                  metricas.tipoError = 'calenturaApagado';
		  metricas.acontecimiento ='power Off Preventivo';
                  setTimeout(apagarEquipo,5000);
                };

		//si el porcentajeMemoria > 3
                if(metricas.porcentajeMemoria > 3){
		  console.log('reiniciando por uso alto de memoria (MEM) => (' + metricas.porcentajeMemoria + ')');
		  metricas.acontecimiento  ='apagado';
                  metricas.tipoError='RamReinicio';
                  fechaError = formatearFechaHora(fechaError);
                  regError('reinicio por uso de ram  ' + fechaMetrica  +  `\n`);
                  setTimeout(reiniciarServer,5000);
                };
                session.metricas = metricas;
	        //console.log('metricas ' + JSON.stringify(metricas) );
	     };
	   });
	    
	}catch(error){
          console.log('fallo en metricas  ---> ' + error );
	};
};
actualizarMetricas();

//CONFIGURACION DEL SERVIDOR Y SUS CONEXIONES ------------------------------>

const app = express();
const server = http.createServer(app);
const io = new Server(server);

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


//DETECCION DE IP - MACADDRES - HOSTNAME  RB
const ifaces = os.networkInterfaces();
Object.keys(ifaces).forEach(function async (ifname) {
    var aux = (ifaces[ifname]); //variable guarda la informacion de las interfaces
    aux.forEach( function async (minhaIp){//iteramos sobre las interfaces buscando la que tiene conexion y sea ipv4
    if (minhaIp.internal === false &&  minhaIp.family === 'IPv4' ) {
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
const operacion = (async  function ingresar(){
    const equiposClinicaDescripcion = session.hostName;
    const equiposClinicaMacAddress = session.macAddress;
    const equiposClinicaIp = session.ip;
    const equiposClinicaEstado = 'conectado';
    var equiposClinicaFechaActualizaci  = new Date();
    const novo = {equiposClinicaMacAddress, equiposClinicaIp, equiposClinicaDescripcion, equiposClinicaFechaActualizaci, equiposClinicaEstado};
    // variable trae la informacion de esa mac en la tabla
    const verificar = await pool.query('select equiposClinicaMacAddress from equiposCli where equiposClinicaMacaddress = ?',[equiposClinicaMacAddress]);
	//verificamos si la mac ya tiene registro )
	  if (verificar[0].length === 0 ){
	    session.cambioIp = equiposClinicaIp;
	    await  pool.query('insert into equiposCli set  ?',[novo]);      
	    console.log('verifica nueva ip y registra ' + novo);
	    console.log('cambio session ' + session.cambioIp);
         //si ya tiene  modificamos  ip        
	  }else{
            console.log('verifica ip y actualiza fecha de revision');
            await pool.query('update equiposCli set equiposClinicaIp = ?, equiposClinicaFechaActualizaci = ?  where equiposClinicaMacaddress = ?',[equiposClinicaIp,equiposClinicaFechaActualizaci,equiposClinicaMacAddress]);   
          }
  return;
 });

//INFO VSERVER ------------------------------------------->

app.use(express.static(path.join(__dirname, './public')));
app.set('view engine','.hbs');
server.listen(app.get('port'),()=>{
   console.log('vservidor en puerto : ', app.get('port'));
});

// Configuracion de singleton para conexion con monitor
const server2Url = 'http://192.168.30.46:4000'; // monitor alma linux
const connectionToServer2 = Singleton.getInstance(server2Url);

//--------------ROTAS-------------------------------->

app.use('/prueba', pantallaRouter(io));

// Eventos de la comunicacion con el monitor
connectionToServer2.on('response_from_server2', (data) => {
  console.log('Resposta recebida do Servidor 2:', data);
});


// Enviar metricas regularmente al monitor
setInterval(() => {
  operacion()
  console.log(session.cambioIp);
  actualizarMetricas()
  console.log('metricas ---------------' + JSON.stringify(session.metricas));
  connectionToServer2.emit('data_from_server1', session.metricas);
},8000);


