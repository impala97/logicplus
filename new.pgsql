--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.10
-- Dumped by pg_dump version 9.5.10

-- Started on 2018-02-06 18:47:10 IST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 9 (class 2615 OID 24856)
-- Name: lp; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA lp;


ALTER SCHEMA lp OWNER TO postgres;

--
-- TOC entry 1 (class 3079 OID 12393)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2393 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 2 (class 3079 OID 24857)
-- Name: citext; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- TOC entry 2394 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


SET search_path = public, pg_catalog;

--
-- TOC entry 613 (class 1247 OID 24941)
-- Name: email; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN email AS citext
	CONSTRAINT email_check CHECK ((VALUE ~ '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zAZ0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$'::citext));


ALTER DOMAIN email OWNER TO postgres;

--
-- TOC entry 615 (class 1247 OID 24943)
-- Name: phone; Type: DOMAIN; Schema: public; Owner: postgres
--

CREATE DOMAIN phone AS citext
	CONSTRAINT phone_check CHECK ((VALUE ~ '^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$'::citext));


ALTER DOMAIN phone OWNER TO postgres;

SET search_path = lp, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 205 (class 1259 OID 25137)
-- Name: admission_batch; Type: TABLE; Schema: lp; Owner: postgres
--

CREATE TABLE admission_batch (
    aid integer NOT NULL,
    bid integer NOT NULL,
    id integer NOT NULL,
    "time" character varying(50) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE admission_batch OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 25150)
-- Name: admission_batch_id_seq; Type: SEQUENCE; Schema: lp; Owner: postgres
--

CREATE SEQUENCE admission_batch_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE admission_batch_id_seq OWNER TO postgres;

--
-- TOC entry 2395 (class 0 OID 0)
-- Dependencies: 206
-- Name: admission_batch_id_seq; Type: SEQUENCE OWNED BY; Schema: lp; Owner: postgres
--

ALTER SEQUENCE admission_batch_id_seq OWNED BY admission_batch.id;


--
-- TOC entry 183 (class 1259 OID 24950)
-- Name: admission_trnxs; Type: TABLE; Schema: lp; Owner: postgres
--

CREATE TABLE admission_trnxs (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    phone public.phone,
    email public.email,
    study character varying(50) NOT NULL,
    course character varying(50) NOT NULL,
    address character varying(100) NOT NULL,
    gender boolean DEFAULT true,
    join_date character varying(25) NOT NULL,
    fees integer NOT NULL,
    active boolean DEFAULT true,
    dp character varying(30) NOT NULL,
    details character varying(1000) NOT NULL,
    bid integer DEFAULT 0
);


ALTER TABLE admission_trnxs OWNER TO postgres;

--
-- TOC entry 184 (class 1259 OID 24959)
-- Name: admission_trnxs_fees_seq; Type: SEQUENCE; Schema: lp; Owner: postgres
--

CREATE SEQUENCE admission_trnxs_fees_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE admission_trnxs_fees_seq OWNER TO postgres;

--
-- TOC entry 2397 (class 0 OID 0)
-- Dependencies: 184
-- Name: admission_trnxs_fees_seq; Type: SEQUENCE OWNED BY; Schema: lp; Owner: postgres
--

ALTER SEQUENCE admission_trnxs_fees_seq OWNED BY admission_trnxs.fees;


--
-- TOC entry 185 (class 1259 OID 24961)
-- Name: admission_trnxs_id_seq; Type: SEQUENCE; Schema: lp; Owner: postgres
--

CREATE SEQUENCE admission_trnxs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE admission_trnxs_id_seq OWNER TO postgres;

--
-- TOC entry 2398 (class 0 OID 0)
-- Dependencies: 185
-- Name: admission_trnxs_id_seq; Type: SEQUENCE OWNED BY; Schema: lp; Owner: postgres
--

ALTER SEQUENCE admission_trnxs_id_seq OWNED BY admission_trnxs.id;


--
-- TOC entry 186 (class 1259 OID 24963)
-- Name: batch_trnxs; Type: TABLE; Schema: lp; Owner: postgres
--

CREATE TABLE batch_trnxs (
    bid integer NOT NULL,
    cid integer NOT NULL,
    fid integer NOT NULL,
    day text NOT NULL,
    "time" text NOT NULL,
    active boolean DEFAULT false NOT NULL,
    entries integer DEFAULT 0 NOT NULL
);


ALTER TABLE batch_trnxs OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 24970)
-- Name: batch_trnxs_bid_seq; Type: SEQUENCE; Schema: lp; Owner: postgres
--

CREATE SEQUENCE batch_trnxs_bid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE batch_trnxs_bid_seq OWNER TO postgres;

--
-- TOC entry 2400 (class 0 OID 0)
-- Dependencies: 187
-- Name: batch_trnxs_bid_seq; Type: SEQUENCE OWNED BY; Schema: lp; Owner: postgres
--

ALTER SEQUENCE batch_trnxs_bid_seq OWNED BY batch_trnxs.bid;


