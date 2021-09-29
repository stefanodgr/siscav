--
-- PostgreSQL database dump
--

-- Dumped from database version 8.4.9
-- Dumped by pg_dump version 9.6.4

-- Started on 2018-05-21 11:15:04 -04

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;
SET row_security = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 140 (class 1259 OID 89033091)
-- Name: conexion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE conexion (
    conexion_id integer NOT NULL,
    conexion_ip character varying(22) NOT NULL,
    conexion_fecha_ini timestamp without time zone NOT NULL,
    conexion_fecha_fin timestamp without time zone,
    rel_perfil_usuario_id integer NOT NULL
);


ALTER TABLE conexion OWNER TO postgres;

--
-- TOC entry 141 (class 1259 OID 89033094)
-- Name: conexion_conexion_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE conexion_conexion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE conexion_conexion_id_seq OWNER TO postgres;

--
-- TOC entry 1950 (class 0 OID 0)
-- Dependencies: 141
-- Name: conexion_conexion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE conexion_conexion_id_seq OWNED BY conexion.conexion_id;


--
-- TOC entry 142 (class 1259 OID 89033096)
-- Name: estructura; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE estructura (
    est_id integer NOT NULL,
    est_sigla character varying(7),
    est_desc character varying(100) NOT NULL,
    est_activo boolean DEFAULT true,
    est_padre_id integer,
    conexion_id integer NOT NULL
);


ALTER TABLE estructura OWNER TO postgres;

--
-- TOC entry 143 (class 1259 OID 89033100)
-- Name: estructura_est_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE estructura_est_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE estructura_est_id_seq OWNER TO postgres;

--
-- TOC entry 1951 (class 0 OID 0)
-- Dependencies: 143
-- Name: estructura_est_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE estructura_est_id_seq OWNED BY estructura.est_id;


--
-- TOC entry 144 (class 1259 OID 89033102)
-- Name: lista_negra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE lista_negra (
    lista_negra_id integer NOT NULL,
    lista_negra_observ character varying(200),
    pers_id integer,
    visitante_id integer,
    conexion_id integer
);


ALTER TABLE lista_negra OWNER TO postgres;

--
-- TOC entry 145 (class 1259 OID 89033105)
-- Name: lista_negra_lista_negra_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE lista_negra_lista_negra_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE lista_negra_lista_negra_id_seq OWNER TO postgres;

--
-- TOC entry 1952 (class 0 OID 0)
-- Dependencies: 145
-- Name: lista_negra_lista_negra_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE lista_negra_lista_negra_id_seq OWNED BY lista_negra.lista_negra_id;


--
-- TOC entry 146 (class 1259 OID 89033107)
-- Name: menu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE menu (
    menu_id integer NOT NULL,
    menu_desc character varying(100) NOT NULL,
    menu_link character varying(100) DEFAULT '#'::character varying NOT NULL,
    menu_icono character varying(100),
    menu_orden integer,
    menu_activo boolean DEFAULT true,
    menu_padre_id integer
);


ALTER TABLE menu OWNER TO postgres;

--
-- TOC entry 147 (class 1259 OID 89033112)
-- Name: menu_menu_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE menu_menu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE menu_menu_id_seq OWNER TO postgres;

--
-- TOC entry 1953 (class 0 OID 0)
-- Dependencies: 147
-- Name: menu_menu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE menu_menu_id_seq OWNED BY menu.menu_id;


--
-- TOC entry 148 (class 1259 OID 89033114)
-- Name: perfil; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE perfil (
    perfil_id integer NOT NULL,
    perfil_desc character varying(100) NOT NULL,
    perfil_activo boolean DEFAULT true NOT NULL
);


ALTER TABLE perfil OWNER TO postgres;

--
-- TOC entry 149 (class 1259 OID 89033118)
-- Name: perfil_perfil_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE perfil_perfil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE perfil_perfil_id_seq OWNER TO postgres;

--
-- TOC entry 1954 (class 0 OID 0)
-- Dependencies: 149
-- Name: perfil_perfil_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE perfil_perfil_id_seq OWNED BY perfil.perfil_id;


--
-- TOC entry 150 (class 1259 OID 89033120)
-- Name: rel_estructura_pabx; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE rel_estructura_pabx (
    rel_est_pabx_id integer NOT NULL,
    pabx character varying(15),
    est_id integer NOT NULL
);


ALTER TABLE rel_estructura_pabx OWNER TO postgres;

--
-- TOC entry 151 (class 1259 OID 89033123)
-- Name: rel_estructura_pabx_rel_est_pabx_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE rel_estructura_pabx_rel_est_pabx_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE rel_estructura_pabx_rel_est_pabx_id_seq OWNER TO postgres;

--
-- TOC entry 1955 (class 0 OID 0)
-- Dependencies: 151
-- Name: rel_estructura_pabx_rel_est_pabx_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE rel_estructura_pabx_rel_est_pabx_id_seq OWNED BY rel_estructura_pabx.rel_est_pabx_id;


--
-- TOC entry 152 (class 1259 OID 89033125)
-- Name: rel_perfil_menu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE rel_perfil_menu (
    rel_perfil_menu_id integer NOT NULL,
    perfil_id integer NOT NULL,
    menu_id integer NOT NULL
);


ALTER TABLE rel_perfil_menu OWNER TO postgres;

--
-- TOC entry 153 (class 1259 OID 89033128)
-- Name: rel_perfil_menu_rel_perfil_menu_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE rel_perfil_menu_rel_perfil_menu_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE rel_perfil_menu_rel_perfil_menu_id_seq OWNER TO postgres;

--
-- TOC entry 1956 (class 0 OID 0)
-- Dependencies: 153
-- Name: rel_perfil_menu_rel_perfil_menu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE rel_perfil_menu_rel_perfil_menu_id_seq OWNED BY rel_perfil_menu.rel_perfil_menu_id;


--
-- TOC entry 154 (class 1259 OID 89033130)
-- Name: rel_perfil_usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE rel_perfil_usuario (
    rel_perfil_usuario_id integer NOT NULL,
    usuario_id integer NOT NULL,
    perfil_id integer NOT NULL
);


ALTER TABLE rel_perfil_usuario OWNER TO postgres;

--
-- TOC entry 155 (class 1259 OID 89033133)
-- Name: rel_perfil_usuario_rel_perfil_usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE rel_perfil_usuario_rel_perfil_usuario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE rel_perfil_usuario_rel_perfil_usuario_id_seq OWNER TO postgres;

--
-- TOC entry 1957 (class 0 OID 0)
-- Dependencies: 155
-- Name: rel_perfil_usuario_rel_perfil_usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE rel_perfil_usuario_rel_perfil_usuario_id_seq OWNED BY rel_perfil_usuario.rel_perfil_usuario_id;


--
-- TOC entry 156 (class 1259 OID 89033135)
-- Name: rel_personal_estructura; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE rel_personal_estructura (
    rel_pers_est_id integer NOT NULL,
    pers_id integer NOT NULL,
    rel_pers_activo boolean DEFAULT true NOT NULL,
    pabx character varying(15),
    est_id integer NOT NULL,
    conexion_id integer NOT NULL
);


ALTER TABLE rel_personal_estructura OWNER TO postgres;

--
-- TOC entry 157 (class 1259 OID 89033139)
-- Name: rel_personal_estructura_rel_pers_est_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE rel_personal_estructura_rel_pers_est_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE rel_personal_estructura_rel_pers_est_id_seq OWNER TO postgres;

--
-- TOC entry 1958 (class 0 OID 0)
-- Dependencies: 157
-- Name: rel_personal_estructura_rel_pers_est_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE rel_personal_estructura_rel_pers_est_id_seq OWNED BY rel_personal_estructura.rel_pers_est_id;


--
-- TOC entry 158 (class 1259 OID 89033141)
-- Name: rel_personal_pabx; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE rel_personal_pabx (
    rel_pers_pabx_id integer NOT NULL,
    pers_id integer,
    pabx character varying(15)
);


ALTER TABLE rel_personal_pabx OWNER TO postgres;

--
-- TOC entry 159 (class 1259 OID 89033144)
-- Name: rel_personal_pabx_rel_pers_pabx_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE rel_personal_pabx_rel_pers_pabx_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE rel_personal_pabx_rel_pers_pabx_id_seq OWNER TO postgres;

--
-- TOC entry 1959 (class 0 OID 0)
-- Dependencies: 159
-- Name: rel_personal_pabx_rel_pers_pabx_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE rel_personal_pabx_rel_pers_pabx_id_seq OWNED BY rel_personal_pabx.rel_pers_pabx_id;


