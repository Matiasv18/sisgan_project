-- SISGAN - Base de Datos
-- Autores: Diego Quintero & Matías Virgüez
-- Fecha: Abril 2026

CREATE DATABASE IF NOT EXISTS sisgan_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE sisgan_db;

-- =====================================================
-- TABLA: usuarios
-- =====================================================
CREATE TABLE usuarios (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  rol ENUM('Administrador', 'Mayordomo', 'Veterinario') NOT NULL,
  activo BOOLEAN DEFAULT TRUE,
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_email (email),
  INDEX idx_rol (rol)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- TABLA: animales
-- =====================================================
CREATE TABLE animales (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(100),
  identificador VARCHAR(50) UNIQUE NOT NULL,
  fechaNacimiento DATE NOT NULL,
  raza VARCHAR(50),
  sexo ENUM('Macho', 'Hembra') NOT NULL,
  estado ENUM('Activo', 'Gestante', 'Enfermo', 'Fallecido') DEFAULT 'Activo',
  madre_id INT,
  observaciones TEXT,
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (madre_id) REFERENCES animales(id) ON DELETE SET NULL,
  INDEX idx_identificador (identificador),
  INDEX idx_estado (estado),
  INDEX idx_madre (madre_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- TABLA: pesos
-- =====================================================
CREATE TABLE pesos (
  id INT PRIMARY KEY AUTO_INCREMENT,
  animal_id INT NOT NULL,
  fecha DATE NOT NULL,
  valor DECIMAL(6,2) NOT NULL CHECK (valor > 0),
  registradoPor INT,
  observaciones TEXT,
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (animal_id) REFERENCES animales(id) ON DELETE CASCADE,
  FOREIGN KEY (registradoPor) REFERENCES usuarios(id) ON DELETE SET NULL,
  INDEX idx_animal_fecha (animal_id, fecha),
  INDEX idx_fecha (fecha)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- TABLA: partos
-- =====================================================
CREATE TABLE partos (
  id INT PRIMARY KEY AUTO_INCREMENT,
  madre_id INT NOT NULL,
  fecha DATE NOT NULL,
  sexoTernero ENUM('Macho', 'Hembra') NOT NULL,
  ternero_id INT,
  pesoTernero DECIMAL(6,2),
  observaciones TEXT,
  registradoPor INT,
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (madre_id) REFERENCES animales(id) ON DELETE CASCADE,
  FOREIGN KEY (ternero_id) REFERENCES animales(id) ON DELETE SET NULL,
  FOREIGN KEY (registradoPor) REFERENCES usuarios(id) ON DELETE SET NULL,
  INDEX idx_madre (madre_id),
  INDEX idx_fecha (fecha)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- TABLA: destetes
-- =====================================================
CREATE TABLE destetes (
  id INT PRIMARY KEY AUTO_INCREMENT,
  animal_id INT NOT NULL,
  fechaProgramada DATE NOT NULL,
  fechaReal DATE,
  pesoDestete DECIMAL(6,2),
  estado ENUM('Programado', 'Realizado', 'Cancelado') DEFAULT 'Programado',
  observaciones TEXT,
  registradoPor INT,
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (animal_id) REFERENCES animales(id) ON DELETE CASCADE,
  FOREIGN KEY (registradoPor) REFERENCES usuarios(id) ON DELETE SET NULL,
  INDEX idx_animal (animal_id),
  INDEX idx_estado (estado),
  INDEX idx_fecha_programada (fechaProgramada)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- TABLA: fallecimientos (CORREGIDO: REFERENCES)
-- =====================================================
CREATE TABLE fallecimientos (
  id INT PRIMARY KEY AUTO_INCREMENT,
  animal_id INT NOT NULL,
  fecha DATE NOT NULL,
  causa TEXT,
  registradoPor INT,
  createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (animal_id) REFERENCES animales(id) ON DELETE CASCADE,
  FOREIGN KEY (registradoPor) REFERENCES usuarios(id) ON DELETE SET NULL,
  INDEX idx_animal (animal_id),
  INDEX idx_fecha (fecha)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- =====================================================
-- DATOS INICIALES
-- =====================================================

-- Usuario Administrador (password: admin123)
INSERT INTO usuarios (nombre, email, password, rol) VALUES 
('Administrador', 'admin@sisgan.com', '$2a$10$8K1p/a0dL3.ky/Y0/o0.DeQo8G5.d7MN9M8OBMt/gI9xQaG5nN0Zu', 'Administrador');

-- Usuario Mayordomo (password: mayordomo123)
INSERT INTO usuarios (nombre, email, password, rol) VALUES 
('Juan Pérez', 'mayordomo@sisgan.com', '$2a$10$vI8aWBnW3fIDtaxUvhoqB.XR4SwQnGqFGkHV.Bqq9.q51qN.Pq/0u', 'Mayordomo');

-- Usuario Veterinario (password: vet123)
INSERT INTO usuarios (nombre, email, password, rol) VALUES 
('Dr. Carlos Ruiz', 'veterinario@sisgan.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'Veterinario');

-- Animales de ejemplo
INSERT INTO animales (nombre, identificador, fechaNacimiento, raza, sexo, estado) VALUES
('Luna', 'BOV-001', '2023-03-15', 'Angus', 'Hembra', 'Activo'),
('Tornado', 'BOV-002', '2022-05-20', 'Brahman', 'Macho', 'Activo'),
('Estrella', 'BOV-003', '2023-01-10', 'Hereford', 'Hembra', 'Gestante'),
('Rayo', 'BOV-004', '2024-02-28', 'Holstein', 'Macho', 'Activo');

-- Pesos de ejemplo
INSERT INTO pesos (animal_id, fecha, valor, registradoPor) VALUES
(1, '2024-01-15', 450.50, 1),
(1, '2024-04-15', 480.00, 2),
(2, '2024-01-15', 520.00, 1),
(3, '2024-02-20', 410.75, 2);

-- Mensaje de confirmación
SELECT '✅ Base de datos SISGAN creada exitosamente' AS Resultado;
SELECT COUNT(*) AS 'Usuarios creados' FROM usuarios;
SELECT COUNT(*) AS 'Animales registrados' FROM animales;