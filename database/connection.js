const mysql = require('mysql');

const connection = mysql.createConnection({
    debug: false,
    host: '127.0.0.1',
    port: 3306,
    database: '*********',
    user: '************',
    password: '********',
});

module.exports = connection;