--
-- TOC entry 160 (class 1259 OID 89033146)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE usuario (
    usuario_id integer NOT NULL,
    usuario_login character varying(10) NOT NULL,
    usuario_clave character varying(100) DEFAULT 'METRO'::character varying NOT NULL,
    usuario_activo boolean DEFAULT true NOT NULL,
    pers_id integer,
    est_id integer
);


ALTER TABLE usuario OWNER TO postgres;

--
-- TOC entry 161 (class 1259 OID 89033151)
-- Name: usuario_usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE usuario_usuario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE usuario_usuario_id_seq OWNER TO postgres;

--
-- TOC entry 1960 (class 0 OID 0)
-- Dependencies: 161
-- Name: usuario_usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE usuario_usuario_id_seq OWNED BY usuario.usuario_id;


--
-- TOC entry 162 (class 1259 OID 89033153)
-- Name: visita; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE visita (
    visita_id integer NOT NULL,
    visita_cod character varying(15) NOT NULL,
    visita_tipo character varying(50) NOT NULL,
    visita_observ character varying(500),
    visita_fecha_ent timestamp without time zone NOT NULL,
    visita_fecha_sal timestamp without time zone,
    visitante_id integer NOT NULL,
    est_id integer NOT NULL,
    pers_id integer,
    conexion_id integer NOT NULL
);


ALTER TABLE visita OWNER TO postgres;

--
-- TOC entry 163 (class 1259 OID 89033159)
-- Name: visita_visita_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE visita_visita_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE visita_visita_id_seq OWNER TO postgres;

--
-- TOC entry 1961 (class 0 OID 0)
-- Dependencies: 163
-- Name: visita_visita_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE visita_visita_id_seq OWNED BY visita.visita_id;


--
-- TOC entry 164 (class 1259 OID 89033161)
-- Name: visitante; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE visitante (
    visitante_id integer NOT NULL,
    visitante_cedula character varying(15) NOT NULL,
    visitante_nombre character varying(100) NOT NULL,
    visitante_apellido character varying(100) NOT NULL,
    visitante_telefono character varying(20),
    visitante_direccion character varying(500),
    visitante_foto boolean DEFAULT false,
    visitante_org character varying(200),
    pers_id integer,
    conexion_id integer NOT NULL
);


ALTER TABLE visitante OWNER TO postgres;

--
-- TOC entry 165 (class 1259 OID 89033168)
-- Name: visitante_visitante_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE visitante_visitante_id_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;


ALTER TABLE visitante_visitante_id_seq OWNER TO postgres;

--
-- TOC entry 1962 (class 0 OID 0)
-- Dependencies: 165
-- Name: visitante_visitante_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE visitante_visitante_id_seq OWNED BY visitante.visitante_id;


--
-- TOC entry 1759 (class 2604 OID 89033170)
-- Name: conexion conexion_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conexion ALTER COLUMN conexion_id SET DEFAULT nextval('conexion_conexion_id_seq'::regclass);


--
-- TOC entry 1761 (class 2604 OID 89033171)
-- Name: estructura est_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY estructura ALTER COLUMN est_id SET DEFAULT nextval('estructura_est_id_seq'::regclass);


--
-- TOC entry 1762 (class 2604 OID 89033172)
-- Name: lista_negra lista_negra_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lista_negra ALTER COLUMN lista_negra_id SET DEFAULT nextval('lista_negra_lista_negra_id_seq'::regclass);


--
-- TOC entry 1765 (class 2604 OID 89033173)
-- Name: menu menu_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY menu ALTER COLUMN menu_id SET DEFAULT nextval('menu_menu_id_seq'::regclass);


--
-- TOC entry 1767 (class 2604 OID 89033174)
-- Name: perfil perfil_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY perfil ALTER COLUMN perfil_id SET DEFAULT nextval('perfil_perfil_id_seq'::regclass);


--
-- TOC entry 1768 (class 2604 OID 89033175)
-- Name: rel_estructura_pabx rel_est_pabx_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rel_estructura_pabx ALTER COLUMN rel_est_pabx_id SET DEFAULT nextval('rel_estructura_pabx_rel_est_pabx_id_seq'::regclass);


--
-- TOC entry 1769 (class 2604 OID 89033176)
-- Name: rel_perfil_menu rel_perfil_menu_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rel_perfil_menu ALTER COLUMN rel_perfil_menu_id SET DEFAULT nextval('rel_perfil_menu_rel_perfil_menu_id_seq'::regclass);


--
-- TOC entry 1770 (class 2604 OID 89033177)
-- Name: rel_perfil_usuario rel_perfil_usuario_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rel_perfil_usuario ALTER COLUMN rel_perfil_usuario_id SET DEFAULT nextval('rel_perfil_usuario_rel_perfil_usuario_id_seq'::regclass);


--
-- TOC entry 1772 (class 2604 OID 89033178)
-- Name: rel_personal_estructura rel_pers_est_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rel_personal_estructura ALTER COLUMN rel_pers_est_id SET DEFAULT nextval('rel_personal_estructura_rel_pers_est_id_seq'::regclass);


--
-- TOC entry 1773 (class 2604 OID 89033179)
-- Name: rel_personal_pabx rel_pers_pabx_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rel_personal_pabx ALTER COLUMN rel_pers_pabx_id SET DEFAULT nextval('rel_personal_pabx_rel_pers_pabx_id_seq'::regclass);


--
-- TOC entry 1776 (class 2604 OID 89033180)
-- Name: usuario usuario_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuario ALTER COLUMN usuario_id SET DEFAULT nextval('usuario_usuario_id_seq'::regclass);


--
-- TOC entry 1777 (class 2604 OID 89033181)
-- Name: visita visita_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY visita ALTER COLUMN visita_id SET DEFAULT nextval('visita_visita_id_seq'::regclass);


--
-- TOC entry 1779 (class 2604 OID 89033182)
-- Name: visitante visitante_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY visitante ALTER COLUMN visitante_id SET DEFAULT nextval('visitante_visitante_id_seq'::regclass);


