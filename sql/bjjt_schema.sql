--
-- PostgreSQL database dump
--

-- Dumped from database version 10.0
-- Dumped by pg_dump version 10.0

-- Started on 2017-10-28 10:57:13 PDT

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12544)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2514 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

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


SET default_tablespace = '';

SET default_with_oids = false;

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
-- TOC entry 196 (class 1259 OID 16395)
-- Name: positionnames; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE positionnames (
    positionname character varying(128),
    index integer NOT NULL
);


--
-- TOC entry 197 (class 1259 OID 16398)
-- Name: relatedtechnique_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE relatedtechnique_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 198 (class 1259 OID 16400)
-- Name: relatedtechnique; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE relatedtechnique (
    index integer DEFAULT nextval('relatedtechnique_id_seq'::regclass) NOT NULL,
    technique integer,
    techniquerelated integer
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


--
-- TOC entry 199 (class 1259 OID 16404)
-- Name: skilllevel; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE skilllevel (
    index integer NOT NULL,
    levelname character varying(128)
);


--
-- TOC entry 200 (class 1259 OID 16407)
-- Name: sport; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE sport (
    sport character varying(128),
    index integer NOT NULL
);


--
-- TOC entry 201 (class 1259 OID 16410)
-- Name: technique_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE technique_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 202 (class 1259 OID 16412)
-- Name: technique; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE technique (
    type integer,
    topic integer,
    name character varying(255),
    setup text,
    details text,
    credit character varying(255),
    index integer DEFAULT nextval('technique_id_seq'::regclass) NOT NULL,
    sport integer,
    startingpos integer,
    endingpos integer,
    imageurl character varying(255),
    numimages smallint,
    videoid character varying(50),
    opponentstartingpos integer,
    skilllevel integer,
    lastteachdate timestamp with time zone,
    rating integer,
    ratings integer
);


--
-- TOC entry 203 (class 1259 OID 16419)
-- Name: techniquetype; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE techniquetype (
    techniquetype character varying(50),
    index integer NOT NULL
);


--
-- TOC entry 204 (class 1259 OID 16422)
-- Name: topic; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE topic (
    topic character varying(128),
    index integer NOT NULL
);


--
-- TOC entry 205 (class 1259 OID 16425)
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
    id integer NOT NULL,
    login character varying(32),
    password character varying(32),
    roleid integer,
    firstname character varying(32),
    lastname character varying(32),
    teamid integer
);


--
-- TOC entry 206 (class 1259 OID 16428)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2350 (class 2606 OID 16432)
-- Name: positionnames PositionNames_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY positionnames
    ADD CONSTRAINT "PositionNames_pkey" PRIMARY KEY (index);


--
-- TOC entry 2354 (class 2606 OID 16434)
-- Name: skilllevel SkillLevel_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY skilllevel
    ADD CONSTRAINT "SkillLevel_pkey" PRIMARY KEY (index);


--
-- TOC entry 2356 (class 2606 OID 16436)
-- Name: sport Sport_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sport
    ADD CONSTRAINT "Sport_pkey" PRIMARY KEY (index);


--
-- TOC entry 2360 (class 2606 OID 16438)
-- Name: techniquetype TechniqueType_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY techniquetype
    ADD CONSTRAINT "TechniqueType_pkey" PRIMARY KEY (index);


--
-- TOC entry 2358 (class 2606 OID 16440)
-- Name: technique Technique_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY technique
    ADD CONSTRAINT "Technique_pkey" PRIMARY KEY (index);


--
-- TOC entry 2362 (class 2606 OID 16442)
-- Name: topic Topic_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY topic
    ADD CONSTRAINT "Topic_pkey" PRIMARY KEY (index);


--
-- TOC entry 2366 (class 2606 OID 16518)
-- Name: class class_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY class
    ADD CONSTRAINT class_pkey PRIMARY KEY (index);


--
-- TOC entry 2368 (class 2606 OID 16520)
-- Name: classtech classtech_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY classtech
    ADD CONSTRAINT classtech_pkey PRIMARY KEY (classid, techid);