--
-- TOC entry 188 (class 1259 OID 24972)
-- Name: chat; Type: TABLE; Schema: lp; Owner: postgres
--

CREATE TABLE chat (
    id integer NOT NULL,
    name character varying(10) NOT NULL,
    message character varying(100) NOT NULL,
    date date,
    "time" time without time zone
);


ALTER TABLE chat OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 24975)
-- Name: chat_id_seq; Type: SEQUENCE; Schema: lp; Owner: postgres
--

CREATE SEQUENCE chat_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE chat_id_seq OWNER TO postgres;

--
-- TOC entry 2402 (class 0 OID 0)
-- Dependencies: 189
-- Name: chat_id_seq; Type: SEQUENCE OWNED BY; Schema: lp; Owner: postgres
--

ALTER SEQUENCE chat_id_seq OWNED BY chat.id;


--
-- TOC entry 190 (class 1259 OID 24977)
-- Name: course_trnxs; Type: TABLE; Schema: lp; Owner: postgres
--

CREATE TABLE course_trnxs (
    id integer NOT NULL,
    cname character varying(20),
    duration character varying(30) NOT NULL,
    details character varying(1000) NOT NULL,
    active boolean DEFAULT true,
    fees integer
);


ALTER TABLE course_trnxs OWNER TO postgres;

--
-- TOC entry 191 (class 1259 OID 24984)
-- Name: course_trxns_id_seq; Type: SEQUENCE; Schema: lp; Owner: postgres
--

CREATE SEQUENCE course_trxns_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE course_trxns_id_seq OWNER TO postgres;

--
-- TOC entry 2404 (class 0 OID 0)
-- Dependencies: 191
-- Name: course_trxns_id_seq; Type: SEQUENCE OWNED BY; Schema: lp; Owner: postgres
--

ALTER SEQUENCE course_trxns_id_seq OWNED BY course_trnxs.id;


--
-- TOC entry 192 (class 1259 OID 24986)
-- Name: faculty; Type: TABLE; Schema: lp; Owner: postgres
--

CREATE TABLE faculty (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    email public.email,
    phone public.phone,
    website character varying(100) NOT NULL,
    company character varying(50) NOT NULL,
    post character varying(20) NOT NULL,
    dob date NOT NULL,
    address character varying(200) NOT NULL,
    gender boolean DEFAULT true,
    dp character varying(30),
    active boolean DEFAULT true
);


ALTER TABLE faculty OWNER TO postgres;

--
-- TOC entry 193 (class 1259 OID 24994)
-- Name: faculty_id_seq; Type: SEQUENCE; Schema: lp; Owner: postgres
--

CREATE SEQUENCE faculty_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE faculty_id_seq OWNER TO postgres;

--
-- TOC entry 2406 (class 0 OID 0)
-- Dependencies: 193
-- Name: faculty_id_seq; Type: SEQUENCE OWNED BY; Schema: lp; Owner: postgres
--

ALTER SEQUENCE faculty_id_seq OWNED BY faculty.id;


--
-- TOC entry 194 (class 1259 OID 24996)
-- Name: inquiry_trnxs; Type: TABLE; Schema: lp; Owner: postgres
--

CREATE TABLE inquiry_trnxs (
    id integer NOT NULL,
    name character varying(20) NOT NULL,
    phone public.phone NOT NULL,
    email public.email NOT NULL,
    course character varying(20) NOT NULL,
    study character varying(20) NOT NULL,
    details character varying(20) NOT NULL,
    active boolean DEFAULT true,
    date date NOT NULL,
    gender boolean DEFAULT true
);


ALTER TABLE inquiry_trnxs OWNER TO postgres;

--
-- TOC entry 195 (class 1259 OID 25004)
-- Name: inquiry_trnxs_id_seq; Type: SEQUENCE; Schema: lp; Owner: postgres
--

CREATE SEQUENCE inquiry_trnxs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE inquiry_trnxs_id_seq OWNER TO postgres;

--
-- TOC entry 2408 (class 0 OID 0)
-- Dependencies: 195
-- Name: inquiry_trnxs_id_seq; Type: SEQUENCE OWNED BY; Schema: lp; Owner: postgres
--

ALTER SEQUENCE inquiry_trnxs_id_seq OWNED BY inquiry_trnxs.id;


--
-- TOC entry 196 (class 1259 OID 25006)
-- Name: invoice_trnxs; Type: TABLE; Schema: lp; Owner: postgres
--

CREATE TABLE invoice_trnxs (
    id integer NOT NULL,
    invoice_no character varying(10) DEFAULT 0,
    aid integer NOT NULL,
    fees integer NOT NULL,
    payment_type boolean DEFAULT false,
    bank text DEFAULT 'payment type is cash.'::text,
    chq_no text,
    active boolean
);


ALTER TABLE invoice_trnxs OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 25015)
-- Name: invoice_trnxs_id_seq; Type: SEQUENCE; Schema: lp; Owner: postgres
--

