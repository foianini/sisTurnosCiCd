// Create a connection to the MySQL database using Unix socket
const mysql = require('mysql2');
const pool = mysql.createPool({
  socketPath: '/var/run/mysqld/mysqld.sock', // Path to your MySQL Unix socket
  user: 'root',                    // Your MySQL username
  password: '*667F407DE7C6AD07358FA38DAED7828A72014B4E',                // Your MySQL password
  database: 'equiposClinica'    // Your MySQL database name
});



module.exports = pool.promise(); // Use promise-based API

cta tab gest pide informe de resonancia pero no se hizo 
ayala arahuco 143950-1
dem 870