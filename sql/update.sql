
--
-- TOC entry 207 (class 1259 OID 16496)
-- Name: class_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE class_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- TOC entry 208 (class 1259 OID 16498)
-- Name: class; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE class (
    index integer DEFAULT nextval('class_id_seq'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    courseid integer,
    sequencenum integer,
    createdate timestamp with time zone
);


--
-- TOC entry 209 (class 1259 OID 16502)
-- Name: classtech; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE classtech (
    classid integer NOT NULL,
    techid integer NOT NULL,
    sequencenum integer,
    createdate timestamp with time zone NOT NULL
);


--
-- TOC entry 210 (class 1259 OID 16505)
-- Name: course_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE course_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 211 (class 1259 OID 16507)
-- Name: course; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE course (
    index integer DEFAULT nextval('course_id_seq'::regclass) NOT NULL,
    name character varying(255) NOT NULL,
    schoolid integer,
    sequencenum integer,
    createdate timestamp with time zone
);

--
-- TOC entry 212 (class 1259 OID 16511)
-- Name: school_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE school_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 213 (class 1259 OID 16513)
-- Name: school; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE school (
    index integer DEFAULT nextval('school_id_seq'::regclass) NOT NULL,
    createdate timestamp with time zone,
    name character varying(255)
);