CREATE SEQUENCE invoice_trnxs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE invoice_trnxs_id_seq OWNER TO postgres;

--
-- TOC entry 2410 (class 0 OID 0)
-- Dependencies: 197
-- Name: invoice_trnxs_id_seq; Type: SEQUENCE OWNED BY; Schema: lp; Owner: postgres
--

ALTER SEQUENCE invoice_trnxs_id_seq OWNED BY invoice_trnxs.id;


--
-- TOC entry 198 (class 1259 OID 25017)
-- Name: programe; Type: TABLE; Schema: lp; Owner: postgres
--

CREATE TABLE programe (
    id integer NOT NULL,
    tech character varying(20) NOT NULL,
    framework character varying(20) NOT NULL,
    defination character varying(1000) NOT NULL
);


ALTER TABLE programe OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 25023)
-- Name: programe_id_seq; Type: SEQUENCE; Schema: lp; Owner: postgres
--

CREATE SEQUENCE programe_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE programe_id_seq OWNER TO postgres;

--
-- TOC entry 2412 (class 0 OID 0)
-- Dependencies: 199
-- Name: programe_id_seq; Type: SEQUENCE OWNED BY; Schema: lp; Owner: postgres
--

ALTER SEQUENCE programe_id_seq OWNED BY programe.id;


--
-- TOC entry 200 (class 1259 OID 25025)
-- Name: technology; Type: TABLE; Schema: lp; Owner: postgres
--

CREATE TABLE technology (
    id integer NOT NULL,
    tech character varying(20) NOT NULL,
    framework character varying(20),
    active boolean DEFAULT true
);


ALTER TABLE technology OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 25029)
-- Name: technology_id_seq; Type: SEQUENCE; Schema: lp; Owner: postgres
--

CREATE SEQUENCE technology_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE technology_id_seq OWNER TO postgres;

--
-- TOC entry 2414 (class 0 OID 0)
-- Dependencies: 201
-- Name: technology_id_seq; Type: SEQUENCE OWNED BY; Schema: lp; Owner: postgres
--

ALTER SEQUENCE technology_id_seq OWNED BY technology.id;


--
-- TOC entry 202 (class 1259 OID 25031)
-- Name: test; Type: TABLE; Schema: lp; Owner: postgres
--

CREATE TABLE test (
    mobile public.phone NOT NULL,
    email public.email NOT NULL
);


ALTER TABLE test OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 25037)
-- Name: user; Type: TABLE; Schema: lp; Owner: postgres
--

CREATE TABLE "user" (
    id integer NOT NULL,
    username character varying(20) NOT NULL,
    password character varying(20) NOT NULL,
    email public.email NOT NULL,
    mobile character varying(10) NOT NULL,
    last_login timestamp without time zone DEFAULT '2017-08-19 13:04:00'::timestamp without time zone,
    status boolean DEFAULT false,
    live boolean DEFAULT false,
    active boolean DEFAULT true
);


ALTER TABLE "user" OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 25047)
-- Name: user_id_seq; Type: SEQUENCE; Schema: lp; Owner: postgres
--

CREATE SEQUENCE user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_id_seq OWNER TO postgres;

--
-- TOC entry 2417 (class 0 OID 0)
-- Dependencies: 204
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: lp; Owner: postgres
--

ALTER SEQUENCE user_id_seq OWNED BY "user".id;


--
-- TOC entry 2203 (class 2604 OID 33371)
-- Name: id; Type: DEFAULT; Schema: lp; Owner: postgres
--

ALTER TABLE ONLY admission_batch ALTER COLUMN id SET DEFAULT nextval('admission_batch_id_seq'::regclass);


--
-- TOC entry 2177 (class 2604 OID 33372)
-- Name: id; Type: DEFAULT; Schema: lp; Owner: postgres
--

ALTER TABLE ONLY admission_trnxs ALTER COLUMN id SET DEFAULT nextval('admission_trnxs_id_seq'::regclass);


--
-- TOC entry 2178 (class 2604 OID 33373)
-- Name: fees; Type: DEFAULT; Schema: lp; Owner: postgres
--

ALTER TABLE ONLY admission_trnxs ALTER COLUMN fees SET DEFAULT nextval('admission_trnxs_fees_seq'::regclass);


--
-- TOC entry 2181 (class 2604 OID 33374)
-- Name: bid; Type: DEFAULT; Schema: lp; Owner: postgres
--

ALTER TABLE ONLY batch_trnxs ALTER COLUMN bid SET DEFAULT nextval('batch_trnxs_bid_seq'::regclass);


--
-- TOC entry 2182 (class 2604 OID 33375)
-- Name: id; Type: DEFAULT; Schema: lp; Owner: postgres
--

ALTER TABLE ONLY chat ALTER COLUMN id SET DEFAULT nextval('chat_id_seq'::regclass);


--
-- TOC entry 2184 (class 2604 OID 33376)
-- Name: id; Type: DEFAULT; Schema: lp; Owner: postgres
--

