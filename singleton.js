const { io } = require('socket.io-client');

class Singleton {
  constructor(serverUrl) {
    if (!Singleton.instance) {
      this.serverUrl = serverUrl;
      this.socket = io(this.serverUrl); // Crear conexion con el servidor
      this.events = {}; // Almacenar callbacks para eventos dinamicos
      this.initListeners();
      Singleton.instance = this; // garantizar que sea una sola instancia
    }
    return Singleton.instance;
  }

  initListeners() {
    this.socket.on('connect', () => {
      console.log(`Conectado a ${this.serverUrl} via Singleton.`);
    });

    this.socket.on('disconnect', () => {
      console.log(`Desconectado de ${this.serverUrl}.`);
    });

    // Gerenciar eventos dinâmicos
    this.socket.onAny((event, data) => {
      if (this.events[event]) {
        this.events[event](data);
      }
    });
  }

  on(event, callback) {
    this.events[event] = callback; // Registrar callback para eveneto
  }

  emit(event, data) {
    this.socket.emit(event, data);
  }

  static getInstance(serverUrl) {
    if (!Singleton.instance) {
      new Singleton(serverUrl);
    }
    return Singleton.instance;
  }
}

module.exports = Singleton;