--
-- TOC entry 1917 (class 0 OID 89033091)
-- Dependencies: 140
-- Data for Name: conexion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY conexion (conexion_id, conexion_ip, conexion_fecha_ini, conexion_fecha_fin, rel_perfil_usuario_id) FROM stdin;
2	10.8.15.178	2017-08-30 15:33:52	2017-08-30 15:40:35	1
3	10.8.15.178	2017-08-30 15:40:41	2017-08-30 15:47:41	1
4	10.8.7.88	2017-08-30 16:18:41	2017-08-30 16:35:55	3
5	10.8.15.178	2017-08-31 09:40:50	2017-08-31 09:42:55	5
6	10.8.15.178	2017-08-31 09:57:52	2017-08-31 12:36:42	1
7	10.8.15.178	2017-08-31 12:36:42	2017-08-31 18:57:14	1
8	10.6.11.191	2017-08-31 18:57:14	2017-08-31 19:17:43	1
9	10.6.11.191	2017-08-31 19:17:43	2017-09-01 11:12:08	1
10	10.6.11.191	2017-09-01 11:12:08	2017-09-01 17:33:57	1
11	10.6.11.191	2017-09-01 17:33:57	2017-09-04 12:00:17	1
12	10.6.11.191	2017-09-04 12:00:17	2017-09-04 17:02:15	1
13	10.6.11.191	2017-09-04 17:02:15	2017-09-04 17:02:26	1
14	10.6.11.191	2017-09-05 09:55:00	2017-09-05 10:02:00	1
15	10.6.11.191	2017-09-05 11:30:55	2017-09-05 11:31:39	1
16	10.8.15.178	2017-09-05 13:55:04	2017-09-05 13:58:55	5
17	10.8.15.178	2017-09-05 13:59:17	2017-09-05 15:06:19	5
18	10.6.11.191	2017-09-05 15:48:59	2017-09-05 15:53:07	1
19	10.8.15.178	2017-09-05 16:03:32	2017-09-05 16:40:34	5
20	10.8.15.178	2017-09-05 16:40:53	2017-09-05 16:47:55	5
22	10.8.15.178	2017-09-06 08:48:06	2017-09-06 09:10:07	5
23	10.8.15.178	2017-09-06 09:33:06	2017-09-06 09:40:07	5
24	10.8.15.178	2017-09-06 09:43:49	2017-09-06 09:49:50	5
26	10.6.11.191	2017-09-06 09:59:10	2017-09-06 10:03:18	1
25	10.8.15.178	2017-09-06 09:51:43	2017-09-06 10:10:41	5
27	10.8.15.178	2017-09-06 10:17:33	2017-09-06 10:50:21	5
28	10.8.15.178	2017-09-06 10:54:11	2017-09-06 11:13:13	5
29	10.8.15.178	2017-09-06 11:13:35	2017-09-06 11:17:22	5
30	10.8.15.178	2017-09-06 11:18:17	2017-09-06 11:28:18	5
31	10.8.15.178	2017-09-06 12:03:30	2017-09-06 12:21:30	5
32	10.8.15.178	2017-09-06 13:24:03	2017-09-06 13:24:06	5
34	10.8.15.178	2017-09-06 13:45:05	2017-09-06 14:24:06	5
35	10.8.15.178	2017-09-06 14:24:25	2017-09-06 14:27:14	5
37	10.8.7.78	2017-09-06 14:38:26	2017-09-06 17:09:16	3
38	10.8.15.178	2017-09-06 17:09:16	2017-09-06 17:22:17	3
39	10.8.15.178	2017-09-07 09:56:15	2017-09-07 11:17:17	5
40	10.8.15.178	2017-09-07 11:45:49	2017-09-07 12:04:50	5
41	10.8.15.178	2017-09-07 12:05:26	2017-09-07 12:33:26	5
43	10.8.15.178	2017-09-07 12:33:58	2017-09-07 12:57:55	5
44	10.8.15.178	2017-09-07 14:50:56	2017-09-07 14:59:16	5
45	10.8.15.178	2017-09-07 14:59:26	2017-09-07 15:00:56	5
48	10.8.15.178	2017-09-07 15:08:42	2017-09-07 15:09:10	5
49	10.8.15.178	2017-09-07 15:15:03	2017-09-07 15:16:37	5
50	10.8.15.178	2017-09-07 15:25:44	2017-09-07 16:36:06	5
52	10.8.15.178	2017-09-07 16:42:23	2017-09-07 16:44:17	5
51	10.8.17.122	2017-09-07 16:24:57	2017-09-07 17:37:31	3
54	10.8.15.178	2017-09-08 13:19:37	2017-09-08 13:19:49	1
57	10.8.15.178	2017-09-08 13:45:12	2017-09-08 14:02:12	5
58	10.8.15.178	2017-09-08 14:11:20	2017-09-08 14:57:31	5
59	10.8.15.178	2017-09-08 15:02:36	2017-09-08 15:08:41	5
61	10.8.7.78	2017-09-08 15:13:52	2017-09-08 15:26:50	3
60	10.8.15.178	2017-09-08 15:09:29	2017-09-08 16:25:35	5
62	10.6.11.191	2017-09-08 16:18:43	2017-09-08 16:36:19	1
63	10.8.15.178	2017-09-08 16:45:05	2017-09-08 17:02:50	5
65	10.8.7.154	2017-09-11 09:19:02	2017-09-11 09:21:47	5
64	10.6.11.191	2017-09-08 18:45:50	2017-09-11 09:51:55	1
66	10.6.11.191	2017-09-11 09:51:55	2017-09-11 10:01:33	1
67	10.6.11.191	2017-09-11 10:01:37	2017-09-11 10:04:15	1
69	10.6.11.191	2017-09-11 15:42:09	2017-09-11 15:48:54	1
70	10.6.11.191	2017-09-11 17:46:40	2017-09-11 17:47:57	1
72	10.8.7.154	2017-09-12 13:28:59	2017-09-12 13:42:19	5
73	10.8.15.178	2017-09-12 13:42:19	2017-09-12 14:02:47	5
74	10.8.15.178	2017-09-12 14:03:30	2017-09-12 16:27:51	5
76	10.8.15.178	2017-09-13 09:00:18	2017-09-13 09:11:20	5
75	10.8.15.178	2017-09-12 16:26:03	2017-09-18 13:33:29	3
77	10.8.7.91	2017-09-18 13:33:29	2017-09-18 16:46:52	3
78	10.8.15.178	2017-09-18 16:46:52	2017-09-18 16:49:55	3
79	10.8.15.178	2017-09-19 08:57:47	2017-09-19 08:59:35	5
80	10.8.7.91	2017-09-19 16:46:05	2017-09-19 16:52:46	3
81	10.8.15.178	2017-09-20 12:17:41	2017-09-20 12:18:32	5
82	10.8.7.91	2017-09-21 08:53:52	2017-09-21 09:00:41	3
83	10.8.7.91	2017-09-21 09:13:43	2017-09-21 09:21:29	3
21	10.6.11.191	2017-09-05 16:43:17	2017-09-05 16:52:17	1
33	10.8.15.178	2017-09-06 13:24:06	2017-09-06 13:44:39	5
36	10.8.15.178	2017-09-06 14:28:32	2017-09-06 14:35:32	1
46	10.8.15.178	2017-09-07 15:01:14	2017-09-07 15:02:36	5
42	10.8.15.178	2017-09-07 12:06:34	2017-09-07 16:24:57	3
53	10.8.15.178	2017-09-07 17:37:31	2017-09-07 18:08:35	3
55	10.8.15.178	2017-09-08 13:20:01	2017-09-08 13:26:16	5
68	10.8.7.154	2017-09-11 10:04:05	2017-09-11 11:05:01	5
47	10.8.15.178	2017-09-07 15:05:20	2017-09-07 15:05:51	5
56	10.8.15.178	2017-09-08 13:28:06	2017-09-08 13:34:50	5
1	1.1.1	2017-08-30 15:18:52	2017-08-30 15:18:54	1
71	10.6.11.191	2017-09-12 09:42:47	2017-09-21 14:46:47	1
84	10.6.11.191	2017-09-21 14:46:47	2017-09-21 14:56:32	1
85	10.6.11.191	2017-09-21 14:56:33	2017-09-21 19:22:47	1
86	10.8.15.178	2017-09-21 19:22:47	2017-09-22 14:17:39	1
87	10.6.11.191	2017-09-22 14:17:39	2017-09-22 14:47:55	1
88	10.6.11.191	2017-09-22 14:47:57	2017-09-22 15:40:05	1
89	::1	2017-09-27 15:25:18	2017-10-04 08:58:57	1
90	::1	2017-10-04 08:58:57	2017-10-04 11:53:24	1
91	10.8.15.178	2017-10-06 09:33:11	2017-10-06 09:33:32	1
93	10.8.15.178	2017-10-06 10:01:55	2017-10-06 10:01:57	1
92	10.8.15.178	2017-10-06 09:33:53	2017-10-06 10:02:03	7
94	10.8.15.178	2017-10-06 10:02:03	2017-10-06 10:17:03	7
95	10.8.15.178	2017-10-06 10:27:55	2017-10-10 11:24:32	1
96	10.6.11.81	2017-10-10 11:24:32	2017-10-10 11:24:50	1
97	10.6.11.81	2017-10-10 11:35:24	2017-10-10 11:46:55	1
98	10.6.11.81	2017-10-10 11:47:00	2017-10-10 12:02:09	1
99	10.6.11.81	2017-10-10 14:31:44	2017-10-10 14:46:51	1
100	10.6.11.81	2017-10-11 08:08:01	2017-10-11 08:11:26	1
101	10.6.11.81	2017-10-11 08:11:26	2017-10-11 08:18:20	1
102	10.8.15.149	2017-10-11 08:18:20	2017-10-11 08:19:00	1
103	10.8.15.149	2017-10-11 08:19:01	2017-10-11 08:34:23	1
104	10.8.15.149	2017-10-11 09:42:40	2017-10-11 09:44:03	1
105	10.8.15.149	2017-10-11 09:46:19	2017-10-11 16:00:17	1
106	10.8.15.149	2017-10-11 16:00:17	2017-10-11 16:02:43	1
107	10.8.15.149	2017-10-11 16:02:43	2017-10-11 16:04:04	1
108	10.8.15.149	2017-10-11 16:04:04	2017-10-16 08:50:04	1
109	10.8.15.149	2017-10-16 08:50:04	2017-10-16 08:57:46	1
110	10.8.15.149	2017-10-16 08:57:46	2017-10-16 09:13:06	1
111	::1	2017-10-16 11:49:59	2017-10-16 11:51:04	1
112	10.8.15.248	2017-10-17 10:24:27	2017-10-18 08:46:19	1
113	10.8.15.178	2017-10-18 08:46:19	2017-10-18 08:47:21	1
114	10.8.15.178	2017-10-18 10:49:32	2017-10-18 10:49:45	1
115	10.8.15.178	2017-10-18 10:50:03	2017-10-18 11:07:57	1
116	10.8.15.178	2017-10-18 11:15:47	2017-10-18 11:30:48	1
117	10.8.15.178	2017-10-26 14:22:28	2017-10-26 14:37:56	1
118	10.8.15.178	2017-10-26 15:46:34	2017-11-03 09:14:26	1
119	10.8.15.178	2017-11-03 09:14:26	2017-11-03 09:16:09	1
120	10.8.15.248	2017-11-18 10:49:08	2017-11-18 10:52:42	1
121	10.8.15.149	2017-11-28 14:39:23	2017-11-28 14:54:36	1
122	10.8.15.149	2017-11-28 15:05:40	2017-11-28 15:06:31	1
123	10.8.15.178	2017-12-04 14:48:26	2017-12-05 11:03:36	1
124	10.8.15.178	2017-12-05 11:03:36	2017-12-05 11:07:36	1
125	10.8.15.178	2018-01-09 14:40:58	2018-01-09 14:50:01	1
126	10.8.15.178	2018-01-09 14:50:01	2018-01-10 09:59:44	1
127	10.8.15.178	2018-01-10 09:59:44	2018-01-10 11:34:32	1
128	10.8.15.178	2018-01-10 11:34:32	2018-01-11 11:10:54	1
129	10.8.15.149	2018-01-11 11:10:54	2018-01-11 11:15:00	1
130	10.8.15.149	2018-02-01 10:16:39	2018-02-01 10:35:54	1
131	10.8.15.149	2018-02-01 12:05:57	2018-02-06 09:03:16	1
132	10.8.15.241	2018-02-06 09:03:16	2018-02-06 09:05:08	1
133	10.8.15.241	2018-02-06 09:05:08	2018-02-06 09:40:53	1
134	10.8.15.178	2018-02-06 09:40:53	2018-02-06 09:55:54	1
135	10.8.15.149	2018-02-06 15:00:19	2018-02-06 15:01:55	1
136	10.6.11.135	2018-02-06 15:26:40	2018-02-06 15:27:13	1
137	10.6.11.135	2018-02-06 15:27:13	2018-02-06 15:33:44	1
138	10.8.15.149	2018-02-07 09:59:30	2018-02-15 09:12:09	1
139	10.8.15.178	2018-02-15 09:12:09	2018-02-15 09:30:41	1
140	10.8.15.178	2018-02-16 10:03:04	2018-02-16 10:03:25	1
141	10.8.15.178	2018-02-16 10:03:29	2018-02-16 10:04:18	1
142	10.8.15.178	2018-02-21 16:06:50	2018-02-21 16:07:40	1
143	10.8.15.178	2018-02-26 15:44:29	2018-02-26 15:47:51	1
144	10.8.15.178	2018-02-28 10:48:07	2018-03-09 14:44:56	1
145	10.8.15.178	2018-03-09 14:44:56	2018-03-09 15:00:27	1
146	10.8.15.178	2018-03-12 12:06:27	2018-03-12 12:21:42	1
147	10.8.15.178	2018-03-14 12:10:30	2018-03-14 12:13:23	1
148	10.8.15.178	2018-03-14 12:14:08	2018-03-14 12:14:40	2
149	10.8.15.178	2018-03-14 12:32:37	2018-03-14 12:36:35	1
150	10.8.15.178	2018-03-14 14:15:13	2018-03-15 11:54:12	1
151	10.8.15.178	2018-03-15 11:54:12	2018-03-15 12:09:34	1
152	10.8.15.178	2018-03-15 13:46:40	2018-03-15 14:02:02	1
153	10.8.15.178	2018-03-15 14:48:09	\N	1
\.


