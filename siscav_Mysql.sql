# Converted with pg2mysql-1.9
# Converted on Mon, 21 May 2018 11:16:31 -0400
# Lightbox Technologies Inc. http://www.lightbox.ca

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone="+00:00";

CREATE TABLE conexion (
    conexion_id int(11) NOT NULL,
    conexion_ip varchar(22) NOT NULL,
    conexion_fecha_ini timestamp NOT NULL,
    conexion_fecha_fin timestamp,
    rel_perfil_usuario_id int(11) NOT NULL
) CHARSET=utf8;

CREATE TABLE estructura (
    est_id int(11) NOT NULL,
    est_sigla varchar(7),
    est_desc varchar(100) NOT NULL,
    est_activo bool DEFAULT 1,
    est_padre_id int(11),
    conexion_id int(11) NOT NULL
) CHARSET=utf8;

CREATE TABLE lista_negra (
    lista_negra_id int(11) NOT NULL,
    lista_negra_observ varchar(200),
    pers_id int(11),
    visitante_id int(11),
    conexion_id int(11)
) CHARSET=utf8;

CREATE TABLE menu (
    menu_id int(11) NOT NULL,
    menu_desc varchar(100) NOT NULL,
    menu_link varchar(100) DEFAULT '#',
    menu_icono varchar(100),
    menu_orden int(11),
    menu_activo bool DEFAULT 1,
    menu_padre_id int(11)
) CHARSET=utf8;

CREATE TABLE perfil (
    perfil_id int(11) NOT NULL,
    perfil_desc varchar(100) NOT NULL,
    perfil_activo bool DEFAULT 1 NOT NULL
) CHARSET=utf8;

CREATE TABLE rel_estructura_pabx (
    rel_est_pabx_id int(11) NOT NULL,
    pabx varchar(15),
    est_id int(11) NOT NULL
) CHARSET=utf8;

CREATE TABLE rel_perfil_menu (
    rel_perfil_menu_id int(11) NOT NULL,
    perfil_id int(11) NOT NULL,
    menu_id int(11) NOT NULL
) CHARSET=utf8;

CREATE TABLE rel_perfil_usuario (
    rel_perfil_usuario_id int(11) NOT NULL,
    usuario_id int(11) NOT NULL,
    perfil_id int(11) NOT NULL
) CHARSET=utf8;

CREATE TABLE rel_personal_estructura (
    rel_pers_est_id int(11) NOT NULL,
    pers_id int(11) NOT NULL,
    rel_pers_activo bool DEFAULT 1 NOT NULL,
    pabx varchar(15),
    est_id int(11) NOT NULL,
    conexion_id int(11) NOT NULL
) CHARSET=utf8;

CREATE TABLE rel_personal_pabx (
    rel_pers_pabx_id int(11) NOT NULL,
    pers_id int(11),
    pabx varchar(15)
) CHARSET=utf8;

CREATE TABLE usuario (
    usuario_id int(11) NOT NULL,
    usuario_login varchar(10) NOT NULL,
    usuario_clave varchar(100) DEFAULT 'METRO',
    usuario_activo bool DEFAULT 1 NOT NULL,
    pers_id int(11),
    est_id int(11)
) CHARSET=utf8;

CREATE TABLE visita (
    visita_id int(11) NOT NULL,
    visita_cod varchar(15) NOT NULL,
    visita_tipo varchar(50) NOT NULL,
    visita_observ text,
    visita_fecha_ent timestamp NOT NULL,
    visita_fecha_sal timestamp,
    visitante_id int(11) NOT NULL,
    est_id int(11) NOT NULL,
    pers_id int(11),
    conexion_id int(11) NOT NULL
) CHARSET=utf8;

CREATE TABLE visitante (
    visitante_id int(11) NOT NULL,
    visitante_cedula varchar(15) NOT NULL,
    visitante_nombre varchar(100) NOT NULL,
    visitante_apellido varchar(100) NOT NULL,
    visitante_telefono varchar(20),
    visitante_direccion text,
    visitante_foto bool DEFAULT 0,
    visitante_org varchar(200),
    pers_id int(11),
    conexion_id int(11) NOT NULL
) CHARSET=utf8;

ALTER TABLE conexion
    ADD CONSTRAINT pk_conexion PRIMARY KEY (conexion_id);
ALTER TABLE estructura
    ADD CONSTRAINT pk_estructura PRIMARY KEY (est_id);
ALTER TABLE lista_negra
    ADD CONSTRAINT pk_lista_negra PRIMARY KEY (lista_negra_id);
ALTER TABLE menu
    ADD CONSTRAINT pk_menu PRIMARY KEY (menu_id);
ALTER TABLE perfil
    ADD CONSTRAINT pk_perfil PRIMARY KEY (perfil_id);
ALTER TABLE rel_estructura_pabx
    ADD CONSTRAINT pk_rel_estructura_pabx PRIMARY KEY (rel_est_pabx_id);
ALTER TABLE rel_perfil_menu
    ADD CONSTRAINT pk_rel_perfil_menu PRIMARY KEY (rel_perfil_menu_id);
ALTER TABLE rel_perfil_usuario
    ADD CONSTRAINT pk_rel_perfil_usuario PRIMARY KEY (rel_perfil_usuario_id);
ALTER TABLE rel_personal_estructura
    ADD CONSTRAINT pk_rel_personal_area PRIMARY KEY (rel_pers_est_id);
ALTER TABLE rel_personal_pabx
    ADD CONSTRAINT pk_rel_personal_pabx PRIMARY KEY (rel_pers_pabx_id);
ALTER TABLE usuario
    ADD CONSTRAINT pk_usuario PRIMARY KEY (usuario_id);
ALTER TABLE visita
    ADD CONSTRAINT pk_visita PRIMARY KEY (visita_id);
ALTER TABLE visitante
    ADD CONSTRAINT pk_visitante PRIMARY KEY (visitante_id);