ALTER TABLE ONLY course_trnxs ALTER COLUMN id SET DEFAULT nextval('course_trxns_id_seq'::regclass);


--
-- TOC entry 2187 (class 2604 OID 33377)
-- Name: id; Type: DEFAULT; Schema: lp; Owner: postgres
--

ALTER TABLE ONLY faculty ALTER COLUMN id SET DEFAULT nextval('faculty_id_seq'::regclass);


--
-- TOC entry 2190 (class 2604 OID 33378)
-- Name: id; Type: DEFAULT; Schema: lp; Owner: postgres
--

ALTER TABLE ONLY inquiry_trnxs ALTER COLUMN id SET DEFAULT nextval('inquiry_trnxs_id_seq'::regclass);


--
-- TOC entry 2194 (class 2604 OID 33379)
-- Name: id; Type: DEFAULT; Schema: lp; Owner: postgres
--

ALTER TABLE ONLY invoice_trnxs ALTER COLUMN id SET DEFAULT nextval('invoice_trnxs_id_seq'::regclass);


--
-- TOC entry 2195 (class 2604 OID 33380)
-- Name: id; Type: DEFAULT; Schema: lp; Owner: postgres
--

ALTER TABLE ONLY programe ALTER COLUMN id SET DEFAULT nextval('programe_id_seq'::regclass);


--
-- TOC entry 2197 (class 2604 OID 33381)
-- Name: id; Type: DEFAULT; Schema: lp; Owner: postgres
--

ALTER TABLE ONLY technology ALTER COLUMN id SET DEFAULT nextval('technology_id_seq'::regclass);


--
-- TOC entry 2202 (class 2604 OID 33382)
-- Name: id; Type: DEFAULT; Schema: lp; Owner: postgres
--

ALTER TABLE ONLY "user" ALTER COLUMN id SET DEFAULT nextval('user_id_seq'::regclass);


--
-- TOC entry 2383 (class 0 OID 25137)
-- Dependencies: 205
-- Data for Name: admission_batch; Type: TABLE DATA; Schema: lp; Owner: postgres
--

COPY admission_batch (aid, bid, id, "time") FROM stdin;
1	1	1	12:00
1	2	2	10:00
\.


--
-- TOC entry 2418 (class 0 OID 0)
-- Dependencies: 206
-- Name: admission_batch_id_seq; Type: SEQUENCE SET; Schema: lp; Owner: postgres
--

SELECT pg_catalog.setval('admission_batch_id_seq', 2, true);


--
-- TOC entry 2361 (class 0 OID 24950)
-- Dependencies: 183
-- Data for Name: admission_trnxs; Type: TABLE DATA; Schema: lp; Owner: postgres
--

COPY admission_trnxs (id, name, phone, email, study, course, address, gender, join_date, fees, active, dp, details, bid) FROM stdin;
5	Bhavik Vyas	9033986379	vcr.faculty@gmail.com	BE-IT	Python	dsgsdfg	t	10/13/2017 - 10/13/2017	15000	t	5_201801122021.jpg	cvbcv	1
12	dfsd	1234567890	sjkdh@dnfkl.com	sjkdfh	Python	lkn	t	01/31/2018 - 01/31/2018	15000	t	12_201802011732.jpg	cnbjk	1
1	mehta smit	9904274495	vcr.student@gmail.com	BE-IT	Python,Asp.net	arihant aashish,6/10 gayakwadi plot	t	09/14/2017 - 09/14/2017	25000	t	1_201801311235.jpg	GEC,Modasa	1
\.


--
-- TOC entry 2419 (class 0 OID 0)
-- Dependencies: 184
-- Name: admission_trnxs_fees_seq; Type: SEQUENCE SET; Schema: lp; Owner: postgres
--

SELECT pg_catalog.setval('admission_trnxs_fees_seq', 1, false);


--
-- TOC entry 2420 (class 0 OID 0)
-- Dependencies: 185
-- Name: admission_trnxs_id_seq; Type: SEQUENCE SET; Schema: lp; Owner: postgres
--

SELECT pg_catalog.setval('admission_trnxs_id_seq', 12, true);


--
-- TOC entry 2364 (class 0 OID 24963)
-- Dependencies: 186
-- Data for Name: batch_trnxs; Type: TABLE DATA; Schema: lp; Owner: postgres
--

COPY batch_trnxs (bid, cid, fid, day, "time", active, entries) FROM stdin;
4	4	1	Tuesday,Thursday,Saturday	10:00,12:00	t	2
2	2	6	Monday,Wednesday,Friday	10:00,15:00	t	1
5	1	6	Wednesday,Thursday,Friday,Saturday	15:00	t	1
1	1	1	Monday,Wednesday,Friday	12:00,15:00	t	3
3	3	1	Tuesday,Thursday,Saturday	10:00,12:00	t	2
\.