--
-- TOC entry 1963 (class 0 OID 0)
-- Dependencies: 141
-- Name: conexion_conexion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('conexion_conexion_id_seq', 153, true);


--
-- TOC entry 1919 (class 0 OID 89033096)
-- Dependencies: 142
-- Data for Name: estructura; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY estructura (est_id, est_sigla, est_desc, est_activo, est_padre_id, conexion_id) FROM stdin;
2	CCO	EDIFICIO CENTRO DE CONTROL DE OPERACIONES	t	1	2
3	\N	PISO 1	t	2	4
4	\N	MANDO CENTRALIZADO	t	3	4
6	\N	PISO 2	t	2	17
1	METRO	C.A METRO DE CARACAS	t	0	1
8	\N	GERENCIA DE TELECOMUNICACIONES	f	6	17
10	\N	UNIDAD DE REDES	f	7	17
49	\N	OFICINA DE DIVISION DE APOYO TECNICO	t	40	33
29	\N	SEBIN	t	27	17
52	\N	GERENCIA GENERAL DE TECNOLOGIA DE LA INFORMACION	t	41	39
9	\N	UNIDAD DE TELEFONIA	f	6	17
53	\N	GERENCIA DE SOPORTE TECNICO	t	41	39
54	\N	OFICINA DE SERVIDORES	t	41	39
55	\N	CENTRO DE MANTENIMIENTO TECNOLOGICO	t	41	39
16	\N	CENTRO DE CONTROL OPERATIVO	f	7	17
56	\N	CENTRO DE SOPORTE OFIMATICO	f	55	39
17	\N	CENTRO DE CONTROL DE FALLAS	f	7	17
18	\N	CENTRO DE CONTROL OPERATIVO	t	6	17
20	\N	PISO 3	t	2	17
21	\N	COORDINACION DE APOYO LOGISTICO	t	20	17
22	\N	GERENCIA DE ORGANIZACION Y PROCESO	t	20	17
23	CCS	CENTRO DE CONTROL DE SEGURIDAD	t	20	17
25	\N	GERENCIA DE SEGURIDAD DE LA INFORMACION	t	20	17
26	\N	CENTRO DE CONTROL DE METROBUS DE FLOTA DE REGION CENTRAL	t	20	17
27	\N	PISO 4	t	2	17
28	\N	COORDINACION DE EVENTOS ESPECIALES	t	27	17
30	\N	AUDITORIO	t	27	17
31	\N	PISO 5	t	2	17
32	\N	RECEPCION	t	31	17
11	\N	UNIDAD DE REDES	t	6	17
14	\N	UNIDAD DE TELEFONIA	t	6	17
7	\N	GERENCIA DE TELECOMUNICACIONES	f	6	17
39	PB	RECEPCION PLANTA BAJA	f	2	22
40	\N	PISO 6	t	2	23
41	\N	PISO 7	t	2	23
35	\N	CAFETIN (JUAN LOPEZ)	t	31	17
57	\N	CENTRO DE SOPORTE OFIMATICO	t	41	39
44	\N	COORDINACION DE CENTRO DE CONTROL DE SEGURIDAD	t	20	27
46	\N	GERENCIA GENERAL DE OPERACIONES	t	40	33
58	\N	CENTRO DE SOPORTE TECNOLOGICO	t	41	39
45	\N	GERENCIA GENERAL DE OPERACIONES	f	40	33
48	\N	AREA DE ESTADISTICAS	t	40	33
59	\N	OFICINA DE APOYO Y CONTROL DE OPERACIONES Y MANTENIMIENTO DE LOS SISTEMAS POR CABLES Y SUB-URBANOS	t	31	40
50	\N	OFICINA DE APOYO TECNICO	f	40	33
47	\N	AREA DE ESTADISTICAS	f	40	33
33	\N	VICEPRESIDENCIA DE TRANSPORTE SUB-URBANO Y TELEFERICO (CONTROL DE APOYO)	f	31	17
34	\N	GERENCIA COORPORATIVA DE OPERACIONES	f	31	17
36	\N	GERENCIA COORPORATIVA DE LOS SISTEMAS POR CABLES Y SUB-URBANOS	f	31	17
37	\N	VICEPRESIDENCIA DE TRANSPORTE	f	31	17
38	\N	AOP	f	31	17
60	\N	GERENCIA COORPORATIVA DE MANTENIMIENTO Y OPERACION DE TRANSPORTE POR CABLES Y SUB-URBANOS	t	31	40
61	\N	GERENCIA GENERAL DE MANTENIMIENTO Y OPERACION DE TRANSPORTE POR CABLES Y SUB-URBANOS	t	31	41
62	\N	GERENCIA COORPORATIVA DE OPERACIONES	t	31	41
63	\N	OFICINA DE APOYO Y CONTROL DE OPERACIONES	t	31	41
51	\N	AREA DE CONTROL DE VENTAS DE BOLETOS Y TARJETAS	t	40	34
64	\N	GERENCIA DEL CENTRO DE CONTROL DE OPERACIONES	t	40	43
65	\N	SOTANO 1	t	2	50
66	\N	SERVICIOS GENERALES	t	65	50
67	\N	OFICINA DE DOCUMENTACION Y CORRESPONDENCIA	t	65	50
68	\N	SOTANO 2	t	2	50
69	\N	OFICINA DE VENTAS EXTERNAS DE RECAUDACION Y VALORES	t	68	50
70	\N	ALMACEN DE RECAUDACION Y VALORES	t	68	50
71	\N	OFICINA DE PRODUCCION DE RECAUDACION Y VALORES INGRESOS PROPIOS	t	68	50
72	\N	UNIDAD DE MANEJO DE VALORES DE METROBUS	t	68	50
73	\N	RECURSOS HUMANO DE LA OFICINA DE RECAUDACION Y VALORES	t	68	50
74	\N	DESPACHO DEL JEFE DE OFICINA DE RECAUDACION Y VALORES	t	68	50
76	\N	SOTANO 3	t	2	50
77	\N	COORDINACION DE COBRO DE PASAJE Y MANTENIMIENTO	t	76	50
78	\N	CORRECTIVO DE COBRO DE PASAJE Y MANTENIMIENTO	t	76	50
79	\N	PREVENTIVO Y METROBUS DE COBRO DE PASAJE Y MANTENIMIENTO	t	76	50
80	\N	LABORATORIO DE COBRO DE PASAJE Y MANTENIMIENTO	t	76	50
81	\N	ALMACEN DE COBRO DE PASAJE Y MANTENIMIENTO	t	76	50
82	\N	UNIDAD DE SOPORTE DE COBRO DE PASAJE Y MANT.	t	76	50
83	\N	UNIDAD DE SOPORTE DE COBRO DE PASAJE Y MANT.	f	76	50
84	\N	GESTION Y SEGUIMIENTO DE COBRO DE PASAJE Y MANT.	t	76	50
86	\N	UNIVERSIDAD	t	85	50
88	\N	UNIDAD DE RADIO	t	6	58
89	\N	ANUNCIOS AL PUBLICO	t	6	58
90	\N	CCTV	t	6	58
91	\N	DIVISION TECNICA DE OPERACIONES DE SISTEMAS POR CABLES Y SUB-URBANO	t	31	58
75	\N	OFICINA DE LOGISTICA Y RECAUDACION DE VALORES	t	68	50
5	OSSP	OFICINA DE SEGURIDAD PATRIMONIAL	t	3	17
87	\N	GERENCIA DE TELECOMUNICACIONES	f	6	58
92	\N	GERENCIA DE TELECOMUNICACIONES	t	68	60
94	\N	OFICINA DE INSPECTORES	t	18	60
95	\N	CONTROLADORES DE TRAFICO	t	18	60
97	\N	PERSONAL EN FORMACION	t	18	60
12	\N	GRUPO DE REDES	f	6	17
19	CCF	CENTRO DE CONTROL DE FALLAS	t	6	17
93	\N	UNIDAD DE APOYO ADMINISTRATIVO DE TELECOMUNICACIONES	f	68	60
98	\N	OFICINA DE PROYECTO DE TELECOMUNICACIONES	f	68	63
99	\N	OFICINA DE APOYO DE TELECOMUNICACIONES	t	92	74
100	\N	UNIDAD DE PROYECTO DE TELECOMUNICACIONES	t	92	74
85	\N	SOTANO 4	t	2	50
96	\N	CONTROLADORES DE MLT	f	18	60
24	\N	OFICINA DE COBERTURA	t	20	17
\.