--
-- TOC entry 2370 (class 2606 OID 16522)
-- Name: course course_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY course
    ADD CONSTRAINT course_pkey PRIMARY KEY (index);


--
-- TOC entry 2352 (class 2606 OID 16444)
-- Name: relatedtechnique relatedtechnique_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY relatedtechnique
    ADD CONSTRAINT relatedtechnique_pkey PRIMARY KEY (index);


--
-- TOC entry 2373 (class 2606 OID 16524)
-- Name: school school_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY school
    ADD CONSTRAINT school_pkey PRIMARY KEY (index);


--
-- TOC entry 2364 (class 2606 OID 16446)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 2371 (class 1259 OID 16525)
-- Name: fki_school_fkey; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_school_fkey ON course USING btree (schoolid);


--
-- TOC entry 2376 (class 2606 OID 16447)
-- Name: technique Technique_EndingPos_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY technique
    ADD CONSTRAINT "Technique_EndingPos_fkey" FOREIGN KEY (endingpos) REFERENCES positionnames(index);


--
-- TOC entry 2377 (class 2606 OID 16452)
-- Name: technique Technique_OpponentStartingPos_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY technique
    ADD CONSTRAINT "Technique_OpponentStartingPos_fkey" FOREIGN KEY (opponentstartingpos) REFERENCES positionnames(index);


--
-- TOC entry 2378 (class 2606 OID 16457)
-- Name: technique Technique_SkillLevel_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY technique
    ADD CONSTRAINT "Technique_SkillLevel_fkey" FOREIGN KEY (skilllevel) REFERENCES skilllevel(index);


--
-- TOC entry 2379 (class 2606 OID 16462)
-- Name: technique Technique_Sport_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY technique
    ADD CONSTRAINT "Technique_Sport_fkey" FOREIGN KEY (sport) REFERENCES sport(index);


--
-- TOC entry 2380 (class 2606 OID 16467)
-- Name: technique Technique_StartingPos_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY technique
    ADD CONSTRAINT "Technique_StartingPos_fkey" FOREIGN KEY (startingpos) REFERENCES positionnames(index);


--
-- TOC entry 2381 (class 2606 OID 16472)
-- Name: technique Technique_Topic_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY technique
    ADD CONSTRAINT "Technique_Topic_fkey" FOREIGN KEY (topic) REFERENCES topic(index);


--
-- TOC entry 2382 (class 2606 OID 16477)
-- Name: technique Technique_Type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY technique
    ADD CONSTRAINT "Technique_Type_fkey" FOREIGN KEY (type) REFERENCES techniquetype(index);


--
-- TOC entry 2384 (class 2606 OID 16526)
-- Name: classtech class_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY classtech
    ADD CONSTRAINT class_fkey FOREIGN KEY (classid) REFERENCES class(index);


--
-- TOC entry 2383 (class 2606 OID 16531)
-- Name: class course_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY class
    ADD CONSTRAINT course_fkey FOREIGN KEY (courseid) REFERENCES course(index);


--
-- TOC entry 2374 (class 2606 OID 16482)
-- Name: relatedtechnique relatedtechnique_technique_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY relatedtechnique
    ADD CONSTRAINT relatedtechnique_technique_fkey FOREIGN KEY (technique) REFERENCES technique(index);


--
-- TOC entry 2375 (class 2606 OID 16487)
-- Name: relatedtechnique relatedtechnique_techniquerelated_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY relatedtechnique
    ADD CONSTRAINT relatedtechnique_techniquerelated_fkey FOREIGN KEY (techniquerelated) REFERENCES technique(index);


--
-- TOC entry 2386 (class 2606 OID 16536)
-- Name: course school_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY course
    ADD CONSTRAINT school_fkey FOREIGN KEY (schoolid) REFERENCES school(index);


--
-- TOC entry 2385 (class 2606 OID 16541)
-- Name: classtech tech_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY classtech
    ADD CONSTRAINT tech_fkey FOREIGN KEY (techid) REFERENCES technique(index);


-- Completed on 2017-10-28 10:57:13 PDT

--
-- PostgreSQL database dump complete
--

