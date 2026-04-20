require('dotenv').config();
const express = require('express');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 3000;

// Middlewares
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Ruta de prueba
app.get('/', (req, res) => {
  res.json({
    message: 'API SISGAN funcionando correctamente',
    version: '1.0.0',
    fecha: new Date().toLocaleDateString('es-CO')
  });
});

// Ruta de salud del servidor
app.get('/health', (req, res) => {
  res.json({ status: 'OK', timestamp: new Date() });
});

// Iniciar servidor
app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
  console.log('Archivo .env cargado desde: backend/.env');

  if (process.env.DB_NAME) {
    console.log(`Base de datos configurada: ${process.env.DB_NAME}`);
  } else {
    console.warn('DB_NAME no esta definida en las variables de entorno');
  }
});
