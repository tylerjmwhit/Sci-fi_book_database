const mysql = require('mysql');

const connection = mysql.createConnection({
    debug: false,
    host: '127.0.0.1',
    port: 3306,
    database: 'twhitmar_cs355sp23',
    user: 'twhitmar_cs355sp23',
    password: 'wh003937016',
});

module.exports = connection;