--
-- TOC entry 2421 (class 0 OID 0)
-- Dependencies: 187
-- Name: batch_trnxs_bid_seq; Type: SEQUENCE SET; Schema: lp; Owner: postgres
--

SELECT pg_catalog.setval('batch_trnxs_bid_seq', 11, true);


--
-- TOC entry 2366 (class 0 OID 24972)
-- Dependencies: 188
-- Data for Name: chat; Type: TABLE DATA; Schema: lp; Owner: postgres
--

COPY chat (id, name, message, date, "time") FROM stdin;
1	smit	hello!	2017-12-12	12:00:00
2	admin	hi there !!!	2018-12-01	14:15:00
3	postgres	hi admin	2018-12-01	14:16:00
4	admin	Hello,postgres	2018-12-01	14:19:00
5	None	hello erveybody	2018-01-31	12:19:00
\.


--
-- TOC entry 2422 (class 0 OID 0)
-- Dependencies: 189
-- Name: chat_id_seq; Type: SEQUENCE SET; Schema: lp; Owner: postgres
--

SELECT pg_catalog.setval('chat_id_seq', 5, true);


--
-- TOC entry 2368 (class 0 OID 24977)
-- Dependencies: 190
-- Data for Name: course_trnxs; Type: TABLE DATA; Schema: lp; Owner: postgres
--

COPY course_trnxs (id, cname, duration, details, active, fees) FROM stdin;
2	Asp.net	09/12/2017 - 09/12/2017	MVC,3-tier architecture	t	10000
3	Java	09/12/2017 - 09/12/2017	Hibernate	t	12500
4	Php	09/12/2017 - 09/12/2017	Wordpress	t	8500
1	Python	09/01/2017 - 12/31/2017	Flask,PostgresSQL,Django,Odoo Technology	t	15000
\.


--
-- TOC entry 2423 (class 0 OID 0)
-- Dependencies: 191
-- Name: course_trxns_id_seq; Type: SEQUENCE SET; Schema: lp; Owner: postgres
--

SELECT pg_catalog.setval('course_trxns_id_seq', 7, true);


--
-- TOC entry 2370 (class 0 OID 24986)
-- Dependencies: 192
-- Data for Name: faculty; Type: TABLE DATA; Schema: lp; Owner: postgres
--

COPY faculty (id, name, email, phone, website, company, post, dob, address, gender, dp, active) FROM stdin;
6	Bhavik Vyas	bhavik@gmail.com	9033986379	http://www.hrsinfomania.com	ITMusketeers Pvt. Ltd.	MD	1991-08-19	hello	t	6_201709141757.jpg	t
5	bhavik	xx@gmail.com	1234567891	http://www.xx.com	xxzz	xxyy	2017-08-02	xxxx	t	5_201709072059.jpg	f
1	Mehta Smit	mehtasmit44@gmail.com	9904274495	http://www.hrsinfomania.com	ITMusketeers Pvt. Ltd.	Python Devloper	1997-06-25	arihant aashish,6/10 gayakwadi plot	t	1_201710111919.jpg	t
\.


--
-- TOC entry 2424 (class 0 OID 0)
-- Dependencies: 193
-- Name: faculty_id_seq; Type: SEQUENCE SET; Schema: lp; Owner: postgres
--

SELECT pg_catalog.setval('faculty_id_seq', 6, true);


--
-- TOC entry 2372 (class 0 OID 24996)
-- Dependencies: 194
-- Data for Name: inquiry_trnxs; Type: TABLE DATA; Schema: lp; Owner: postgres
--

COPY inquiry_trnxs (id, name, phone, email, course, study, details, active, date, gender) FROM stdin;
2	mehta smit	9904274495	mehtasmit44@gmail.com	Python	BE-IT	GEC,Modasa	t	2017-09-08	t
3	sr	1234567891	mehtasmit44@gmail.com	Python	BE-IT	sdhfkq	t	2017-09-08	t
4	jhg	1234567891	mehtasmit44@gmail.com	Python	gyiyu	smit mehtA	t	2017-09-08	t
\.


--
-- TOC entry 2425 (class 0 OID 0)
-- Dependencies: 195
-- Name: inquiry_trnxs_id_seq; Type: SEQUENCE SET; Schema: lp; Owner: postgres
--

SELECT pg_catalog.setval('inquiry_trnxs_id_seq', 7, true);


--
-- TOC entry 2374 (class 0 OID 25006)
-- Dependencies: 196
-- Data for Name: invoice_trnxs; Type: TABLE DATA; Schema: lp; Owner: postgres
--

COPY invoice_trnxs (id, invoice_no, aid, fees, payment_type, bank, chq_no, active) FROM stdin;
8	lp7	1	5000	f	payment type is cash.	-	t
10	lp9	1	5000	f	payment type is cash.	-	t
12	lp11	5	7500	t	SBI	12345	t
\.


--
-- TOC entry 2426 (class 0 OID 0)
-- Dependencies: 197
-- Name: invoice_trnxs_id_seq; Type: SEQUENCE SET; Schema: lp; Owner: postgres
--

