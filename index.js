const express = require('express');
const http = require('http');
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
 const fs = require('fs').promises; // Usa a versão de Promises do fs
 const os = require('os');
 
 async function actualizarMetricas() {
   try {
     verCalentura(); // Função externa presumida
 
     const memoriaTotal = os.totalmem();
     const memoriaUsada = process.memoryUsage();
     let metricas = {};
 
     // Formatar data
     let fechaMetrica = new Date();
     fechaMetrica = formatearFechaHora(fechaMetrica); // Função externa presumida
     metricas.fechaMetrica = fechaMetrica;
     metricas.acontecimiento = 'handShake';
 
     try {
       const resultado = await fs.readFile(archivoCalenturaSys); // Lê o arquivo de forma assíncrona
       metricas.ipRb = session.ip;
       metricas.macRb = session.macAddress;
       metricas.hostName = session.hostName;
       metricas.calentura = resultado / 1000;
       metricas.memoriaUsada = (memoriaUsada.rss / (1024) ** 3).toFixed(2);
       metricas.totalMemoria = (memoriaTotal / (1024) ** 3).toFixed(2);
       metricas.porcentajeMemoria = (metricas.memoriaUsada / metricas.totalMemoria) * 100;
 
       console.log('memoria usada => ' + metricas.porcentajeMemoria);
 
       // Verifica temperatura
       if (metricas.calentura > 60) {
         console.log('apagando por exeso de calor  (TEMP) => (' + metricas.calentura + ')');
         let fechaError = new Date();
         fechaError = formatearFechaHora(fechaError);
         metricas.acontecimiento = 'apagado preventivo';
         regError('apagando por temperatura ' + fechaError + ' temperatura ' + metricas.calentura + `\n`);
         metricas.tipoError = 'temperatura elevada';
         setTimeout(apagarEquipo, 5000); // Função externa presumida
       }
 
       // Verifica uso da memória
       if (metricas.porcentajeMemoria > 5) {
         console.log('reiniciando por uso alto de memoria (MEM) => (' + metricas.porcentajeMemoria + ')');
         metricas.acontecimiento = 'reinicio preventivo';
         metricas.tipoError = 'uso exesivo de ram';
         let fechaError = formatearFechaHora(new Date());
         regError('reinicio por uso de ram  ' + fechaError + `\n`);
         setTimeout(reiniciarServer, 5000); // Função externa presumida
       }
 
     } catch (err) {
       console.log('error leyendo temperatura ' + err);
     }
     console.log();
     console.log('');   
     console.log('+++++++++++++++++++++++++METRICAS+++++DEL+++++++SISTEMA+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
     return metricas;


 
   } catch (error) {
     console.log('fallo en metricas  ---> ' + error);
     throw error; // Repassa o erro para tratamento externo, se necessário
   }
 }
 
//actualizarMetricas();

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
	store: sessionStore,
    cookie: {
        sameSite:'lax',
        httpOnly: true,
        secure: false,
        expires: new Date(Date.now() + 60000 * 30) // Expira en 30 min
      }
}));

app.use(flash());
app.use((req,res,next)=>{
  app.locals.message = req.flash('message'),
  next();
});


//DETECCION DE IP - MACADDRES - HOSTNAME  RB

async function  registrarInfoEnSession() {
    const ifaces = os.networkInterfaces();
    await  Object.keys(ifaces).forEach((ifname) => {
        const aux = ifaces[ifname]; // Variable guarda la informaciÃ³n de las interfaces
         aux.forEach((minhaIp) => { // Iteramos sobre las interfaces buscando la que tiene conexiÃ³n y sea IPv4
            if (!minhaIp.internal && minhaIp.family === 'IPv4') {
                session.macAddress = minhaIp.mac;
                session.hostName = os.hostname();
                session.ip = minhaIp.address;
                console.log('IP: ' + session.ip + '  Mac: ' + session.macAddress);
            }
        });
    });

    // Mensaje final de la informaciÃ³n registrada
    return ;
}


//REGISTRANDO INFO EN SESSION DE FORMA GLOBAL
const infoEnSession = ('HOST : ' +  session.hostName + ' //  IP : ' + session.ip + ' //  MAC : ' + session.macAddress  );

