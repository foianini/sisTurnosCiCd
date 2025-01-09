let io;

module.exports = {
 init:(server)=>{
   if(!io){
      const {Server} = require('socket.io');
      io = new Server(server)
      console.log('socket singleton inicializado');
   }
   return io;
   },
   getIO: ()=>{
      if(!io){
        throw new Error('socket no inicializado falta init server');
      }

   return io;
   }
 };