--
-- TOC entry 1964 (class 0 OID 0)
-- Dependencies: 143
-- Name: estructura_est_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('estructura_est_id_seq', 100, true);


--
-- TOC entry 1921 (class 0 OID 89033102)
-- Dependencies: 144
-- Data for Name: lista_negra; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY lista_negra (lista_negra_id, lista_negra_observ, pers_id, visitante_id, conexion_id) FROM stdin;
\.


--
-- TOC entry 1965 (class 0 OID 0)
-- Dependencies: 145
-- Name: lista_negra_lista_negra_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('lista_negra_lista_negra_id_seq', 0, true);


--
-- TOC entry 1923 (class 0 OID 89033107)
-- Dependencies: 146
-- Data for Name: menu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY menu (menu_id, menu_desc, menu_link, menu_icono, menu_orden, menu_activo, menu_padre_id) FROM stdin;
2	Visitas	controlador/visita/visita.php	multimedia/imagen/menu/visita.png	2	t	\N
3	Datos Generales	#	multimedia/imagen/menu/referencial.png	3	t	\N
1	Visitantes	controlador/visitante/visitante.php	multimedia/imagen/menu/visitante.png	1	t	\N
4	Estructura	controlador/referencial/referencial.php?case=0	\N	1	t	3
5	Usuario	controlador/referencial/referencial.php?case=1&estado=inicial	\N	1	t	3
\.


--
-- TOC entry 1966 (class 0 OID 0)
-- Dependencies: 147
-- Name: menu_menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('menu_menu_id_seq', 5, true);


--
-- TOC entry 1925 (class 0 OID 89033114)
-- Dependencies: 148
-- Data for Name: perfil; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY perfil (perfil_id, perfil_desc, perfil_activo) FROM stdin;
1	TRANSCRIPTOR	t
2	SUPERVISOR	t
3	SISTEMAS	t
\.


--
-- TOC entry 1967 (class 0 OID 0)
-- Dependencies: 149
-- Name: perfil_perfil_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('perfil_perfil_id_seq', 3, true);


--
-- TOC entry 1927 (class 0 OID 89033120)
-- Dependencies: 150
-- Data for Name: rel_estructura_pabx; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY rel_estructura_pabx (rel_est_pabx_id, pabx, est_id) FROM stdin;
1	\N	2
2	\N	3
3	4315	4
5	\N	6
6	\N	7
7	\N	8
8	\N	9
9	\N	10
44	\N	49
13	\N	16
14	\N	17
15	\N	18
17	\N	20
18	\N	21
19	\N	22
20	\N	23
22	\N	25
23	\N	26
24	\N	27
25	\N	28
27	\N	30
28	\N	31
29	\N	32
30	\N	33
31	\N	34
33	\N	36
34	\N	37
35	\N	38
10	\N	11
11	\N	12
12	\N	14
36	4317/4308	39
37	\N	40
38	\N	41
32	4827	35
39	\N	44
40	\N	45
41	\N	46
42	\N	47
43	\N	48
45	\N	50
26	4654	29
47	\N	52
48	\N	53
49	\N	54
50	\N	55
51	\N	56
52	\N	57
53	4444	58
54	\N	59
55	\N	60
56	\N	61
57	\N	62
58	\N	63
46	\N	51
59	\N	64
60	\N	65
61	\N	66
62	\N	67
63	\N	68
64	\N	69
65	\N	70
66	\N	71
67	\N	72
68	\N	73
69	\N	74
71	\N	76
72	\N	77
73	\N	78
74	\N	79
75	\N	80
76	\N	81
77	\N	82
78	\N	83
79	\N	84
81	\N	86
82	\N	87
83	\N	88
84	\N	89
85	\N	90
86	\N	91
70	\N	75
4	4362	5
87	\N	92
88	\N	93
89	\N	94
90	\N	95
91	\N	96
92	\N	97
93	\N	98
16	\N	19
94	\N	99
95	\N	100
80	4850/4867	85
21	OCOB	24
\.


--
-- TOC entry 1968 (class 0 OID 0)
-- Dependencies: 151
-- Name: rel_estructura_pabx_rel_est_pabx_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('rel_estructura_pabx_rel_est_pabx_id_seq', 95, true);


--
-- TOC entry 1929 (class 0 OID 89033125)
-- Dependencies: 152
-- Data for Name: rel_perfil_menu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY rel_perfil_menu (rel_perfil_menu_id, perfil_id, menu_id) FROM stdin;
1	1	1
2	1	2
3	2	1
4	2	2
5	2	3
6	2	4
7	2	5
8	3	1
9	3	2
10	3	3
11	3	4
12	3	5
\.


--
-- TOC entry 1969 (class 0 OID 0)
-- Dependencies: 153
-- Name: rel_perfil_menu_rel_perfil_menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('rel_perfil_menu_rel_perfil_menu_id_seq', 12, true);


--
-- TOC entry 1931 (class 0 OID 89033130)
-- Dependencies: 154
-- Data for Name: rel_perfil_usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY rel_perfil_usuario (rel_perfil_usuario_id, usuario_id, perfil_id) FROM stdin;
2	2	3
3	3	2
4	4	2
5	5	2
6	6	2
1	1	3
7	7	3
8	8	3
9	9	2
\.


--
-- TOC entry 1970 (class 0 OID 0)
-- Dependencies: 155
-- Name: rel_perfil_usuario_rel_perfil_usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('rel_perfil_usuario_rel_perfil_usuario_id_seq', 9, true);


