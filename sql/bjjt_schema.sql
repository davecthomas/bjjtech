--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.5
-- Dumped by pg_dump version 9.6.5

-- Started on 2017-10-08 15:22:30 PDT

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12655)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2489 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- TOC entry 198 (class 1259 OID 24580)
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
-- TOC entry 201 (class 1259 OID 24601)
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
-- TOC entry 202 (class 1259 OID 24611)
-- Name: classtech; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE classtech (
    classid integer NOT NULL,
    techid integer NOT NULL
);


--
-- TOC entry 197 (class 1259 OID 24578)
-- Name: course_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE course_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 200 (class 1259 OID 24590)
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
-- TOC entry 185 (class 1259 OID 16386)
-- Name: positionnames; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE positionnames (
    positionname character varying(128),
    index integer NOT NULL
);


--
-- TOC entry 186 (class 1259 OID 16389)
-- Name: relatedtechnique_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE relatedtechnique_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 187 (class 1259 OID 16391)
-- Name: relatedtechnique; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE relatedtechnique (
    index integer DEFAULT nextval('relatedtechnique_id_seq'::regclass) NOT NULL,
    technique integer,
    techniquerelated integer
);


--
-- TOC entry 196 (class 1259 OID 24576)
-- Name: school_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE school_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 199 (class 1259 OID 24582)
-- Name: school; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE school (
    index integer DEFAULT nextval('school_id_seq'::regclass) NOT NULL,
    createdate timestamp with time zone,
    name character varying(255)
);


--
-- TOC entry 188 (class 1259 OID 16395)
-- Name: skilllevel; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE skilllevel (
    index integer NOT NULL,
    levelname character varying(128)
);


--
-- TOC entry 189 (class 1259 OID 16398)
-- Name: sport; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE sport (
    sport character varying(128),
    index integer NOT NULL
);


--
-- TOC entry 190 (class 1259 OID 16401)
-- Name: technique_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE technique_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 191 (class 1259 OID 16403)
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
-- TOC entry 192 (class 1259 OID 16410)
-- Name: techniquetype; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE techniquetype (
    techniquetype character varying(50),
    index integer NOT NULL
);


--
-- TOC entry 193 (class 1259 OID 16413)
-- Name: topic; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE topic (
    topic character varying(128),
    index integer NOT NULL
);


--
-- TOC entry 194 (class 1259 OID 16416)
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
-- TOC entry 195 (class 1259 OID 16419)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 2329 (class 2606 OID 16423)
-- Name: positionnames PositionNames_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY positionnames
    ADD CONSTRAINT "PositionNames_pkey" PRIMARY KEY (index);


--
-- TOC entry 2333 (class 2606 OID 16425)
-- Name: skilllevel SkillLevel_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY skilllevel
    ADD CONSTRAINT "SkillLevel_pkey" PRIMARY KEY (index);


--
-- TOC entry 2335 (class 2606 OID 16427)
-- Name: sport Sport_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sport
    ADD CONSTRAINT "Sport_pkey" PRIMARY KEY (index);


--
-- TOC entry 2339 (class 2606 OID 16429)
-- Name: techniquetype TechniqueType_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY techniquetype
    ADD CONSTRAINT "TechniqueType_pkey" PRIMARY KEY (index);


--
-- TOC entry 2337 (class 2606 OID 16431)
-- Name: technique Technique_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY technique
    ADD CONSTRAINT "Technique_pkey" PRIMARY KEY (index);


--
-- TOC entry 2341 (class 2606 OID 16433)
-- Name: topic Topic_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY topic
    ADD CONSTRAINT "Topic_pkey" PRIMARY KEY (index);


--
-- TOC entry 2350 (class 2606 OID 24605)
-- Name: class class_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY class
    ADD CONSTRAINT class_pkey PRIMARY KEY (index);


--
-- TOC entry 2352 (class 2606 OID 24625)
-- Name: classtech classtech_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY classtech
    ADD CONSTRAINT classtech_pkey PRIMARY KEY (classid, techid);


