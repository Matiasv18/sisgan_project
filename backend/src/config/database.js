const mysql = require('mysql2');

const pool = mysql.createPool({
  host: 'localhost',      // o '127.0.0.1'
  user: 'root',
  password: 'admit',
  database: 'sisgan_db',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});

// Probar conexión
pool.getConnection((err, connection) => {
  if (err) {
    console.error('❌ Error conectando a MySQL:', err.message);
    if (err.code === 'ECONNREFUSED') {
      console.log('💡 Asegúrate de que MySQL esté corriendo');
    }
    return;
  }
  console.log('✅ Conexión exitosa a MySQL');
  console.log(`📊 Base de datos: sisgan_db`);
  connection.release();
});

module.exports = pool.promise();