//REGISTRO DE LA IP Y MAC EN DB
const operacion = (async  function ingresar(){
    await registrarInfoEnSession();
    const equiposClinicaDescripcion = session.hostName;
    const equiposClinicaMacAddress = session.macAddress;
    const equiposClinicaIp = session.ip;
    const equiposClinicaEstado = 'conectado';
    var equiposClinicaFechaActualizaci  = new Date();
    const novo = {equiposClinicaMacAddress, equiposClinicaIp, equiposClinicaDescripcion, equiposClinicaFechaActualizaci, equiposClinicaEstado};
    // variable trae la informacion de esa mac en la tabla
    var verificar = await pool.query('select  EquiposClinicaIp from equiposCli where equiposClinicaMacaddress = ?',[equiposClinicaMacAddress]);
        verificar = verificar[0];
	verificar = verificar[0];
    var verificaResultado = {};
    //console.log('verificar = ' + JSON.stringify(verificar));
	//verificamos si la mac ya tiene registro )
	  if (!verificar ){
	    //session.cambioIp = equiposClinicaIp;
	    await  pool.query('insert into equiposCli set  ?',[novo]);  
        console.log('');
        console.log('');    
	    console.log('+++++++++++++++++++++++RESULTADO+++VERIFICACION++++IPS++++++++++++++++++++++++++++++++++++++++++++++++++++++ ');
	    verificaResultado.verificacionIp = 'nuevo Registro';
	    verificaResultado.ipActual = equiposClinicaIp ;
	    console.log('PRIMER REGISTRO DE IP => ' + JSON.stringify(verificaResultado));
        console.log();
        console.log('');
        console.log('+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
         //si ya tiene  modificamos  ip        
	  }else{
        console.log('');
        console.log('');
        console.log('++++++++++++++++++++++++RESULTADO+++++VERIFICACION+++IPS++++++++++++++++++++++++++++++++++++++++++++++++++');
	    console.log('');
        if(verificar.EquiposClinicaIp === equiposClinicaIp){
	      verificaResultado.verificacionIp = 'vieja Ip';
	      verificaResultado.ipActual = equiposClinicaIp;
	      console.log(' MANTIENE LA IP => ' + JSON.stringify(verificaResultado));
          console.log();
          console.log('');
          console.log('+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
          
	    }else{
          verificaResultado.verificacionIp = 'nueva Ip';
	      verificaResultado.ipActual = equiposClinicaIp;
	      console.log('CAMBIO LA IP A => ' + JSON.stringify(verificaResultado));
          console.log();
          console.log('');
          console.log('+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
          
	    }
	  }
	    //session.verificaIp = verificaResultado.verificacionIp;
            await pool.query('update equiposCli set equiposClinicaIp = ?, equiposClinicaFechaActualizaci = ?  where equiposClinicaMacaddress = ?',[equiposClinicaIp,equiposClinicaFechaActualizaci,equiposClinicaMacAddress]);   
  
  return verificaResultado;
 });

//INFO VSERVER ------------------------------------------->

app.use(express.static(path.join(__dirname, './public')));
app.set('view engine','.hbs');
server.listen(app.get('port'),()=>{
   console.log('vservidor en puerto : ', app.get('port'));
});

// Configuracion de singleton para conexion con monitor
const server2Url = 'http://192.168.30.46:5000'; // monitor alma linux
const connectionToServer2 = Singleton.getInstance(server2Url);

//--------------ROTAS-------------------------------->

app.use('/prueba', pantallaRouter(io));

// Eventos de la comunicacion con el monitor
connectionToServer2.on('response_from_server2', (data) => {
  console.log('Resposta recebida do Servidor 2:', data);
});


// Enviar metricas regularmente al monitor
  setInterval( async () => {
  var verificacionIp =  operacion(); 
  var metricasSis =   await actualizarMetricas();
  if(verificacionIp === 'nueva Ip'){
      metricasSis.acontecimiento = 'cambio de Ip';
      metricasSis.tipoError = 'problemas de red';
  }
  console.log(JSON.stringify(metricasSis));
  connectionToServer2.emit('data_from_server1', metricasSis);
},8000);