--
-- TOC entry 1933 (class 0 OID 89033135)
-- Dependencies: 156
-- Data for Name: rel_personal_estructura; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY rel_personal_estructura (rel_pers_est_id, pers_id, rel_pers_activo, pabx, est_id, conexion_id) FROM stdin;
1	10753	t	4321	21	19
2	10936	t	4858	21	19
3	11771	t	4316	21	19
4	14988	t	4571	21	19
5	9586	t	4440	21	19
6	8865	t	4855	21	19
7	9173	t	4378	21	19
8	9312	t	4246	21	19
9	2431	t	4860	21	19
10	12052	t	4860	21	19
11	9052	t	4871	22	19
12	9263	t	4312	22	19
13	9708	t	4339	22	19
14	638	t	4809	22	19
15	9707	t	4856	22	19
16	16187	t	4679	22	25
17	14813	t	4845	25	25
18	1538	t	4273	25	25
19	12936	t	4256	25	25
20	20	t	4613	25	25
21	14142	t	4661	25	25
22	15489	t	4854	25	25
105	11498	t	4389	49	34
24	15687	t	4334	28	25
25	9607	t	4881	23	27
26	14207	t	4881	23	27
27	16166	t	4881	23	27
28	21079	t	3970	23	27
29	21078	t	3970	23	27
30	1000	t	4882	23	27
31	2182	t	7777	23	27
32	983	t	3970	23	27
33	998	t	3970	23	27
34	21122	t	3970	23	27
35	1017	t	4882	23	27
36	14994	t	7777	23	27
37	2091	t	4882	23	27
38	15003	t	3970	23	27
39	1074	t	4881	23	27
40	21108	t	4881	23	27
41	2185	t	4882	23	27
42	2715	t	3970	23	27
43	276	t	4882	23	27
44	21134	t	7777	23	27
45	21129	t	3970	23	27
46	1068	t	7777	23	27
49	2208	t	4544	44	27
47	14212	t	4544/4846	44	27
48	15253	t	4544/4846	44	27
50	2146	t	4544	44	27
51	15782	t	4545	24	28
52	13546	t	4546	24	28
53	13858	t	4610	24	28
54	14020	t	4545	24	28
55	14696	t	4546	24	28
56	15788	t	4610	24	28
57	13550	t	4545	24	28
58	15107	t	4610	24	28
59	15789	t	4610	24	28
60	14987	t	4546	24	28
61	278	t	4546	24	28
62	15778	t	4545	24	28
63	11681	t	4610	24	28
64	20684	t	4336	28	31
65	9980	t	4379	46	33
141	9670	t	4245	49	39
67	9750	t	4560	46	33
142	9379	t	4382	49	39
69	10891	t	4553	46	33
143	10344	t	4350	49	39
71	15456	t	4553	46	33
144	10178	t	4244	49	39
73	21362	t	4201	46	33
145	11044	t	4263	49	39
75	2041	t	4201	46	33
146	8990	t	4253	49	39
77	1932	t	4201	46	33
147	2319	t	4307	49	39
79	11416	t	4201	46	33
148	9494	t	4205	49	39
81	13948	t	4201	46	33
149	9581	t	4492	49	39
83	11038	t	4201	46	33
150	12673	t	4250	49	39
85	13957	t	4201	46	33
151	11660	t	4238	49	39
87	11455	t	4201	46	33
152	13102	t	4228	49	39
89	11090	t	4201	46	33
153	3	t	4329	52	39
91	8678	t	4201	46	33
154	15325	t	4270	52	39
93	14023	t	4201	46	33
155	11628	t	4337	52	39
95	302	t	4201	46	33
156	13262	t	4270	52	39
97	15005	t	4201	46	33
157	1532	t	4290	52	39
158	14371	t	4290	52	39
101	13685	t	4201	46	33
159	10113	t	4337	52	39
103	10275	t	4204	48	33
160	18	t	4322	53	39
106	10868	t	4240	49	34
161	10211	t	4271	53	39
107	2153	t	4282	49	34
108	11089	t	4300	51	34
109	715	t	4300	51	34
110	14256	t	4244	51	34
111	732	t	4254	51	34
112	9924	t	4254	51	34
113	11088	t	4217	51	34
114	1990	t	4236	51	34
115	10637	t	4801	26	34
116	10966	t	4813	26	34
117	11244	t	4694	26	34
118	9291	t	4694	26	34
119	12495	t	4804	26	34
120	12500	t	4801	26	34
121	11246	t	4801	26	34
122	11541	t	4804	26	34
123	11145	t	4694	26	34
124	10617	t	4801	26	34
125	12608	t	4694	26	34
126	9605	t	4801	26	34
127	11238	t	4813	26	34
128	9254	t	4694	26	34
129	11212	t	4801	26	34
130	10444	t	4801	26	34
131	10191	t	4694	26	34
132	10439	t	4694	26	34
133	10603	t	4804	26	34
134	12623	t	4804	26	34
135	9429	t	4694	26	34
136	10590	t	4804	26	34
137	14283	t	4804	26	34
138	10169	t	4813	26	34
139	9101	t	4801	26	34
140	14692	t	4801	26	34
162	13886	t	4271	53	39
163	10761	t	4367	54	39
164	12704	t	4386	54	39
165	3423	t	4386	54	39
166	10660	t	4291	54	39
167	10202	t	4357	54	39
168	10419	t	4357	54	39
169	10655	t	4367	54	39
170	9668	t	4890	54	39
171	11611	t	4258	54	39
172	3298	t	4396	54	39
173	15336	t	4485	54	39
174	15368	t	4591	54	39
175	3855	t	4591	54	39
176	21384	t	4396	54	39
177	12864	t	4859	55	39
178	14027	t	4859	55	39
179	15349	t	4859	55	39
180	15664	t	4358	55	39
181	2487	t	4358	55	39
182	17352	t	4358	55	39
183	19889	t	4514	57	39
184	19976	t	4819	57	39
185	2447	t	4844	57	39
186	13894	t	4485	57	39
187	15472	t	4844	58	39
188	16330	t	3932	58	39
189	14609	t	3930	58	39
190	21490	t	3933	58	39
191	11027	t	4586	59	40
192	11377	t	4557	59	40
193	15517	t	4625	59	40
194	15179	t	4513	59	40
195	11598	t	4576	59	40
196	10759	t	4562	59	40
197	10941	t	4600	60	40
198	1428	t	4601	60	41
199	19122	t	4604	60	41
200	8971	t	4435	61	41
201	2152	t	4435	61	41
202	8156	t	4490	62	41
203	1238	t	4226	62	41
204	16198	t	4410	62	41
205	17100	t	4839	62	41
206	13368	t	4249	63	41
207	2142	t	4891	63	41
208	13414	t	4368	63	41
209	13393	t	4368	63	41
210	9306	t	4353/4207	64	43
211	9764	t	4398	64	43
212	2506	t	4398	64	43
213	20439	t	4398	64	43
214	8626	t	4207	64	43
225	13081	t	4328	66	50
226	14276	t	4342	67	50
227	14277	t	4325	67	50
228	1551	t	4375	69	50
229	15250	t	4375	69	50
230	620	t	4375	69	50
231	13875	t	4301	70	50
232	14121	t	4374	71	50
233	11993	t	4302	72	50
234	10098	t	4239	72	50
235	424	t	4372	73	50
236	15816	t	4372	73	50
237	10736	t	4343-4225	74	50
238	10121	t	4452	75	50
239	15819	t	4209	75	50
240	15832	t	4209	75	50
241	14244	t	4452	75	50
242	2928	t	4452	75	50
243	8988	t	4452	75	50
244	15066	t	4215	77	50
245	15065	t	4401	77	50
246	551	t	4454	77	50
247	553	t	4304	77	50
248	15064	t	4390	77	50
249	15063	t	4430	78	50
250	15314	t	4430	78	50
251	496	t	4430	78	50
252	497	t	4430	78	50
253	500	t	4430	78	50
254	501	t	4430	78	50
255	502	t	4430	78	50
256	505	t	4430	78	50
257	512	t	4430	78	50
258	514	t	4430	78	50
259	1491	t	4430	78	50
260	549	t	4430	78	50
261	555	t	4430	78	50
262	557	t	4430	78	50
263	560	t	4430	78	50
264	561	t	4430	78	50
265	562	t	4430	78	50
266	564	t	4430	78	50
267	566	t	4430	78	50
268	1471	t	4430	78	50
269	5027	t	4430	78	50
270	19814	t	4430	78	50
271	14287	t	4433	79	50
272	1490	t	4433	79	50
273	15062	t	4433	79	50
274	504	t	4433	79	50
275	517	t	4433	79	50
276	563	t	4433	79	50
277	506	t	4483	80	50
278	515	t	4483	80	50
279	552	t	4483	80	50
280	554	t	4483	80	50
281	556	t	4483	80	50
282	1469	t	4483	80	50
283	1492	t	4483	80	50
284	2975	t	4483	80	50
285	4329	t	4483	80	50
286	19813	t	4483	80	50
287	19812	t	4483	80	50
288	19815	t	4483	80	50
289	558	t	4355	81	50
290	567	t	4355	81	50
291	1461	t	4355	81	50
292	19816	t	4355	81	50
293	15240	t	4869	82	50
294	524	t	4869	82	50
295	12713	t	4869	82	50
296	13140	t	4305	84	50
297	14130	t	4305	84	50
298	20752	t	4305	84	50
99	8568	t	4333	30	33
299	9036	t	4301	70	57
300	13878	t	4301	70	57
301	1548	t	4301	70	57
302	1544	t	4301	70	57
303	13909	t	4301	70	57
304	1541	t	4301	70	57
305	1560	t	4301	70	57
306	1550	t	4301	70	57
307	1559	t	4301	70	57
308	1553	t	4301	70	57
309	9259	t	4301	70	57
310	1554	t	4301	70	57
311	3502	t	4584	14	58
312	12596	t	4393	14	58
313	3370	t	4393	14	58
314	12568	t	4393	14	58
315	3429	t	4584	14	58
316	17970	t	4393	14	58
317	11696	t	4393	14	58
324	398	t	4866	88	58
325	11165	t	4369	89	58
326	12503	t	4311	90	58
327	9538	t	4332	91	58
328	10250	t	4621	91	58
329	14259	t	4362	5	60
330	13558	t	4362	5	60
331	13867	t	4362	5	60
332	15234	t	4362	5	60
318	9218	t	4214	11	58
333	14245	t	4362	5	60
335	15885	t	4285	4	60
336	14412	t	4285	4	60
338	15898	t	4285	4	60
343	14521	t	4825	4	60
344	12445	t	4825	4	60
346	8160	t	4266	94	60
345	8146	t	4266	94	60
347	9380	t	4266	94	60
348	9400	t	4266	94	60
349	9777	t	4266	94	60
350	10518	t	4266	94	60
351	8931	t	4266	94	60
352	9453	t	4266	94	60
353	9778	t	4266	94	60
354	9990	t	4310	95	60
355	11037	t	4310	95	60
356	2833	t	4310	95	60
357	9104	t	4310	95	60
358	9816	t	4310	95	60
359	13376	t	4310	95	60
360	13731	t	4310	95	60
361	13103	t	4310	95	60
362	11070	t	4310	95	60
363	13377	t	4310	95	60
364	9828	t	4310	95	60
365	13476	t	4310	95	60
366	9771	t	4370	95	60
367	11321	t	4370	95	60
368	9513	t	4370	95	60
369	8955	t	4370	95	60
370	10504	t	4370	95	60
371	9119	t	4370	95	60
372	10261	t	4370	95	60
373	9964	t	4370	95	60
374	13040	t	4370	95	60
375	9649	t	4370	95	60
376	11107	t	4370	95	60
377	13111	t	4370	95	60
378	9118	t	4370	95	60
379	11417	t	4370	95	60
380	9313	t	4370	95	60
381	14334	t	4310	95	60
382	11505	t	4370	95	60
383	11520	t	4310	95	60
384	12555	t	4370	95	60
385	13983	t	4310	95	60
386	10166	t	4310	95	60
387	12454	t	4310	95	60
388	11198	t	4310	95	60
389	9409	t	4310	95	60
390	9911	t	4370	95	60
391	9782	t	4370	95	60
392	10819	t	4310	95	60
393	12603	t	4310	95	60
394	13525	t	4310	95	60
395	13369	t	4370	95	60
396	9383	t	4370	95	60
397	12558	t	4310	95	60
398	15430	t	4370	97	60
399	11040	t	4370	97	60
400	11407	t	4370	97	60
401	10693	t	4370	97	60
402	12593	t	4866	88	63
403	3488	t	4866	88	63
404	15306	t	4866	88	63
406	16437	t	4866	88	63
408	4463	t	4468	11	68
409	5524	t	4468	11	68
410	611	t	4947	11	68
411	14411	t	4947	11	68
412	14541	t	4468	11	68
413	11591	t	4468	11	68
414	789	t	4947	11	68
415	14520	t	4947	11	68
416	11615	t	4261	88	68
407	15236	t	4261	88	63
405	14970	t	4261	88	63
417	4608	t	4369	89	68
418	5735	t	4234	89	68
419	15072	t	4369	89	68
420	21482	t	4234	89	68
421	1900	t	4286	90	68
422	20344	t	4286	90	68
423	12706	t	4311	90	68
424	1462	t	4286	90	68
425	3427	t	4311	90	68
426	754	t	4286	90	68
427	12840	t	4286	90	68
462	13458	t	4374	71	73
463	8761	t	4374	71	73
464	2337	t	4374	71	73
465	12418	t	4374	71	73
466	11753	t	4374	71	73
467	12081	t	4374	71	73
468	7162	t	4374	71	73
469	12074	t	4374	71	73
470	15495	t	4374	71	73
430	9870	t	4387	19	68
428	12898	t	3737	19	68
429	2486	t	3737	19	68
431	12414	t	4500	19	68
432	12473	t	4500	19	68
433	1908	t	4624	19	68
434	10796	t	4624	19	68
435	10850	t	4678	19	68
436	9868	t	4678	19	68
437	1639	t	4678	19	68
438	1935	t	4387	19	68
439	10364	t	4387	19	68
440	9148	t	3737	19	68
441	11230	t	3737	19	68
442	10365	t	3737	19	68
443	9871	t	4500	19	68
444	10574	t	4500	19	68
445	1233	t	4500	19	68
446	9996	t	4624	19	68
447	10074	t	4624	19	68
448	1910	t	4678	19	68
449	3985	t	4678	19	68
450	10233	t	4678	19	68
451	9999	t	4678	19	68
452	11443	t	4378	19	68
453	10886	t	4378	19	68
454	1931	t	3737	19	68
455	8910	t	3737	19	68
456	10797	t	3737	19	68
457	10020	t	3737	19	68
458	8932	t	4500	19	68
459	1933	t	4500	19	68
460	9392	t	4678	19	68
461	1904	t	4387	19	68
473	10899	t	4212	99	74
474	702	t	4848	100	74
475	3669	t	4949	100	74
476	5670	t	4359	100	74
477	518	t	4359	100	74
478	19	t	4213	92	74
334	9864	t	4371	4	60
337	15899	t	4498	4	60
339	1939	t	4315	4	60
340	16154	t	4285	4	60
341	16155	t	4495	4	60
342	15891	t	4315	4	60
479	95	t	4572	32	76
\.


