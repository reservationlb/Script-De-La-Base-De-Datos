CREATE SCHEMA IF NOT EXISTS reservation_lb DEFAULT CHARACTER SET utf8 ;
USE reservation_lb ;

CREATE TABLE IF NOT EXISTS reservation_lb.tipo_documento (
  id_tipo_documento INT NOT NULL,
  descripcion VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_tipo_documento))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS reservation_lb.disponibilidad (
  id_disponibilidad INT(11) NOT NULL AUTO_INCREMENT,
  fecha DATE NOT NULL,
  hora TIME NOT NULL,
  estado VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_disponibilidad))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


CREATE TABLE IF NOT EXISTS reservation_lb.permiso (
  id_permiso INT(11) NOT NULL AUTO_INCREMENT,
  descripcion VARCHAR(100) NOT NULL,
  PRIMARY KEY (id_permiso))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


CREATE TABLE IF NOT EXISTS reservation_lb.tipo_decoracion (
  id_tipo_decoracion INT(11) NOT NULL AUTO_INCREMENT,
  nombre_decoracion VARCHAR(100) NOT NULL,
  descripcion VARCHAR(200) NOT NULL,
  valor_decoracion DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (id_tipo_decoracion))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


CREATE TABLE IF NOT EXISTS reservation_lb.tipo_evento (
  id_tipo_evento INT(11) NOT NULL AUTO_INCREMENT,
  nombre_evento VARCHAR(100) NOT NULL,
  descripcion VARCHAR(200) NOT NULL,
  valor_evento DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (id_tipo_evento))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


CREATE TABLE IF NOT EXISTS reservation_lb.tipo_menu (
  id_tipo_menu INT(11) NOT NULL AUTO_INCREMENT,
  nombre_menu VARCHAR(100) NOT NULL,
  descripcion_menu VARCHAR(255) NOT NULL,
  valor_menu DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (id_tipo_menu))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


CREATE TABLE IF NOT EXISTS reservation_lb.rol (
  id_rol INT(11) NOT NULL AUTO_INCREMENT,
  descripcion VARCHAR(100) NOT NULL,
  estado VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_rol))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