SELECT pg_catalog.setval('invoice_trnxs_id_seq', 12, true);


--
-- TOC entry 2376 (class 0 OID 25017)
-- Dependencies: 198
-- Data for Name: programe; Type: TABLE DATA; Schema: lp; Owner: postgres
--

COPY programe (id, tech, framework, defination) FROM stdin;
\.


--
-- TOC entry 2427 (class 0 OID 0)
-- Dependencies: 199
-- Name: programe_id_seq; Type: SEQUENCE SET; Schema: lp; Owner: postgres
--

SELECT pg_catalog.setval('programe_id_seq', 1, false);


--
-- TOC entry 2378 (class 0 OID 25025)
-- Dependencies: 200
-- Data for Name: technology; Type: TABLE DATA; Schema: lp; Owner: postgres
--

COPY technology (id, tech, framework, active) FROM stdin;
5	Java	spring	t
6	Java	struts	t
2	Python	Odoo	t
1	Python	Flask	t
3	Python	django	t
4	Java	hibernate	t
\.


--
-- TOC entry 2428 (class 0 OID 0)
-- Dependencies: 201
-- Name: technology_id_seq; Type: SEQUENCE SET; Schema: lp; Owner: postgres
--

SELECT pg_catalog.setval('technology_id_seq', 7, true);


--
-- TOC entry 2380 (class 0 OID 25031)
-- Dependencies: 202
-- Data for Name: test; Type: TABLE DATA; Schema: lp; Owner: postgres
--

COPY test (mobile, email) FROM stdin;
9904274495	mehtasmit44@k
9904274495	mehtasmit44@gmail.com
9904274495	mehtasmit44@k
9904274495	mehtasmit44@gmail.com
9904274495	mehtasmit44@k
9904274495	mehtasmit44@gmail.com
\.


--
-- TOC entry 2381 (class 0 OID 25037)
-- Dependencies: 203
-- Data for Name: user; Type: TABLE DATA; Schema: lp; Owner: postgres
--

COPY "user" (id, username, password, email, mobile, last_login, status, live, active) FROM stdin;
2	bhavik1991	bhavik1991	bhavik@itmusketeers.com	9033986379	2017-09-06 17:17:00	f	f	f
3	test	ITMCS	test@itmusketeers.com	1234567890	2017-08-19 13:04:00	f	f	f
4	admin	admin	admin@itmusketeers.com	1234567890	2018-02-06 11:58:00	f	f	t
1	sr_mehta	sr_mehta	postgres@itmusketeers.com	9904274495	2018-02-06 14:21:00	f	t	t
\.


--
-- TOC entry 2429 (class 0 OID 0)
-- Dependencies: 204
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: lp; Owner: postgres
--

SELECT pg_catalog.setval('user_id_seq', 5, true);


--
-- TOC entry 2240 (class 2606 OID 25154)
-- Name: admission_batch_pkey; Type: CONSTRAINT; Schema: lp; Owner: postgres
--

ALTER TABLE ONLY admission_batch
    ADD CONSTRAINT admission_batch_pkey PRIMARY KEY (id);


--
-- TOC entry 2206 (class 2606 OID 25064)
-- Name: admission_trnxs_email_key; Type: CONSTRAINT; Schema: lp; Owner: postgres
--

ALTER TABLE ONLY admission_trnxs
    ADD CONSTRAINT admission_trnxs_email_key UNIQUE (email);


--
-- TOC entry 2208 (class 2606 OID 25066)
-- Name: admission_trnxs_phone_key; Type: CONSTRAINT; Schema: lp; Owner: postgres
--

ALTER TABLE ONLY admission_trnxs
    ADD CONSTRAINT admission_trnxs_phone_key UNIQUE (phone);


--
-- TOC entry 2210 (class 2606 OID 25068)
-- Name: admission_trnxs_pkey; Type: CONSTRAINT; Schema: lp; Owner: postgres
--

ALTER TABLE ONLY admission_trnxs
    ADD CONSTRAINT admission_trnxs_pkey PRIMARY KEY (id);


--
-- TOC entry 2212 (class 2606 OID 25070)
-- Name: batch_trnxs_pkey; Type: CONSTRAINT; Schema: lp; Owner: postgres
--

ALTER TABLE ONLY batch_trnxs
    ADD CONSTRAINT batch_trnxs_pkey PRIMARY KEY (bid);


--
-- TOC entry 2214 (class 2606 OID 25072)
-- Name: chat_pkey; Type: CONSTRAINT; Schema: lp; Owner: postgres
--

ALTER TABLE ONLY chat
    ADD CONSTRAINT chat_pkey PRIMARY KEY (id);


--
-- TOC entry 2216 (class 2606 OID 25074)
-- Name: course_trxns_cname_key; Type: CONSTRAINT; Schema: lp; Owner: postgres
--

ALTER TABLE ONLY course_trnxs
    ADD CONSTRAINT course_trxns_cname_key UNIQUE (cname);