--
-- TOC entry 1971 (class 0 OID 0)
-- Dependencies: 157
-- Name: rel_personal_estructura_rel_pers_est_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('rel_personal_estructura_rel_pers_est_id_seq', 479, true);


--
-- TOC entry 1935 (class 0 OID 89033141)
-- Dependencies: 158
-- Data for Name: rel_personal_pabx; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY rel_personal_pabx (rel_pers_pabx_id, pers_id, pabx) FROM stdin;
\.


--
-- TOC entry 1972 (class 0 OID 0)
-- Dependencies: 159
-- Name: rel_personal_pabx_rel_pers_pabx_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('rel_personal_pabx_rel_pers_pabx_id_seq', 0, true);


--
-- TOC entry 1937 (class 0 OID 89033146)
-- Dependencies: 160
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY usuario (usuario_id, usuario_login, usuario_clave, usuario_activo, pers_id, est_id) FROM stdin;
4	080350	METRO	t	15253	2
6	110849	METRO	t	2146	2
3	070005	236949254A9D8189D499C4F706FAA43BA8EF29AA	t	14212	2
5	110840	78B2EBB74753372586BDF313B443B0F84EE47528	t	2208	2
1	100473	12A170331E7B4578E98646C041C6D235D4EC90D8	t	3924	2
7	150104	3BB51ECC3CD4F79F4B0DDEA8BB074FD969F0E151	t	18751	2
8	070074	METRO	t	14170	2
9	060584	METRO	t	13857	2
2	950003	8C8475F392D243EF737687AE53241740C72444F6	t	12426	2
\.


--
-- TOC entry 1973 (class 0 OID 0)
-- Dependencies: 161
-- Name: usuario_usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('usuario_usuario_id_seq', 9, true);


--
-- TOC entry 1939 (class 0 OID 89033153)
-- Dependencies: 162
-- Data for Name: visita; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY visita (visita_id, visita_cod, visita_tipo, visita_observ, visita_fecha_ent, visita_fecha_sal, visitante_id, est_id, pers_id, conexion_id) FROM stdin;
1	CCO2017000001	LABORAL	PRUEBA	2017-09-21 14:56:51	2018-01-09 14:41:16	1	4	9864	85
\.


--
-- TOC entry 1974 (class 0 OID 0)
-- Dependencies: 163
-- Name: visita_visita_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('visita_visita_id_seq', 1, true);