CREATE TABLE IF NOT EXISTS reservation_lb.usuario (
  id_usuario INT(11) NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(100) NOT NULL,
  apellido VARCHAR(100) NOT NULL,
  direccion VARCHAR(100) NOT NULL,
  documento VARCHAR(100) NOT NULL,
  telefono VARCHAR(45) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  fecha_de_vencimiento_clave DATE NOT NULL,
  autorizacion_dato DATE NOT NULL,
  user_name VARCHAR(45) NOT NULL,
  password VARCHAR(45) NOT NULL,
  rol_id_rol INT(11) NOT NULL,
  tipo_documento_idtipo_documento INT NOT NULL,
  estado VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_usuario),
  INDEX fk_usuario_tipos_usuarios1_idx (rol_id_rol ASC),
  INDEX fk_usuario_tipo_documento1_idx (tipo_documento_idtipo_documento ASC),
  CONSTRAINT fk_usuario_tipos_usuarios1
    FOREIGN KEY (rol_id_rol)
    REFERENCES reservation_lb.rol (id_rol)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_usuario_tipo_documento1
    FOREIGN KEY (tipo_documento_idtipo_documento)
    REFERENCES reservation_lb.tipo_documento (id_tipo_documento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


CREATE TABLE IF NOT EXISTS reservation_lb.reserva (
  id_reserva INT(11) NOT NULL AUTO_INCREMENT,
  hora TIME NOT NULL,
  fecha DATE NOT NULL,
  numero_persona INT(11) NOT NULL,
  valor_reserva DECIMAL(10,2) NOT NULL,
  disponibilidad_id_disponibilidad INT(11) NOT NULL,
  tipo_menu_id_tipo_menu INT(11) NOT NULL,
  tipo_decoracion_id_tipo_decoracion INT(11) NOT NULL,
  tipo_evento_id_tipo_evento INT(11) NOT NULL,
  usuario_id_usuario INT(11) NOT NULL,
  PRIMARY KEY (id_reserva),
  INDEX fk_reservas_disponibilidad1_idx (disponibilidad_id_disponibilidad ASC),
  INDEX fk_reservas_tipo_menu1_idx (tipo_menu_id_tipo_menu ASC),
  INDEX fk_reservas_tipo_decoracion1_idx (tipo_decoracion_id_tipo_decoracion ASC),
  INDEX fk_reservas_tipo_evento1_idx (tipo_evento_id_tipo_evento ASC),
  INDEX fk_reservas_usuario1_idx (usuario_id_usuario ASC),
  CONSTRAINT fk_reservas_disponibilidad1
    FOREIGN KEY (disponibilidad_id_disponibilidad)
    REFERENCES eservation_lb.disponibilidad (id_disponibilidad)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_reservas_tipo_decoracion1
    FOREIGN KEY (tipo_decoracion_id_tipo_decoracion)
    REFERENCES reservation_lb.tipo_decoracion (id_tipo_decoracion)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_reservas_tipo_evento1
    FOREIGN KEY (tipo_evento_id_tipo_evento)
    REFERENCES reservation_lb.tipo_evento (id_tipo_evento)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_reservas_tipo_menu1
    FOREIGN KEY (tipo_menu_id_tipo_menu)
    REFERENCES reservation_lb.tipo_menu (id_tipo_menu)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_reservas_usuario1
    FOREIGN KEY (usuario_id_usuario)
    REFERENCES reservation_lb.usuario (id_usuario)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS reservation_lb.permiso_has_rol (
  permiso_id_permiso INT(11) NOT NULL,
  rol_id_rol INT(11) NOT NULL,
  PRIMARY KEY (permiso_id_permiso, rol_id_rol),
  INDEX fk_permiso_has_rol_rol1_idx (rol_id_rol ASC),
  INDEX fk_permiso_has_rol_permiso1_idx (permiso_id_permiso ASC),
  CONSTRAINT fk_permiso_has_rol_permiso1
    FOREIGN KEY (permiso_id_permiso)
    REFERENCES reservation_lb.permiso (id_permiso)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_permiso_has_rol_rol1
    FOREIGN KEY (rol_id_rol)
    REFERENCES reservation_lb.rol (id_rol)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


INSERT INTO tipo_documento (id_tipo_documento, descripcion) VALUES
(1, 'Cédula de ciudadanía'),
(2, 'Tarjeta de identidad'),
(3, 'Cédula de extranjería'),
(4, 'Pasaporte'),
(5, 'NIT'),
(6, 'DNI'),
(7, 'Permiso de permanencia'),
(8, 'Documento diplomático'),
(9, 'Registro civil'),
(10, 'Documento temporal');

INSERT INTO disponibilidad (id_disponibilidad, fecha, hora, estado) VALUES
(1, '2026-09-05', '12:00:00', 'Disponible'),
(2, '2026-09-05', '15:00:00', 'Disponible'),
(3, '2026-09-12', '18:00:00', 'Disponible'),
(4, '2026-09-19', '12:30:00', 'Disponible'),
(5, '2026-09-19', '19:00:00', 'Disponible'),
(6, '2026-09-26', '13:00:00', 'Disponible'),
(7, '2026-10-03', '17:30:00', 'Disponible'),
(8, '2026-10-10', '14:00:00', 'Disponible'),
(9, '2026-10-17', '18:30:00', 'Disponible'),
(10, '2026-10-24', '20:00:00', 'Disponible');

INSERT INTO permiso (id_permiso, descripcion) VALUES
(1, 'Registrar usuarios'),
(2, 'Consultar usuarios'),
(3, 'Actualizar usuarios'),
(4, 'Eliminar usuarios'),
(5, 'Registrar reservas'),
(6, 'Consultar reservas'),
(7, 'Actualizar reservas'),
(8, 'Cancelar reservas'),
(9, 'Administrar menús'),
(10, 'Administrar decoración');

INSERT INTO tipo_decoracion
(id_tipo_decoracion, nombre_decoracion, descripcion, valor_decoracion) VALUES
(1, 'Cumpleaños básico', 'Decoración con globos y mesa principal.', 80000.00),
(2, 'Cumpleaños premium', 'Decoración temática con globos y accesorios.', 150000.00),
(3, 'Aniversario', 'Decoración romántica para celebración de aniversario.', 180000.00),
(4, 'Baby shower', 'Decoración temática para baby shower.', 200000.00),
(5, 'Graduación', 'Decoración con temática de graduación.', 160000.00),
(6, 'Empresarial', 'Decoración formal para eventos empresariales.', 250000.00),
(7, 'Infantil', 'Decoración colorida con temática infantil.', 130000.00),
(8, 'Elegante', 'Decoración sobria con detalles dorados.', 300000.00),
(9, 'Navideña', 'Decoración temática de Navidad.', 220000.00),
(10, 'Personalizada', 'Decoración diseñada según solicitud del cliente.', 350000.00);

INSERT INTO tipo_evento
(id_tipo_evento, nombre_evento, descripcion, valor_evento) VALUES
(1, 'Cumpleaños', 'Celebración de cumpleaños.', 50000.00),
(2, 'Aniversario', 'Celebración de aniversario de pareja.', 70000.00),
(3, 'Graduación', 'Evento para celebrar una graduación.', 80000.00),
(4, 'Baby shower', 'Celebración previa al nacimiento de un bebé.', 90000.00),
(5, 'Reunión familiar', 'Reunión especial para familiares.', 40000.00),
(6, 'Evento empresarial', 'Reunión o celebración corporativa.', 120000.00),
(7, 'Cena romántica', 'Cena especial para pareja.', 60000.00),
(8, 'Celebración infantil', 'Evento para niños.', 55000.00),
(9, 'Despedida', 'Celebración de despedida.', 65000.00),
(10, 'Evento personalizado', 'Evento diseñado según las necesidades del cliente.', 100000.00);

INSERT INTO tipo_menu
(id_tipo_menu, nombre_menu, descripcion_menu, valor_menu) VALUES
(1, 'Hamburguesa clásica', 'Hamburguesa de carne, papas y bebida.', 28000.00),
(2, 'Hamburguesa doble', 'Hamburguesa doble carne, papas y bebida.', 35000.00),
(3, 'Hamburguesa pollo', 'Hamburguesa de pollo, papas y bebida.', 30000.00),
(4, 'Hamburguesa BBQ', 'Hamburguesa con salsa BBQ, papas y bebida.', 32000.00),
(5, 'Hamburguesa especial', 'Hamburguesa especial de la casa.', 38000.00),
(6, 'Combo infantil', 'Hamburguesa pequeña, papas, bebida y postre.', 24000.00),
(7, 'Combo familiar', 'Selección de hamburguesas para compartir.', 95000.00),
(8, 'Menú vegetariano', 'Hamburguesa vegetariana, papas y bebida.', 30000.00),
(9, 'Menú premium', 'Hamburguesa premium con acompañamiento y bebida.', 45000.00),
(10, 'Menú personalizado', 'Menú ajustado a las necesidades del evento.', 50000.00);

INSERT INTO rol (id_rol, descripcion, estado) VALUES
(1, 'Administrador', 'Activo'),
(2, 'Cliente', 'Activo'),
(3, 'Recepcionista', 'Activo'),
(4, 'Cajero', 'Activo'),
(5, 'Mesero', 'Activo'),
(6, 'Chef', 'Activo'),
(7, 'Decorador', 'Activo'),
(8, 'Supervisor', 'Activo'),
(9, 'Auxiliar administrativo', 'Activo'),
(10, 'Consultor', 'Inactivo');

INSERT INTO usuario
(id_usuario, nombre, apellido, direccion, documento, telefono,
 fecha_nacimiento, fecha_de_vencimiento_clave, autorizacion_dato,
 user_name, password, rol_id_rol, tipo_documento_idtipo_documento, estado) VALUES
(1, 'Laura', 'Gómez', 'Calle 10 #15-20', '1001001001', '3001001001', '1995-02-14', '2027-02-14', '2026-08-20', 'laura.gomez', 'Clave123', 1, 1, 'Activo'),
(2, 'Carlos', 'Rodríguez', 'Carrera 7 #22-15', '1001001002', '3001001002', '1998-05-20', '2027-05-20', '2026-08-20', 'carlos.rodriguez', 'Clave123', 2, 1, 'Activo'),
(3, 'Andrés', 'Martínez', 'Calle 25 #8-40', '1001001003', '3001001003', '1992-08-11', '2027-08-11', '2026-08-20', 'andres.martinez', 'Clave123', 3, 1, 'Activo'),
(4, 'Valentina', 'López', 'Carrera 12 #30-18', '1001001004', '3001001004', '2000-01-30', '2027-01-30', '2026-08-20', 'valentina.lopez', 'Clave123', 4, 1, 'Activo'),
(5, 'Santiago', 'Pérez', 'Calle 45 #12-09', '1001001005', '3001001005', '1997-11-03', '2027-11-03', '2026-08-20', 'santiago.perez', 'Clave123', 5, 1, 'Activo'),
(6, 'Camila', 'Torres', 'Carrera 18 #41-25', '1001001006', '3001001006', '1999-03-17', '2027-03-17', '2026-08-20', 'camila.torres', 'Clave123', 2, 1, 'Activo'),
(7, 'Daniel', 'Ramírez', 'Calle 52 #20-11', '1001001007', '3001001007', '1994-07-22', '2027-07-22', '2026-08-20', 'daniel.ramirez', 'Clave123', 6, 1, 'Activo'),
(8, 'Mariana', 'Castro', 'Carrera 25 #16-32', '1001001008', '3001001008', '1996-09-09', '2027-09-09', '2026-08-20', 'mariana.castro', 'Clave123', 7, 1, 'Activo'),
(9, 'Felipe', 'Moreno', 'Calle 60 #5-19', '1001001009', '3001001009', '1991-12-18', '2027-12-18', '2026-08-20', 'felipe.moreno', 'Clave123', 8, 1, 'Activo'),
(10, 'Natalia', 'Herrera', 'Carrera 30 #14-27', '1001001010', '3001001010', '2001-06-25', '2027-06-25', '2026-08-20', 'natalia.herrera', 'Clave123', 2, 1, 'Activo');

INSERT INTO reserva
(id_reserva, hora, fecha, numero_persona, valor_reserva,
 disponibilidad_id_disponibilidad, tipo_menu_id_tipo_menu,
 tipo_decoracion_id_tipo_decoracion, tipo_evento_id_tipo_evento,
 usuario_id_usuario) VALUES
(1, '12:00:00', '2026-09-05', 4, 242000.00, 1, 1, 1, 1, 2),
(2, '15:00:00', '2026-09-05', 6, 430000.00, 2, 2, 2, 2, 6),
(3, '18:00:00', '2026-09-12', 8, 500000.00, 3, 3, 3, 3, 10),
(4, '12:30:00', '2026-09-19', 5, 450000.00, 4, 4, 4, 4, 2),
(5, '19:00:00', '2026-09-19', 10, 580000.00, 5, 5, 5, 5, 6),
(6, '13:00:00', '2026-09-26', 12, 1510000.00, 6, 7, 6, 6, 10),
(7, '17:30:00', '2026-10-03', 3, 280000.00, 7, 8, 7, 7, 2),
(8, '14:00:00', '2026-10-10', 7, 670000.00, 8, 9, 8, 8, 6),
(9, '18:30:00', '2026-10-17', 9, 735000.00, 9, 10, 9, 9, 10),
(10, '20:00:00', '2026-10-24', 15, 1875000.00, 10, 7, 10, 10, 2);

INSERT INTO permiso_has_rol (permiso_id_permiso, rol_id_rol) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 2),
(6, 2),
(7, 3),
(8, 3),
(9, 4),
(10, 7);


SELECT 'tipo_documento' AS tabla, COUNT(*) AS registros FROM tipo_documento
UNION ALL SELECT 'disponibilidad', COUNT(*) FROM disponibilidad
UNION ALL SELECT 'permiso', COUNT(*) FROM permiso
UNION ALL SELECT 'tipo_decoracion', COUNT(*) FROM tipo_decoracion
UNION ALL SELECT 'tipo_evento', COUNT(*) FROM tipo_evento
UNION ALL SELECT 'tipo_menu', COUNT(*) FROM tipo_menu
UNION ALL SELECT 'rol', COUNT(*) FROM rol
UNION ALL SELECT 'usuario', COUNT(*) FROM usuario
UNION ALL SELECT 'reserva', COUNT(*) FROM reserva
UNION ALL SELECT 'permiso_has_rol', COUNT(*) FROM permiso_has_rol;

CREATE TABLE IF NOT EXISTS Categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Producto (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL,
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)
);


INSERT INTO Categoria (nombre) VALUES
('Cortes de Carne'),
('Cortes de Cerdo'),
('Cortes de Pollo'),
('Pescados y Mariscos'),
('Platos Medias Porciones'),
('Sopas Especiales'),
('Arroces'),
('Entradas'),
('Hamburguesas'),
('Perros Calientes'),
('Especiales'),
('Crepes'),
('Salchipapa'),
('Mazorcadas'),
('Pastas y Lasagnas'),
('Pollo al Horno'),
('Pollo a la Broaster'),
('Menú Latin Kids'),
('Porciones'),
('Granizados'),
('Bebidas'),
('Malteadas'),
('Jugos Naturales'),
('Frutería');


INSERT INTO Producto (nombre, descripcion, precio, id_categoria) VALUES
('Carne de Res 400 gr', 'Corte de res a la parrilla con acompañamientos a elección', 33900, (SELECT id_categoria FROM Categoria WHERE nombre = 'Cortes de Carne')),
('Carne en Bistec 400 gr', 'Carne en bistec con acompañamientos a elección', 34900, (SELECT id_categoria FROM Categoria WHERE nombre = 'Cortes de Carne')),
('Carne en Bistec a Caballo 400 gr', 'Carne en bistec acompañada de huevo frito y acompañamientos', 35500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Cortes de Carne')),
('Churrasco 400 gr', 'Churrasco a la parrilla con acompañamientos a elección', 42000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Cortes de Carne')),
('Sobrebarriga a la Plancha 400 gr', 'Sobrebarriga dorada a la plancha', 33900, (SELECT id_categoria FROM Categoria WHERE nombre = 'Cortes de Carne')),
('Sobrebarriga en Salsa 400 gr', 'Sobrebarriga bañada en salsa especial', 35900, (SELECT id_categoria FROM Categoria WHERE nombre = 'Cortes de Carne')),
('Lengua en Salsa 400 gr', 'Lengua preparada en salsa criolla', 34500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Cortes de Carne'));


INSERT INTO Producto (nombre, descripcion, precio, id_categoria) VALUES
('Lomo de Cerdo', 'Corte de lomo de cerdo a la parrilla', 32500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Cortes de Cerdo')),
('Ceviche de Chicharrón (Sin Acompañante)', 'Ceviche crujiente de chicharrón', 18000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Cortes de Cerdo'));


INSERT INTO Producto (nombre, descripcion, precio, id_categoria) VALUES
('Pechuga a la Plancha', 'Pechuga de pollo jugosa a la plancha', 31900, (SELECT id_categoria FROM Categoria WHERE nombre = 'Cortes de Pollo')),
('Pechuga Gratinada', 'Pechuga cubierta con queso gratinado', 32900, (SELECT id_categoria FROM Categoria WHERE nombre = 'Cortes de Pollo')),
('Pechuga en Salsa de Champiñones', 'Pechuga bañada en crema y champiñones', 33500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Cortes de Pollo')),
('Pechuga Hawaiana', 'Pechuga con jamón, piña y queso gratinado', 33900, (SELECT id_categoria FROM Categoria WHERE nombre = 'Cortes de Pollo'));


INSERT INTO Producto (nombre, descripcion, precio, id_categoria) VALUES
('Mojarra 700 gr', 'Acompañada de arroz, chips patacón, papa a la francesa y ensalada', 33500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Pescados y Mariscos')),
('Trucha a la Plancha', 'Trucha fresca a la plancha con acompañamientos', 34500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Pescados y Mariscos')),
('Trucha Gratinada', 'Trucha cubierta con queso gratinado', 35900, (SELECT id_categoria FROM Categoria WHERE nombre = 'Pescados y Mariscos')),
('Trucha Hawaiana', 'Trucha con jamón, piña y queso', 37500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Pescados y Mariscos')),
('Trucha en Salsa de Champiñones', 'Trucha bañada en salsa de champiñones', 37500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Pescados y Mariscos')),
('Salmón en Salsa de Maracuyá', 'Filete de salmón en reducción de maracuyá', 43900, (SELECT id_categoria FROM Categoria WHERE nombre = 'Pescados y Mariscos')),
('Salmón en Salsa Marinera', 'Filete de salmón cubierto de salsa marinera y mariscos', 46900, (SELECT id_categoria FROM Categoria WHERE nombre = 'Pescados y Mariscos')),
('Ceviche de Camarón (Sin Acompañante)', 'Ceviche fresco de camarón', 22400, (SELECT id_categoria FROM Categoria WHERE nombre = 'Pescados y Mariscos')),
('Cazuela de Camarón y Mixtura', 'Cazuela cremosa de mariscos y camarones', 31900, (SELECT id_categoria FROM Categoria WHERE nombre = 'Pescados y Mariscos'));


INSERT INTO Producto (nombre, descripcion, precio, id_categoria) VALUES
('Carne de Res (Media Porción)', 'Media porción de carne de res', 17900, (SELECT id_categoria FROM Categoria WHERE nombre = 'Platos Medias Porciones')),
('Carne en Bistec (Media Porción)', 'Media porción de carne en bistec', 19900, (SELECT id_categoria FROM Categoria WHERE nombre = 'Platos Medias Porciones')),
('Carne en Bistec a Caballo (Media Porción)', 'Media porción de carne en bistec con huevo', 21000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Platos Medias Porciones')),
('Churrasco (Media Porción)', 'Media porción de churrasco', 22000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Platos Medias Porciones')),
('Lomo de Cerdo (Media Porción)', 'Media porción de lomo de cerdo', 18000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Platos Medias Porciones')),
('Pechuga a la Plancha (Media Porción)', 'Media porción de pechuga a la plancha', 17000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Platos Medias Porciones')),
('Pechuga Gratinada (Media Porción)', 'Media porción de pechuga gratinada', 18000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Platos Medias Porciones')),
('Pechuga en Salsa de Champiñones (Media Porción)', 'Media porción de pechuga con champiñones', 19000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Platos Medias Porciones')),
('Pechuga Hawaiana (Media Porción)', 'Media porción de pechuga hawaiana', 19500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Platos Medias Porciones'));


INSERT INTO Producto (nombre, descripcion, precio, id_categoria) VALUES
('Viernes: Mute Santandereano Sencillo', 'Mute tradicional santandereano', 16000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Sopas Especiales')),
('Viernes: Mute Santandereano con Arroz y Patacón', 'Mute acompañado de arroz y patacón', 18000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Sopas Especiales')),
('Sábado: Sancocho de Gallina Sencillo', 'Sancocho tradicional de gallina', 17000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Sopas Especiales')),
('Sábado: Sancocho de Gallina con Arroz y Patacón', 'Sancocho de gallina completo', 19000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Sopas Especiales')),
('Domingo: Mondongo Sencillo', 'Mondongo tradicional', 16000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Sopas Especiales')),
('Domingo: Mondongo con Arroz y Patacón', 'Mondongo acompañado de arroz y patacón', 18000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Sopas Especiales')),
('Media Sopa', 'Media porción de sopa del día', 5000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Sopas Especiales'));


INSERT INTO Producto (nombre, descripcion, precio, id_categoria) VALUES
('Arroz con Pollo', 'Arroz tradicional con pollo y verduras', 25500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Arroces')),
('Arroz de la Casa', 'Salteado de pollo, carne de cerdo, chicharrón, plátano, chorizo, salchicha y maíz tierno', 28900, (SELECT id_categoria FROM Categoria WHERE nombre = 'Arroces')),
('Paella Valenciana', 'Arroz, verduras, mariscos, pollo, costilla y chorizo', 39900, (SELECT id_categoria FROM Categoria WHERE nombre = 'Arroces'));


INSERT INTO Producto (nombre, descripcion, precio, id_categoria) VALUES
('Arepa Boyacense 3 Unds', '3 arepas boyacenses tradicionales', 7000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Entradas')),
('Chips de Patacón', 'Porción de chips de patacón crujientes', 10000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Entradas'));


INSERT INTO Producto (nombre, descripcion, precio, id_categoria) VALUES
('Hamburguesa Sencilla', 'Pan bimbo, carne, queso, papa miga, lechuga, tomate, cebolla caramelizada y salsas', 13500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Hamburguesas')),
('Hamburguesa Especial', 'Pan bimbo, carne, queso, jamón, papa miga, lechuga, pollo, tomate, cebolla caramelizada y salsas', 16500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Hamburguesas')),
('Hamburguesa Apanada de Pollo', 'Pan bimbo, pollo apanado, queso, jamón, papa miga, lechuga, tomate, cebolla caramelizada y salsas', 18500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Hamburguesas')),
('Hamburguesa BBQ', 'Pan bimbo, carne, chorizo, tocineta, queso, papa miga, lechuga, tomate, cebolla caramelizada y salsas', 18500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Hamburguesas')),
('Hamburguesa Latin Burger', 'Pan bimbo, carne, pollo desmechado, huevo, tocineta, queso, papa miga, lechuga, tomate, cebolla caramelizada, salsa de champiñones y salsas', 19500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Hamburguesas')),
('Hamburguesa de la Casa', 'Pan bimbo, doble carne, pollo desmechado, doble queso, huevo, tocineta, salsa de champiñones, lechuga, tomate, cebolla caramelizada, papa miga y salsas', 21900, (SELECT id_categoria FROM Categoria WHERE nombre = 'Hamburguesas')),
('Hamburguesa Monster House', 'Pan bimbo, carne, pollo apanado, mazorca tierna, tocineta, carne desmechada, chicharrón, tajada de plátano, queso, lechuga, tomate, cebolla caramelizada y salsas', 27900, (SELECT id_categoria FROM Categoria WHERE nombre = 'Hamburguesas'));


INSERT INTO Producto (nombre, descripcion, precio, id_categoria) VALUES
('Perro Especial', 'Pan bimbo, salchicha americana, pollo, papa miga, queso, dos huevos y salsas', 13500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Perros Calientes')),
('Perro Super Latin', 'Pan bimbo, salchicha americana, pollo, tocineta, salsa de desmechada, tajadas de criolla, queso, papa miga, huevo y salsas', 15900, (SELECT id_categoria FROM Categoria WHERE nombre = 'Perros Calientes')),
('Perro Criollo', 'Pan bimbo, salchicha americana, mazorca tierna, carne champiñones, papa miga, queso, tres huevos y salsas', 16500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Perros Calientes')),
('Perrada Monster House', 'Pan bimbo, ensalada de repollo y zanahoria, tocineta, salchicha, mazorca tierna, carne desmechada, pollo, queso mozarela, papa miga, dos huevos y salsas', 21900, (SELECT id_categoria FROM Categoria WHERE nombre = 'Perros Calientes'));


INSERT INTO Producto (nombre, descripcion, precio, id_categoria) VALUES
('Tabla Mixta', 'Carne de res 150g, pechuga 150g, lomo de cerdo 150g, acompañada de ensalada y papa criolla', 36900, (SELECT id_categoria FROM Categoria WHERE nombre = 'Especiales')),
('Costilla BBQ de la Casa', 'Arroz, ensalada y papa a la francesa', 36900, (SELECT id_categoria FROM Categoria WHERE nombre = 'Especiales'));


INSERT INTO Producto (nombre, descripcion, precio, id_categoria) VALUES
('Crepe Pollo', 'Jamón, salsa de champiñones, queso, huevo y salsas', 19500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Crepes')),
('Crepe Carne', 'Jamón, salsa boloñesa, queso, huevo y salsas', 19500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Crepes')),
('Crepe Mixto', 'Pollo, carne, jamón, queso, huevo y salsas', 19500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Crepes')),
('Crepe Vegetariano', 'Mazorca, cebolla, pimentón, queso, champiñones y huevo de codorniz', 18200, (SELECT id_categoria FROM Categoria WHERE nombre = 'Crepes')),
('Crepe Dulce', 'Helado, banano, fresa y durazno', 18200, (SELECT id_categoria FROM Categoria WHERE nombre = 'Crepes'));


INSERT INTO Producto (nombre, descripcion, precio, id_categoria) VALUES
('Salchipapa Especial', 'Papa a la francesa, salchicha americana y huevo', 12000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Salchipapa')),
('Salchipapa Super Latin', 'Papa a la francesa, salchicha americana, tocineta, queso y huevo', 15900, (SELECT id_categoria FROM Categoria WHERE nombre = 'Salchipapa')),
('Salchipapa de la Casa', 'Papa a la francesa, salchicha americana, chorizo, hogao de carne, papa miga, queso y huevo', 17500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Salchipapa')),
('Salchipapa Monster House', 'Papa francesa, tocineta, mazorca tierna, carne desmechada, pollo, chicharrón, salchicha, chorizo, queso, papa miga, huevo de codorniz y salsas', 29900, (SELECT id_categoria FROM Categoria WHERE nombre = 'Salchipapa'));


INSERT INTO Producto (nombre, descripcion, precio, id_categoria) VALUES
('Mazorcada Super Latin', 'Mazorca, pollo, carne, tocineta, papa miga, queso y salsas', 21900, (SELECT id_categoria FROM Categoria WHERE nombre = 'Mazorcadas')),
('Mazorcada Monster House', 'Mazorca, carne, pollo, chorizo, chicharrón, tocineta, papa miga, queso y salsas', 24900, (SELECT id_categoria FROM Categoria WHERE nombre = 'Mazorcadas')),
('Mazorcada Vegetariana', 'Mazorca, pimentón, cebolla, champiñón, queso, un huevo de codorniz y salsas', 18500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Mazorcadas'));


INSERT INTO Producto (nombre, descripcion, precio, id_categoria) VALUES
('Spaghetti Carbonara con Pollo', 'Spaghetti en salsa carbonara con tiras de pollo', 23000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Pastas y Lasagnas')),
('Spaghetti Bolognesa', 'Spaghetti en salsa boloñesa con carne molida', 23000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Pastas y Lasagnas')),
('Lasagna Mixta', 'Pollo, carne, jamón y queso', 17000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Pastas y Lasagnas'));


INSERT INTO Producto (nombre, descripcion, precio, id_categoria) VALUES
('Pollo Completo al Horno', 'Acompañado de papas saladas o papa a la francesa y salsas', 35000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Pollo al Horno')),
('Medio Pollo al Horno', 'Acompañado de papas saladas o papa a la francesa y salsas', 17500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Pollo al Horno')),
('Pollo Completo a la Broaster', 'Acompañado de papas saladas o papa a la francesa y salsas', 35000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Pollo a la Broaster')),
('Medio Pollo a la Broaster', 'Acompañado de papas saladas o papa a la francesa y salsas', 17500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Pollo a la Broaster')),
('Cuarto de Pollo', 'Pechuga y ala / pierna pernil', 8500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Pollo a la Broaster'));


INSERT INTO Producto (nombre, descripcion, precio, id_categoria) VALUES
('Hamburguesa Chiki Kids', 'Pan pequeño bimbo, carne, queso, papa miga y salsas', 10500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Menú Latin Kids')),
('Nuggets Latin Kids', 'Nuggets porcionado, papa francesa, huevo y pulpo de salchicha americana', 17200, (SELECT id_categoria FROM Categoria WHERE nombre = 'Menú Latin Kids')),
('Cajita Latin Kids', 'Hamburguesa pequeña, papa francesa, gaseosa, gomita y juguete', 24500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Menú Latin Kids'));


INSERT INTO Producto (nombre, descripcion, precio, id_categoria) VALUES
('Papa Criolla', 'Porción de papa criolla', 5000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Porciones')),
('Papa Francesa', 'Porción de papa a la francesa', 5000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Porciones')),
('Patacón 4 Unds', 'Porción de 4 patacones', 4000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Porciones')),
('Papa Salada', 'Porción de papa salada', 4000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Porciones')),
('Ensalada', 'Porción de ensalada fresca', 3000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Porciones')),
('Queso Frutería', 'Porción de queso', 6000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Porciones')),
('Arroz', 'Porción de arroz', 3500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Porciones')),
('Carne de Hamburguesa Res', 'Porción de carne de res', 6000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Porciones')),
('Carne de Hamburguesa Apanada', 'Porción de pollo apanado', 7500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Porciones')),
('Tocineta 2 Unds', '2 tiras de tocineta', 4000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Porciones')),
('Huevos de Codorniz 5 Unds', '5 huevos de codorniz', 3000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Porciones')),
('Queso Dos Lonjas', 'Dos lonjas de queso', 2500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Porciones')),
('Salsa de Champiñón', 'Porción de salsa de champiñones', 4000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Porciones')),
('Salsa Bistek', 'Porción de salsa bistek', 4000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Porciones')),
('Salsa Hawaiana', 'Porción de salsa hawaiana', 4000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Porciones'));


INSERT INTO Producto (nombre, descripcion, precio, id_categoria) VALUES
('Cholado', 'Cholado tradicional con frutas y leche condensada', 10000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Granizados')),
('Granizado de Café', 'Granizado a base de café', 9000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Granizados')),
('Granizado de Maracuyá', 'Granizado natural de maracuyá', 9000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Granizados')),
('Granizado de Mora', 'Granizado natural de mora', 9000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Granizados')),
('Agua', 'Botella de agua', 2500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Bebidas')),
('Coronita', 'Cerveza Coronita', 4500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Bebidas')),
('Cerveza', 'Cerveza nacional', 4500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Bebidas')),
('Club Colombia', 'Cerveza Club Colombia', 4500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Bebidas')),
('Cola y Pola Lata', 'Lata de Cola y Pola', 3500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Bebidas')),
('Postobón 250 ml', 'Gaseosa Postobón 250 ml', 2500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Bebidas')),
('Postobón 400 ml', 'Gaseosa Postobón 400 ml', 4000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Bebidas')),
('Postobón 1.5 Litros', 'Gaseosa Postobón 1.5 Litros', 9000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Bebidas')),
('Coca-Cola 400 ml', 'Gaseosa Coca-Cola 400 ml', 4000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Bebidas')),
('Coca-Cola 1.5 Litros', 'Gaseosa Coca-Cola 1.5 Litros', 9000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Bebidas')),
('Gaseosa 3 Litros', 'Gaseosa formato 3 Litros', 13500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Bebidas'));


INSERT INTO Producto (nombre, descripcion, precio, id_categoria) VALUES
('Malteada (Sabores Varios)', 'Sabores: arequipe, brownie, fresa, frutos rojos, ron con pasas, chocolate, vainilla, maracuyá y mandarina', 10000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Malteadas')),
('Jugo Natural en Agua', 'Sabores: guanábana, fresa, lulo, mango, mora, maracuyá, guayaba, borojó', 7000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Jugos Naturales')),
('Jugo Natural en Leche', 'Sabores: guanábana, fresa, lulo, mango, mora, maracuyá, guayaba, borojó', 9000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Jugos Naturales')),
('Limonada Natural', 'Limonada recién exprimida', 5000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Jugos Naturales')),
('Limonada de Hierba Buena', 'Limonada refrescante con hierbabuena', 6000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Jugos Naturales')),
('Limonada de Coco', 'Cremosa limonada con coco', 8000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Jugos Naturales')),
('Cerezada', 'Limonada cerezada', 9000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Jugos Naturales'));


INSERT INTO Producto (nombre, descripcion, precio, id_categoria) VALUES
('Ensalada Corriente', 'Frutas, queso y crema', 13000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Frutería')),
('Ensalada Especial', 'Frutas, queso, crema y 1 helado', 14500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Frutería')),
('Ensalada Natural', 'Frutas variadas', 11000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Frutería')),
('Ensalada Tropical', 'Frutas variadas, 2 helados, gelatina, barquillo galleta, queso y crema', 17900, (SELECT id_categoria FROM Categoria WHERE nombre = 'Frutería')),
('Ensalada Tentación', 'Frutas variadas, 1 helado, gelatina, helado de galleta, barquillo, galletas, queso y crema', 16500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Frutería')),
('Ensalada Latin Burguer', 'Frutas variadas, 2 helados, helado de galleta, gelatina, galleta, gomitas, queso y crema', 21500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Frutería')),
('Ensalada Júnior', 'Frutas, helado, queso y crema', 11500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Frutería')),
('Ensalada Mini Latin', 'Frutas, 2 helados, gomitas, gelatina, queso y crema', 13900, (SELECT id_categoria FROM Categoria WHERE nombre = 'Frutería')),
('Banana Split', 'Banano, fresas, galleta, queso y crema', 14900, (SELECT id_categoria FROM Categoria WHERE nombre = 'Frutería')),
('Brownie con Helado', 'Brownie caliente acompañado de helado', 12500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Frutería')),
('Copa de Helado Latin', '4 bolas de helado, frutas, salsas y barquillo y galleta', 16000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Frutería')),
('Fresas con Crema + Toppin', 'Fresa, helado, crema y topping', 12500, (SELECT id_categoria FROM Categoria WHERE nombre = 'Frutería')),
('Porción de Helado', 'Una bola de helado', 3000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Frutería')),
('Helado de Dos Bolas', 'Dos bolas de helado', 5000, (SELECT id_categoria FROM Categoria WHERE nombre = 'Frutería')),
('Porción de Crema de Leche', 'Porción individual de crema de leche', 4800, (SELECT id_categoria FROM Categoria WHERE nombre = 'Frutería'));

USE reservation_lb;

SELECT COUNT(*) FROM Categoria;
SELECT COUNT(*) FROM Producto;

USE reservation_lb;

ALTER TABLE Producto
    ADD COLUMN imagen VARCHAR(255) NULL AFTER id_categoria,
    ADD COLUMN activo TINYINT(1) NOT NULL DEFAULT 1 AFTER imagen;

ALTER TABLE reserva
    ADD COLUMN estado VARCHAR(45) NOT NULL DEFAULT 'Pendiente' AFTER usuario_id_usuario,
    ADD COLUMN color_evento VARCHAR(45) NULL AFTER estado,
    ADD COLUMN comentarios VARCHAR(255) NULL AFTER color_evento;

CREATE TABLE IF NOT EXISTS reservation_lb.reserva_producto (
  id_reserva_producto INT NOT NULL AUTO_INCREMENT,
  reserva_id_reserva INT(11) NOT NULL,
  producto_id_producto INT NOT NULL,
  cantidad INT NOT NULL DEFAULT 1,
  precio_unitario DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (id_reserva_producto),
  INDEX fk_resprod_reserva_idx (reserva_id_reserva ASC),
  INDEX fk_resprod_producto_idx (producto_id_producto ASC),
  CONSTRAINT fk_resprod_reserva
    FOREIGN KEY (reserva_id_reserva)
    REFERENCES reservation_lb.reserva (id_reserva)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_resprod_producto
    FOREIGN KEY (producto_id_producto)
    REFERENCES reservation_lb.Producto (id_producto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS reservation_lb.abono (
  id_abono INT NOT NULL AUTO_INCREMENT,
  reserva_id_reserva INT(11) NOT NULL,
  medio_pago VARCHAR(45) NOT NULL,
  valor_abono DECIMAL(10,2) NOT NULL,
  fecha_abono DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  estado VARCHAR(45) NOT NULL DEFAULT 'Registrado',
  PRIMARY KEY (id_abono),
  INDEX fk_abono_reserva_idx (reserva_id_reserva ASC),
  CONSTRAINT fk_abono_reserva
    FOREIGN KEY (reserva_id_reserva)
    REFERENCES reservation_lb.reserva (id_reserva)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

USE `reservation_lb`;

ALTER TABLE `tipo_evento`
    ADD COLUMN `imagen` VARCHAR(255) NULL AFTER `valor_evento`,
    ADD COLUMN `activo` TINYINT(1) NOT NULL DEFAULT 1 AFTER `imagen`;

ALTER TABLE `tipo_decoracion`
    ADD COLUMN `imagen` VARCHAR(255) NULL AFTER `valor_decoracion`,
    ADD COLUMN `activo` TINYINT(1) NOT NULL DEFAULT 1 AFTER `imagen`;

CREATE TABLE IF NOT EXISTS `reservation_lb`.`color_evento` (
  `id_color` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `codigo_hex` VARCHAR(7) NOT NULL,
  `imagen` VARCHAR(255) NULL,
  `activo` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id_color`)
) ENGINE = InnoDB DEFAULT CHARACTER SET = utf8;

INSERT INTO `color_evento` (`nombre`, `codigo_hex`) VALUES
('Rojo', '#C0392B'),
('Azul', '#2E5C99'),
('Amarillo', '#E8C547'),
('Verde', '#3F7D45'),
('Negro', '#222222'),
('Blanco', '#FFFFFF');