--
-- TOC entry 2218 (class 2606 OID 25076)
-- Name: course_trxns_pkey; Type: CONSTRAINT; Schema: lp; Owner: postgres
--

ALTER TABLE ONLY course_trnxs
    ADD CONSTRAINT course_trxns_pkey PRIMARY KEY (id);


--
-- TOC entry 2220 (class 2606 OID 25078)
-- Name: faculty_email_key; Type: CONSTRAINT; Schema: lp; Owner: postgres
--

ALTER TABLE ONLY faculty
    ADD CONSTRAINT faculty_email_key UNIQUE (email);


--
-- TOC entry 2222 (class 2606 OID 25080)
-- Name: faculty_phone_key; Type: CONSTRAINT; Schema: lp; Owner: postgres
--

ALTER TABLE ONLY faculty
    ADD CONSTRAINT faculty_phone_key UNIQUE (phone);


--
-- TOC entry 2224 (class 2606 OID 25082)
-- Name: faculty_pkey; Type: CONSTRAINT; Schema: lp; Owner: postgres
--

ALTER TABLE ONLY faculty
    ADD CONSTRAINT faculty_pkey PRIMARY KEY (id);


--
-- TOC entry 2226 (class 2606 OID 25084)
-- Name: inquiry_trnxs_pkey; Type: CONSTRAINT; Schema: lp; Owner: postgres
--

ALTER TABLE ONLY inquiry_trnxs
    ADD CONSTRAINT inquiry_trnxs_pkey PRIMARY KEY (id);


--
-- TOC entry 2228 (class 2606 OID 25086)
-- Name: invoice_trnxs_pkey; Type: CONSTRAINT; Schema: lp; Owner: postgres
--

ALTER TABLE ONLY invoice_trnxs
    ADD CONSTRAINT invoice_trnxs_pkey PRIMARY KEY (id);


--
-- TOC entry 2230 (class 2606 OID 25088)
-- Name: programe_pkey; Type: CONSTRAINT; Schema: lp; Owner: postgres
--

ALTER TABLE ONLY programe
    ADD CONSTRAINT programe_pkey PRIMARY KEY (id);


--
-- TOC entry 2232 (class 2606 OID 25090)
-- Name: technology_framework_key; Type: CONSTRAINT; Schema: lp; Owner: postgres
--

ALTER TABLE ONLY technology
    ADD CONSTRAINT technology_framework_key UNIQUE (framework);


--
-- TOC entry 2234 (class 2606 OID 25092)
-- Name: technology_pkey; Type: CONSTRAINT; Schema: lp; Owner: postgres
--

ALTER TABLE ONLY technology
    ADD CONSTRAINT technology_pkey PRIMARY KEY (id);


--
-- TOC entry 2236 (class 2606 OID 25094)
-- Name: user_pkey; Type: CONSTRAINT; Schema: lp; Owner: postgres
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- TOC entry 2238 (class 2606 OID 25096)
-- Name: user_username_key; Type: CONSTRAINT; Schema: lp; Owner: postgres
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_username_key UNIQUE (username);


--
-- TOC entry 2245 (class 2606 OID 25140)
-- Name: admission_batch_aid_fkey; Type: FK CONSTRAINT; Schema: lp; Owner: postgres
--

ALTER TABLE ONLY admission_batch
    ADD CONSTRAINT admission_batch_aid_fkey FOREIGN KEY (aid) REFERENCES admission_trnxs(id);


--
-- TOC entry 2246 (class 2606 OID 25145)
-- Name: admission_batch_bid_fkey; Type: FK CONSTRAINT; Schema: lp; Owner: postgres
--

ALTER TABLE ONLY admission_batch
    ADD CONSTRAINT admission_batch_bid_fkey FOREIGN KEY (bid) REFERENCES batch_trnxs(bid);


--
-- TOC entry 2241 (class 2606 OID 25097)
-- Name: batch_trnxs_cid_fkey; Type: FK CONSTRAINT; Schema: lp; Owner: postgres
--

ALTER TABLE ONLY batch_trnxs
    ADD CONSTRAINT batch_trnxs_cid_fkey FOREIGN KEY (cid) REFERENCES course_trnxs(id);


--
-- TOC entry 2242 (class 2606 OID 25102)
-- Name: batch_trnxs_fid_fkey; Type: FK CONSTRAINT; Schema: lp; Owner: postgres
--

ALTER TABLE ONLY batch_trnxs
    ADD CONSTRAINT batch_trnxs_fid_fkey FOREIGN KEY (fid) REFERENCES faculty(id);


--
-- TOC entry 2243 (class 2606 OID 25107)
-- Name: invoice_trnxs_aid_fkey; Type: FK CONSTRAINT; Schema: lp; Owner: postgres
--

ALTER TABLE ONLY invoice_trnxs
    ADD CONSTRAINT invoice_trnxs_aid_fkey FOREIGN KEY (aid) REFERENCES admission_trnxs(id);