--
-- TOC entry 1941 (class 0 OID 89033161)
-- Dependencies: 164
-- Data for Name: visitante; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY visitante (visitante_id, visitante_cedula, visitante_nombre, visitante_apellido, visitante_telefono, visitante_direccion, visitante_foto, visitante_org, pers_id, conexion_id) FROM stdin;
1	V19201769	JHAMES JOSE	RAMOS HERNANDEZ	\N	\N	t	C.A METRO DE CARACAS	2613	85
\.


--
-- TOC entry 1975 (class 0 OID 0)
-- Dependencies: 165
-- Name: visitante_visitante_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('visitante_visitante_id_seq', 1, true);


--
-- TOC entry 1781 (class 2606 OID 89033184)
-- Name: conexion pk_conexion; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conexion
    ADD CONSTRAINT pk_conexion PRIMARY KEY (conexion_id);


--
-- TOC entry 1783 (class 2606 OID 89033186)
-- Name: estructura pk_estructura; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY estructura
    ADD CONSTRAINT pk_estructura PRIMARY KEY (est_id);


--
-- TOC entry 1789 (class 2606 OID 89033188)
-- Name: lista_negra pk_lista_negra; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lista_negra
    ADD CONSTRAINT pk_lista_negra PRIMARY KEY (lista_negra_id);


--
-- TOC entry 1791 (class 2606 OID 89033190)
-- Name: menu pk_menu; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY menu
    ADD CONSTRAINT pk_menu PRIMARY KEY (menu_id);


--
-- TOC entry 1793 (class 2606 OID 89033192)
-- Name: perfil pk_perfil; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY perfil
    ADD CONSTRAINT pk_perfil PRIMARY KEY (perfil_id);


--
-- TOC entry 1797 (class 2606 OID 89033194)
-- Name: rel_estructura_pabx pk_rel_estructura_pabx; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rel_estructura_pabx
    ADD CONSTRAINT pk_rel_estructura_pabx PRIMARY KEY (rel_est_pabx_id);


--
-- TOC entry 1799 (class 2606 OID 89033196)
-- Name: rel_perfil_menu pk_rel_perfil_menu; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rel_perfil_menu
    ADD CONSTRAINT pk_rel_perfil_menu PRIMARY KEY (rel_perfil_menu_id);


--
-- TOC entry 1801 (class 2606 OID 89033198)
-- Name: rel_perfil_usuario pk_rel_perfil_usuario; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rel_perfil_usuario
    ADD CONSTRAINT pk_rel_perfil_usuario PRIMARY KEY (rel_perfil_usuario_id);


--
-- TOC entry 1803 (class 2606 OID 89033200)
-- Name: rel_personal_estructura pk_rel_personal_area; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rel_personal_estructura
    ADD CONSTRAINT pk_rel_personal_area PRIMARY KEY (rel_pers_est_id);


--
-- TOC entry 1807 (class 2606 OID 89033202)
-- Name: rel_personal_pabx pk_rel_personal_pabx; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rel_personal_pabx
    ADD CONSTRAINT pk_rel_personal_pabx PRIMARY KEY (rel_pers_pabx_id);


--
-- TOC entry 1809 (class 2606 OID 89033204)
-- Name: usuario pk_usuario; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT pk_usuario PRIMARY KEY (usuario_id);


--
-- TOC entry 1813 (class 2606 OID 89033206)
-- Name: visita pk_visita; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY visita
    ADD CONSTRAINT pk_visita PRIMARY KEY (visita_id);


--
-- TOC entry 1815 (class 2606 OID 89033208)
-- Name: visitante pk_visitante; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY visitante
    ADD CONSTRAINT pk_visitante PRIMARY KEY (visitante_id);


--
-- TOC entry 1785 (class 2606 OID 89033210)
-- Name: estructura uk_estructura_1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY estructura
    ADD CONSTRAINT uk_estructura_1 UNIQUE (est_id, est_padre_id);


--
-- TOC entry 1787 (class 2606 OID 89033212)
-- Name: estructura uk_estructura_2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY estructura
    ADD CONSTRAINT uk_estructura_2 UNIQUE (est_sigla);


--
-- TOC entry 1795 (class 2606 OID 89033214)
-- Name: perfil uk_perfil_desc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY perfil
    ADD CONSTRAINT uk_perfil_desc UNIQUE (perfil_desc);


--
-- TOC entry 1805 (class 2606 OID 89033216)
-- Name: rel_personal_estructura uk_relpersonalestructura; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rel_personal_estructura
    ADD CONSTRAINT uk_relpersonalestructura UNIQUE (pers_id);


--
-- TOC entry 1811 (class 2606 OID 89033218)
-- Name: usuario uk_usuario_login; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT uk_usuario_login UNIQUE (usuario_login);


--
-- TOC entry 1825 (class 2606 OID 89033219)
-- Name: rel_personal_estructura fk_conexion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rel_personal_estructura
    ADD CONSTRAINT fk_conexion FOREIGN KEY (conexion_id) REFERENCES conexion(conexion_id);


--
-- TOC entry 1817 (class 2606 OID 89033224)
-- Name: lista_negra fk_conexion_lista_negra; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lista_negra
    ADD CONSTRAINT fk_conexion_lista_negra FOREIGN KEY (conexion_id) REFERENCES conexion(conexion_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1816 (class 2606 OID 89033229)
-- Name: conexion fk_conexion_rel_perfil_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conexion
    ADD CONSTRAINT fk_conexion_rel_perfil_usuario FOREIGN KEY (rel_perfil_usuario_id) REFERENCES rel_perfil_usuario(rel_perfil_usuario_id);


--
-- TOC entry 1820 (class 2606 OID 89033234)
-- Name: rel_estructura_pabx fk_estructura; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rel_estructura_pabx
    ADD CONSTRAINT fk_estructura FOREIGN KEY (est_id) REFERENCES estructura(est_id);


--
-- TOC entry 1826 (class 2606 OID 89033239)
-- Name: rel_personal_estructura fk_estructura; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rel_personal_estructura
    ADD CONSTRAINT fk_estructura FOREIGN KEY (est_id) REFERENCES estructura(est_id);


--
-- TOC entry 1821 (class 2606 OID 89033244)
-- Name: rel_perfil_menu fk_menu; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rel_perfil_menu
    ADD CONSTRAINT fk_menu FOREIGN KEY (menu_id) REFERENCES menu(menu_id);


--
-- TOC entry 1819 (class 2606 OID 89033249)
-- Name: menu fk_menu_menu; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY menu
    ADD CONSTRAINT fk_menu_menu FOREIGN KEY (menu_padre_id) REFERENCES menu(menu_id);


--
-- TOC entry 1823 (class 2606 OID 89033254)
-- Name: rel_perfil_usuario fk_perfil_rel_perfil_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rel_perfil_usuario
    ADD CONSTRAINT fk_perfil_rel_perfil_usuario FOREIGN KEY (perfil_id) REFERENCES perfil(perfil_id);


--
-- TOC entry 1822 (class 2606 OID 89033259)
-- Name: rel_perfil_menu fk_rel_perfil_menu_perfil; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rel_perfil_menu
    ADD CONSTRAINT fk_rel_perfil_menu_perfil FOREIGN KEY (perfil_id) REFERENCES perfil(perfil_id);


--
-- TOC entry 1827 (class 2606 OID 89033264)
-- Name: usuario fk_usuario_estruc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT fk_usuario_estruc FOREIGN KEY (est_id) REFERENCES estructura(est_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1824 (class 2606 OID 89033269)
-- Name: rel_perfil_usuario fk_usuario_rel_perfil; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY rel_perfil_usuario
    ADD CONSTRAINT fk_usuario_rel_perfil FOREIGN KEY (usuario_id) REFERENCES usuario(usuario_id);


--
-- TOC entry 1828 (class 2606 OID 89033274)
-- Name: visita fk_visita_conexion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY visita
    ADD CONSTRAINT fk_visita_conexion FOREIGN KEY (conexion_id) REFERENCES conexion(conexion_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1829 (class 2606 OID 89033279)
-- Name: visita fk_visitante; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY visita
    ADD CONSTRAINT fk_visitante FOREIGN KEY (visitante_id) REFERENCES visitante(visitante_id);


--
-- TOC entry 1818 (class 2606 OID 89033284)
-- Name: lista_negra fk_visitante; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY lista_negra
    ADD CONSTRAINT fk_visitante FOREIGN KEY (visitante_id) REFERENCES visitante(visitante_id);


--
-- TOC entry 1830 (class 2606 OID 89033289)
-- Name: visitante fk_visitante_conexion; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY visitante
    ADD CONSTRAINT fk_visitante_conexion FOREIGN KEY (conexion_id) REFERENCES conexion(conexion_id);


--
-- TOC entry 1949 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2018-05-21 11:15:05 -04

--
-- PostgreSQL database dump complete
--