--
-- TOC entry 2347 (class 2606 OID 24594)
-- Name: course course_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY course
    ADD CONSTRAINT course_pkey PRIMARY KEY (index);


--
-- TOC entry 2331 (class 2606 OID 16435)
-- Name: relatedtechnique relatedtechnique_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY relatedtechnique
    ADD CONSTRAINT relatedtechnique_pkey PRIMARY KEY (index);


--
-- TOC entry 2345 (class 2606 OID 24586)
-- Name: school school_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY school
    ADD CONSTRAINT school_pkey PRIMARY KEY (index);


--
-- TOC entry 2343 (class 2606 OID 16437)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 2348 (class 1259 OID 24600)
-- Name: fki_school_fkey; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX fki_school_fkey ON course USING btree (schoolid);


--
-- TOC entry 2355 (class 2606 OID 16438)
-- Name: technique Technique_EndingPos_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY technique
    ADD CONSTRAINT "Technique_EndingPos_fkey" FOREIGN KEY (endingpos) REFERENCES positionnames(index);


--
-- TOC entry 2356 (class 2606 OID 16443)
-- Name: technique Technique_OpponentStartingPos_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY technique
    ADD CONSTRAINT "Technique_OpponentStartingPos_fkey" FOREIGN KEY (opponentstartingpos) REFERENCES positionnames(index);


--
-- TOC entry 2357 (class 2606 OID 16448)
-- Name: technique Technique_SkillLevel_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY technique
    ADD CONSTRAINT "Technique_SkillLevel_fkey" FOREIGN KEY (skilllevel) REFERENCES skilllevel(index);


--
-- TOC entry 2358 (class 2606 OID 16453)
-- Name: technique Technique_Sport_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY technique
    ADD CONSTRAINT "Technique_Sport_fkey" FOREIGN KEY (sport) REFERENCES sport(index);


--
-- TOC entry 2359 (class 2606 OID 16458)
-- Name: technique Technique_StartingPos_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY technique
    ADD CONSTRAINT "Technique_StartingPos_fkey" FOREIGN KEY (startingpos) REFERENCES positionnames(index);


--
-- TOC entry 2360 (class 2606 OID 16463)
-- Name: technique Technique_Topic_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY technique
    ADD CONSTRAINT "Technique_Topic_fkey" FOREIGN KEY (topic) REFERENCES topic(index);


--
-- TOC entry 2361 (class 2606 OID 16468)
-- Name: technique Technique_Type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY technique
    ADD CONSTRAINT "Technique_Type_fkey" FOREIGN KEY (type) REFERENCES techniquetype(index);


--
-- TOC entry 2364 (class 2606 OID 24614)
-- Name: classtech class_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY classtech
    ADD CONSTRAINT class_fkey FOREIGN KEY (classid) REFERENCES class(index);


--
-- TOC entry 2363 (class 2606 OID 24606)
-- Name: class course_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY class
    ADD CONSTRAINT course_fkey FOREIGN KEY (courseid) REFERENCES course(index);


--
-- TOC entry 2353 (class 2606 OID 16473)
-- Name: relatedtechnique relatedtechnique_technique_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY relatedtechnique
    ADD CONSTRAINT relatedtechnique_technique_fkey FOREIGN KEY (technique) REFERENCES technique(index);


--
-- TOC entry 2354 (class 2606 OID 16478)
-- Name: relatedtechnique relatedtechnique_techniquerelated_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY relatedtechnique
    ADD CONSTRAINT relatedtechnique_techniquerelated_fkey FOREIGN KEY (techniquerelated) REFERENCES technique(index);


--
-- TOC entry 2362 (class 2606 OID 24595)
-- Name: course school_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY course
    ADD CONSTRAINT school_fkey FOREIGN KEY (schoolid) REFERENCES school(index);


--
-- TOC entry 2365 (class 2606 OID 24619)
-- Name: classtech tech_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY classtech
    ADD CONSTRAINT tech_fkey FOREIGN KEY (techid) REFERENCES technique(index);


-- Completed on 2017-10-08 15:22:30 PDT

--
-- PostgreSQL database dump complete
--