--
-- TOC entry 2244 (class 2606 OID 25112)
-- Name: programe_framework_fkey; Type: FK CONSTRAINT; Schema: lp; Owner: postgres
--

ALTER TABLE ONLY programe
    ADD CONSTRAINT programe_framework_fkey FOREIGN KEY (framework) REFERENCES technology(framework);


--
-- TOC entry 2390 (class 0 OID 0)
-- Dependencies: 9
-- Name: lp; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA lp FROM PUBLIC;
REVOKE ALL ON SCHEMA lp FROM postgres;
GRANT ALL ON SCHEMA lp TO postgres;


--
-- TOC entry 2392 (class 0 OID 0)
-- Dependencies: 8
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- TOC entry 2396 (class 0 OID 0)
-- Dependencies: 183
-- Name: admission_trnxs; Type: ACL; Schema: lp; Owner: postgres
--

REVOKE ALL ON TABLE admission_trnxs FROM PUBLIC;
REVOKE ALL ON TABLE admission_trnxs FROM postgres;
GRANT ALL ON TABLE admission_trnxs TO postgres;


--
-- TOC entry 2399 (class 0 OID 0)
-- Dependencies: 186
-- Name: batch_trnxs; Type: ACL; Schema: lp; Owner: postgres
--

REVOKE ALL ON TABLE batch_trnxs FROM PUBLIC;
REVOKE ALL ON TABLE batch_trnxs FROM postgres;
GRANT ALL ON TABLE batch_trnxs TO postgres;


--
-- TOC entry 2401 (class 0 OID 0)
-- Dependencies: 188
-- Name: chat; Type: ACL; Schema: lp; Owner: postgres
--

REVOKE ALL ON TABLE chat FROM PUBLIC;
REVOKE ALL ON TABLE chat FROM postgres;
GRANT ALL ON TABLE chat TO postgres;


--
-- TOC entry 2403 (class 0 OID 0)
-- Dependencies: 190
-- Name: course_trnxs; Type: ACL; Schema: lp; Owner: postgres
--

REVOKE ALL ON TABLE course_trnxs FROM PUBLIC;
REVOKE ALL ON TABLE course_trnxs FROM postgres;
GRANT ALL ON TABLE course_trnxs TO postgres;


--
-- TOC entry 2405 (class 0 OID 0)
-- Dependencies: 192
-- Name: faculty; Type: ACL; Schema: lp; Owner: postgres
--

REVOKE ALL ON TABLE faculty FROM PUBLIC;
REVOKE ALL ON TABLE faculty FROM postgres;
GRANT ALL ON TABLE faculty TO postgres;


--
-- TOC entry 2407 (class 0 OID 0)
-- Dependencies: 194
-- Name: inquiry_trnxs; Type: ACL; Schema: lp; Owner: postgres
--

REVOKE ALL ON TABLE inquiry_trnxs FROM PUBLIC;
REVOKE ALL ON TABLE inquiry_trnxs FROM postgres;
GRANT ALL ON TABLE inquiry_trnxs TO postgres;


--
-- TOC entry 2409 (class 0 OID 0)
-- Dependencies: 196
-- Name: invoice_trnxs; Type: ACL; Schema: lp; Owner: postgres
--

REVOKE ALL ON TABLE invoice_trnxs FROM PUBLIC;
REVOKE ALL ON TABLE invoice_trnxs FROM postgres;
GRANT ALL ON TABLE invoice_trnxs TO postgres;


--
-- TOC entry 2411 (class 0 OID 0)
-- Dependencies: 198
-- Name: programe; Type: ACL; Schema: lp; Owner: postgres
--

REVOKE ALL ON TABLE programe FROM PUBLIC;
REVOKE ALL ON TABLE programe FROM postgres;
GRANT ALL ON TABLE programe TO postgres;


--
-- TOC entry 2413 (class 0 OID 0)
-- Dependencies: 200
-- Name: technology; Type: ACL; Schema: lp; Owner: postgres
--

REVOKE ALL ON TABLE technology FROM PUBLIC;
REVOKE ALL ON TABLE technology FROM postgres;
GRANT ALL ON TABLE technology TO postgres;


--
-- TOC entry 2415 (class 0 OID 0)
-- Dependencies: 202
-- Name: test; Type: ACL; Schema: lp; Owner: postgres
--

REVOKE ALL ON TABLE test FROM PUBLIC;
REVOKE ALL ON TABLE test FROM postgres;
GRANT ALL ON TABLE test TO postgres;


--
-- TOC entry 2416 (class 0 OID 0)
-- Dependencies: 203
-- Name: user; Type: ACL; Schema: lp; Owner: postgres
--

REVOKE ALL ON TABLE "user" FROM PUBLIC;
REVOKE ALL ON TABLE "user" FROM postgres;
GRANT ALL ON TABLE "user" TO postgres;


-- Completed on 2018-02-06 18:47:11 IST

--
-- PostgreSQL database dump complete
--

