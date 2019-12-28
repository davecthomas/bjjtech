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


COPY positionnames (positionname, index) FROM stdin;
Guard	1
Half Guard	2
Side Control	3
Mount	4
Lying on back	6
On all fours or Sprawling	7
Turtle	9
North-South	10
Seated	11
Rear Mount	12
Kesa Gatame Side	13
Reverse Kesa Side	14
Executing Submission	15
Lying on Stomach	16
Standing or standing inside guard	5
Kneeling or kneeling inside guard	8
N/A	17
\.


--
-- TOC entry 2572 (class 0 OID 47989)
-- Dependencies: 175
-- Data for Name: relatedtechnique; Type: TABLE DATA; Schema: public; Owner: -
--

COPY relatedtechnique (index, technique, techniquerelated) FROM stdin;
1	1	3
2	4	3
3	6	111
8	26	27
11	29	31
13	39	40
14	40	39
15	41	49
17	48	47
21	54	55
22	55	54
23	58	59
24	59	58
26	61	50
28	64	56
29	73	72
30	75	73
31	76	227
35	86	87
36	87	85
37	92	264
39	106	96
40	111	6
42	118	119
47	124	120
50	132	130
51	133	134
60	161	250
61	162	163
63	184	190
66	203	141
68	220	219
69	221	220
73	227	226
76	231	233
77	232	231
78	233	234
80	235	234
81	236	234
82	237	233
83	240	239
84	241	228
85	243	235
93	262	263
94	263	262
95	264	265
96	265	264
97	269	268
102	281	141
103	283	233
104	284	128
106	286	3
110	257	253
111	257	258
116	258	257
117	258	253
125	11	135
126	11	126
127	11	65
128	11	76
129	11	127
130	11	125
131	135	126
132	135	65
133	135	76
134	135	127
135	135	125
136	135	11
143	126	135
144	126	65
145	126	76
146	126	127
147	126	125
148	126	11
149	126	293
150	293	135
151	293	126
152	293	65
153	293	76
154	293	127
155	293	125
156	293	11
160	125	135
161	125	126
162	125	127
163	125	11
182	215	149
183	149	215
190	296	115
191	296	119
192	296	184
193	112	113
194	112	114
195	113	112
196	113	114
197	114	113
198	114	112
199	114	122
200	114	123
201	297	115
202	297	111
203	297	198
204	198	297
205	121	116
206	121	113
207	121	112
208	121	114
209	121	122
210	121	123
211	121	120
212	121	117
213	121	115
214	121	297
215	121	119
216	121	118
217	119	113
218	119	116
219	119	112
220	119	114
221	119	122
222	119	123
223	119	118
228	120	122
229	120	123
230	123	122
231	123	120
232	122	120
233	193	95
234	193	227
237	298	286
238	160	179
240	299	233
241	299	231
242	145	14
245	147	300
246	147	149
247	300	149
248	300	147
249	14	145
253	301	150
254	301	152
255	301	151
256	150	152
257	150	301
262	152	150
263	152	301
265	164	181
266	181	164
267	181	165
272	166	162
273	166	7
280	7	166
281	7	162
285	127	135
286	127	126
287	127	65
288	127	76
289	138	136
290	138	137
291	138	128
292	43	104
297	302	136
298	302	138
299	302	137
300	302	128
318	136	138
319	136	137
320	136	128
321	136	303
322	303	136
323	128	138
324	128	137
325	128	136
326	128	248
327	50	49
328	50	63
329	50	48
330	50	74
331	142	50
332	230	224
333	230	142
346	196	141
347	196	305
350	28	26
351	30	29
352	31	29
354	131	130
355	130	139
356	130	245
357	130	133
368	304	141
369	304	44
370	139	245
371	139	9
372	139	133
373	139	130
374	139	131
377	63	52
378	63	46
379	169	171
380	169	290
383	47	48
384	49	42
385	49	50
387	108	98
393	306	43
394	306	205
395	189	187
396	189	184
401	52	174
402	53	52
403	211	204
404	204	211
413	217	216
414	217	162
415	217	163
426	2	279
427	279	2
428	280	2
429	280	279
430	260	261
431	261	279
432	261	260
433	277	278
434	277	169
439	216	162
440	216	163
441	163	162
442	163	216
443	105	45
444	45	105
445	234	233
446	234	231
447	234	235
448	234	239
449	234	240
450	234	288
451	234	243
452	234	241
453	234	237
454	234	234
457	309	264
458	309	308
459	308	68
460	308	308
461	308	85
462	311	310
465	255	253
466	255	258
467	255	254
468	254	255
469	253	255
470	253	256
474	313	255
475	313	310
476	310	311
477	310	313
478	314	312
479	314	313
483	312	255
484	312	314
485	312	254
487	51	56
489	56	51
490	99	205
495	315	121
496	315	99
497	90	88
499	316	44
501	317	130
502	318	172
503	172	183
504	172	160
505	172	318
506	218	168
507	168	218
511	319	72
512	156	158
513	156	154
514	88	262
515	88	85
516	88	87
517	88	86
518	158	156
519	158	157
520	322	153
521	322	158
522	153	322
523	101	154
526	323	85
527	323	87
529	97	250
530	250	161
534	72	319
536	174	183
537	174	166
538	174	52
539	174	191
542	185	121
543	185	184
546	37	29
556	326	297
557	326	198
558	327	278
565	21	303
566	21	23
567	21	22
568	21	274
577	274	23
578	274	21
579	274	303
580	274	22
581	38	37
587	24	23
588	23	24
589	23	296
590	23	22
591	23	274
592	25	3
593	27	26
595	288	27
596	324	37
597	194	227
598	194	193
599	191	174
600	219	222
604	223	219
605	223	222
606	244	219
607	244	222
608	244	223
609	244	245
614	245	222
615	245	219
616	245	223
617	245	244
626	329	222
627	329	219
628	329	223
629	329	244
630	329	317
632	278	277
633	173	121
635	195	110
640	229	224
641	224	226
642	224	229
643	224	230
644	171	169
648	170	250
649	170	169
650	170	290
651	331	228
652	331	51
656	183	160
657	183	179
658	334	39
659	334	160
660	334	179
663	177	176
664	177	334
665	165	164
666	165	176
670	335	110
671	335	122
672	335	39
674	197	78
677	336	278
678	336	160
679	285	12
681	339	162
683	340	336
685	78	79
686	78	82
687	78	83
688	78	84
689	117	84
690	117	78
691	84	78
693	79	78
694	79	80
695	79	82
696	79	83
697	80	78
698	80	79
699	80	82
706	83	78
707	83	79
708	83	80
709	81	78
710	81	79
711	81	80
712	81	81
713	81	83
728	341	281
729	341	141
730	341	134
731	341	305
732	341	196
733	341	140
734	341	342
738	328	278
753	342	341
754	342	328
755	342	343
763	343	341
764	343	328
765	343	342
766	343	344
771	344	341
772	344	328
773	344	343
774	344	342
778	246	233
781	345	155
782	345	154
783	155	154
784	155	345
785	154	155
786	154	345
787	110	113
788	110	122
789	110	117
790	110	297
792	10	111
793	295	111
794	295	10
797	346	169
801	348	88
802	348	267
810	333	176
811	333	350
812	350	333
813	350	176
814	350	177
815	60	50
816	60	347
819	325	37
820	325	29
821	325	184
822	325	249
823	249	184
824	249	325
829	247	219
830	247	220
831	247	222
844	355	121
845	355	353
846	355	351
849	353	121
850	353	351
851	141	305
852	141	44
853	141	134
854	141	196
855	141	341
856	141	140
857	134	130
858	134	141
859	134	305
860	134	196
861	134	341
862	134	140
863	305	141
864	305	44
865	305	134
866	305	196
867	305	341
868	305	140
870	68	308
872	357	217
876	358	202
877	358	199
878	358	201
884	361	29
885	361	198
886	360	74
887	360	75
888	359	49
895	226	227
896	226	364
902	362	225
903	362	224
904	362	283
905	362	363
906	362	364
908	363	226
909	363	362
910	363	364
914	93	156
915	93	157
916	93	158
925	365	226
926	365	363
929	356	333
930	356	24
935	351	121
936	351	353
937	351	355
940	367	326
941	367	168
944	370	119
945	370	118
948	157	156
949	157	158
954	372	156
955	372	158
956	372	153
957	372	322
961	373	367
962	373	366
963	373	364
966	374	362
967	374	366
968	364	362
969	364	226
970	364	363
971	364	374
972	366	365
973	366	226
974	366	363
975	366	364
976	366	373
979	375	128
980	375	26
983	376	121
984	376	173
989	377	297
990	377	118
992	378	22
1001	380	224
1002	380	226
1003	380	366
1010	382	350
1011	382	177
1012	382	381
1013	381	24
1014	381	23
1015	381	21
1016	381	382
1017	222	247
1018	222	219
1019	379	356
1032	383	382
1033	383	356
1034	383	350
1035	383	177
1040	386	338
1041	385	128
1042	385	3
1043	385	286
1045	387	224
1049	389	141
1050	389	246
1051	389	45
\.


--
-- TOC entry 2588 (class 0 OID 0)
-- Dependencies: 174
-- Name: relatedtechnique_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('relatedtechnique_id_seq', 1051, true);


--
-- TOC entry 2573 (class 0 OID 47993)
-- Dependencies: 176
-- Data for Name: skilllevel; Type: TABLE DATA; Schema: public; Owner: -
--

COPY skilllevel (index, levelname) FROM stdin;
1	Beginner
2	Intermediate
3	Advanced
\.


--
-- TOC entry 2574 (class 0 OID 47996)
-- Dependencies: 177
-- Data for Name: sport; Type: TABLE DATA; Schema: public; Owner: -
--

COPY sport (sport, index) FROM stdin;
Gi only	1
No-gi only	2
Either Gi or No-gi	3
MMA	4
\.


--
-- TOC entry 2576 (class 0 OID 48001)
-- Dependencies: 179
-- Data for Name: technique; Type: TABLE DATA; Schema: public; Owner: -
--

COPY technique (type, topic, name, setup, details, credit, index, sport, startingpos, endingpos, imageurl, numimages, videoid, opponentstartingpos, skilllevel, lastteachdate, rating, ratings) FROM stdin;
2	3	Americana Escape to Payback Americana	He has you in Americana on your left arm from your right side control. Your right arm is outside the side control (he\nisn't on it). This is important since you will need your right arm to press out of this tight spot!	1.  As he sets up the submission, reach your right hand over and grab your left hand. Use this to assist you to get on\nyour left side. You should be facing away from him on your side now, not on your back. \n2. Push with your right hand against his left elbow and keep pressure on him\n3. Rotate his elbow over and GET TO YOUR KNEES. Keep pressing and he will roll over you to his back. Secure side control\nand keep his arm.\n4. Payback: Americana him now! His left arm should be trapped since you've been rolling him with it under control.	\N	136	3	6	8	\N	\N	Yj0HCR-Sdss	3	3	2007-12-22 06:00:00+00	83	4
3	14	Neck Crank from North/South	You are on him in North/South position. He is hugging  around you.	1.  Walk feet around to side. You should be able to trap his arm across his neck. If he lets go, you can trap his arm\nanyway with your upper armpit\n   2. Dig your arm under his head and put on the pressure. This may take lots of muscle, but it works!	\N	8	3	10	15	\N	\N	\N	6	2	2008-01-23 06:00:00+00	\N	\N
3	3	Omo Plata from Side	You have him in right side control	   1.  Convert to Kesa Gatame\n   2. Pull his right arm behind your left thigh and trap his wrist between your legs. Clamp!\n   3. Keep your left arm close to your side and roll over his chest on your left shoulder. Kick his shoulder over as you roll.\n   4. Omo plata!	\N	9	3	3	11	\N	\N	\N	6	2	\N	\N	\N
5	9	North and South	You are holding him in side control and will transition to North South	With your arms holding him tightly and your weight on him continuously, pivot 90 degrees on your chest (walk your legs over his head).\nThis position is like the side control, except you are lying on his face with your legs sprawled above his head and your head on his stomach.	\N	12	3	3	10	\N	\N	\N	6	1	\N	\N	\N
5	9	High side control, or Quarter North/South	You are holding him in side control	Pivot 45 degrees toward his head from side control. Sprawl out and put most of your weight on his shoulder. \nThis is a hybrid between north and south and side control. It is extremely strong because he cant get his legs involved in the escape. Most of your pressure is one of his shoulders and his head.	\N	13	3	3	3	\N	\N	\N	6	1	\N	\N	\N
3	3	Kimura from inside Half Guard	You are in his half guard.	1.  Slap/trap kimura figure 4 lock around his outside arm\n   2. Roll forward  over him\n   3. Pull him over you so he rolls into kimura, pulling him into guard.	\N	11	3	8	1	\N	0	\N	2	1	\N	\N	\N
3	15	Ankle Lock	You are standing in his open guard. His feet are near your arms so you can grab an ankle quickly. You are attacking his\nleft ankle.	1. The more you crowd him, the less useful his feet are from his open guard. Keep in mind that crowding him may expose\nyou to getting taken down. \n2. Scoop your right arm under his left ankle and clamp it tightly under your armpit, pulling up under his Achilles heel\nto tighten.\n3. Figure 4 grip (your right palm grips your left wrist and your left palm grips his left shin) or gable grip. \n4. Arch your back as you tighten.	\N	300	3	5	15	\N	\N	5L1BJ9GTXLg	1	1	2007-12-18 06:00:00+00	70	24
2	5	Passing Sword Guard	Breaking this tough grip is not easy. Assume he has you with his right arm on your left lapel.	   1.  Grab his right sleeve at the wrist with your left hand\n   2. Grab his right collar lapel with your right hand\n   3. Jerk his arm to the right and his collar down to the right as you pull him into you. Rotate your shoulders to the right at the same time.\n   4. Pass guard quickly to the left	\N	48	1	8	3	\N	\N	\N	1	2	\N	\N	\N
5	5	Sword Guard	This is not a very useful guard. I've seen it mostly used by big strong guys but its so defensive as to be nearly\nuseless. On the other hand, it can be used to frustrate an opponent.	This is a sitting up guard where you have a strong straight arm grab to his mirror-side lapel (like a sword). This hold\nprevents him from closing the distance and pressing to pass.	\N	47	1	1	1	\N	\N	\N	8	1	\N	\N	\N
1	5	Preventing getting pulled into guard when you are both standing	This is when the guy grabs you, plants his foot and puts the other on your hip to pull you into a tight guard.	   1.  He will signal this move by grabbing you and putting one foot up on your hip. \n   2. As he plants his base foot, step on it. This will prevent him from using this leg in the guard\n   3. With his foot trapped, this leg becomes his "beaten leg", pass the guard towards this side	\N	54	3	5	3	\N	\N	\N	5	2	\N	\N	\N
5	5	Pulling to Closed Guard from Standing	You are both standing. You want to get him into guard. In competition, this is helpful if you know your opponent is a good wrestler (take-down skills) and is going to put you on the ground. This is not recommended for MMA.	1. Grab him in a clinch (lapel and sleeve or arm and behind neck)\n2. Plant your left foot on the floor and your right foot on his left hip\n3. Sit down quickly pulling him down with you.\n4. Close your guard	\N	55	3	5	1	\N	\N	\N	5	1	\N	\N	\N
5	5	Knee Trapping Guard	You are holding him in closed guard. You want to frustrate his attempts to pass you keeping him in guard.	Grab the outside of both of his knees under your thights. Maintaining hold of the outside of his knees, he will be unable to back out. Keep your abs tight to assist keeping him close.	\N	58	1	1	1	\N	\N	\N	8	1	\N	\N	\N
2	5	Escape Knee Trapping Guard	He is holding you in closed guard, gripping the outside of your knees	1. Lean forward and press your head into his gut. \n2. Pin both of his arms by pressing your hands into his biceps\n3. Stand up, keeping as much weight as possible on his gut: TRIPOD\n4. Once you do this, his grip is lost. He no longer holds your knees.\n5. Start a pass quickly to prevent him from grabbing again.	\N	59	1	8	1	\N	\N	\N	1	2	\N	\N	\N
1	5	Knee Ride Guard Pass Defense	You have him in half guard. In this example, you are trapping his right leg. You can get your left arm under his right arm.	   1.  Keep on your right side throughout this technique! Just like the others, keep your elbows tight and your right hand over your face to prevent cross-face.\n   2. If he pushes on your left shoulder to flatten you out, get your right elbow over and pull down on his arm to kill the push\n   3. Get your top knee under his butt. This will help push him forward in a second.\n   4. Reach your left hand behind his upper right thigh (under his butt). This will also help push him forward in a second.\n   5. Drive him forward using knee and arm. You should be able to get hold of his leg tightly with both arms and escape out the back door.\n   6. Control his legs and take him down	\N	73	3	2	8	\N	\N	\N	8	2	\N	\N	\N
3	1	Passing the Half Guard with Knee Ride	You are in his half guard. In this example, your right leg is trapped, but your knee is out, starting to step through into the knee ride.	   1.  Push down on his left shoulder with your right arm. This is to flatten him out.\n   2. Pull up on his right sleeve with your left arm. This is to help hold him in kesa gatame.\n   3. Press the knee of your trapped leg against his hip toward your free leg as you slide your weight down\n   4. Once your butt hits the floor, complete Kesa gatame hold	\N	75	3	8	13	\N	\N	\N	1	1	\N	\N	\N
6	7	Single Leg with Trip - from Clinch	Variation - I have seen a great video of Renaldo "Jacare" DeSousa doing this. He actually starts the move with the trip. The way he does it is a bit of a hybrid between a single leg and an ankle pick.	   1.  Hold his left arm above the triceps or behind his neck. Gi: hold his left lapel.\n   2. Hook the opponents left heel with the right foot\n   3. Drive in and down fast grabbing his left leg behind the knee with your left hand	\N	86	3	5	3	\N	\N	\N	5	1	\N	\N	\N
6	7	Single Leg with Trip	This is a definite improvement of the single-leg takedown. Exactly the same as the single leg except your right foot at the heel catches behind his Achilles. As you drive forward, this trips him, preventing him from moving that foot to balance himself.	Do the Single Leg Takedown, but at the end, bring your right leg around behind his left heel and keep driving forward. Your right knee will press to the mats and he'll be unable to sprawl.	\N	87	3	5	3	\N	\N	\N	5	1	\N	\N	\N
2	9	Knees under the Armpits Reversal from Under North and South	This only works if you can grab his arms and get your knees inside his arms before he grabs you.	   1.  Get your hands under his armpits and push up HARD\n   2. Pull your knees under his armpits and move your hands down to hold his sleeves\n   3. Push up with your knees and pull down with your hands.\n   4. When his weight lifts off you, sit up. He will roll forward off you\n   5. take side control	\N	15	3	6	3	\N	\N	\N	10	3	\N	\N	\N
2	9	Escape from North-South when Both Arms are Trapped	Your arms are under his. In other words, his arms are not wrapped around yours.	   1.  Wrap your arms around his and grasp your hands near his belly. This will prevent him from posting with his hands.\n   2. Roll slightly to your side. Once you can get your legs under you, PUSH him off.	\N	16	3	6	8	\N	\N	\N	10	3	\N	\N	\N
2	9	Escape from North-South when One Arm is Free	He has one of your arms, the other is free.	   1.  Hug his arm with your trapped arm\n   2. With your free hand, reach up and grab under his other side knee\n   3. Roll toward his trapped arm	\N	17	3	6	8	\N	\N	\N	10	3	\N	\N	\N
2	9	Escape from North-South with Both Arms Free	He is holding your belt or pants. Both of your hands are free.	   1.  Push on his hips to get as much of your lower body out from under him as possible. This will pull his arms up closer to where you can trap them.\n   2. Trap his arms by hugging around both of them\n   3. Roll	\N	18	3	6	8	\N	\N	\N	10	3	\N	\N	\N
2	9	North-South Escape - Over the Top	You are stuck under him in North-South position. This is one of the most insane escapes in BJJ. It requires a good degree of flexibility.	   1.  If his weight isn't near your hips, you should be able to bend at the waist and wrap your feet over his back\n   2. Push both hands on his hips to make extra space to get over his back\n   3. If you can get one hook into his hips, you should be able to escape and take his back	\N	19	3	6	12	\N	\N	\N	10	3	\N	\N	\N
2	9	North-South Escape - Trapping his posted knee	You are stuck under him in North-South position.	   1.  Grab his belt with both hands and push up above your head. To keep his weight on top of you, he will probably reposition his knees near your head.\n   2. Grab on the outside of both his knees (this traps his post)\n   3. Pull down to one side and roll in that direction.	\N	20	3	6	8	\N	\N	\N	10	3	\N	\N	\N
2	9	Side Control Escape with Leg over his face	He's on right side with his arm closest to your head either under or over your neck	   1.  Push off his face under his jaw with your left hand. Do it STRONG.\n   2. Crunch your abs tight and pull your left leg across his face so the head is behind your knee. Extend your leg to push him over\n   3. This will stretch his arm out that is closest to your head. Wrap your right arm around the base of his tricep (nearest his elbow).\n   4. Perform an elbow lock by clasping your hands and pressing them towards your left (left bicep flex pose)\n   5. He will roll over you	\N	22	3	6	3	\N	\N	\N	3	2	\N	\N	\N
2	9	Knee on Chest Escape - Grab triceps and roll away	He has knee on chest on your right side and his head is up	1.  Grab his triceps with your left hand and under his shin with your right\n   2. Roll away	\N	80	3	6	8	\N	\N	ddvJes8bVWQ	3	2	\N	\N	\N
2	9	Side Control Escape - Bridging Belt Hold	You are held in right side control. Both hands are free.	1.  With the left arm, reach over his shoulder and grab his belt\n   2. With the right arm, reach down low on his leg and grab his pant leg (ankle is good)\n   3. Make a wide arc motion with both arms over your head and BRIDGE away\n   4. You may end up either in his guard or holding him in side control	\N	21	1	6	3	\N	\N	\N	3	2	\N	\N	\N
2	9	Shoulder Rolling Escape from Kesa Gatame	You are held in kesa gatame on your left side. Your left arm is trapped.	1.  Right hand grabs behind his neck to keep him close to you.\n   2. Left hand grab the back of his tricep. Be careful not to let him armbar this arm.\n   3. Right hand clasps left around the back of his triceps.\n   4. Pull in. This might armbar him. If so, great. Otherwise keep pulling to roll him over you via his trapped shoulder.	\N	28	3	6	3	\N	\N	\N	13	1	\N	\N	\N
2	9	Bridging Sweep Escape from Side Control	He has you in right head in arm control.	1.  Press head to mat towards his elbow. This traps his arm. If you loose his arm under your head, you can't do this\ntechnique.\n   2. Grab his pant leg closest to you as close to his ankle as possible\n   3. With other arm, reaching over his shoulder (preferably the shoulder furthest from your head), grab his belt\n   4. Look up in preparation for a good bridge\n   5. With both arms (grasping his leg and belt), make a sweeping arc over your head as you bridge (pressing head hard\nagainst arm).	\N	24	1	6	3	\N	\N	-cGdB7R3o1Q	3	2	\N	\N	\N
2	9	Sit up Side Control Escape	He has you in a head in arm side control on your right side. Warning: like many escapes, this one is hard to get\nconsistently.	1.  Keep your arms together on your chest. Reach your right arm around his neck and grab the inside of your right leg.\n   2. Swing your right leg down as you sit up\n   3. Sit up and roll him on his side. You should end up in a kesa gatame position.	Travis Tooke	25	3	6	13	\N	\N	9FivzU1Ik0A	3	2	\N	\N	\N
2	11	Escape from Rear Mount	The important thing to note is that you are in serious choke danger. He needs two hands for a good choke. The best way to protect against this is to not sweat the first hand. You can still easily escape if he is working one hand in for a choke.	   1.  You need to prevent the second hand from coming across your neck. The way to do this is to put your arm over your head and press your shoulder tight against your cheek/neck.\n   2. When his second arm comes across under your arm grab it with your opposite arm (left grabs his right for example).\n   3. Push away from the one choking arm that is holding you. A good way to remember this is that his arm is pointing in the direction you should move.\n   4. Scoot your hips out of his hooks in this same direction until your legs are free\n   5. Turn into him to guard	\N	40	3	6	1	\N	\N	\N	12	2	\N	\N	\N
3	17	Quad Crush From Twister Lockdown	Twister lockdown	   1.  Reach over to his right quad and scoop under it with your right wrist. Clamp your hands together on his quad\n   2. Roll over him and split his legs open like a banana split. Crush his quad with a shearing action.	Eddie Bravo	238	3	3	15	\N	\N	\N	6	3	\N	\N	\N
5	5	Stretch Guard or 'Chapter 13'	He can be kneeling or standing. The reason I call this Chapter 13: Imagine a student into Math class nervous on the first day of school. There is a big textbook is staring at him on your desk. The teacher says in commanding voice: "Open to Chapter 13!" expecting the hapless student to already know chapters 1 through 12. The idea is that you are throwing such a complex problem to solve at your opponent that you will baffle and frustrate him. Sure, it's oblique???	Grab one or both of his sleeves or triceps and press your feet or knees into the crooks of his elbows, wrists, or shoulders. You can control him from here and get him off balance enough to throw him. Keep moving your knees or feet around, pressing on his junction points (hips, shoulders, elbows, inside knees, etc).	\N	46	3	1	1	\N	\N	\N	8	2	\N	\N	\N
3	2	Armbar from Side Control (near side)	You have him in side control, on his right side. I think this is an awkward position. The opposite side armbar is far better.	   1.  Grab his right sleeve near his wrist\n   2. Push your right knee up onto his stomach\n   3. Dig your left arm under his right arm to trap\n   4. Put your weight over your right knee. This puts pressure on him and also allows you to easily put your left leg over his face.\n   5. Sit back into armbar.	\N	118	3	3	15	\N	\N	\N	6	2	\N	\N	\N
2	5	Basic Guard Pass	Start from Position 2 (you have opened the closed guard) with your right knee up and foot flat in between his legs.	1. Scoop under his right leg with your left arm. Keep elbow or palm pressure on his other leg with your right hand to\nprevent triangle. \n2. Press your right knee forward (lean forward) over his left thigh\n3. Reach your right arm up under his neck on his left side. Put your chest down on his chest.\n4. Once your right knee hits the floor, your right leg has his left leg trapped with your foot on the floor on the\ninside and your knee on the floor on the outside. If you don't do this, he can get you into a frustrating half-guard. \n5. 'Wing Out' - Keeping his left leg trapped, turn your hips to the left bringing your left leg past your right leg.\nThis seems awkward the first time you do it.\n6. With your left hand push his right thigh away from you as you secure a tight side control. This is a useful step in\nthat it makes it harder for him to do an immediate elbow-knee esscape and also makes it easier for you to get a tight\nside control.	\N	50	3	8	3	http://austinjiujitsu.com/ajj/pictures/Techniques/Guard-pass.jpg	1	dUawAwSB8Vo	1	1	2007-12-28 06:00:00+00	\N	\N
6	8	Knee pinning sweep from Guard	He is trying to pass your guard	   1.  Grab the outside of both of his knees under your thights. Maintaining hold of the outside of his knees, he will be unable to back out. Lower your guard legs slightly from his waist to his mid-thighs. Clamp your knees as much as possible to pull his legs together more. This will prevent him from "sprawling," which, from this position, simply means spreading his knees apart to prevent you from sweeping him. In other words, your knee clamp prevents him from posting with either knee.\n   2. Roll to a crunched, seated position by sitting up with one elbow\n   3. Clamp further. Your goal is to cross your feet, guaranteeing the sweep. Giving him some wiggle room with your knees may allow you to cross your feet, since he may pull his knees closer together to attempt to push out again.\n   4. If you can cross your feet, great. If not, the sweep may be much harder. Prevent the opponent from posting by clamping one of his elbows with your arm and hug the opponent around the back (optionally grabbing his belt) with the other arm. Press your head close in to his shoulder/chest. Alternative method to prevent the opponent from posting: grab his gi at the wrist (opposite arm) and pull across. Keep hold of the wrist. \n   5. Roll diagonally back to your shoulder and bridge to mount. Quickly move your knees higher to stabilize position (since your knees are very low on him).	\N	57	1	1	4	\N	\N	\N	8	2	\N	\N	\N
2	3	Rolling Omo Plata Escape	He is locking you with omo plata	As he starts, do a front roll over your locked shoulder. This only works on beginners or weak uma plata locks, so don't count on it working every time!	\N	132	3	7	1	\N	\N	\N	15	1	\N	\N	\N
3	18	Banana Split or Crotch Ripper	This is a great move to use as you pass the guard over one leg.	1. During the basic guard pass (see related technique), before you wing out hug his scooped leg\n2. Keep his hip pinned with your other leg and press your body into his scooped leg	\N	142	3	8	15	\N	\N	dLnkFvDDapQ	1	2	2007-12-28 06:00:00+00	\N	\N
2	5	Canopener from Inside Closed Guard	This can be a submission or escape depending on how your opponent reacts. He is holding you in closed guard. Note: this submission is illegal in most competitions.	   1.  Grab the back of his head with both hands and pull it toward you, driving your elbows to his chest. \n   2. He is forced to counter this, usually by breaking guard and pulling his knees to your midsection to get his back straightened. If he doesn???t, you can tap him (assuming it's legal). \n   3. Keep his head held until you get a chance to pull one of your legs into the middle. \n   4. Go for a basic guard pass.	\N	61	3	8	3	\N	\N	\N	1	1	\N	\N	\N
6	8	Defending X Pass to Sweep	He is X-passing your guard to your left.	   1.  He X-passes, your legs are bent\n   2. Grab outside his right elbow with your right palm and pull strongly towards you. This prevents his posting arm\n   3. When his inside leg passes it is next to your side. Reach your left arm deep under his thigh\n   4. Keep his momentum coming into you. Salute your left arm (under his thigh)\n   5. Hold outer arm in trap and roll head back to BRIDGE\n   6. This will roll him over you	\N	64	1	1	8	\N	\N	\N	5	2	\N	\N	\N
3	3	Kimura from Guard Pass Defense	He is passing your guard to your left. \nWarning: as Matt Hughes proved, this move can be countered with an armbar.	   1.  As he comes around to your left, you will be turned toward your left to prevent the pass.\n   2. With your left hand, grab his right wrist \n   3. Shoot your right arm over his right shoulder, hooking over his arm to figure 4 grip your left wrist\n   4. Prepare to bridge at just the right moment: Plant your feet as he comes around. He will try to defend this by coming over your head, so you need to move very fast now.\n   5. As he comes toward your head bridge and roll to your right. You must keep his arm tight to you. Don't let him pull it up.\n   6. Press his left wrist back toward his shoulder blades for Kimura shoulder lock.	\N	65	3	1	1	\N	\N	\N	8	2	\N	\N	\N
6	8	Rolling Reversal from Defending Open Guard Pass	He is coming around your legs to your left, beating your guard. This may be possible with no gi as well, but I've only done this with gi.	   1.  As he comes around, you will be turned toward him to prevent the pass.\n   2. With your outer hand, grab his gi/wrist that is on the side he is passing toward (i.e. your left hand grabs his right wrist if he is passing to his right).\n   3. Pull this hand down as far as you can toward your feet. It is crucial that you trap this hand.\n   4. As he comes around, bridge toward him slightly (to the left, in this example) and grab your other hand around his upper lat into his armpit\n   5. Now pull hard on his lat, roll to the right, and bridge hard to roll him off your chest\n   6. Keep control of  his left arm throughout so you can use it to finish him (kimura or whatever)	\N	66	1	1	3	\N	\N	\N	8	2	\N	\N	\N
1	5	Tug-Down Defense from Guard Pass	He is passing your guard to your left.	   1.  Grab behind him on his belt or pants behind his back OR grab his collar hard and drive your forearm into his neck. The point is, grab something on him firmly.\n   2. Pull him down HARD. Use this pull to bring yourself up to your knees. Sometimes you can take the back from here or at least sprawl on his back.	\N	67	1	1	8	\N	\N	\N	8	2	\N	\N	\N
6	7	Steering Wheel Roll - Guard Pass Defense	He is passing your guard to the left. This technique is not easy, so be patient and work it! It is arguable if this move is considered a throw or a sweep. Whatever the case, it's a great reversal, worth 2 points!	   1.  Shotgun his hip/shoulder as you turn to your left side\n   2. Your left hand reaches over his back and grabs into his left armpit\n   3. Your right hand reaches around under/behind his right elbow into the crook.\n   4. Roll away from him and "steer" him over. Keep control of his arms on the way over. You should have his left arm trapped so you can finish him when he rolls to his back.	\N	69	1	1	3	\N	\N	\N	8	2	\N	\N	\N
2	5	Half Guard to Back or Back Door Escape	You have him in half guard. In this example, you are trapping his right leg. You can get your left arm under his right arm. If he wizzers you, forget it.	   1.  Keep on your right side throughout this technique!\n   2. Keep your elbows tight in your center and your right hand over your face. This is an excellent defense against cross-face.\n   3. It is helpful (although not required) to use your left knee against his right hip to make space\n   4. Reach your left arm under his arm and grab his belt (no-gi: just hug tight around his lats).\n   5. Pull his belt. This will scoot you further under his body toward the "back door."\n   6. Keep your left elbow up. This will prevent him from hugging your left arm as in a wizzer.\n   7. Once you are deep enough out the back door, pull up on your right elbow and take his back.	\N	70	3	2	12	\N	\N	\N	8	2	\N	\N	\N
2	5	Passing Stretch Guard (Chapter 13)	He is holding you in stretch guard. He is controlling you by controlling your arms. This works best if he is stretching\nyou with his feet inside your elbows.	1.  Grab both of his sleeves. This gives you more strength in the place you need it most: your arms.\n   2. Walk forward carefully avoiding the sweep or throw.\n   3. Once you get close enough, you can press your thighs against his and stack him up.\n   4. Go for stacking guard pass	\N	63	1	8	3	\N	\N	\N	1	3	\N	\N	\N
5	5	Half Guard to Guard Transition	You have him in half guard. In this example, you are trapping his right leg. You can not get your left arm under his right arm because he is across you, almost in side control position.	   1.  Keep on your right side throughout this technique!\n   2. It is imperative that you keep both elbows down towards his upper [left] leg to keep him from establishing a tight side control.\n   3. Open your guard just enough to bait him into passing the half guard.\n   4. As he attempts to pass, put him back in guard.\n\nNote: Sometimes, after step 2, if you get your elbows deep under his hips, you can get a sweeping foot it and sweep him. Depends on where his weight is and how tight he is.	\N	71	3	2	1	\N	\N	\N	8	1	\N	\N	\N
2	5	Passing the Half Guard	You are in his half guard. In this example, your right leg is trapped, with your knee trapped.	   1.  Pull your right elbow down low into his hip. This keeps your back door closed.\n   2. With your left hand, grab the gi lapel behind his head, preferably under his right arm. Pin his collar to the ground.\n   3. Lower your left elbow to his face to keep pressure on his head.\n   4. Press your hand down on his thigh to get your knee out.\n   5. Once your knee is out, tripod your head down and pull your left foot up to help open his legs. You should be able to put lots of pressure opening his hips.\n   6. As soon as his legs open, pull both feet up to your butt to prevent him from trapping one of your feet again.\n   7. Although you can mount from here, Carlos recommends going to the side control to establish position.	\N	74	3	1	1	\N	\N	\N	1	1	\N	\N	\N
5	14	Rolling the Turtle	He is in Turtle position. You want to crack open his shell! :) It is a natural response to attack his upper body (to set up clock choke, etc.) but this is unwise. He can easily stand out of this position if attacked at the shoulders. So, we go after control of the legs!	   1.  Get behind him (in this example, you are on his right side), but be wary of the rolling knee bar.\n   2. With your left hand, grab his right ankle.\n   3. With your right hand, grab behind his right knee\n   4. (optional) Step your left knee over his calf.\n   5. You now control his right leg\n   6. Switch your left hand to grab his left ankle\n   7. Lower yourself to drive your shoulder into his right hip. Pull his legs as you drive him over.\n   8. Keep control of his legs! Try to jump over to the opposite side. It is easier to take side control from this direction.	\N	77	3	7	3	\N	\N	\N	9	3	\N	\N	\N
2	9	Knee on Chest Escape - Rolling	He is on your right side. His right knee is on your chest	   1.  Roll slightly right (toward him) to your side. This is difficult, but you only need to roll slightly. This is to set up him pressing harder in the opposite direction.\n   2. Grab his pant-leg at the knee with your right hand\n   3. Roll left, holding the knee until you get to your left side\n   4. BRIDGE to your shoulder, then head (looking "up" over your left shoulder). In other words, bridge, using your head also.\n   5. As he rolls off of you, you keep hold of his leg to keep him from taking your back (since after bridging, your back is partially facing him)\n   6. Quickly turn into him and try to establish side control. If you let go of the leg, you're screwed.	\N	82	3	6	3	\N	\N	\N	3	3	\N	\N	\N
1	1	Rear Naked Choke Defense	He is just beginning to sink rear naked choke. In this example, his right arm is choking.	   1.  The first thing you need to do is get to his left arm, since it is holding his right arm in place. With both hands, grab his left wrist and pull it down. Hold his left writs/gi with your left hand to keep it from closing again.\n   2. Quickly grab your right hand into the crook of his right elbow and pull down to make space. As soon as you can get your chin in...\n   3. Grab behind his right elbow with your right hand and push over to the left in an arc as you roll to the left.\n   4. Keep control of his right elbow. You can move into kimura.	\N	179	3	7	1	\N	\N	\N	12	1	\N	\N	\N
1	1	Counter Lapel Under arm Choke	He is putting this choke on you. In this example, his right had is grabbing your lapel and pulling across your throat. Your left arm is immobilized by his left under your arm and behind your head.	   1.  There are two ways to deal with your left arm that is trapped:\n         1. reach your left arm back and grab behind his head and pull his head down\n         2. Tighten your left arm to your side by crunching your lat down hard\n   2. Grab behind his right elbow with your right hand and push over to the left in an arc as you roll to the left.\n   3. Keep control of his right elbow. You can move into kimura.	\N	180	1	6	3	\N	\N	\N	3	1	\N	\N	\N
6	7	Single Leg Take-down	This is a classic wrestling takedown with an important modification to prevent a defensive choke. The trick of the single leg is to understand exactly where your opponent's balance is weakest. I imagine I'm throwing him into a hole in his balance. This hole is typically right behind his butt to the side of his back foot.	   1.  From standing, left leg forward. Your partner's left leg is forward.\n   2. Shuffle step your left leg forward, your right leg staying back, moving along with the leg\n   3. Drop your right knee to the mat and keep moving forward by dropping your left shin forward so your left knee drops to the mat\n   4. Your right knee really just skips off the mat; it is down for only an instant. I tell my students to imagine it is a stone skipping once across a pond. The right foot steps forward a full step past the left foot, landing flat on your right foot.\n   5. By now you should be close enough to reach out and hug your opponents left leg tight. I tell the kids in my kids' class to hug it "teddy bear tight" as if they are holding on to their most prized possession on earth. It is crucial they hug the leg with the full arm, not just the hands gripping. It is equally crucial that this leg be tight against their chest. Just like you hug your teddy bear, right?\n   6. Put your head on the inside of the leg. Wrestlers are taught the opposite of this, but wrestlers don't use the guillotine choke. Putting your head on the inside makes the guillotine counter choke much less likely. In addition, the head on the inside helps you apply pressure (from the inside out) with your head to drop him.\n   7. At this point he can take a number of defensive moves, including cross face and other nasty counters, so don't just stand there, drive forward HARD.\n   8. Your forward momentum continues by driving your front right knee forward and down.\n   9. If he doesn't go down, a number of things could be wrong:\n         1. Most likely: you didn't drive deep enough or he sprawled on you\n         2. Not likely: He has awesome balance.\n         3. He stepped "into the hole" meaning his rear foot moved over and planted right where you were driving. This gives him a good base. Avoid this by changing direction. There's always a hole, your job is to find it.  As his feet move around, the hole moves around. It takes lots of drilling to have an ability to react this change. For example, if he steps deep into the hole after you grab his leg, you may have to pull him forward rather than drive him back. That's a 180 degree change in direction!\n  10. Put your outside leg behind his trapped leg to trip him and take one more step on your knees to drop him.\n  11. Be prepared for the takedown! All of your weight and his weight headed for the mat is very disruptive of your balance. Keep squarely balanced as he falls so you can maintain control. He can put you in a nasty guard, half guard, guillotine choke or triangle from here. Think ahead about beating the trapped leg to take side control.	\N	85	3	5	3	\N	\N	\N	5	1	\N	\N	\N
3	1	Triangle with Loose Locked Legs	You have him in a triangle but your legs aren't in figure 4	   1.  Reach around behind his elbow with opposite hand, lean back. If he resists, barrel roll 1/4 turn to opposite side and grab other arm same way.\n   2. Pull as you put your calf behind his neck\n   3. Loose lock ankles. He should be leaning into you now, since your weight is on his upper body.\n   4. Pull calves back in (hamstrings), curl toes for max strength. This should exert extreme pressure on his lower neck.\n   5. Extra benefit can be derived from pressing both hands down on the top of his head (compress his neck).	\N	186	3	1	1	\N	\N	\N	8	3	\N	\N	\N
3	1	Triangle when his arm is not across his face	It's funny that a lot of people think they can block a triangle by keeping him from pulling your inside arm across your face. Some people swear by the defense of hugging under the opponents lower leg thigh to keep this inside arm out of trouble. In reality, there is an easy way to tap a guy even if they are hugging around your thigh like that. Since the goal of the triangle is to crush his neck between his shoulder (the inside arm) and your calf behind his neck, his hugging around your thigh takes his shoulder away from his neck.\n\nSetup: you have him in triangle and he defends by hugging your thigh	   1.  Grab around the outside of both of your knees and pull in tight. This will press his shoulder into his neck and maximize the crush from the rear. He should tap here.\n\nIf not, here's an alternative (that doesn't work as well)\n\n   1. Switch your feet. In other words if your right leg is behind his neck, put your left leg behind his neck.\n   2. Squeeze.	David Thomqs	187	3	1	15	\N	\N	\N	8	3	\N	\N	\N
3	1	Flying Triangle	\N	   1.  Pull his left arm down so you can get your leg over his shoulder. It is best if he is leaning forward so your weight has more affect on him.\n   2. Pull him down further as you jump up right leg first aiming to get your leg over his shoulder.\n   3. Your left leg follows and attempts to get your ankles crossed around his back to prevent your body weight (gravity) from pulling you off him.\n   4. Work the right leg behind the left for triangle.	\N	188	3	5	15	\N	\N	\N	5	3	\N	\N	\N
6	8	Butterfly Scooping Sweep	He is standing above you in your open guard.	1. Grab his collar with right hand and his sleeve with your left. Both feet are on his hips, or wherever in open guard.\n2. Move both feet behind his knees and push his feet out a little.\n3. Shoot both arms arm under his legs and scoop them out from under him as you push out on your butterfly hooks.\n4. He will fall	\N	104	3	1	3	\N	0	BNcDHAy6PgQ	5	1	2007-12-23 06:00:00+00	\N	\N
3	2	Armbar - Figure 4 with legs	You are working on an armbar. He is holding his hands really hard and you need to put some pressure on them to open up.	1.  Grab your left lapel with your right hand (this holds his arm in place for a moment while you do #2)\n   2. With your left hand, reach down and grab your right foot at the toe. Lift it up and lie it on his gripped hands.\nYour right leg is bent across his midsection.\n   3. Lift your left leg and get a figure 4. You don't need to sink it tight. \n   4. Push your figure 4 down on him as you lie back (or to side) and complete the armbar	\N	112	3	4	15	\N	0	siZVjQMmmg0	6	2	2007-12-23 06:00:00+00	\N	\N
2	2	Armbar Escape from Top	He has started to arm lock you from his guard. You are above him.	1.  Reach your free hand behind his neck immediately and pull tight to stack him\n   2. Imagine your arm is a rope, flexible and loose. In short, jerky, bursty movements, tug your trapped \narm out.	\N	120	3	8	8	\N	\N	6BtSips0VCs	1	1	2007-12-23 06:00:00+00	\N	\N
2	9	Knee on Chest Escape - Pushing the knee and pulling the foot	He is on your right side with knee on chest.	1. Press his right knee with your right hand (beware he can armbar you here)\n2. Pull his right foot by reaching under his instep with your right hand and grabbing his instep	\N	81	3	6	3	\N	\N	\N	3	2	\N	\N	\N
2	2	Armbar Escape from Bottom	He has started to arm lock you from mount. He is above you.	The best way to escape is to get your endangered elbow out from between his legs by explosively turning \ntoward him and pulling your arm. That doesn't always work, so try this also...\n   1.  Grab your hands together to buy a second\n   2. In a short, quick bridging motion, grab around his forearm with your free hand. The deeper you grab, \nthe better. With the same, free hand, can grab his collar (if he has a gi). This will be stronger than just \ngrabbing his arm.\n   3. You should be able to sit up now by pulling on your arm that is hooking his arm\n   4. Go to the Armbar Escape from Top.	\N	122	3	6	8	\N	\N	8QIAHjZOVzo	4	1	2007-12-23 06:00:00+00	\N	\N
2	2	Double-armbar Escape	He is trying to double armbar you from guard.	Turn your wrists in. That will throw off his angles. He can't correct both, so he will likely discard one and focus on the other. Be prepared for a regular armbar escape.	\N	124	3	8	8	\N	\N	\N	1	3	\N	\N	\N
3	3	Omo Plata from a failed omo plata - opponent rolls away	He just rolled out of uma plata. First of all, you should stop his roll by reaching across his back. Assuming you didn't do that???	   1.  After he rolls, your leg is still under his triceps\n   2. Dive shoulder first across him and kick your leg\n   3. This should force his shoulder over so you can continue.\n\nA more fun counter is the Biggie Slicer. See referenced move.	\N	133	3	1	15	\N	\N	\N	8	2	\N	\N	\N
3	17	Biggie Slicer: Biceps crush from side control	You are holding him in left side control.	1.  From side control, step your right knee over his left arm. You can feed it by grapping his wrist with your right\nhand.\n   2. Put your right shin into the crook of his left elbow, with your knee near his head.\n   3. Reach under your body with your left hand and grab his left wrist and pull it up under your body.\n   4. Lower your weight on his arm to trap it under you.\n   5. The crook of his elbow has intense pressure on it now. Press your body forward to crush his biceps.	\N	140	3	3	3	http://austinjiujitsu.com/ajj/pictures/Techniques/Biggie-Slicer.jpg	1	\N	6	2	\N	\N	\N
3	18	Belt tightening hip crank	You are in his closed guard.	   1.  Grab on either side of his waist (either grab his belt or his pant waist). TIGHT!\n   2. Pull your elbows into his hips and use the elbow as a fulcrum to pull your fists together as far as they will go while retaining grip of his belt. This tightens his belt around his back.\n   3. Press out using your elbows to crank his hips open OR, for more strength, Step up with both shins and press forward. Crank!	Vandry	144	1	8	8	\N	\N	\N	1	2	\N	\N	\N
3	14	Boston Crab from Open Guard	You are standing in his open guard.	   1.  Grab both ankles deep in your armpits deep and strong enough to control him.\n   2. Step over his legs and turn around. This rolls him over to his stomach and turns you away from him.\n   3. Sit back slowly over his rear and crank.	\N	146	3	5	15	\N	\N	\N	1	2	\N	\N	\N
1	16	Cross Ankle Lock - Defense	He has you in cross ankle lock. Your right ankle is locked.	   1.  KICK your left instep under his right elbow.\n   2. Press up on his elbow. This might shoulder lock him. If you are not strong enough to do this, sit up and grab that same elbow and pull it.	\N	148	3	1	1	\N	\N	\N	11	2	\N	\N	\N
3	16	Heel Hook from Side Control Escape	\N	If you are holding him in side control and he starts a knee escape, you can grab his heel and heel hook him.	\N	151	3	8	15	\N	\N	\N	1	2	\N	64	2
6	7	Fireman's Carry	ou are standing with your left leg forward, as is your opponent.	   1.  Grab his left arm above the elbow (overhook)\n   2. Crouch down and slide forward on your left foot.\n   3. Land in between their legs and hug his left leg with your left arm. Your left foot is flat on the floor (knee up) behind his left foot and your right knee is down in front of his left foot. They should be bending over since you are still holding their arm.\n   4. Fast - Holding tightly, fall to your right side and bridge sideways. Keep hold of his arm and turn to control him as he lands. \n<b>OR - Alternative - For more "air" on the throw:<b>\n   4. Fast - Press your shoulders into him and straighten your back to pick him up on your shoudlers. Keep hold on his arm and throw him on the ground.	\N	89	3	5	3	\N	\N	\N	5	2	\N	\N	\N
6	7	Ankle Pick	Ive seen very different approaches for the ankle pick. I've talked to wrestlers who execute this differently, with\nsuccess. This one works best for me.	1. Grab his left wrist with your right or overhook his left arm with your right. (Gi - grab with your right hand in his\nleft lapel)\n2. Step in with your right foot past his left foot and go down to your left knee\n3. Grab his left heel with your left hand \n4. YANK his foot out from under him as you PULL him down and back with your right hand	\N	90	3	5	3	\N	\N	MpBTFoHLsEM	5	2	2007-10-21 05:00:00+00	\N	\N
3	1	Moraes Sweep and Reversal	He is in your closed guard.	   1.  Hold his right collar with your right hand. Hold him close down on you or else this won't work!\n   2. Hold his left sleeve with your left hand. This takes his posting arm\n   3. Plant your right foot, knee up, outside his left knee. This takes his posting leg.\n   4. Swing your left leg out sideways to the mat and slam it against his right side while you roll right. This sweeps him.\n   5. Finish with Ezekiel choke	Daniel Moraes	208	1	1	15	\N	\N	\N	8	2	\N	\N	\N
3	18	Electric Chair Hip Crank from Lockdown Half Guard	Lock-down, steps 1-4	1.      He places his left leg up near your head, posting\n   2.      Scoop his leg with your right arm up to your shoulder.\n   3.      Clamp his quad with both hands, gable grip\n   4.      Rotate to your left, rolling him to his right\n   5.      You can either banana split (hip crank) him or hamstring stretch him depending on if you roll on top of him\nor stay to the side. In the banana split case, you are prying his hips apart. In the hamstring stretch, you get on top\nand drive his knee toward his face.	Eddie Bravo	230	3	2	15	\N	\N	_gd2Y36qj2E	8	2	2008-01-19 06:00:00+00	\N	\N
3	17	Biggie Slicer (Bicep Crush) from failed Uma Plata when he does rolling escape	He just rolled out of uma plata	1.  After he rolls, your shin is across his bicep\n   2. Sit forward toward side control, trapping his bicep under your shin and finish with bicep crush.	\N	134	3	1	15	\N	\N	\N	8	2	\N	\N	\N
5	5	Tard Control - Rubber Guard	Tard control is a tight guard position that is useful when trying to restrain an active opponent.	   1.  Start holding your opponent in closed guard. They are sitting up.\n   2. Sit up and hug them around their arms and lie back down again.\n   3. Get in mission control.\n   4. Gable-grip your hands (your right hand will be under your left ankle).	Eddie Bravo	220	2	1	1	\N	\N	\N	8	1	\N	\N	\N
3	2	The Pump to Armbar	Tard control, but you can't get the Zombie. In this case his arms are tightly defended and you can't isolate one. The Pump is named after the pumping motion you make to drive his arm in and isolate his shoulder for the armbar setup.	   1.  Cross your ankles behind his neck. Still keep hold of your left ankle.\n   2. Vigorously push his right elbow with your left palm as you straighten and flex your crossed legs behind his neck (pump!). Work your left leg as high on his shoulder as possible. Getting your calf around his right shoulder is perfect.\n   3. Clamp with your left leg and trap his right arm with your left arm by driving it in between the crook of his elbow.\n   4. Let go of your ankle with your right hand and reach under his leg to do an armbar from guard, sweeping him to his back in the process.	Eddie Bravo	221	2	1	1	\N	\N	\N	8	2	\N	\N	\N
5	5	New York - Rubber Guard	Mission Control. Assume his arms are on your chest.	Same as London, but you clasp your hands together by grabbing under your left thigh.	Eddie Bravo	223	2	1	1	\N	\N	8wYsegjBqRA	8	1	\N	\N	\N
6	7	Half and Half Sweep	You have lockdown, holding his right leg. This is more of a takedown than a sweep, but since you start in guard, it is\neasier to think of as a sweep.	1.  Double underhooks\n   2. Explosively lift your legs and jerk your body to the right to get out from under him a bit.\n   3. Open your guard and get up on your right elbow, then knee\n   4. If he doesn't wizzer you, take his back!\n   5. If he does wizzer you, reclamp your hands (Gable grip) and drive him back\n   6. Turn out your legs to pass guard. If he attempts to block this pass you may be able to mount him.	Eddie Bravo	229	3	2	3	\N	\N	4J-Avq3u804	8	2	2006-11-15 06:00:00+00	\N	\N
5	9	Reverse Kesa Gatame	This is a great side control variant. It is useful for setting up lots of attacks and allows you great visibility of your opponent. You are on his right side.	1. Turn your body to the left, pushing your left knee to his right hip and your right leg will be posted out wih your right foot flat on the ground and knee up. You will end up sitting on your butt with your left side (lats) pressed against his upper chest. \n2. Your left elbow is in his far (left) armpit with your left hand holding alongside his left hip. \n3. Your right hand can either hold his right hip but it actually isn't required to help\nCritical points: lots of pressure on his upper chest and tight knee against his hip!	\N	232	3	3	3	\N	\N	\N	6	2	\N	\N	\N
3	14	Twister from Twister Lockdown - Rolling Back	Twister lockdown	   1.  Pull him back toward you.\n More detail needed.	Eddie Bravo	237	3	3	15	\N	\N	\N	6	3	\N	\N	\N
3	14	Twister from Double Under Guard Pass	You are in his guard.	   1.  Scoop both arms under his thighs and stack him up on his neck.\n   2. Allow him to roll backwards to all fours.\n   3. Do Twister from All Fours\nYou can pull him back on you in step 4 to get the twister that way instead. This move also works from a failed shoot. If you are sprawled on his back and he is on all 4s, try the same thing.	Eddie Bravo	240	3	7	15	\N	\N	\N	7	3	\N	\N	\N
3	1	Twister from Rear Mount	You have him in rear mount. You can't get the choke so you will go for a lockdown from the back (perfect twister setup).	   1.  You need to get a much lower position on your opponent to lockdown their legs. To do this go to over/under arm position. This is required to be able to hoist your opponent.\n   2. Unlock anaconda and use your right hook under his butt along with your arms to wriggle him up and you down.\n   3. Lockdown your left leg around his lower thigh. Your right foot will be behind his left achilles heel.\n   4. Slide your shoulders right, pulling up to your left elbow. You need to have your upper body to his right to get the triangle. He may lock his arms together if he knows what's coming. If he does, see setting up arm position for twister.\n   5. Complete the twister.	\N	243	3	12	15	\N	\N	\N	7	3	\N	\N	\N
3	14	Twister from All Fours	He is on all fours. This is a great setup!	   1.  step your right foot over the back of his left calf\n   2. Drive your left knee in between his legs\n   3. Grab his right ankle with both hands\n   4. Roll forward over him, getting the lockdown as you roll over\n   5. Twister	Eddie Bravo	239	3	7	15	\N	\N	\N	7	3	\N	\N	\N
3	1	Triangle from Mission Control	Mission Control. Your left leg is behind his neck. You will be attacking his neck with your legs to choke him. He is\nhugging your right knee.	1.  Push his left hand off your knee with your right hand. This will require you let go of mission control momentarily.\n2. As soon as his hand is away, drive your right foot behind his neck (replacing your left leg). Turn to your right to\nget to triangle position. Clamp and tap him.	Eddie Bravo	244	2	1	15	\N	\N	kyUgScgRZ3E	8	1	\N	\N	\N
3	3	Oma Plata from Mission Control	Mission Control. Your left leg is behind his neck. You will be attacking his right arm with a shoulder lock similar to a\nkimura.	1.  Since your right wrist is hooking your left ankle, it is an easy transition to grab the outer edge of your left\nfoot with your right hand. Pull your foot across the right side of his face (on your left). It may help to push his face\naway with your left hand as you make this transition.\n   2. Drive your legs together tight. Push them hard away from you clamping his upper triceps/deltoid.\n   3. As you do this, push his forearm to your left with your right hand. This is crucial in that it orients his\nshoulder the right way to get him with the shoulder lock.\n   4. Wrap your left arm around his waist to prevent him from rolling.\n   5. Roll to your right side to maximize the stress on his shoulder. This should prevent him from sitting up (a common\ndefense for omaplata).\n   6. Slide both feet to your right, keeping your knees together near his shoulder. Sit up. This is an awkward\ntransition, and is definitely the hardest part of this move. Drill it!\n   7. Sitting forward, make sure his arm is trapped to your left side. This will shoulder lock him if you sit forward\nfar enough. Some times I'll dig my arms around his neck to increase the shoulder pressure.	Eddie Bravo	245	2	1	15	\N	\N	mxp2kAwshzE	8	2	\N	\N	\N
5	5	London - Rubber Guard	Note: Eddie has removed this from his 10th planet system due to an inherent weakness related to a simple \ncartwheel or step-over escape that renders this rubber guard variant useless. See \nhttp://www.youtube.com/watch?v=kaVklKMW3aw&NR=1. \n\nMission Control. Assume his arms are on your chest.	1.  Get his right hand using the Zombie.\n   2. Move your right hand across his face (keep tight!) and reclamp under your left leg on your left.\n   3. Clamp your hands together behind his neck\n   4. His right arm should be trapped	Eddie Bravo	222	2	1	1	\N	\N	8wYsegjBqRA	8	2	\N	\N	\N
3	1	Invisible Collar Choke	London Rubber Guard	1.  Bring your right foot up and cross ankle\n2. Grab your left knee with your left hand\n3. Drop your right elbow, squeeze your right knee in and tighten your legs to choke	Eddie Bravo	247	3	1	15	\N	\N	8wYsegjBqRA	8	3	\N	\N	\N
4	19	Single Leg Shoot Drill - Standing Duck Walk	This takes place without a partner. The goal is to memorize the specific footwork and grab necessary for a perfect single leg takedown.	   1.  From standing, left leg forward. Imagine your partner's left leg is forward.\n   2. Shuffle step your left leg forward, your right leg staying back, moving along with the leg\n   3. Drop your right knee to the mat and keep moving forward by dropping your left shin forward so your left knee drops to the mat\n   4. Your right knee really just skips off the mat; it is down for only an instant. I tell my students to imagine it is a stone skipping once across a pond. The right foot steps forward a full step past the left foot, landing flat on your right foot.\n   5. By now you should be close enough to reach out and hug your opponents left leg tight. I tell the kids in my kids' class to hug it "teddy bear tight" as if they are holding on to their most prized possession on earth. It is crucial they hug the leg with the full arm, not just the hands gripping. It is equally crucial that this leg be tight against their chest. Just like you hug your teddy bear, right?\n   6. Stand up and repeat	David Thomas	262	3	5	5	\N	\N	\N	16	1	\N	\N	\N
4	19	Duck walk	This is a drill to help with shoot-ins.	Walking forward across the floor, you will be taking the same steps you do with the single leg takedown. This is hell on your knees, so try to glide the knees across the floor rather than slamming them down. The visual of skipping a stone across the pond helps me here.	\N	263	3	8	8	\N	\N	\N	16	1	\N	\N	\N
4	19	Sprawl Drill	A sprawl is used to defend against a take-down. The goal is to get your legs as far back as possible while driving as much of your upper body weight down on your opponent as them come under you for the takedown. This drill takes place without a partner. The coach should encourage the team to compete for who can hit the mats the fastest and who can get up first. The drill should go on for about 30 seconds to one minute depending on how often the sprawls are happening. In between sprawls, the students quickly shift their weight from foot to foot, making the gym resonate with the sound of feet drumming on the mats. This is a very fast and explosive foot motion and is sure to be demanding on the cardio!	   1.  Stand with both knees slightly bent with feet shoulder width apart.\n   2. Put your hands at shoulder height, palms away from you. Arms are bent at the elbows.\n   3. Jump your legs backwards driving your palms and upper body down to the mats just where your feet were.\n   4. Your body hits the ground in this order: palms, chest, hips, then toes. You want to maximize the weight on your upper body and hips, so your legs should not touch the ground. Only your toes are toughing the ground. Keep your hips pressed hard to the mats.\n   5. Explode to a standing position with one motion.	\N	264	3	5	5	\N	\N	\N	16	1	\N	\N	\N
4	19	Sprawl Ball	This is a sprawling drill with 2 partners passing a medicine ball back and forth. It is an intense cardio workout so start at no more than 2 minutes and work up to 3 minutes.\nBeginners can start on knees. Work up to starting from standing.	1. Face your partner about 5-10 feet apart. \n2. Throw the medicine ball at your partner's chest and immediately sprawl. \n3. Partner catches the ball and does the same to you. Keep moving as fast as can be safely and gracefully attempted.	Randy Couture	265	3	5	5	\N	\N	\N	5	1	\N	\N	\N
6	7	Reverse Heimlich Takedown	This is a simple takedown from a double underhooks clinch from standing. I call this the Reverse Heimlich Drop because\nit basically looks like you are performing the Heimlich maneuver on your opponent except he's facing you, not away from\nyou. Silly name, great takedown.	1. From double underhooks, Gable grip low on your opponent's back.\n2. Pull in strongly while you drive your head and upper chest into your opponent.	\N	261	3	5	4	\N	\N	LJ23GRes_S0	5	1	2008-01-09 06:00:00+00	\N	\N
3	1	Cobra Choke	You are sitting up in your guard and he is on his knees in front of you. You want him pressing into you to get the choke\nsunk in deep. Get him pressing into you by pushing against his neck and far shoulder with your right forearm.	1. Your right hand is on his right shoulder near his neck. Turn your right palm toward you.\n2. Quickly reach your left arm up and place your left wrist into your right palm\n3. Grasp behind his neck with your left hand and pull his head into your chest near your right armpit.\n4. Lift your right elbow to sink your right forearm under his chin and into his neck. \n5. At the same time use your left palm to press his head low into the choke.	Travis Tooke	277	3	1	1	\N	\N	1m3NrOkTzqQ	8	2	2008-01-09 06:00:00+00	\N	\N
3	1	Loop choke	In this move, you "feed" one lapel of your opponents gi from one hand to the other across his neck. This ends up with a\nsuper-tight choke that is very hard to escape.	1. Reach with your right hand to his right lapel and grab, but not too deep. You need a little slack for this move.\n2. Pull him toward you and sit toward him as you pull his lapel to your right across his neck\n3. Reach your left arm behind his neck and take the lapel from your other hand\n4. Pull hard to to left with your left hand. You can often sweep and mount before the choke sets in since his base will\nfall apart as you begin to choke him.	\N	278	1	1	1	\N	\N	VEpAfSJCiYQ	8	2	\N	\N	\N
6	8	Bicep Control Sweep	He is in your open guard. This technique setup is similar to the bicep crush from guard, so review this if you don''t\nknow it.	1.  Hold his right sleeve at the end.\n2. With your left foot, start outside his right arm and "thread" your left foot over his forearm into the crook of\nhis elbow. If you are holding his sleeve tight, you will have effectively trapped his right arm momentarily.\n3. Start pressing in the inside of his elbow by driving your left foot out away from him to your left.\n4. At the same time, rotate your upper body to the right and scoop under his left leg. Your right knee should go to\nhis midsection.\n5. He will fall forward to your left. Keep connected to him and go to knee on chest.	\N	203	1	1	1	http://austinjiujitsu.com/ajj/pictures/Techniques/Bicep-control-sweep.jpg	1	\N	8	3	2006-11-13 06:00:00+00	\N	\N
5	9	Kesa Gatame Side Control	This position is like side control, except you are sitting on your butt, with your legs spread, rather than on your\nknees. Each of your arms is controlling one of his arms, under his triceps. Start from right side control.	1. Grab under his right armpit with your left hand\n2. Grab  under his left armpit with your right hand and reach under so your palm is around his shoulder\n3. Turn your hips to your left so your butt is sitting on the floor next to his right side and your right knee is next\nto his right ear with your foot straight out past his head\n4. Your left leg is up, foor flat, knee up. This leg stabilizes you from him pressing toward you.\n5. You can apply lots of pressure on his chest, but be sure not to overcommit your weight or he can roll you.	\N	26	3	3	13	http://austinjiujitsu.com/ajj/pictures/Techniques/Kesa-Gatame2.jpg	1	\N	6	1	\N	\N	\N
3	3	Kimura from Guard or Half Guard	You are in his half guard. In this example, your right leg is trapped, with your knee trapped.	1.  If he extends his arm (for example to shotgun your right arm with his left arm), wrap your left arm over his left\ntriceps and close the kimura.\n   2. Roll back to get the kimura.	\N	76	3	1	1	http://austinjiujitsu.com/ajj/pictures/Techniques/Kimura-Bobby-Colin.jpg	1	\N	8	1	\N	\N	\N
3	14	Single leg defense to stocks	He has your leg	1. Turn away\n2. Fall to the floor on all fours\n3. trap his shoulder with your leg\n4. Grab over his back, under his opposite arm\n5. Roll over his back\n6. He will roll to his back, almost like a crucifix\n7. Turn in on him for stocks	\N	95	3	5	8	http://austinjiujitsu.com/ajj/pictures/Techniques/Stocks	3	\N	5	2	\N	\N	\N
3	2	Armbar from Mount - Conversion to Triangle	If the opponent attempts to get his head between your legs, his is setting himself up for a triangle	1.  Pull his right arm to your right with your right hand. This will be the arm that goes across his face.\n   2. Lean forward and grab behind his head. Slide your left leg behind his neck.\n   3. Your right leg needs to figure 4 the left foot, so make sure you don't let his left arm get in the way. Slide your\nleft foot between his left arm and his body.\n   4. Once you figure 4, you can roll to your back and pull his head toward you. Bridge your pelvis to tighten the noose.	\N	115	3	4	15	http://austinjiujitsu.com/ajj/pictures/Techniques/S%20Mount.jpg	1	\N	6	2	\N	\N	\N
5	9	Ownage - Knee-up Side Control	This is my favorite side control. It is extremely difficult to escape and is easily transitioned to mount or sweep.\nStart in a head-in-arm side control on his right side.	1. Slide your right knee up on his belly. 2. Your right instep is tight against his right hip. Clamp your leg against\nhis hip. Don't over-commit your weight! Use your arms to control his head and neck.	\N	286	3	3	3	http://austinjiujitsu.com/ajj/pictures/Techniques/Ownage.JPG	1	\N	6	2	\N	\N	\N
3	2	Reverse Armbar from side	You are in right side control. His arms are tight and close.	1.  You need to get control of his left  arm by getting your wrist into the crook of his elbow. His elbows are\nstrong! Don't try to dig around his elbow. He's too strong here. Push your left wrist under left wrist. This is the\nweakest point in his arm and is the easiest place to dig under. Once you get under his wrist, it is easy to get into the\ncrook of his elbow.<br>\n   2. Move to a North/South, keeping strong control of his trapped arm.<br>\n   3. Push your knee over the bicep of his right arm. This disables this arm for the duration of this technique. <br>  \n4. Now you need to work on the left  arm. This is the one you will be armbarring.  Dig under it the same way.\n   5. Once you get your arm into the crook of his arm, get your head under it. Pull your arm out and get your arm\nbetween his arm and the floor. This leaves his arm trapped in your shrugged shoulder.<br>\n   6. Put your left leg on the mat over his head. Force your calf behind his neck and get the leg into figure 4. This\nputs much more control and pressure on his neck.<br>\n   7. Now you are ready to armbar. Shimmy your arm/head along his arm until it is at the base of his triceps just above\nhis elbow. Squeeze!\n\nAlternatives from this position:<br>\n\n   1. Keeping arm trapped, sit up to one knee and do Kimura or inverted armbar<br>\n   2. Keeping arm trapped, sit up to one knee, Spin around to seated regular armbar<br>	\N	6	3	3	3	http://austinjiujitsu.com/ajj/pictures/Techniques/Reverse-armbar-from-Kesa-gatame.jpg	1	\N	6	2	\N	\N	\N
3	1	Pillow Choke or Arm Triangle	This works from standing, from side control, or even inside the half-guard. I've even gotten this from under the mount\nposition. You should go for this any time your opponent puts his arm across his face.	1.  Get high mount, driving his arms up over his face\n   2. Press his left elbow across his face and immediately lean on this arm to trap it\n   3. Trap his hand by reaching under his neck with your right arm and holding his hand\n   4. Get low and press your neck into his trapped arm\n   5. Dismount to his left side. Dig your arm deeper until you can grab your left bicep next to his shoulder\n   6. Squeeze	\N	161	3	4	3	http://austinjiujitsu.com/ajj/pictures/Techniques/Teaching-arm-triangle.jpg	1	\N	6	2	\N	\N	\N
5	9	Twister Side Control	Side control on his right side. You are hugging him and keeping his right arm isolated. This is important! This is a\nside control the same as reverse kesa getame. It really is only useful for setting up the twister submission and the\nrelated family of submissions.	1.  Turn and face his legs, sitting on his right arm.\n   2. Put your left elbow under his left armpit and your right hand on his right hip.\n   3. Your legs are open to the right\n   4. You MUST keep your left knee against his right hip to prevent him from taking your back.	Eddie Bravo	231	3	3	3	\N	0	c1nV0kji8Uc	6	2	2007-12-23 06:00:00+00	\N	\N
6	7	Sambo Scissor Sweep	Recently covered on The Human Weapon, this is a fun takedown from the clinch.\n	See the video.	Sambo	292	3	5	15	\N	\N	vFbsrB_PPuE	5	3	2007-12-11 06:00:00+00	\N	\N
3	14	Twister attack when opponent locks up his hands	You have to get your opponent's arms apart to twister him. This technique helps you do that when they are clamping their\nhands together. \nHe is locking his palms together to prevent you from separating his arm to get it behind your neck for twister. You have\nthe lockdown of his left leg from behind and are behind him to his right side near his head.	1.  Hook his right arm under the elbow with your right arm. Pull.\n   2. If he doesn't break, change arms so that your left is hooking.\n   3. Palm-heel strike his grip with your right hand at the same time you pull.\n   4. Snap his grip open and assume a "left baseball bat position." This position has you holding his right wrist with\nyour right hand and his right forearm with your left arm. Your left elbow should be pushing in his ribs.\n   5. Pull his right arm behind your head with your right arm.\n   6. Reach your left arm behind his head\n   7. Clamp your hands together\n   8. If all of this fails, you can take his back.	Eddie Bravo	235	3	15	15	http://austinjiujitsu.com/ajj/pictures/Techniques/Twister%20setup.jpg	1	\N	6	3	\N	\N	\N
6	7	X Guard Sweep	You have him in X Guard with his right leg trapped in X	1.  Scoop under his left leg with your right arm. You are now underneath him.\n2. Lift with your X legs. This will unbalance him and he'll either regain his balance with his right hand on the mats\nor he'll just try to balance by driving his hips into you.\n3. If his palm touches the mat (he is posting), grab him with your left hand at his wrist and pull his posting arm\ntoward you. Press his scooped leg away from you to sweep.\n   4. Follow up with side control pass	\N	105	3	1	3	http://austinjiujitsu.com/ajj/pictures/Techniques/X%20guard%20sweep.jpg	1	CZrF9ZiAanY	5	3	2007-12-30 06:00:00+00	\N	\N
1	7	Single Leg Defense - Sprawl	\N	If he doesn't have your leg and is coming in, sprawl. This is done by jumping your legs back as far as you can and\ndriving the weight of your upper body down on his upper back, shoulders and back of his neck with your palms. From here\nyou might be able to take his back. In your dreams???	\N	92	3	5	7	http://austinjiujitsu.com/ajj/pictures/Techniques/sprawl.jpg	1	\N	8	1	\N	\N	\N
6	8	Back Roll Sweep	This sweep is done only when your opponent overcommits his weight inside the butterfly guard. The best way to set this\nup is to get a tight butterfly guard with double underhooks.	1. From butterfly guard, get double underhooks\n2. Scoot your butt close to him as you pull his weight on you\n3. Explosively roll back and kick your feet over your head	\N	287	3	1	4	http://austinjiujitsu.com/ajj/pictures/Techniques/Backroll%20sweep%20-%20over%20head.jpg	1	\N	8	3	\N	\N	\N
5	10	Mount	This is a description of a good mount position. Start straddling him, sitting on his stomach.	1. Keep your knees in his armpits and his arms off the floor. You want to prevent his arms from being used to escape. \n2. Press your hips forward into his arms to prevent his arms from escaping\n3. Keep both palms posted on the ground wide far away from his head\n4. Keep both feet flat against his hips, clamp.	\N	29	3	4	4	http://austinjiujitsu.com/ajj/pictures/ValeTudo/Demonstrating-the-mount.jpg	1	\N	6	1	\N	\N	\N
3	2	Reverse Armbar From Mount	You are mounted on your opponent.	1.  Your left knee traps his right bicep.\n   2. Press our head to the mat to the right side of his head\n   3. Trap his left arm by hugging it with both arms between your forearms and your shoulder. Make sure you clamp both\narms on top of each other to raise the fulcrum as high as possible off the mats. This makes it easier to finish the\ntechnique.\n   4. Hug while driving your shoulder to the mat.	\N	111	3	4	15	http://austinjiujitsu.com/ajj/pictures/ValeTudo/Daves-fav.jpg	1	\N	6	2	\N	\N	\N
5	5	Closed Guard	This describes proper closed guard technique.	1.  Hold his sleeves or his elbows or one sleeve and his collar. No gi: grab his triceps or one arm and behind the neck.\n   2. Keep your butt in between his legs. If he shifts over, move your hips with him.\n   3. Keep your feet crossed behind his back above his pelvis. Higher is generally better. \n   4. Keep your abs tight. If he lifts you, you should be able to keep with him using thigh and ab strength	\N	41	3	1	1	http://austinjiujitsu.com/ajj/pictures/Women/Closed-guard2.jpg	1	\N	8	1	\N	\N	\N
5	9	Head in Arm Control	This is a very common position and is very strong. It is different from the classic side control in that you are hugging\nhigh around his neck and armpit rather than grasping his legs. This guard puts lots of weight on his upper chest and\njaw. In this example, you are on his right side.	1.  Your left arm is under his head\n2. Your right arm is across his upper chest and under his left armpit and shoulder\n3. Your hands are clasped in Gable Grip underneath his left shoulder\n4. Knees are close to him, with the left knee at his right ear and your left knee pressing into his right hip.	\N	3	3	3	3	http://austinjiujitsu.com/ajj/pictures/Women/Side-Control.jpg	1	\N	6	1	\N	\N	\N
5	9	Classic Side Control	This describes the classic side control position. Assume you are on his right side)	1.  Your chest should be on his chest. You are perpendicular to him. \n2. Your knees should be pressed against him with your butt back on the floor resting on your feet (flat). Your left knee\nis against his right ear. Your right knee is pressed firmly against his hip. \n3. Grab his pants near his right hip with your right hand or scoop your right arm around his right hip. \n4. Wrap your other arm across their neck and around their left (far) shoulder \n5. Keep your weight pressed on him. If you "overcommit" -- putting your weight too far past him near his left side, he\ncan roll you.\n6. Don't be too rigid. As with most other positions in BJJ, you should be strong, tight, and responsive (react to\nchanges in position quickly).	\N	1	3	3	3	http://austinjiujitsu.com/ajj/pictures/Competitions/04-2004-Smack-Down-Houston/Dave-solidifies-side.jpg	1	\N	6	1	\N	\N	\N
5	11	Rear Mount	Known as Rear Mount or Rear hooks or Back Mount. Start with your opponent on all fours, face down.	1. Straddle him sitting on the base of his back\n2. Hook both feet under his hips. Usually, this is pretty easy if you press hard. Sometimes you have to get one hook,\nthen roll him over (you roll to your side) to get the other one. \n3. Hook both arms under his armpits. You will eventually want to take one arm out to attack the neck with chokes.\n4. Drive your hips in and pull his arms up to flatten him on the floor.	\N	39	3	12	12	http://austinjiujitsu.com/ajj/pictures/Competitions/10-2007-Dallas-BJJ-Invitational/Jenny-rear-mount2.jpg	1	\N	7	1	\N	\N	\N
1	8	100% Defense of Old School	Opponent is doing old school sweep, step 3.	1.  Reach your left arm under his right arm deep (to your elbow)\n   2. Gable grip behind their back with your right hand grabbing your left hand (I don't show this on the video, but it\nis a good idea)\n   3. Roll back and to the right, sweeping them.\n   4. You will land on top of them in a stocks position. You should be either in the mount or with your left leg\ntrapping their right leg\n   5. If you can neck crank, do so. Eddie often uses this position to set up taking the back rather than finish here\nwith crank. You do this by letting them reach their left arm under you to turn in to relieve pressure on his neck.\n   6. Drive your right knee against his hip as he turns and take his back.	Eddie Bravo	227	3	8	1	\N	0	Tve_W2LcH9k	2	3	2006-11-12 06:00:00+00	\N	\N
5	10	Mount from Side Control	You have him in side control, on his right side	1.  Your left arm is over his left shoulder, (gi: holding his belt on his left side).\n   2. Your right arm is blocking his hip on his right side\n   3. Drive your left hip against his right side (his right elbow will probably be here).\n   4. Grab over his left knee with your right hand and pull it toward you.\n   5. Step over with your right leg around his upper thigh/hip and immediately squeeze your legs together to immobilize\nhis legs/hips.\n   6. Drive your feet under his butt	\N	31	3	3	4	\N	\N	\N	6	1	\N	\N	\N
5	10	Knee-Slide transition to Mount from Side Control	You have him in right head in arm side control	   1.  Hug him tight and raise his left arm up by raising your right arm higher into his armpit\n   2. Press your right knee into his stomach and slide across to mount	\N	32	3	3	4	\N	\N	\N	6	1	\N	\N	\N
2	10	Elbow-Knee Escape from Mount	He is mounted	   1.  High mount: Drive your elbows down to keep his knees out of your armpits. Shimmy up as you do this.\n   2. Push both hands down to his knee on one side as you twist to your side.\n   3. Simultaneous with #2, pull your lower knee up tight (abdominal crunch) under his knee you are pushing\n   4. As soon as you get your knee out, quickly do 2, 3 on other side\n   5. Get guard	\N	33	3	6	1	\N	\N	\N	4	1	\N	\N	\N
2	10	Upa Mount Escape	He is mounted with his arms spread and strong over your head	   1.  Grab his elbow with both hands clamped and pull down to bend his elbow\n   2. Once bent pull his arm to your chest and trap tight\n   3. Trap his same-side ankle with your foot\n   4. Bridge hard and high over	\N	34	3	6	1	\N	\N	\N	4	1	\N	\N	\N
2	10	Push-Pull-Push Escape from Mount	He is mounted. The idea here is that he will not be able to adjust to the rapid succession of balance changes required to stay on you. It is a very explosive, aggressive move.	   1.  Grab hard with both hands low on his gi just above his hips, low on his abdomen\n   2. PUSH hard down - EXPLODE!\n   3. PULL hard up\n   4. PUSH hard out	\N	35	3	6	1	\N	\N	\N	4	3	\N	\N	\N
2	10	Rolling over the top Mount Escape - To Boston Crab	His mount is high. Knees are in your armpits. This is very important, because this technique finishes with you ankle-locking the opponent.	   1.  Push him even higher up by double shotgunning his shoulders at his armpits. Do this as many times as necessary to get his hips over your face.\n   2. Before you roll over him, note that his legs are in your armpits, as you roll you must keep track of at least one of these legs. The ankle of this leg is the finishing move.\n   3. Roll over his back and attempt to dig at least one foot into his armpits. This will help maintain control of him. Come up to on one knee and secure the ankle lock. Stabilize him from rolling by wrapping the non-locking hand around his knee on the locked leg. Lift and crank. Sit back slowly on his rear (he is on his stomach).	\N	36	3	6	8	\N	\N	\N	4	3	\N	\N	\N
3	17	Calf Crush from Inside Half Guard	He is holding you in a seated half guard. This involves him wrapping his leg very deep around your thigh. He is seated to your side. His other foot is positioned inside as if to sweep.	   1.  Straighten one leg out behind you as if sprawling. \n   2. As you drag your knee back in, catch his foot of his trapping leg with the lead edge of your knee.\n   3. As you move his foot forward, you are crushing his calf behind your leg	\N	62	3	8	8	\N	\N	\N	2	2	\N	\N	\N
1	7	Cross Face from Single Leg	\N	If he has your leg, cross face. Drive your forearm across his face under his chin. Drive hard and deep so that the crook of your elbow is mashing into his jaw. This makes it very difficult for him to keep hold of your leg. This is because you are forcing his head up. The magic of the cross face is that it changes the mechanics of your opponent's spine.	\N	91	3	5	5	\N	\N	\N	8	1	\N	\N	\N
3	1	Single leg defense to Omo Plata	He has your leg	   1. Turn away\n   2. Fall to the floor on all fours. You can't trap his leg. Instead you are further away and can trap his shoulder.\n   2. Kick over under his arm\n   3. Omo Plata	\N	94	3	5	8	\N	\N	\N	5	3	\N	\N	\N
1	7	Defense against Tackle	He is rushing into you for a takedown, coming low	   1.  Grab the back of his pants or his belt over his back\n   2. Sit back as he hits you and pull/sweep him over you.\n   3. He will fly over you as you roll back, so track with him to follow up with mount.	\N	96	3	5	4	\N	\N	\N	5	1	\N	\N	\N
6	8	Two hip Heel-hooking rear-drop	He is standing above you and you can feel his ankles near your rear:	   1.  Grab both of his heels with your hands\n   2. Put both feet on his hips\n   3. Push your feet as you hold his feet.\n   4. Follow him down. I like to imagine his feet are a tow rope that help me get up quickly as he falls.	\N	100	3	1	5	\N	\N	\N	5	1	\N	\N	\N
3	3	Armpit Americana	You have him in right side control. He is holding his arms in tight	   1.  Push your right arm wrist under his left wrist\n   2. Put your weight on in\n   3. Wrap your left hand around his left elbow\n   4. Spin to other side, trapping his elbow\n   5. Turn your body to get Americana	Vandry	129	3	3	15	http://austinjiujitsu.com/ajj/pictures/Techniques/Armpit-Americana	2	\N	6	2	\N	\N	\N
2	3	Americana Escape Free Arm trapped Rolling	He has you in Americana, your free arm is trapped under him	   1.  Pivot your body out by "walking" your feet up toward his head. This will rotate your body to be closer to parallel to him\n   2. Now your free arm is out from under him. Wrap it around his lat, hug, and roll.\n   3. Take side control	\N	137	3	6	3	\N	\N	\N	3	2	\N	\N	\N
3	18	Hip Crank	You have him in open guard. You are attacking his right leg.	   1.  Put your right foot on his right hip.\n   2. Put your left foot under his right thigh (sweeping position).\n   3. Right hand grabs his left triceps\n   4. Left hand grabs his right knee\n   5. From this position you can sweep him either way (depending on where his weight is) OR hip implosion\n   6. You can easily pull his right leg and press your right foot hard into his hip. It really hurts!	\N	143	3	1	1	\N	\N	\N	8	1	\N	\N	\N
3	1	One hand Gi Choke from Guard	You are holding him in guard	   1.  Reach across with your right hand and pull his right arm to your right\n   2. Grab deep in his left lapel with your left hand, 4 fingers inside\n   3. Turn your wrist so your pinky side is to his neck, pulling your left elbow down to your side (tight)\n   4. He may tap here.\n   5. Transition into a nice tight high guard by putting your left leg over his shoulder and closing guard.\n   6. He may tap (again) here.	\N	167	1	1	1	\N	\N	\N	8	2	\N	\N	\N
3	1	Rolling Gi Choke from Sprawl	he attempted a single leg and you sprawled on him. He has your left leg.	   1.  Reach your left hand under his neck between his shoulder and his neck (in other words, not under his armpit)\n   2. Grab his left gi at the lapel, but not too deep in the collar\n   3. Fast - "Dive" under his left side (to your right)\n   4. Drive your left arm straight and strong, between his left triceps and his neck, behind his head\n   5. Roll sideways, turning your hips all the way around. Maintain a tight hold of this gi. He will tap.\n\nVariation: Grabbing his far triceps. Same as steps 1 thru 3 below, then\n\n   4. Reach your right arm across under him and grab his right triceps and hug tight.\n   5. Roll over, "walk" to North/South\n   6. Drive your abs into the back of his head to complete the choke.	\N	175	1	7	15	\N	\N	\N	16	3	\N	\N	\N
1	1	Double Lapel Choke Defense	\N	   1.  Grab his closer arm at the crook of the elbow and pull hard into your chest. Hold tight.\n   2. Other hand grabs his further arm at the tricep\n   3. "Roll" his arm (like kimura) to force his elbow over his shoulder\n   4. As he rolls over, follow him and maintain hold of both arms\n   5. Finish with double arm lock	\N	182	1	16	16	\N	\N	\N	15	2	\N	\N	\N
3	4	Single leg defense to kneebar	He has your leg	1.  Turn away\n   2. Fall to the floor on all fours\n   3. Trap his leg with your caught foot\n   4. Reach deep under his knee\n   5. Kick your non-trapped leg over their shoulder\n   6. Kick other leg to knee bar	\N	93	3	5	15	\N	\N	\N	5	3	\N	\N	\N
6	8	Sweep - Through the legs Belt or Gi grab	you on your back in open guard, him standing.	   1.  Set up your legs in De La Riva position while you start this (left leg behind his right leg, right foot on his left thigh)\n   2. Grab his belt with your right hand from the front and feed it to your left hand grabbing around from the rear (between his legs).\n   3. Turn your left wrist toward your face like you are looking at your watch to tighten the hold on the belt. Your wrist should be tight against his rear/upper thigh.\n   4. Get behind him. Make sure your right shin is behind his right heel and your left calf is in front of his right shin. This traps his right leg\n   5. Reach up and grab his behind belt or his pants with your right hand.\n   6. Let go of his belt with your left hand and grab his sleeve\n   7. Pull him over backwards. Control him. Take side control.	\N	200	1	1	3	\N	\N	\N	8	2	\N	\N	\N
6	8	De La Riva Armpit Sweep	you are in his open guard. He is standing	   1.  Grab both sleeves and raise your hips on to his right knee.\n   2. Grab his right heel with your left hand.\n   3. Grab his right sleeve with your left hand\n   4. Drive your right foot into his right armpit\n   5. Throw him off balance by pushing your right foot far forward in front of him.	\N	202	1	1	1	\N	\N	\N	5	1	\N	\N	\N
1	17	Biggie Slicer Defense to Kneebar	If you are getting sliced, here's the easy escape.	1.  Push down on his knee with your free hand, grasping the back of this arm with your trapped hand (like a kimura grab)\n   2. Either crush his calf immediately or step over him to get the Boston crab-style ankle lock	David Thomas	196	3	8	15	\N	\N	y25UwbLPgFY	15	2	2007-12-28 06:00:00+00	\N	\N
1	1	Triangle Escape - The Rock	I call this The Rock because you make your fist like a rock and drive it into his leg. It hurts a lot, but don't expect this to work in a competition. It works in training only if your opponent has a low pain threshold.	   1.  Clasp your hands together around squeeze his quad near his knee. An alternative location to push is under his hip with your clasped hands pushing into his hip socket. This position is a little more difficult to get, but is very painful for him if you do get it.\n   2. You must keep your hands clasped to prevent him from getting armbar.\n   3. Push your weight down hard on his leg\n   4. Pull your clasped arms down as you apply the weight. This might break his legs open.	\N	190	3	8	8	\N	\N	\N	15	1	\N	\N	\N
6	8	Scooping Sweep	He is posting his left leg inside your guard	  1.  Hook your left instep under his right thigh\n  2. Straighten your right leg under his left leg\n  3. Kick your right knee up into his left thigh as you sink deeper under him. When you can scoop under his left thigh with your right arm, roll him to your left.	\N	206	3	1	1	\N	\N	\N	8	1	\N	\N	\N
6	8	Pittman Sweep	He is in your closed guard	   1.  Grab his right sleeve with your right hand.\n   2. Grab under your right arm to get his left sleeve\n   3. Put both feet on his hips to push away.\n   4. Pull his arms toward your head as you push away\n   5. Drive your left hook under his right thigh\n   6. Drive your right hook under his right armpit\n   7. Pulling his left arm, kick your right foot over to the right and sweep your left leg\n   8. He will fall over to your right. Pull him into armbar	Pittman	207	3	1	16	\N	\N	\N	8	2	2006-11-13 06:00:00+00	\N	\N
6	8	Palm Sweep	You are in balled up in hook sweep guard controlling his left leg with your right instep and he is beginning to pass your guard to your left. You do not have his right leg.	   1.  As he passes to your left and plants his right knee on your left, trap it with your left palm\n   2. Press down on his knee as you hook sweep with your right leg. This rotates his hips "out from under him." If this is done correctly, he will quickly flop over.\n   3. Quickly drive your right shin into his right hip to prevent him putting you in guard. Drive your shin forward more and get side control.	Vandry	209	3	1	3	\N	\N	\N	8	2	\N	\N	\N
6	8	Liborio Sweep	This sweep is named after Ricardo Liborio, a Brazilian Top Team leader.\n\nSetup: you are on the ground holding him in the open guard.	   1.  Grab his right collar with your right hand\n   2. Put your right foot instep into his left armpit\n   3. Your left foot can go on his right hip or on his right knee/shin, depending on how his leg is.\n   4. Pull him to the left and sweep him over.	Ricardo Liborio	210	1	1	1	\N	\N	\N	8	2	2006-11-12 06:00:00+00	\N	\N
6	8	Half-Guard Sweep - Change Custody	In this escape, you switch which of your legs is trapping your opponent. For example, if you are holding their right leg, your right leg is usually across the back of their leg, with your left leg holding the figure 4. When you "change custody," you will straighten your right leg and put your left leg over to trap the opponent's leg.	   1.  As with many half guard positions, I recommend blocking the cross face and hugging under their upper arm.\n   2. Change custody, as described above.\n   3. Pull your right leg up to a hook sweep position\n   4. Raise your left hugging arm to take the post away\n   5. Sweep	Richard Power	212	3	2	16	\N	\N	\N	8	2	\N	\N	\N
6	8	Half Guard - One leg scissor sweep	he is in your half guard. You have just the bottom of his leg trapped with your legs.	   1.  Lower outside leg goes low on his ankle, upper inside leg goes to inside of his knee\n   2. Sweep. Focus on pushing his knee over. \n   3. Trap your upper leg inside his knee\n   4. He should be on his stomach. Try to get the calf crush or knee crank	\N	214	3	2	1	\N	\N	\N	8	2	\N	\N	\N
6	8	Half Guard Momentum Sweep	He is in your half-guard, lying on you.	   1.  Trap his posting arm\n   2. With other hand, grab as low as you can on his pant leg\n   3. Take your free leg and raise it up. Swing it to mat to make momentum to roll him over.	\N	213	3	2	1	\N	\N	\N	8	2	\N	\N	\N
2	5	Lock-down Escape	You are being held in lock-down.	   1.  Turn toward your feet\n   2. Pop your trapped instep free with your other foot.\n\nAnother escape that works better for me: point your trapped foot away to the side. It feels awkward, but it's very hard for him to catch your foot when it is out there.	Eddie Bravo	225	3	8	8	\N	\N	\N	2	2	\N	\N	\N
2	5	Staple Gun Guard Pass	You are inside his open guard. This is a guard pass similar to the one I call the pancake pass.	   1.  Push his right foot in between your legs to give him a half-butterfly guard\n   2. Reach under his left thigh with your right hand and clamp your hands together\n   3. Drive your elbow into his right thigh and flatten out on it\n   4. Bring your right shin across his right calf. Pressure!\n   5. Wing out to pass	Eddie Bravo	228	3	8	3	\N	\N	\N	1	2	\N	\N	\N
3	1	Americana to Triangle from Mount	you have the mount and go for Americana on their right arm. They block by reaching their left arm through and grabbing it. You are going to switch attacks to his left arm.	   1.  Grab his left arm with your right as he reaches through\n   2. Pull your left foot under his right shoulder as you turn to your left. This will allow you to throw your right leg under his neck\n   3. Scoop his leg with your left arm as you continue to turn to the left\n   4. Drive your left foot past his right shoulder next to his neck and sit back into triangle	\N	248	3	4	15	\N	\N	\N	6	2	\N	\N	\N
5	5	The Jaws of Life - Establishing double underhooks	You have your right arm trapped above his shoulder. You will need to get it under his arm.	This move helps you get double underhooks when your opponent is holding you "head in arm" where you have one underhook, but the other arm is trapped above his shoulder.   \n   1.  Press diagonally up and away to the left on his forehead with your right arm. This puts lots of pressure on his neck.\n   2. Assist pressing up with your left arm.\n   3. Wedge your left forearm under his armpit and bench press up. This will create enough space that you should be able to sneak your right arm under his armpit.	Eddie Bravo	251	3	1	1	\N	\N	\N	8	2	\N	\N	\N
5	5	The Zombie - getting underhooks	This is the move used when you gave someone in your guard and you want to get their arm trapped. The name comes from the look of your hand as it comes up though their arm, like a zombie rising from the grave. :)	   1.  Your opponent has their hands on your chest inside your guard. The goal is to get their hand hugged to you, palm on the mats.\n   2. Drive your hand up through the crook of his elbow.\n   3. Once through, bring your arm to the outside and drop your elbow to the mats, hugging his arm. It is now trapped.	Eddie Bravo	252	3	1	1	\N	\N	\N	8	1	\N	\N	\N
4	19	Half Back Roll - Rocking Chair Drill	This is a drill useful in developing the curve in the back required to roll easily. I tell my students to image they are\nwrapped around a large beach ball. You don't complete the roll, you just rock back and forth on your curved back,\nswitching which leg is out after each repetition.	1.  From a seated position you have your left leg extended in front of you and your right leg bent 90 degrees flat on\nits side\n   2. Curve your back (around the imaginary beachball)\n   3. Tuck your chin to your chest and lean your head to the right\n   4. Initiate the roll by leaning back and pulling your left leg up slightly\n   5. Rock back until your shoulder blades hit the mat (the apex of the roll)\n   6. Before you drop down to the original position, switch which leg is extended. When you land you should have the\nlegs switched.\n   7. Continue this alternating legs, attempting to be as curved as possible.	\N	254	3	11	11	\N	\N	\N	16	1	\N	\N	\N
4	19	Rear ukemi sitout or Rear Roll in Place	This will make you dizzy!	You execute rear ukemi but slide forward each time you land in order to prevent you from moving backwards as you roll. This requires some practice, but it is good for tight quarters drills and also is pretty fun when you get the hang of it.	\N	256	3	11	11	\N	\N	\N	16	1	\N	\N	\N
4	19	Side to side breakfall drill - Fish Flop	This is a fun drill in that it really trains you to open up your body to accept the breakfall, alternating sides. It is a good ab workout also.	   1.  Start on your back and throw your legs high above you so your weight is momentarily 100% on your shoulders and neck. Your legs are mostly together high in the air.\n   2. As gravity brings your legs down, turn to your side and position your body for a breakfall.\n   3. Do the same thing again coming down on the opposite time.\n   4. Repeat, attempting to maximize your "hang time" and really focus on the correctness of your technique in each fall.	David Thomas	259	3	6	6	\N	\N	\N	16	2	\N	\N	\N
4	19	Medicine ball toss - sit up drill	This is a crazy ab workout. Start about 5 to 10 feet away from your opponent facing each other in a seated position.	1. Toss the ball in a straight and fast "line drive" about 12 inches over your opponents head\n2. He will catch it and sit back flat against the floor. \n3. He sits up and throws the ball in a similar manner above your head. The important aspect of this is the timing of the throw. Don???t sit up, then throw. Thow it as you sit up, forcing your abs to do most of the throwing. Don't lob the ball. Drill it!	Colin and John	266	3	11	11	\N	\N	\N	11	1	\N	\N	\N
4	13	Shrimping Drill	This is one of the most common drills in BJJ. It is to improve the reflexes when an opponent is passing your guard or holding you in side control.	   1.  Start on your back with both feet flat and knees pointing to the ceiling. Your hands are palm forward in front of your shoulders. Imagine your opponent coming around your legs to pass your guard.\n   2. Plant your right foot firmly, all of the motion from this drill comes from you pressing off this foot.\n   3. You must turn to your left quickly to face your opponent as he comes around to the left. Accomplish by pushing off your right foot, driving your rear end out to your right simultaneously shooting both palms to your left\n   4. For just a moment, you are folded in half on your left side as if you are touching your toes.\n   5. Quickly draw your knee to your chest and "square up" by pulling your butt back under you\n   6. Repeat on opposite side.	\N	267	3	6	16	\N	\N	\N	16	1	\N	\N	\N
2	8	Half guard sweep - Stiff body with shin in his belly	You are on your back holding opponent in half guard with his right leg in between yours.	1. Grab his pants outside his left knee with your right hand\n2. Grab his left sleeve at the wrist with your left hand\n3. Press your left knee into his belly as you stiffen your torso and bridge right on your right side. You must be very stiff with your core muscles tight here. \nIf he doesn???t press forward, you should cause him to fall sideways to your right.	Travis Tooke	268	1	2	3	\N	\N	\N	8	2	\N	\N	\N
2	8	Defending a half-guard pass to an overhead sweep	He is passing your half guard to your right. Keep your half guard clamped as long as possible. If he explodes out, you're toast. Make sure you keep the leg as long as possible.	1. Get your right elbow under him and try to get your head posted into his chest in between you. This prevents him from improving his position much during the move. \n2. "Stack yourself" by bringing your legs over your head (again, holding his leg in the middle)\n3. Roll back over your left shoulder.	Travis Tooke	270	1	2	3	\N	\N	\N	8	3	\N	\N	\N
2	8	Knee ride defense to sweep	You are defending a knee ride, starting with a good grip on his foot in between your legs. It is critical that you hold his foot in the middle until you are ready to roll.	1. \tStretch his trapped leg out by pulling your clamped knees down and pulling your feet toward your butt. Think ???gluteus??? contraction!\n2. \n3. Roll to your left	Travis Tooke	271	1	2	3	\N	\N	\N	8	3	\N	\N	\N
2	8	Knee ride defense to X Guard	He is passing your half guard with a knee ride. His right knee is trapped above your torso, not on the floor.	1. \tPush both hands against his knee to prevent him from moving forward. Clamp your knees tight. If you clamp his knee correctly, you should be able to move his trapped knee left and right to control his balance a bit. \n2. \tPress your knees to the left, causing him to step forward enough with his left leg.\n3. \tScoop under his left leg with your right arm and get the X- Guard	Travis Tooke	272	1	2	1	\N	\N	\N	5	3	\N	\N	\N
2	8	Carpet Sweep #2	He is standing. Your are sitting up in front of him	1. \tHook your left instep behind his right foot and grab low on his right ankle with your left hand. Make sure your left hand is on the outside of your left knee.\n2. \tMake sure your right foot is between his legs. You will be reaping with it in a second. \n3. \tReach your right arm through his leg behind his left knee and get ready to pivot on your back to your right.\n4. \tAll at once: dive under him to your right on your back, pop his right ankle to the left with your left hand (keep hold of it), and sweep your right foot to the left\n5. \tHe will either fall down or loose enough balance to allow you to pull X guard	Travis Tooke	273	3	1	1	\N	\N	\N	5	2	\N	\N	\N
2	8	Reverse Kesa side control ??? Rolling away sweep	He is holding you in reverse kesa side control, facing your legs. He is on your right side.	1.\tWork your elbows down, forcing his weight low toward your hips.\n2.\tPress down against his left elbow with your right hand, keeping constant pressure downward toward your feet.\n3.\tWork your way up on to your left elbow, then hand, attempting to sit up.\n4.\tOnce you get him pushed down enough and you are sitting up enough, you can roll him over your.	Travis Tooke	275	3	6	3	\N	\N	\N	14	2	\N	\N	\N
2	8	Knee on belly escape ??? Driving your knee under his leg to sweep	He is holding you down with right knee on belly	1.\tPress your arms into his far knee and on his far hip so you can get on your right side\n2.\tDrive your left knee up underneath his butt and under his knee. \n3.\tOnce your knee is under there, you should be able to roll him away for a sweep, maintaining hold of his outer knee through the roll.	Travis Tooke	276	1	6	3	\N	\N	\N	3	3	\N	\N	\N
2	9	Side control escape - Carrying the logs	He is holding you in side control - either head in arm or traditional side control (it doesn't matter where his lower\narm is). He is on your right side.	1. Reach both of your arms around his right side (out the back door) and get a super-tight grip on his gi in the center\nof his back. Both hands stay tight!\n2. Jiggle out the back door. \n3. Once you get far enough out, turn out toward his head (your feet go toward his head, not back toward guard). Keep\npressure on his back to maintain control.	Travis Tooke	274	1	6	8	\N	\N	\N	3	3	\N	\N	\N
5	11	Anaconda Rear Mount or Figure 4 Rear Mount	This is a figure 4 rear mount across his midsection. You may be able to tap him with this by pulling your knees in and pressing your hips forward. I think Eddie Bravo named this Anaconda, even though there are chokes with the same name.	1. From the rear mount, roll to your back and then to your left side\n2. Put your left leg across his belly\n3. Figure 4 your left foot behind your right knee	\N	242	3	12	12	http://austinjiujitsu.com/ajj/pictures/Techniques/Anaconda-rear-choke.jpg	1	\N	7	1	\N	\N	\N
3	1	Brabo Choke with Gi	From his back with you on his left side	1.  With your left hand, pull his gi lapel out from the left side and grab the tail of it at the lower tip\n   2. Pull this across his back with your left hand, feeding it to your right hand which is reaching under his left\narmpit across his chest to the right side of his neck\n   3. Grab the tip of his gi and hold tight with your right hand\n   4. Your left hand will grab the part of this gi tail that is across the back of his neck. Stick the 4 fingers of your\nhand between the tail of his gi and his back\n   5. Roll to your left pulling your hands together like a regular gi choke.	Travis Tooke	176	1	7	15	\N	\N	6Jz365wSQfg	9	3	2008-01-09 06:00:00+00	\N	\N
3	14	Twister from Staple Gun Pass	Staple Gun Pass	1.  As you pass him, he turns in to his knees and gets on all fours.\n   2. Do Twister from All Fours	Eddie Bravo	241	3	8	15	http://austinjiujitsu.com/ajj/pictures/Techniques/Twister-Bravo.jpg	1	\N	1	3	\N	\N	\N
5	5	How to Kneel inside a Closed Guard	A key aspect of the closed guard is your ability to sit with stability and "base." This position is so fundamental that\nI call it "Position 1."	1.  You are on your knees, sitting on your heels. Your knees are open 90 degrees\n   2. You are grabbing his pants at his hips\n   3. Your elbows are in against your ribs and his thighs\n   4. Your back is straight with a slight lean forward\n   5. Your chin is up, not looking down at him	\N	42	3	8	8	http://austinjiujitsu.com/ajj/pictures/Techniques/Inside-Guard-Position-1.jpg	1	\N	1	1	\N	\N	\N
6	8	Hook Sweep	he is posting his left arm inside your guard	1.  Hook your left instep under his right thigh\n  2. Grab his left arm by wrapping your right armpit around his arm.  Pull in to break the post.\n  3. Sweep your left leg over. As you go over, you will rotate your hips to the right. This will allow you to turn your\nright leg under you to push off the floor with your right foot. This is a crucial step because it adds significantly to\nthe power and range of motion of your sweep.	\N	205	3	1	1	http://austinjiujitsu.com/ajj/pictures/Techniques/Hook%20sweep.jpg	1	\N	8	1	\N	\N	\N
6	8	Half guard sweep - rolling over your head	If you started doing the Half Guard Sweep - Stiff Body with Shin in his Belly, and he presses forward to prevent you\nfrom throwing him sideways, this sets up a great overhead sweep. You need to throw him over your head. Since he is\npressing his weight into you, that's a good start. You are starting where the other technique left off, before the throw.	1. Make a large circular motion from the right  to the side, over your head, and to the left, continuously pulling his\nweight over your to maintain control. \n2. As he starts to come over you, keep hold of his sleeve and pants and execute a back roll over your left shoulder\n3. You should end up in a side control, or in a very easily escaped half guard.	Travis Tooke	269	1	2	3	\N	0	\N	8	3	\N	\N	\N
5	10	Grapevine Mount	You are on top in mount.	1. Drive your feet around the outside of his knees and around his feet, hooking on his ankles with your insteps\n2. Press your hips forward into him. Arch your back. This creates a lot of pressure. \n3. As with regular mount, keep your arms out posted	\N	30	3	4	4	http://austinjiujitsu.com/ajj/pictures/Techniques/Grapevine%20mount.jpg	1	\N	6	1	\N	\N	\N
3	17	Shin Crush Guard Pass	You are passing his open guard from standing or your knees. \nThis is a seriously painful move.	1. Grab his right ankle and step your right shin over his calf\n2. Put your knee on the mat and pull up on his ankle	William Vandry	291	3	8	15	http://austinjiujitsu.com/ajj/pictures/	0	\N	1	1	\N	\N	\N
6	7	Cross behind the knees (a.k.a Teetering the Giant or Connecticut-New Zealand Sweep)	He is standing, you have your guard closed around his hips OR\nYou have an open guard	1. Strong - wrap your legs around his thighs just above the knees. His legs MUST be pulled together, so clamp hard.\n   2. Sit up quickly (use your elbows) and do a double-leg takedown. If you raise your hips before you sit up, it could\ngive you a bit more control and momentum. \n   3. Keep pressure with your shoulder on his thigh to allow for a strong takedown and guard pass.	David Thomas	107	3	1	3	http://austinjiujitsu.com/ajj/pictures/Competitions/04-2004-Smack-Down-Houston/teetering-double-leg	8	quVc8zso1_M	5	3	2008-01-09 06:00:00+00	\N	\N
6	7	2 Hip Throw (Tomoe Nage)	You are down on your back with your feet up near opponents hips. He is facing you. You are holding one of his\nwrists/sleeves OR his lapel (something on his top half).	1.  If your opponent is dumb enough to move his weight forward so you can get under his center of gravity, you can\nlift him easily off the floor. You need to have hold of his arm/lapel to control him thru the fall.\n   2. As you kick your legs back over your head, PULL his top half down.\n   3. Follow thru by doing a back roll to the mount/side.	\N	106	3	5	3	\N	0	Rrp6k68lWs8	6	1	2008-01-09 06:00:00+00	\N	\N
4	19	Back Roll	A back roll will roll you all the way over your back for a full revolution, ending where you started. You roll over your\nshoulders. Your head doesn't touch the floor!	1.  You start on with one knee up, just like Kneeling front ukemi (right knee on ground, left knee up)\n   2. Fold your right foot toward your left knee to get it out of the way, since your rear end is about to sit back.\n   3. Sit back, right rear first. You are now in the same position as you start in a half rear ukemi.\n   4. Same as half rear ukemi steps 1..5, but continue over the left shoulder. The difference is you need to put more\nenergy into the roll to make it all the way over. Typical mistakes made here is the student hitting their head on the\nmat, draining all the energy from the roll (so they don't go over). This is remedied by making sure you lean your head\nas far to your right shoulder as possible. If you roll over your left shoulder, your head should be out of the way.\n   5. Attempt to land in exactly the same position you started in: on the same knee.	\N	255	3	5	5	\N	\N	\N	16	1	\N	\N	\N
4	19	Front Roll	A roll is called ukemi in the Japanese root systems from which BJJ is derived. Ukemi is the Japanese term used to\ndescribe technique for falling safely. Its literal translation means "receiving self." An uke, in traditional martial\narts context, is the person who receives technique, or toward whom an attack is initiated. Mi means body or self.\n\nA key aspect of nearly every ukemi technique is to keep your head from striking the ground. This is usually done by\nkeeping your chin to your chest and tilting your head to one side (depending on the roll).	1.  Start from kneeling, with your right knee on the ground and your left foot on the mat with your left knee in\nfront of you. Your left arm is slightly outstretched in front of your chest near your left knee with your left elbow\nfacing away from you. Relax!\n   2. Tuck your chin to your chest and tilt your head to the right. You will be rolling over your left shoulder.\n   3. Roll forward. The first part of your body that hits the mats is behind your left shoulder. This is difficult for\nmost beginners because they have to avoid their head and the front of their shoulders from hitting the ground. This\nrequires a bit of a leap of faith for beginners. For the faint hearted, it is sometimes necessary to have them manually\nplace their shoulder on the mat to get past this initial, dynamic move.\n   4. Roll diagonally from your left shoulder blade to your right buttock.\n   5. Keep your right leg folded below you the entire time so your right leg does not unfold and stop your roll. Your\nleft leg can stay partially open (90 degrees is fine) so your left heel lands on the mat as you complete your ukemi.\n   6. You should end up in the same position you started in. If not, fix your position before you start over.	\N	253	3	8	8	\N	\N	\N	16	1	\N	\N	\N
4	19	Rear breakfall from squatting	\N	1.  Squat with both arms loosely to your sides with your palms facing backwards\n   2. Fall backwards landing first on your butt, then rolling up toward your shoulders with a curved back. As with rear\nukemi, make sure you have a good "rocking chair back."\n   3. Slap the mats simultaneously with both hands and recoil them immediately. I tell my students to imaging a spring\nrelease switch under their shoulder blades. Just as their shoulderblades hit the mats, the switch triggers the arms to slap.	\N	257	3	1	1	\N	0	\N	1	1	\N	\N	\N
4	19	Front breakfall from knees	Just like front ukemi except you do not stay in a ball, you open up and slap the mats as you come over. This requires\nsome very specific technique to get it right. Most students are pretty sloppy with this unless their coach really works\nthem on it. As you roll forward (your legs are above you), the technique begins???	1.  The "trailing arm and leg" will be slapping the mats. This means if you lead your roll with your left hand and\nfoot, your right hand will be slapping. So extend your right hand and foot straight parallel with your body as you roll\nover.\n   2. Orient your body as your body comes over to land as straight as possible on your right side. Do not land flat on\nyour back!\n   3. When you land, before you get up, check your positioning and correct it before you get up. This is the only way\nyou can train your brain to get it right. Lots of reps and lots of corrections will make this fall perfect!\n\nEssential points on ending position for breakfall:\n\n   1. You are on your side\n   2. Your body is straight, not bent at the hips\n   3. Your right leg is straight out, parallel with your body with the right foot pulled toward your face. This has the\neffect of pulling your ankle off the ground somewhat reducing slamming on your toes and ankle when your leg hits the ground.\n   4. Your right arm is about 30 degrees off parallel away from your side, palm down. When you slap down, your legs and\narm should slap simultaneously. Slap with the whole arm, not just the hand.\n   5. The fall should make a "whoomp!" sound, meaning your whole body hits at once, with little or no bounce.	\N	258	3	8	6	\N	0	\N	16	1	\N	\N	\N
3	2	Armbar - Completing it if he stacks you	You are on your back and he is up. You still have the arm bar, but his weight is preventing you from \ncompleting.	1.  Squeeze his midsection with your lower leg\n   2. Straighten your upper leg across his face. \n   3. He will lie back down.	\N	116	3	1	15	\N	0	\N	8	2	\N	\N	\N
3	3	Kimura from Guard	You have him in your guard. His right hand is on the ground near your left hip	1.  Grab his right wrist with your left hand. I call this the "milkshake grip" so my kids understand how the grab\nworks. You grab his wrist just like you pick up a milkshake.\n   2. Open your guard and plant your right foot for power\n   3. Sit up quickly pressing your hips against him and reaching your right arm over his right shoulder/triceps.\n   4. Grab your left wrist with your right hand in figure 4 position.\n   5. Sit back and press his wrist behind his back.	\N	126	3	1	1	\N	0	HYNoQ6Ms-rE	8	1	2008-01-09 06:00:00+00	\N	\N
1	3	Kimura Escape	He has you in Kimura from Mount or Side.\nNote: this escape will not work against a very strong opponent, especially with the gi on. As with most escapes, it\nworks best if you escape early in the technique. The deeper he has the submission, the less likely you will get out!	1.  Grab inside the crook of your right knee with your right hand (the hand of the trapped arm)\n   2. With your left hand, grab the crook of his left forearm/elbow. Pull down into you.\n   3. Bridge up to get your body as close to your trapped arm as possible.\n   4. Quickly drop down, turn to the right, and pull your trapped elbow down. This should free you. It may take 2 or 3\ntries.\n\nNote: this is a defense, not an escape since you are still flat on your back in danger.	\N	135	2	6	6	\N	0	\N	3	2	\N	\N	\N
3	2	Armbar - Kicking the Far Bicep	As you lie back, you notice he is grabbing.	1.  With your left arm, grab his left arm tight around the base of his tricep\n   2. You can now move your right arm into this position as well. If you lock his left arm out, you will notice that you\nnow have both of his arms.\n   3. You can lean back to get the armbar or lock out his left arm where you are sitting	\N	114	3	4	15	\N	0	siZVjQMmmg0	6	1	2007-12-11 06:00:00+00	\N	\N
1	16	Ankle Lock Defense - The Boot	He is ankle locking you	I call this "the boot" because it helps me remember to pull my toes back and imagine driving my heel deep into a boot.\nBy pulling back on his shoulder with your toes he can't get as deep and far back as he needs to tap you.	\N	149	3	1	1	\N	0	\N	11	1	2007-11-22 06:00:00+00	\N	\N
3	15	Half Guard to Ankle Lock	you are holding him in half guard. You are trapping his left leg. Your right arm is around his back, elbow high. You\nwill be attacking his left ankle.	1.  Your left calf is crossing over the back of his knee. (your inside leg). The instep is hooked behind your right\ncalf like an incomplete figure 4.\n   2. Your right instep is hooked under his heel\n   3. Slide your legs down gradually until you can apply pressure on his ankle.\nYou can sweep from here by "V-hooking" your left palm under his right knee. Pick up your legs to pull his trapped left\nleg up to his rear and throw him over to the right.	\N	215	3	2	15	\N	0	\N	8	2	\N	\N	\N
3	3	Near-arm Americana	This is a tricky technique since finding your opponent's arm and wrist in the right place is rare.\nYou are holding your opponent in right side control. His right arm is bend under your chest with his right hand near\nyour right armpit.	1. Reach your right hand under his right arm to grab his wrist\n2. Pull it down toward his feet.\nKeep lots of weight on him!		284	3	3	15	http://austinjiujitsu.com/ajj/pictures/Techniques/Near-arm-Americana.jpg	1	\N	6	2	\N	\N	\N
3	17	Bicep Crush (Elbow Crank) from Arm Bar Setup	You are executing an arm bar from either guard or mount. If your opponent is resisting the hyperextension, you can\nswitch to a fast bicep crush from here.	1. Your right forearm (not your wrist) is deep inside his elbow with the narrow edge pressing into his elbow joint.\n2. Grab your left forearm with your right palm to strengthen your grip\n3. Grab his wrist with your left palm\n4. Press his wrist away from you as you pull your right arm (and his elbow) into your chest. Extend back slightly with\nyour lower back muscles.\nBe careful - this can injure your opponent quickly. Watch for the tap.		281	3	15	15	http://austinjiujitsu.com/ajj/pictures/Techniques/Dave-elbow-crank.jpg	1	\N	6	2	\N	\N	\N
5	5	Lockdown Half Guard	This position is very tight and is a good setup to get to other nice moves. You can also submit a weaker opponent with\nthe calf crushing potential of this move. \nYou are on your back holding him in half guard with his right leg trapped.	1. Your left leg steps over his right leg so your right calf is behind his knee\n2. Fish your left instep under your right knee\n3. Put your right instep around his right instep\n4. Extend both legs to tighten.\n\nALWAYS use underhooks!	Eddie Bravo	283	3	2	2	http://austinjiujitsu.com/ajj/pictures/Techniques/Lock-down-with-underhooks.jpg	1	\N	8	1	\N	\N	\N
5	9	Knee on Biceps Side Control	This is a great basic position which disables your opponent's inside arm while you hold him in side. It is a good\n"cooking hold," meaning it is more likely to tire your opponent than a standard side control. This is because when you\nkeep your knee on his arm he is far more likely to struggle than rest. As he struggles, his arm becomes quite weakened,\nallowing you to switch sides and attack that arm. Very reliable "surfing" position also!\nYou are holding him in right side control.	1. From head in arm position, drive your left knee up into his right armpit\n2. Pick up your left knee and drive it over his biceps\n3. Rest your shin on his arm. Your knee should be as far to the other side of his arm as possible.\n		289	3	3	3	http://austinjiujitsu.com/ajj/pictures/Techniques/Knee%20on%20biceps%20Side%20Control.jpg	1	\N	6	2	\N	\N	\N
3	2	Armbar from S Mount	You have mounted your opponent with S Mount. You are attacking their right arm.\nFrom a tight S-Mount position, their arms are very exposed, so you can really attack with a number of different\ntechniques. See the video.	1. Their right arm will be up against your left thigh. Either trap it behind our left arm and press back with your\ntriceps or grip his wrist and press back.		297	3	4	15	http://austinjiujitsu.com/ajj/pictures/	0	d1juHOQRy-g	6	3	2007-12-11 06:00:00+00	\N	\N
5	10	S Mount	This mount position is similar to the Knee Up Mount, but is harder to escape and creates much more pressure on your\nopponent. Assume you are in a regular mount position. Follow the instructions below to convert this to an S Mount.	1.  Start from a high mount. Knees way up into their armpits.\n   2. Put your right heel under their left shoulder. Your right knee is pointing toward their feet. Your right leg is\nflat on its side. Your heel is tight under their triceps/shoulder.\n   3. Drive your left knee hard into their right shoulder. Your left leg is pointing away from their head with your left\nfoot flat on its inside side.\n   4. Pull your legs in tight to create pressure on their shoulders.\n   5. Their arms are crowded in front of their face and very susceptible to attack.\n   6. It is very easy to lean right and swing your left leg over their face for armbar. Also, wristlocks and kimura are\neasy from here.	\N	198	3	4	4	\N	\N	\N	6	2	2007-12-11 06:00:00+00	\N	\N
3	2	Armbar - Attacking the Thumb	he is grabbing his hands with his fingers making hooks for a tight grip.	1.  Find a thumb and peel it back hard. As soon as it lets go,\n   2. Slap the hands apart and lie back before he can grab again	\N	113	3	1	15	\N	0	siZVjQMmmg0	4	1	2007-12-11 06:00:00+00	\N	\N
3	2	Armbar from Guard	You have him in guard. You are attacking his right arm.	1. Clamp his right arm tightly to your chest with both hands. It is best to have his wrist with one hand and hold above\nhis elbow with the other. \n2. Put your left foot on his right hip.\n3. Pivot out 60 degrees to your right by pressing on his left hip. At the same time, clamp your right leg over his back\njust behind his armpit. You should "steer him" aside with your legs.\n4. Depending on your flexibility and just how far you just pivoted, you should be able to put your left leg over his\nface with no problem. If it feels awkward, pivot out further. You can press off his face with your hand to help pivot. \n5. Clamp your knees together and bridge by raising your hips up. Tap him	\N	121	3	1	1	http://austinjiujitsu.com/ajj/pictures/Competitions/12-2005-Carlson%20Gracie%20Open-DrippingSprings/Zachary%20gets%20the%20armbar.jpg	1	Syt0AWb5GXw	8	1	2007-12-11 06:00:00+00	\N	\N
3	2	Armbar from Side Control (far side)	You are in his right side control with head in arm position.	1. You will be attacking his left arm. Your right arm is deep under his left armpit in head in arm control, so \nkeep track of that arm as you stabilize.\n2. Hug his left arm tight as you step your left foot over his face flat on the floor near his left ear. Keep \nyour weight on him.\n3. Hoist him up on his right side by sitting up on your knee. Your right knee is on the mat on his right \nside and your left foot is still near his head. \n4. Quickly rotate 180 degrees and sit next to his left shoulder hugging his arm. \n5. Tap him	\N	119	3	3	15	\N	\N	8wayMfTzdiY	6	1	2007-12-11 06:00:00+00	\N	\N
3	14	Stocks	You are sprawling on his back	1.  Reach one arm from front under his shoulder\n   2. Reach the other arm from the side/back under his armpit\n   3. Up on one foot (planting to get the base to push him over).\n   4. Push him over sideways, keeping close to prevent his head from escaping\n   5. Land on his side and turn away from him to increase pressure	\N	193	3	7	15	http://austinjiujitsu.com/ajj/pictures/Techniques/Stocks	3	RyGKjHqTSGE	9	2	\N	\N	\N
6	8	Ownage Sweep	Any time you have your opponent in a side control -- or even a near-side control, even a sloppy side control, you can\nget this sweep. It is useful in flattening out and mentally defeating your opponent from the side. In this example, you\nare on or near your opponent's right side control.	1. Underhooking you right arm under his left armpit is essential\n2. Keep your weight high, even over his head, by leaning left and hugging around his neck with your left arm\n3. Put your right instep "hook" under his left thigh.\n4. As you hug and lean left, flip the hook sweep to flatten him out.	David Thomas	298	3	3	3	\N	\N	yREzyEOQcps	6	3	\N	\N	\N
3	1	Rear Naked Choke - Mata de Leo	Mata de Leo means "Kill the Lion" in Portuguese. You have rear mount. Make sure you are not too high on him. If you are\ntoo high, you wont be able to grab deep enough or squeeze with enough strength to choke.	1.  Right arm drives under his chin with the crook of your elbow deep under chin. \n2. Grab left biceps with your palm and bend your left arm and either put your left hand behind your head, his head, or\nnext to your left ear. \n3. Squeeze by flexing your lats and biceps. It is a mistake to think you need to pull your arms up.	\N	160	3	12	15	http://austinjiujitsu.com/ajj/pictures/Techniques/Rear-choke.jpg	1	RSGTomE5TV8	7	1	\N	\N	\N
5	11	Taking the back from incomplete twister lockdown	When you are working the twister lockdown, your opponent is vulnerable to getting rear mounted. Granted, any fool that\nrolls away from you while in this position is asking for a rear mount.	1. If he ever turns away from you, your lockdown will directly convert into a rear mount hook. The other hook is just a\nmatter of timing it as he rolls away.		299	3	14	12	\N	\N	BBsFjk5lHUQ	6	2	\N	78	6
2	5	Two Leg Stacking Guard Pass	In his open guard	Just like the One Leg Stacking Pass, but you scoop under both legs deep and high him around his upper thighs/hips. Pick\na side to go to. You are basically hoisting the lower half of his body around in this move.	\N	53	3	8	3	\N	\N	qyz9_PtiDcI	1	1	2008-01-09 06:00:00+00	\N	\N
3	15	Fast Achilles Ankle Lock	You are in his open guard.	The best way to describe this it is a guillotine choke to the Achilles heel. Your arms are supporting each other like a\nguillotine or mata de leo (rear naked choke). His foot is trapped between this choke hold and your chest, so the instep\nof his foot is on your chest. Now, choke it. Watch him tap!	David Thomas	147	3	8	15	\N	\N	\N	1	3	\N	90	1
3	16	Toe hold from North and South	You are holding him in North and South. This is a bit of a risky move because you are going from a position of control\nto having almost no control at all. You do have the benefit of surprise, since this is rarely seen and unexpected.	1. Attacking his left leg:  Dive between his legs and scoop under his left Achilles heel with the crook of your left\nelbow.\n   2. Grab his toes with your right hand and grasp your right bicep with your left hand\n   3. Press his toes down and to the inside.	\N	14	3	10	8	http://austinjiujitsu.com/ajj/pictures/Techniques/Toe%20hold.jpg	1	V5THAAPJSH4	6	3	2007-12-18 06:00:00+00	\N	\N
3	16	Toe Hold from Standing in Guard	The goal in general is to get his opposite heel in the crook of your elbow. You are standing in his open guard.	1.  As you feint passing his guard, trap his heel in your opposite elbow. \n   2. Wrap the other hand around his toe area and lock your arm as in kimura.\n   3. Drop your outer knee into him: either wrong knee on stomach or into his hip area.\n   4. Torque his ankle into avulsion\n\nNote: You can grab either heel and have this work, but opposite is stronger. In the case where you grab "mirror" side\nheel, you will be turning the ankle in the opposite direction.	\N	145	3	5	5	http://austinjiujitsu.com/ajj/pictures/Techniques/Toe%20hold.jpg	1	R19vm31WRmI	1	1	2007-12-18 06:00:00+00	\N	\N
3	16	Heel Hook	The heel hook is dangerous! Be careful to apply this technique slowly so you don''t injure your opponent''s knee.	\N	\N	150	3	1	1	http://austinjiujitsu.com/ajj/pictures/Techniques/Heel%20hook.jpg	1	mTFv5K4u6j4	1	3	2007-12-18 06:00:00+00	\N	\N
1	16	Heel Hook Defense	he is heel hooking your right foot	1. Roll to the left and wrap your left toe over your trapped heel. This will make it difficult for him to pull on it.\n2. As soon as you can, use your left foot to push his arm off.	William Vandry	152	3	11	11	\N	\N	-MSv6W92ihI	15	3	2007-12-18 06:00:00+00	\N	\N
3	1	Zipper Choke: Double Lapel Choke from the Back	The choke has you behind him with one hand pulling his lapel across his throat and the other under his armpit with the\nhand behind his head.\n\nYou are behind him in rear mount with hooks in.	1.  Grab across his neck to the opposite lapel\n2. Other hand goes under his arm and as far behind his head as possible. The deeper the better\n3. Pull choke	\N	172	1	12	12	\N	\N	AlOhhBmIRcg	7	2	2007-12-19 06:00:00+00	\N	\N
3	1	Clock Choke	You are controlling him from his back.	1.  Reach your left hand thru his armpit and grasp (monkey grip) his far forearm (which is on the floor)\n   2. Pull his far forearm down so he can't post. Maintain hold of this throughout.\n   3. As you move off his back to his right side, reach under his chin with your right hand and grab his far \nlapel\n   4. Sit forward  by stepping your legs our in front of him. Your right hand is tight against your chest, \nreaching under his neck.	\N	164	1	7	15	\N	\N	1CWd0EAGcYY	9	2	2007-12-19 06:00:00+00	\N	\N
1	1	Clock Choke Defense	he has a clock choke sunk on you. Assume his left arm is under your armpit	1.  Clamp your left arm hard on his arm\n   2. Roll over your left shoulder. He will follow, if he wants to keep the choke\n   3. You will roll over his head. His arm is in a nasty Americana	\N	181	1	7	15	\N	\N	9x_quJLuJl0	16	2	2007-12-19 06:00:00+00	\N	\N
3	1	Gi Choke from Stacking Guard Pass	You are passing his guard with a double-under pass	1.  From inside the guard, get double under grab (under both legs)\n   2. Reach your right left hand around and grab his left lapel\n   3. Reach your left left hand around and grab his left lapel\n   4. Slide your left hand high up the collar under his chin (holding with the right)\n   5. Stack him up un your knee, putting the weight of his body over your forearm\n   6. He will either tap from the choke or let you pass. If he lets you pass, maintain the choke and finish it from the\nside.	\N	174	1	8	15	\N	\N	hPmHSNcyv6Q	1	2	2007-12-20 06:00:00+00	75	1
3	1	Gi Choke from Side Control	You have him in side control. He is rolled to his side	1.  Reach your outside arm under his head, then under his chin. Feed the lapel to this hand with your other hand.\n   2. Hold other lapel with your other hand.\n   3. Grab and pull tight. Augment it with your outside knee on the back of his head.	\N	166	1	3	3	\N	\N	Rj-hS9b81zk	6	2	2007-12-20 06:00:00+00	\N	\N
3	1	Rear collar choke from side control	You are in right side control. He is grabbing his left arm over your back, instead of keeping his arms close.	1.  Reach your right  hand under his back and grab his rear collar with your 4 fingers. Clamp and hold for the rest\nof the technique. Be sneaky or else he???ll block the choke.<br>\n   2. press you upper knee behind his head<br>\n   3. Sneak your upper hand thumb-first under his collar under his chin. You can sneak from the top or bottom. If he\nspots you doing this, you may screw the technique. A good way to prevent this is to hide your arm flat against your side\nas you sneak it in.<br>\n   4. As you (optionally) sprawl your legs out, pull your hands together. Drop your elbow to the floor.<br>	Carlos Machado	7	1	3	1	\N	\N	cZHKPD4qgxc	6	2	2007-12-20 06:00:00+00	\N	\N
3	3	Kimura from Kesa Gatame	You are holding him in Kesa Gatame from his right side. He is hugging around you with both arms. You will attack his\nright arm (which is around the front of your chest). This is a really weird move that doesn't work every time, but it's\ncool when it does work. It takes almost no movement.	1.  Bridge up to put pressure on his chest\n   2. Hook your left wrist under his right forearm and pull up slightly. Notice it will lever his right shoulder just\nenough to potentially tap him.	\N	127	3	13	13	\N	\N	\N	6	1	\N	\N	\N
5	5	Butterfly Guard	This is a good setup for sweeps. You have him in your closed guard	1. Put both feet hooked under his thighs so your feet are behind him hooking behind his legs between his knees and his\nbutt. \n2. Underhook with your right arm. Either grab his belt (gi) or hug his back\n3. Grab his right arm with your left hand or grab his collar (gi)	\N	43	3	1	1	\N	\N	\N	8	1	\N	\N	\N
2	3	Americana Escape - Free Arm Trapped under Him	He has you in Americana, your free arm is trapped under him	1.  Push your left arm against his legs to keep his legs away from your side. This will prevent him from finishing\nfor a moment.\n   2. Get your arm out and finish with referenced move	\N	138	3	6	3	\N	\N	\N	3	2	\N	\N	\N
2	9	Side Control Escape - Barrel Roll	He is holding you in right side control. This is a great escape, but the risk for a pillow choke (arm triangle) is very\nreal!	1.  Shotgun both arms into his hip and face to make room to reposition both arms.\n   2. Left arm reaches in front of your face (choke risk here) and grabs over his shoulder to his belt \n   3. Right arm reaches as low as possible on his right (FAR) leg. Straighten his leg\n   4. Walk your legs toward his head. This reorients his body to make it easier to roll him. This is the most important\nstep!\n   5. Bridge and roll him over. Just like the Sweeping Bridge escape, make sure you look up if his arm is under your\nhead to trap his arm and maximize the bridge.	\N	23	1	6	3	\N	\N	HYqUFzX5PoI	3	3	\N	\N	\N
6	8	Ankle - Shin Sweep	He is passing your guard, standing above you in your open guard. His right leg is forward.	1.  Grab his right ankle with your left hand\n   2. At the same time you grab, push your left knee into his right leg just below his knee and press \noutward to turn his knee out. The combination of pressure from your leg and holding his foot is the key to \nthis move.\n   3. Use your right leg to butterfly hook his left leg in order to scoop his left leg with your right arm. He \nwill step forward with his left leg in a natural attempt to stabilize his position since you are pushing his \nother leg back.\n   4. Push hard on his right leg and scoop your right arm under his left leg. Depending on which direction \nhis balance/weight is, you can take him down in one of 3 directions.	Rigan Machado	102	3	1	3	\N	0	Lx37O-i1iOA	5	2	2007-12-23 06:00:00+00	77	2
3	3	Americana Shoulder Lock	You have him in side control on his right side. Note: This isn't the same Americana BJJ schools have been teaching for\nthe past 10 years. This one is more efficient and easier.	1.  If he is hiding his arms near his chest, sneak your left arm close to your head between his arm and your head\n2. Press his left wrist to the floor near his head with your left hand and your head\n3. Reach under his left triceps with your right hand and grab your left wrist\n4. Pull your right elbow to his left ribs. Most guys will tap at this point. For those lucky enough to have loose\nshoulder sockets, you'll have to go to step 5...\n5. Keeping his wrist pressed to the floor, drive his wrist toward his hip. You should lift your elbow and his elbow to\nget his wrist all the way down there. Even the most insanely loose dudes will tap at this point.	Travis Tooke	128	3	3	3	\N	\N	mTmWT_YPQ-Y	6	1	2007-12-22 06:00:00+00	\N	\N
3	18	Crotch Splitter from the Twister setup	This is done as a "detour" during the twister. Before you go to step 2 on The Twister you need to set up trapping his\nother leg so you can split him. Crotch splitter is similar to a banana split, but done from the Twister setup.	1.  Dig your right hand under his right thigh. If you can gable grip now, it'll be easier later. But, his leg may be\ntoo tight on the mats to get a full grip.\n   2. Now go to step 2 on The Twister (roll over him).\n   3. Clamp his right thigh in a rear choke grip (grab your left biceps with your right hand) -- or gable grip is fine.\nEddie does gable grip, I do rear choke grip.\n   4. Stretch him out by bridging and stretching the lockdown.	Eddie Bravo	236	3	14	15	http://austinjiujitsu.com/ajj/pictures/Techniques/Crotch-ripper%20Bravo.jpg	1	WNN1iVtxv1Y	6	3	2007-12-23 06:00:00+00	\N	\N
1	3	Defending Kimura from Guard	You are inside your opponent's guard and he attacks your right arm with a Kimura. As with most defenses, the sooner you\nsee you are in trouble, the better. Many defenses stop working once the technique is really "sunk," The benefit of lots\nof mat time (experience) is you can see what your opponent is up to very early on. Mat experience is like having ESP,\nyou can predict and detect your opponent's plan very quickly. But I digress. On to the defense!	1. As quickly as you can, hug both arms around his hips and S grip, if possible. Grabbing your own belt is not a\nreliably strong defense.\n2. Drive your head deep under his arm and keep pressing to crowd his arm high. The harder you drive, the weaker he is.\nKeep in mind that the more weight you commit on him, the more likely it will be for him to abandon the attack and resort\nto a sweep, so be prepared to get your base back as soon as he releases.	\N	293	3	8	8	http://austinjiujitsu.com/ajj/pictures/	0	K-ZQ3JPI6qY	1	1	2007-12-23 06:00:00+00	\N	\N
1	3	Defending Kimura from Guard with Caveman Hook	You are in his guard and he is attempting to Kimura your right arm.	1. Step your right foot up and catch your inner thigh with your right palm in a "caveman hook" \n2. This will only buy you a little time, so quickly start driving your weight forward into his right armpit. The deeper\nyou go into his armpit, the weaker he gets.\n3. If you can, drop your right knee on his left hand. His left hand is gripping his right wrist. Breaking this will\nguarantee the escape. This step isn't required, but it helps.	David Thomas	294	3	8	8	http://austinjiujitsu.com/ajj/pictures/	0	WjjDgaIdPjY	1	2	2007-12-23 06:00:00+00	\N	\N
2	2	Armbar Escape from Bottom- rolling your shoulder	He has started to arm lock you from mount. He is above you. In this example, he has your right arm. \nThis technique is\ndangerous to your arm, but does work if done perfectly!	1.  As he sits back, walk to the left making your bodies as parallel as possible (you started perpendicular).\n   2. Turn your elbow up as you roll to the left	\N	123	3	6	8	\N	\N	wIvdU00BdtU	15	3	2007-12-23 06:00:00+00	92	3
2	1	Guillotine escape - Back roll sweep	If someone gets you in a guillotine choke from standing, you have a couple of pretty cool options.\nOne option is to immediately sit at your opponent's feet and throw him over your back. It's crazy, but it works. It is\nespecially easy on an opponent of similar size. Bigger guys are harder to do this to since they won't let you just sit\ndown unless you surprise them. Since it's an unconventional defense, they may not expect it.\nIn this setup, he is choking you from standing.	1. Sit at his feet\n2. Butterfly guard to defend him from mounting you\n3. Sit very close to him and scoop under one of his legs with your hand. Make sure you are under his center of gravity.\nIf he attempts to maintain the choke, he will be leaning forward, which helps.\n4. You should be able to lift him slightly with your hands and butterfly guard. \n5. Roll back	\N	290	3	8	4	http://austinjiujitsu.com/ajj/pictures/Techniques/Guillotine%20escape%20to%20back%20roll%20sweep	4	soLA2jKIGG8	15	3	2007-12-23 06:00:00+00	\N	\N
3	3	Kimura from Side Control	You are on top in North-South position. In this example, you are attacking his right arm.	1.  With your left hand, trap his right wrist\n   2. With your right hand, go under his right triceps and grab your left wrist\n   3. Plant all of your weight with your chest on his right shoulder. This is the most important step!\n   4. Make sure you have correct hand position: Your left elbow should be against his ribs.\n   5. He should be immobilized. Raise your left elbow slightly to finish.	\N	125	3	3	15	\N	0	d-JRaxaUP8w	6	1	2007-12-23 06:00:00+00	\N	\N
3	1	Vice Choke (No Gi Bat Choke)	You are holding him in right side control, head in arm position.	1. Your left arm is under his neck. \n2. Gable grip with your right hand, drawing your right forearm under his neck.\n3. Drop your weight on your right forearm (sprawling back can help) while you pull your left arm up against the back of\nhis neck. \nTake care to apply this choke against the side of their neck, avoiding their windpipe.	\N	217	2	3	3	\N	\N	pMdbA4wLYRw	6	2	2007-12-23 06:00:00+00	\N	\N
6	8	Low X-guard (Butterfly Scooping) Shin Sweep	He is passing your guard, standing above you in your open guard. His right leg is forward.	1.  Grab his collar with right hand and his sleeve with your left. Both feet are on his hips, or wherever in \nopen guard.\n   2. Move both feet behind his knees and push his feet out a little.\n   3. Shoot your right arm under his left leg and scoop his leg\n   4. Push both shins against his right leg just below his knee and grab his right foot with your left hand.\n   5. "Roll" your right arm to left as you push against his right leg.\n   6. As he falls, follow him so you maintain control.	Carlos Machado	103	1	1	3	\N	0	_HXOPe8H04M	5	2	2007-12-23 06:00:00+00	\N	\N
3	1	Side Choke Alternative from Armbar Attempt	When attempting to execute many armbar submissions, it is typical for your opponent to grip his hands together to\nprevent the submission. While there are numerous ways to break his grip, an easier alternative is to change to a\ndifferent submission. This is similar to a triangle choke from armbar attempt, but the choke is distinctively different.\nThe pressure from a side choke is on the opposite side of the neck. Unlike the typical "my head is exploding" feeling of\na triangle, the side choke creates significant pain on the side of the neck while the choke takes effect. \nIn this technique, you are attempting an armbar from the left side of your opponent (you have his left arm).	1. Push your left foot between his locked arms and his chest, driving your heel against the floor right next to his neck\non his right side. \n2. Put your right leg above his head on the floor. It is likely that an experienced BJJ fighter will immediately sit up\nbetween your legs to attempt to escape. This actually helps complete the lock around his neck if he does, but in this\nexample, let's assume he doesn't sit up.\n3. Grab behind his head with your left hand and pick his head up off the floor\n4. Drive your left leg behind his head as deep as possible. This will likely hurt your quadriceps a bit, especially if\nthe dude has a huge head. Deal with the pain, since he'll be tapping momentarily.\n5. Put your left foot behind your right knee, but unlike a triangle choke, you don't need to bend your right leg. Keep\nit straight and flat on the floor.\n6. This is the tricky part, so watch the video. Place both hands on the floor on either side of your hips and lift your\nbutt off the mat. Rotate your torso toward the top of his head. This will have the effect of clamping his neck, and\nimportantly driving your right knee toward the back of his neck.	William Vandry	296	2	15	15	http://austinjiujitsu.com/ajj/pictures/	0	4achgQPGNsU	6	3	2007-12-23 06:00:00+00	\N	\N
3	17	Kamikaze Calf Crush	From a twister lock-down setup, you can get this calf crush. It is executed half way through the rolling twister.	1.  Grab his foot\n2. Open your lockdown\n3. Push your left foot with your right foot as you pull his foot back to you.	Eddie Bravo	246	2	3	15	http://lh4.ggpht.com/dthomasjiujitsu/SIaSnkJX9fI/AAAAAAAABhA/YD75JBZvUu0/IMG_6778.JPG	1	mT-Fwk8LNd4	6	2	2007-12-23 06:00:00+00	\N	\N
5	9	Twister Lockdown	From Twister Side Control or Hog Tie.	1.  You now must get a lockdown on his left leg. This is easy if he doesn't expect the twister, since he will attempt\nto turn toward you. When he does this, his left leg will swing toward you.\n   2. Trap his left leg by hooking your right heel over the back of their leg. This is a temporary hold.\n   3. Get a lockdown on this leg by putting your left calf behind his left leg and hooking your right calf with your\nleft instep. Eddie calls this "the Gerber" or "Feed the baby" because you are feeding their left leg to your right leg\nwith your left leg.\n   4. Hook your right instep around his left foot. Now you have the lockdown.\n   5. You can either pull him toward you or roll over him for the next step.	Eddie Bravo	233	3	3	3	\N	0	c1nV0kji8Uc	6	2	2007-12-23 06:00:00+00	\N	\N
3	14	Twister	From Twister lockdown. This is know as a guillotine in wrestling.	1.  Keeping your left knee on his hip, get up on your left knee and place your left hand on the ground on the other\nside of him behind his butt.\n   2. Roll over him toward his legs - KEEP THE LOCKDOWN!\n   3. Wrap your left arm around the back of his head and his right arm around the back of your head. See setting up arm\nposition for twister.\n   4. Pull his head toward you	Eddie Bravo	234	3	3	15	http://austinjiujitsu.com/ajj/pictures/Techniques/Twister%20setup.jpg	1	tSwHMRLzuWI	6	3	2007-12-23 06:00:00+00	\N	\N
2	9	Escape Head in Arm Control	You are in side control being held in head in arm control. Assume he is on your right side.	1.  Make space between you and him by getting your right elbow into his left hip.<br>\n2. His left elbow is near your right ear. You will focus on getting this elbow off you first. Push your right palm under his elbow and look down (so your head doesn't block your own escape). Reach under your head with your left arm to help pull his arm over your head.<br>\n3. Once you pull his arm off from around your head, keep pushing it down all the way to your feet. He will roll over you.<br>\n4. Keep control of this arm and take side control or kesa gatame.<br>	\N	4	3	6	3	\N	\N	\N	3	2	\N	94	\N
5	10	Knee-up Mount	This mount is useful if you are mounting a big-chested guy. Unless you have long legs, you may notice that your knees\nare not stable flat on the ground. Start from mount.	1. Step your right foot up flat (knee up). Make sure your foot is pressed hard against his hip and stays flat on the\nfloor. The nice side-effect of this is that it makes a elbow-knee escape very hard to do.\n2. Move most of your weight over your left leg so your butt is sitting on your left thigh. \n3. Post out your left hand and press on his far shoulder with your right hand.	\N	37	3	4	4	\N	\N	R3En98hVCr0	6	2	2008-01-29 06:00:00+00	\N	\N
6	7	Arm Drag	The goal of this technique is to grab your opponent and get an advantageous hold. The arm drag is an explosive\ntechnique. It is best done with no-gi, but works with the gi as well, especially if you are outside the clinch. You and\nyour opponent are standing facing each other. Assuming he is standing in natural stance (he's not a southpaw), his left\nhand is slightly ahead of his right. You will be dragging his left arm.	While this move seems to ""all happen at once"", it can still be done in steps while you are learning it. \n1. Slap his left wrist inward with your right hand as you step forward with your right foot.  \n2. Catch his left arm above the elbow with your left hand.  \n3. Pull him in to you as you step deep behind him.  \n4. Gable grip your hands and hug him low around his hips. \n5. You should end up behind him or on his left side past his arm, giving you access to his back. If you aren't all the\nway behind him, you can use your grip around him to work to his back.	\N	2	3	5	5	\N	\N	hERx0Sy2Wes	5	1	2008-01-09 06:00:00+00	\N	\N
5	9	Shoulder Pinning Side Control	This is a great side control to use on big guys who tend to pull you over them as you breadroll (over committing your weight on him).	   1.  Top arm under his neck grabbing far armpit from under\n   2. Bottom arm holding pants or scooping his near hip\n   3. Press DOWN all weight on his near shoulder	\N	5	3	3	3	\N	\N	\N	6	2	\N	31	\N
2	9	Side Control Escape - The Angry Sweater Escape	This escape is almost identical to the "Americana Escape to Payback Americana."\nThe only real difference is the way he starts: he is holding you in a head-in-arm side control. This presents a problem\nthat is solved with what I call "The Angry Sweater." \nImagine how you'd take off an angry sweater. You'd grab it from around your neck and you'd rip it the hell off of you.\nHis arm under your neck represents this angry sweater. \nIn this technique, he is holding you on your right side control. His left arm is under your neck.	1. Grab his left arm with both hands. With your right hand, grab behind his elbow. With your right hand, grab around his\nwrist. \n2. Angry sweater time! Grip hard, shrug your shoulders, and tear his arm out from under your neck as you twist away from\nhim on to your left side.\n3. Push with your right hand against his left elbow and keep pressure on him\n4. Rotate his elbow over and GET TO YOUR KNEES. Keep pressing and he will roll over you to his back. Secure side control\nand keep his arm.\n5. Payback: Americana him now! His left arm should be trapped since you've been rolling him with it under control.	\N	303	3	6	3	\N	\N	fZYUyWlOUlI	3	3	2007-12-22 06:00:00+00	100	2
3	16	Heel Hook from Guard Pass	As you are passing his guard, his knees and shins are often under your chest. His defense can be used against him by\nattacking his legs. An easy method is a heel hook since his feet are actively hooking, often even under your armpit,\nexactly where you need them to hook the heel! \nIn this example, you are passing the guard to his right attacking his left foot. He is on his right side defending the\nguard pass so his left foot is higher than his right.	1. Scoop his left foot under your right armpit\n2. Reach your forearm around his heel\n3. Clamp with gable grip and press your weight into him (he'll start thrashing to escape and you need some weight on him\nhere)\nTorque your hips to your left to tap him. Be careful, by the time he feels the pain, he may already be injured. Coach\nyour partner to tap early.	\N	301	3	8	15	\N	\N	rgWW9mTsDG8	1	3	2007-12-18 06:00:00+00	74	2
3	3	Near-side Americana from Kesa Gatame	This is one of those tricky techniques that you some guys find lots of success with. From a Kesa Gatame (also known as a\nscarf hold, or what some wrestlers call "Head in Arm"), you are going to attack your opponent's near arm with your leg.\nIn this technique you are on his left side attacking his left arm.	1. He will probably be "hiding" his arm, unless he's a total sucker. Expect you will have to pry it away from his body.\nAs in most BJJ techniques, we do this by focusing our "big muscles" against his "small muscles." No, that doesn't mean\nwe are stronger than him, it means we are going to use our major muscle groups to attack his relatively weaker\nappendages. The way we do it in this case is we grab his left wrist with our right arm. Straighten your arm and press\nhis arm to the mat with the strength of your back and torso. In other words, don't fight him with your tiny triceps\nmuscles. You are "straight-arming" him and using your whole body to press his arm down.\n2. As his wrist comes to the mat (it needs to be his wrist), you will trap it under your left leg. Pick up your left leg\nat the ankle and stuff his wrist under it.\n3. Press your ankle to the mat and bridge your hips. Most guys will tap now, but if they have loose shoulders, keep\nreading...\n4. Keeping his wrist solid on the mat, push his left elbow away from you with your right palm. This will torque even a\nlimber guy enough to tap him. Ka-zowie!	\N	302	3	13	15	\N	\N	W4jv--Ooaco	6	3	2007-12-22 06:00:00+00	87	47
3	1	Omo Plata from guard - opponent standing	He is in your open guard. He is standing. Both of your feet are on or near his hips.	1.  Your left hand holds his right sleeve at wrist near your left hip. His right arm is against your left thigh.\n   2. Your right hand holds his collar to keep his weight down\n   3. Push your left leg up as you pull his right arm down and back to "roll" his right shoulder forward\n   4. Your right hand moves from his collar to his right elbow and pulls his elbow forward.\n   5. As you push your leg to further roll his arm forward, grab his belt or pants near waist with your left hand and\nstart to pull him to the ground (toward you and down). This is very important to help pull him to the ground for 2 reasons:\n\n             1. It helps tug him over toward his trapped arm. He can't post with this side since his arm is trapped so\nhe is easier to drop.\n             2. The elbow of your left arm applies pressure to his right knee to prevent him from stepping toward you\nwith the right leg, thereby taking his posting leg away.\n\n   6. Figure 4 your leg to lock his arm into place, but keep your left leg straight to apply more weight on his shoulder\nuntil he falls flat.\n   7. Once he falls, keep pulling him toward you by holding his belt with your left hand and pulling your body away with\nyour right hand.\n   8. You'll notice that if you are seated too close to him, that he won't tap as quickly, so make sure you position\nyour body such that your right leg is off his shoulder and on his tricep close to his elbow. As you lean forward to\nsubmit him, you can raise your body off the mat by pressing your right fist into the mat and lifting your rear.	\N	131	3	1	15	\N	\N	\N	8	2	\N	\N	\N
2	3	Omo Plata Escape - Cartwheel Over Head	He is doing omo plata on you, attacking your left shoulder.	1. Before he gets too deep into the submission, jump over his head, throwing your legs high like a cartwheel. Your legs\nneed to be high in case his head is high (if he is sitting up).	David Thomas	139	3	16	3	\N	\N	-Mqeu2kyr78	15	2	2007-12-29 06:00:00+00	\N	\N
3	1	Guillotine Choke	This can be executed from standing, guard, or mount position. In this case it is being executed from standing during a\ntake-down defense.	1.  He is shooting in and leaves his head outside on your right\n   2. Grab around his neck with your right arm and either pull to guard or remain standing\n   3. Grab your right wrist with your left hand and pull up against his throat. Be careful of his windpipe and give him\na chance to tap.	\N	169	3	5	1	\N	\N	\N	5	1	\N	\N	\N
2	5	Opening the closed guard (going from Position 1 to Position 2)	We need to note a couple of important points about stability and opening the closed guard. If you have good balance and\nhis legs are open, your job will be much easier. The basic idea is that you will be putting pressure on his hips with\nyour hands, his legs with your elbows, and his ankles with the base of your spine. This generally pops him open.\nAt the end of this movement, you are in what I call Position 2	1.  Grab his pants at the waist with both fists tight at his hips. (Gi: don't grab the belt. It can slide up his\ntorso, voiding the effectiveness of your grip). \n   2. Put your right knee  in/under his butt. If he raises his butt up, you are probably not putting enough pressure on\nhis hips. Keep your left knee 90 degrees away, so it should be far off to the left for good base.\n   3. Pull your elbows in to your sides, straighten your back, and look up (this will help you to stay up if he sits up\nto pull you down).\n   4. Push down on his thighs. This will crank his pelvis and put pressure on his legs. It may not open his guard yet. \n   5. Sometimes it is useful to take your left hand and press on the inside of his right knee to put pressure on his\nclosed guard. \n   6. If he has long legs or you have short arms or legs, you may need to reposition your grip lower than his hips.\n   7. Position 2: Immediately bring your right knee up to your chest, with your thigh flat and tight against your chest,\nfoot flat on the floor.  Keep outward pressure on his thighs to prevent him from re-closing guard. Keep your left knee\nflat on the floor. Position 2 is a very stable position that is nearly sweep-proof if you have good base!	\N	49	3	8	8	http://austinjiujitsu.com/ajj/pictures/Techniques/Inside-Guard-Position	2	\N	1	1	\N	\N	\N
6	8	Gringo Roll	You are holding your opponent in guard. You will be sweeping him to your right.	1.  Start in a hook sweep position with your left foot hooked under his thigh\n   2. Sit up and get right underhook\n   3. Grab your right hand with your left over his left shoulder - Gable grip\n   4. Pull hard down on his shoulder and pull him to your chest\n   5. Push your right foot on his left knee as you rotate your left elbow into his jaw\n   6. He should roll	Travis Tooke	108	3	1	3	\N	\N	RzZKo3OXJxY	8	3	2007-12-30 06:00:00+00	\N	\N
6	8	Spider Guard Sweep	He is standing above you. You have him in open spider guard\nYou are sweeping him over your right shoulder. Keep your right foot deep in his left elbow gripping his sleeve\nthroughout this technique!	1. Grabbing his left gi sleeve with your right hand, pull him toward you. This "leading pull" is crucial to the success\nof the technique. You need his weight over you, so if he is "based back," you will need to either pull him over you or\npull yourself under him. The difference between you going under him and him coming over you is usually the lighter guy\nwill move. \n2. Once you are under him grab under his right thigh or knee with your left hand. \n3. As he begins to fall forward, give him some help by pulling him down with your right hand and pushing his leg over to\nyour right with your left hand.	\N	304	1	1	3	\N	\N	5ln8hEPHyQo	5	2	2008-01-09 06:00:00+00	\N	\N
1	1	Triangle Choke Defense by hugging his thigh	This defense doesn't always work since there is a counter (see related technique), but since most folks don't know the\ncounter choke, you may as well know this move.\n\nSetup: He is triangling you but he doesn't have your arm across.	1.  Hug around his leg with your inside arm. Try to grab your  other hand around his hips.\n   2. I have no suggestion for an escape from here, you just are buyung some time (and hoping he changes to another move\nbefore he figures out the counter to this defense).	\N	189	3	8	8	\N	\N	\N	15	1	\N	\N	\N
6	8	High Underhook Sweep	He is in your butterfly guard. You will be sweeping him to your left.	1. Get double underhooks\n2. Lean back and start to stretch him out by pressing his thighs back with your butterfly guard and pulling your\nunderhooks high into his armpits to force his arms up. This step reduces his ability to post with any of his 4 limbs.\nYou can sweep in either direction from this point.\n3. To further reduce his ability to your left, keeping your left underhook, put your palm behind your head and press\nyour neck back. This uses your back muscles to strengthen your left high underhook. \n4. Roll left to sweep and go to mount position.	David Thomas	306	3	1	4	\N	\N	MV4a47xEv68	8	2	2008-01-09 06:00:00+00	\N	\N
1	1	Gi Choke Prevention from Turtle	You are in turtle position or he has your back.	1.  Grab both of your own lapels and shrug your shoulders high as you pull the lapels up to your ears.\n\nThis will buy you enough time to move to something else	\N	178	1	9	9	\N	\N	\N	12	1	\N	\N	\N
6	8	Carlos' Sweep - Perosh Variation	He is either sitting or standing in your guard. See "Carlos' Sweep Setup" for details on the opening sequence.	1.  Right hand grabs his collar, left hand grabs his right sleeve\n   2. Left foot on his right hip\n   3. Pull his right arm to your right strongly as you lift your hips and rotate your hips to the left. Make sure you\ntrap his right elbow inside your left leg as you rotate your hips.\n   4. As soon as you have his right arm trapped, grab behind his back with your left hand and hold his belt very\ntightly. Drop your left elbow close and tight against him. This prevents him from escaping his arm. This is critical in\nthat it takes his posting arm away.\n   5. Get both your hooks in, insteps under his thighs.\n   6. There are 2 ways to sweep him now:\n\n       1. Reach your right arm deep under his left elbow. Scoot your hips to the right to slowly move his body weight\noff to the left once it is far enough over (it takes some scooting!), raise your right arm in a scooping motion toward\nyour head and kick your right foot up to sweep.  OR\n       2. If he is pulling back, shoot your right leg through his legs and bump your right knee into his rear from below\nto move him up. Reach your right arm under his left thigh and use your right arm to sweep him.	Carlos Machado and Anthony Perosh	211	1	1	16	\N	\N	5c5RpuTmKq4	5	2	2008-01-09 06:00:00+00	\N	\N
6	7	Heimlich Takedown	You have just completed an arm drag and are hugging around the back of your opponent. You are around his hips with or\nwithout one of his arm trapped. I named this the Heimlich takedown since it looks like you are giving the guy the\nHeimlich maneuver when you are executing the technique.	Pull backwards strongly while you sit and pivot sideways. The pivot is important and will prevent him from landing on\nyou. Scramble to rear hooks or side control.	\N	279	3	5	3	\N	\N	hERx0Sy2Wes	5	1	2008-01-09 06:00:00+00	\N	\N
4	12	Rear Control Scramble	This is a really fun and challenging drill with a partner. You and a partner will take turns with a partial rear\ncontrol, then go "live" until someone has a position of control. Assuming you are holding the partial rear control (you\nare going first), a partial rear control position looks like this:\n1. You are lying on your back or sitting up, behind your opponent, with both arms under his armpits, hugging his midsection.\n2. You do not have your hooks in.	When the drill starts, both of you will scramble to get better position. Clearly, this is easier for the guy in back,\nbut it's surprisingly hard to get hooks on a well defended scrambling opponent. Don't let this develop into an all out\nbrawl. Try to get a solid position. The trick for the guy in the rear is to use your hooks to control his legs so he\ncan't turn around.\nThis is a fun drill when combined with an arm drag to drop-sit takedown.	\N	280	3	11	12	\N	\N	PiDSjTWcdy4	11	1	2008-01-09 06:00:00+00	\N	\N
4	19	Pummeling Drill	This is also known as swimming in. The purpose is to gap the distance to your opponent and take control with double\nunderhooks.	Alternating arms, the purpose of this drill is to have both partners race to get double underhooks.\nThe first half of this drill is treated as pure drilling technique where the partners are moving fast and smooth, but\nnot competitive. \nThe second half of the drill is competitive. Fight for underhooks. The winner should try to overwhelm their opponent and\nget them to the mat, but only with a "Reverse Heimlich Drop."	\N	260	2	5	5	http://austinjiujitsu.com/ajj/pictures/Techniques/Dave-crowding-Bobby.jpg	1	LJ23GRes_S0	5	1	2008-01-09 06:00:00+00	\N	\N
3	3	Omo Plata from guard	He is in your open guard. You are attacking his left arm.	1.  Pull his left wrist to your left hip\n   2. Put your left foot on his right hip and push away to start rotating your head toward his feet\n   3. Throw your other leg around his left arm near triceps. This should unbalance and pull him downward\n   4. Figure 4 with your legs as you rotate 180 degrees (your head goes where your feet were) keep your right leg\nstraight to apply more weight on his shoulder until he falls flat.\n   5. To pull him flat on his stomach, there are a couple of tricks. Sometimes he'll go flat just with a nice strong\npull to the ground with your hand on his hip and the back of your leg on the back of his arm. Other times you have to\nactually reach away with your left hand and pull yourself sideways (away from him). This will pull him off balance. \n   6. Prevent him from rolling (even though you can finish the move after he rolls, it gets harder) by holding his\nback/belt w/ your right hand\n   7. Don't have the lock too high up his arm. Work it toward the elbow for a more effective lock. Lean forward to\nsubmit him.	\N	130	3	1	15	http://austinjiujitsu.com/ajj/pictures/Women/Working%20omoplata.jpg	1	xjy_IUqwCXM	8	1	2008-01-09 06:00:00+00	\N	\N
5	5	X Guard	Good for sweeps	X Guard is like a half butterfly guard. Your left leg is in butterfly position, hooking his right thigh with the hook of\nyour left foot. Your right foot is hooking around his hip on his upper thigh above your left foot. Your right arm is\ngenerally hooking his other leg or holding the pants of his other leg near the knee.	\N	45	3	1	1	\N	\N	CZrF9ZiAanY	5	2	2008-01-09 06:00:00+00	\N	\N
6	8	Hook Sweep	He is in your guard	1.  Hook instep under his mirror-side thigh (i.e. your right instep under his left thigh)\n   2. Sit up CLOSE and TIGHT and grab around his back with your right hand. Hold his belt or pants top\n   3. Grab his right hand at the sleeve and press it against him. This will allow you to mount over his arm once you sweep\n   4. Roll back towards opposite shoulder, kicking leg. This will throw him over your head.\n   5. Maintain control after he goes over (with your arms). Pull him toward you to take mount.\n   6. If you can mount over his arm, go to the triangle choke from mount.	\N	98	3	1	3	http://austinjiujitsu.com/ajj/pictures/Techniques/Hook%20sweep.jpg	1	fml00BKBtBs	8	1	2008-01-09 06:00:00+00	\N	\N
6	8	Old School Sweep	You are holding your opponent in half guard with underhooks.	1.  Start in lock-down with double-underhooks.\n   2. Explosively lift your legs and jerk your body to the right to get out from under him a bit. He will \nwhizzer you to\nkeep you from taking his back.\n   3. Hug your left arm far across his back and scootch close to his legs (get deep under him)\n   4. Reach your right arm under his left shin and grab the toes of his left foot\n   5. Keeping his right leg trapped, hold his left foot and drive forward and to the left, passing his guard	Eddie Bravo	226	3	2	3	\N	\N	sQ084KXhcm4	8	2	2008-01-09 06:00:00+00	\N	\N
2	5	One Leg Stacking Guard Pass	You are in his open guard. You will be passing to your right.	1. Scoop your right arm under his left thigh. Prevent the triangle by keeping pressure on his right leg with your left\nhand. \n2. Hug his left leg tightly, picking up his hips with your back muscles.\n4. Press his left knee forward toward his face with your shoulder. This will "Stack" him the higher his hips are over\nhis head. Optional: you can choke him here with his lapel. Refer to related techniques for detail.\n5. Once you stack him enough, turn your head and shrug to have his left leg fall off you so you can secure side control.\n	\N	52	3	8	3	\N	\N	DYsVNlszZq8	1	1	2008-01-09 06:00:00+00	\N	\N
6	8	Carlos' Sweep Setup	This is how to set up Carlos' best position to start sweep. The basic goal is that you want to trap his arm across his\nchest between you and grab behind his back to hold his belt while you get a hooking foot in. This move requires you to\nhave your hands free, so if he's trying to control your arms, you'll need to break free of this. This can be done from\nstanding or from the ground.	1.  Grab his right sleeve at the wrist with your left hand\n   2. Grab his right collar lapel with your right hand\n   3. If you are standing, drop to your back.\n   4. Quickly place your left foot in his right hip and your left foot on his left leg.\n   5. Jerk his arm to the right and his collar down to the right as you pull him into you. Rotate your shoulders to the\nright at the same time.\n   6. With left hand, quickly grab around his back to his belt and pull your left elbow low and tight to prevent him\ngetting his arm back in.\n   7. Set up a hooking foot for a sweep. Ok, that's the sweep setup. Next step depends on which way his weight/posting\nlimbs are. You can either go right, left, or forward.	Carlos Machado	204	1	1	1	\N	\N	5c5RpuTmKq4	8	1	2008-01-09 06:00:00+00	\N	\N
4	19	Back bridge	This is a neck strengthening and base development drill. The result of lots of "bridge work" on your neck is that you\nare more likely to post with your head, giving your "table" of base a 5th leg! The head is a key tool in grappling\nsports. A strong neck will help you successfully use your head.	Lie on your back and put your palms on the mats over each shoulder (your elbows point to the ceiling).\nPlace your feet flat on the ground, with your knees pointing to the ceiling\nUsing your back and shoulder muscles bridge your hips up as high as possible\nRest the rear back of your head on the ground and maintain a bridge position\nIf your neck is strong enough take your hands off the mats using only your neck strength\nRock your head back and forth, allowing the base of your head to touch the mat, rocking al the way up to your crown. \nRepeat this motion. \n		311	3	6	6	\N	\N		17	1	\N	\N	\N
4	19	Back Roll to Front Neck Bridge	This is a good mobility drill that incorporates both a back roll and front neck bridge.	1. Starting with a back roll, you build twisting momentum by swinging your right leg across your left leg as you roll\nback. This will help turn your body over in a barrel roll as you do a rear ukemi. \n2. When you land on your shoulders/neck, push up with your neck muscles to a front neck bridge. In other words, this\nstarts as a rear roll and ends in a front bridge.\n3. Bonus move: stand up from the front bridge without using your hands!	David Thomas	313	3	11	7	\N	\N	\N	17	2	\N	\N	\N
3	1	Rolling gi choke	You are sprawled on opponents back	1.  Reach one arm under his arm and grab opposite gi lapel\n   2. Reach other arm under his armpit and thread arm behind his neck\n   3. Roll sideways toward choking arm to flip him over. Come to your knees\n   4. Pull and choke	\N	194	3	7	15	\N	\N	\N	9	2	\N	\N	\N
4	19	Front bridge	This is a neck strengthening and base development drill. The result of lots of "bridge work" on your neck is that you\nare more likely to post with your head, giving your "table" of base a 5th leg! The head is a key tool in grappling\nsports. A strong neck will help you successfully use your head.	1. From standing or kneeling, place your head on the ground. Beginners may start by putting their palms on the ground\nfirst, but you should try to simply lean forward and put your forehead on the mats without hand assistance. \n2. Once you have weight on your head, carefully nod your head forward and back. Visualize your neck muscles doing all\nthe work to prevent you "cheating" by using your legs. Newbies will use their legs to work the nodding motion, but this\nshould be avoided in that it doesn't help your neck strength. \n3. Bonus move: stand up from the front bridge without using your hands!\nSome coaches recommend side to side motion here. I minimize this direction for safety.	\N	310	3	7	7	\N	\N	\N	17	1	\N	\N	\N
4	19	Human Beat box	This is a complicated move, but once mastered, demonstrates a great level of agility on the ground. It is a good warm up\ndrill for the advanced student.	1. Do the back roll to front neck bridge\n2. Tie this together with the side shoulder roll. \n3. Go back and forth \n\nThis technique needs a video! :)	David Thomas	314	3	11	11	\N	\N		17	3	\N	\N	\N
4	19	Sideways Shoulder Roll	Rolling side to side across the shoulders. Only the neck, shoulders, and balls of the feet touch the floor. This is a\ngreat technique for neck flexibility and balance.	1. Start on your back in the Half Back Roll position with the ball of your left foot over your your left shoulder on the\nground (you are balled up with your weight on your left shoulder, neck, and left foot. \n2. Keeping your legs over your head roll from your left shoulder across the back of your neck to your right shoulder. As\nyou switch sides, your legs go over your head. Plant the ball of your right foot on the ground over your right shoulder.\nNow you are balled up with your weight on your right shoulder, neck, and right foot. \n3. Repeat side to side. \n	David Thomas	312	3	6	6	\N	\N	\N	17	2	\N	\N	\N
3	1	Rolling Crucifix Choke	This can work from a couple of positions:\n1. He is in turtle position and you are facing him\n2. He shot in and you sprawled on his back	1. Sprawl your chest on his back\n2. Drive your left knee into his right armpit by spinning to the right\n3. Reach over his back with your left hand and grab under his left armpit, "one on one" grab his forearm. \n4. Dig your right heel in to trap his right arm. Trap it with figure 4\n5. Roll over his back\n6. Finish him with the zipper choke	Igor Gracie	318	1	7	15	\N	\N		9	3	\N	\N	\N
2	5	Passing the Spider Guard	He is holding you in spider guard, with our without gi	1. Turn your wrists in to the center so your palms are facing the back of his legs near the calf\n2. Press your hands and hips in to crowd his legs\n3. As soon as his feet pop off your arms, press to one side to pass his guard.	Travis Tooke	316	3	8	3	\N	\N	7HEoKDLtFoI	1	2	2008-01-19 06:00:00+00	\N	\N
1	1	Double Lapel Choke Block	From mount or guard, your opponent can set up a double-lapel choke. The double-lapel choke has one hand on each side of\nhis neck reaching deep into the collar. One arm is over the other making an X on your chest. Note their bottom arm! You\nneed to spot this quickly to prevent getting choked! Assume his right arm is the lower arm in this drill.	1.  Reach your left arm sideways over his lower arm and thread it between his upper and lower arm.\n   2. Turn your body and head to the right as you force your arm through.\n   3. Reach your left palm behind your head (like the "rear choke" augmenting arm) once you have it through. Keep\nlooking to the right.\n   4. The choke should be blocked, but you can get extra strength by pressing your left elbow into his right bicep/crook\nof his elbow.	\N	218	1	6	6	\N	\N	\N	4	1	\N	\N	\N
3	1	Double Lapel Choke from Top	you have knee on chest or in mount	1.  Grab his near side lapel with 4 fingers DEEP\n   2. Grab his far side lapel over the other arm thumb-in DEEP. Push the thumb to the ground.\n   3. If your knee is on his chest, sprawl out now.\n   4. Twist both palms toward your face and pull your elbows DOWN toward your hips, NOT out. A common mistake is to pull\nyour elbows out. You have much less strength when you pull your arms away from your sides.	\N	168	1	4	4	\N	\N	\N	6	1	\N	\N	\N
3	17	Quad Crush from Reverse Knee Guard Pass	You are inside open guard and attacking their right leg	1. Details coming	David Thomas	320	3	8	15	\N	\N	nD6XRahhXcQ	6	2	2008-01-19 06:00:00+00	\N	\N
6	7	Double leg Take-down	Like all wrestling takedowns, this is done best fast and explosive, even if it is taught slow in steps.\nThe fundamental steps of all takedowns include:\n1. Set up \n2. Lower level\n3. Penetration step\n4. Power drive\n5. Control after the takedown\n\nIn this takedown, you are driving in with your left foot first, assuming you have a standard stance (left \nfoot forward). Make sure you are close enough to touch his chest with an outreached arm.	1.  Shuffle-Step in between his legs with front leg. Your forehead is toward him with your shoulder \nshrugged in to protect from Guillotine.  \n2. Chop behind his knees with both hands and hug tight\n3. Push forward until your inner knee hits the floor. This pushes him off balance. Tighten your arms\n4. Step the rear leg up on the outside as you further tighten and drive him sideways. Push your head \nagainst his side\n5. Sweep his legs up high, driving your head against his side HARD.	\N	88	3	5	3	\N	\N	08KtDDENU_M	5	1	2008-01-19 06:00:00+00	\N	\N
5	5	Spider Guard	This is a good position for setting up the Biggie Slicer or a sweep.	   1.  Grab both sleeves or both wrists\n   2. Each leg wraps from the outside of his arm driving your foot into his armpit behind his shoulder\n   3. You can also do a half-spider guard, but be careful about getting your guard passed on the other side.	\N	44	3	1	1	\N	\N	\N	8	1	2008-01-19 06:00:00+00	\N	\N
3	1	Gogo Plata from Guard	Your opponent is in your open guard.	1. Start the same way you would an omo plata. Grab his right wrist with your left hand and press it around your left\nthigh toward the ground as you bring your left leg forward, pressing against his right triceps. \n2. Drive your left foot under his chin\n3. Reach behind his neck with your left hand and grab your left foot around the big toe.\n4. Press your right foot into your left ankle to strengthen the pressure under his neck as you reach your right hand\nbehind his head. \n5. Pull with both hands on his head as you press your left ankle under his neck with your right foot. His head will\n"fold" over your shin under his neck, choking him.	\N	317	3	1	15	\N	\N	vLcyxlkoDr0	8	3	2008-01-19 06:00:00+00	\N	\N
2	1	Escape Vice Choke to Armbar	He has you in the side control or knee on chest (from your right) and set up the Baseball choke a.k.a. bat choke a.k.a.\nvice choke and is about to choke you out!	1.  As in most choke blocks from this position, place your right hand, palm up under his right elbow with \nyour right elbow against the floor. This is the most important part of this block, but really only will buy you \na second before you get choked against a strong or highly skilled person.\n   2. Grasp his right forearm with your left hand and press it to your chest. Now both hands are firmly \ngrasping his right arm. The choke is completely blocked!\n   3. Throw your left leg over his head and extend your hips to arm bar his right arm.	\N	216	3	6	15	\N	\N	azWg2-xtfks	3	3	2008-01-19 06:00:00+00	\N	\N
1	1	Vice Choke Escape Using Angry Sweater to Gazoni	You are getting vie choked (also known as bat or baseball choke in Gi BJJ) from your right side.	1.  Your right hand hugs his right forearm just below his elbow. This will buy you a moment to continue without getting\nchoked out.\n2. Your left hand grabs behind his left triceps\n3. Pull his left elbow over to reverse him as in the Angry Sweater.\n4. As you roll away from him switch from an angry sweater grip to a overhook clamp, similar to the Gazoni in wrestling.\nThis is stronger and will overcome him sprawling away as he feels himself going over.	David Thomas	163	3	6	3	\N	\N	pzLfF85wy_A	3	2	2008-01-19 06:00:00+00	\N	\N
3	4	Knee bar from half guard	You are in his half guard. Your left leg is trapped.	1.  Push your right palm hard on his left bicep. This will keep him from sitting up.\n   2. Reach your left hand and grab his left ankle (the one that is between your legs)\n   3. Step up on your left leg (the trapped one)\n   4. Grab behind his hamstring with your right hand and quickly roll to your right to sink the leg lock.	\N	156	3	8	15	http://austinjiujitsu.com/ajj/pictures/Techniques/Dave-kneebar.jpg	1	t5Ask8X9cO8	2	3	2008-01-19 06:00:00+00	\N	\N
2	5	Pancake Guard Pass	You are in his open guard. You will be passing to your left.\nI have heard this called the "Black Belt Pass," but since it's not an advanced move, I'm not sure why it is referred to\nthat way.	1.  Left hand grab inside and slightly below his right knee, (no-gi: press his leg to the floor with your palm)\n   2. Right arm scoop deep under his left thigh, (gi: grabbing his belt behind him)\n   3. Quickly sprawl all your weight on this right thigh. Your head should be low near the ground over his thigh. Almost\nlike a tripod.\n   4. Pull his other leg down hard to your side toward your feet.\n   5. His legs should be beat now. Step over to your left.\n   6. If he tries to block by pulling on your shoulder that you have planted his thigh, you can easily change directions\nand pass in the other direction (under his leg Stacking Pass using your shoulder).	\N	51	3	8	3	\N	\N	wnqB1ffGDGk	1	2	2008-01-19 06:00:00+00	\N	\N
6	8	Scissor sweep	He is in your guard	1.  Turn to your left side and grab behind his neck with your right arm (gi: grab collar)\n   2. Push your right knee into his midsection. \nTrap his right posting arm by wrapping around it above the elbow.\n   3. Left foot either pushes his knee down (straightening his leg, collapsing him to that side), OR sweeps HARD under\nhis right knee with your left heel (causing his knee to sweep under him)\n   4. At the same time kick your right bent knee across his midsection and bridge to mount as he falls over.	\N	99	3	1	4	\N	\N	1SY7efayZAU	8	1	2008-01-19 06:00:00+00	\N	\N
3	4	Spinning Kneebar from Inside Guard	You are in his open guard with your right knee up in between his legs (I call this "position 2"). Keep him back.\nYou will be attacking his left leg.	1.  Reach through your right knee with your left hand and grab his left leg inside the knee.\n   2. Press inside his right knee with your right hand. You will reach over your own right knee to do this.\n   3. Pick up your rear and quickly rotate 180 degrees to your left, pulling his left leg in between your legs. Sit \non his left hip as you clamp his left leg.\n   4. Kneebar.	\N	157	3	8	15	\N	\N	Tf-bcTVvVls	1	3	2008-01-19 06:00:00+00	\N	\N
6	8	Fake Armbar Sweep	This sweep has a nearly identical setup to a basic armbar from guard. It looks so much like it that I call this the fake\narmbar sweep. \nYou are holding him in your guard and will be sweeping him to your right.\nNote: the video for this technique shows it as a follow-up to a failed scissor sweep, but that is just an option. This\nsweep is most effective from the armbar setup, as its name suggests.	1. Grab his left wrist (gi) or behind his elbow (no-gi). Keep hold of this through the technique. \n2. Open your guard and put your right foot on his left hip\n3. Turn 90 degrees to your left by pushing off his hip. Clamp your left leg under his right armpit. Make sure his chest\nis resting on the bottom of your left thigh.\n4. Reach under his right thigh with your left hand and grasp under, palm up. \n5. At the same time as #4, take your right foot off his hip and swing your right leg far past his head\n6. Swing your right leg down toward the floor away from you as you extend your left leg and "shot put" his right thigh\naway with your palm. This means 3 parts of your body are imparting motion to your opponent to throw him. \n7. Follow up to mount	\N	315	3	1	4	\N	\N	nm9DbqwQj88	8	2	2008-01-19 06:00:00+00	\N	\N
2	5	X Pass or Bullfighter Pass	You are standing in his open guard, passing to your left.	1.  Grab opponents pant-legs at the inside of his knees with thumbs pointing down. Alternative: grab inside his right\nknee and grasp his left ankle (this will reduce his mobility)\n   2. Drop one arm low (drop his leg down low)\n   3. Step to your left (toward his right side), blocking his right shin with your right shin.\n   4. Take side or put right knee on stomach	\N	56	1	5	3	\N	\N	SlL9gBmuxbA	1	1	2008-01-19 06:00:00+00	\N	\N
3	4	Knee bar from standing - Super fast	You are both standing. This is my favorite knee bar. When drilled hard, you can sink it from a standing position in one\nsecond.	1. Pull his right arm with your right hand to your right side so his arm is pulled across his body. This takes a posting\nadvantage from him.\n2. At the same time you are pulling his arm, sit with your left leg deep between his legs so he is standing over you.\n3. Grab behind his right knee  from the inside with your left leg.\n4. Pull on his trapped leg as you roll back. Put your right knee deep into his right hip.\n5. As he falls forward, sink the leg lock	\N	158	3	5	15	\N	\N	DHSPadLxhZ8	5	3	2008-01-19 06:00:00+00	\N	\N
3	4	Rolling Kneebar from Standing ??? Rear	He is behind you, hugging low around your hips. Before you start, always make sure his hands stay low by pressing both\nof your hands against his wrists. If his arms go high, and he's strong, you may not be able to bend over and execute\nthis technique.\n	1. Drop your left shoulder to the floor (don't smack your head on the ground!) and reach between your legs to grab his\nright leg behind his knee. Since you are reaching between your legs for his right leg, you are pretty much guaranteed\nthat his right leg will be trapped between your legs as you complete this technique. \n2. Roll forward strongly, kicking your legs over to press momentum forward and force him to fall\n3. Drive your feet to the ground as you roll. This helps extend his leg and position the kneebar.\n4. Clamp your thighs together and pull the kneebar	\N	322	3	5	15	\N	\N	t7CrSuQgd9A	5	3	2008-01-19 06:00:00+00	\N	\N
3	4	Rolling Knee Bar from Turtle	You are in the turtle position. He is behind you trying to gain control.	Look under your legs. If you see his leg, dive under yourself, shooting both arms deep behind his knee as you roll.	\N	153	3	9	15	\N	\N	\N	7	1	\N	\N	\N
3	1	Triangle Escape by Standing	You are getting triangled	1.  Grab his lapel. This may prevent him from converting to armbar.\n   2. Look up\n   3. Stand and shake. The triangle should break, but his feet may not open completely.\n   4. You may have to manually open his feet behind his neck to get him off.	\N	192	3	8	5	\N	\N	\N	15	1	\N	\N	\N
3	1	Forearm Crush Rear Choke Escape	He is reaching his arm across your neck to start a choke.	This doesn't always work, but you can sometimes get just enough time to escape if you put both hands behind your head,\ntense your neck and pull your chin into his arm.	Vandry	183	3	11	11	\N	\N	Y3AxswVrpnw	15	2	\N	\N	\N
6	8	Sickle Sweep to Kneebar	You have him in open guard with both feet on his hips. He is standing over you. You will be attacking his left leg.	1.  Hold his right sleeve with your left hand. Keep hold of this until you begin to execute the submission at the end.\nYour grip here will help you transition as he falls. \n2. Turn your left foot to the right, maintaining position on his right hip. It should be pointing toward his center. \n3. Drop your right leg between his legs\n4. Turn to your right side and hook your right palm on his left heel\n5. Simultaneously push his hip with your left foot, pull his left foot toward you, and "chop" him down by sweeping your\nright foot behind his right heel. As he falls, the grip you have on his sleeve will act as a "tow rope" to pull you up\nto your knees, speeding up your transition to knee bar.\n6. You should be able to grab his leg and roll over to kneebar him.	\N	101	3	1	15	\N	\N	DL0ORjMcZ1I	5	2	2008-01-19 06:00:00+00	\N	\N
3	4	Single Leg Takedown to Kneebar	You are standing, prepared for a shoot. You will be attacking their right leg.	1. Execute a single leg (see related technique)\n2. Dump him on his butt and keep control of the leg\n3. Drive your left knee into his right hip as you rotate to the right\n4. Pull his leg in between your legs as you sit down close to his hips. \n5. Clamp your thighs and bridge	\N	323	3	5	15	\N	\N	E5-s5cEAFDA	5	3	2008-01-21 06:00:00+00	\N	\N
3	4	Knee crank from guard pass	You are in his open guard. You are attacking his right leg.	1.  Stepping to your left slap his right foot from the outside in (to your right) with your left hand\n   2. Scoop his right leg behind the knee with your right arm at the same time you trap his foot behind your right knee.\nThis is critical.\n   3. Drive your left knee into his hip\n   4. Sit back as you pull your right arm to your chest (vertically) - assist with left hand Gable grip	\N	159	3	5	15	\N	\N	QiuCQjs5vU4	1	2	2008-01-21 06:00:00+00	\N	\N
2	8	Hook Sweep Sprawl Escape to Arm Triangle	He is sprawling his weight on your back. You can't reach his legs. Assume you can't get up. Your back isn't strong enough.	This is hard. He is heavy and you are crushed. Work!\n   1.  Move your head to the left under his right armpit and crane your neck back. Important!\n   2. Look up to sink your head into his armpit. This keeps him from cross-facing you\n   3. Sit back, slowly pulling your legs underneath you. This is going to stretch your head forward somewhat.\n   4. Sit back into a sweeping position. Hold his posting arm so you can immediately sweep before getting stuck on your\nback.\n   5. You can either sweep him or arm triangle him from here.	David Thomas	97	3	8	1	\N	\N	1gwDrYTLV58	7	2	2008-01-21 06:00:00+00	\N	\N
3	1	Arm triangle (Pillow Choke) from side	You are holding him in side control hugging him with one arm under his neck and the other under his far shoulder. You\nare on his right.	1.  Throughout this move you are going to use your head to control his left arm. Keep it low and close.\n   2. Scoop his left arm with your right arm low on his triceps near his elbow -- this location is important\n   3. Strongly drive his left arm up with your right arm and hug his head. Your right palm must grasp his head on his\nright side.\n   4. Clamp his left armpit with your left hand (the hand that was under his neck). You are now basically hugging the\ncrap out of his head.\n   5. Use your head to help trap his arm. Keep very low against his face\n   6. Right knee on his stomach - switch sides and end up on his left side with your left knee on his stomach. Drill\nthis! Good BJJ students should be able to flow through this position.\n   7. Use your head to get his left arm as low down his face toward his neck as possible. The left side of your head\nshould be touching the left side of his head.\n   8. Get your arms into "rear naked choke position" (i.e. clamp your right biceps with your left hand and place your\nright palm against your right ear\n   9. "Tripod up" on your right foot so you are driving your weight into his shoulder/neck. Squeeze your arms. This will\neither neck crank or pillow choke him. Eddie calls this an "arm triangle."	\N	250	3	3	15	http://austinjiujitsu.com/ajj/pictures/Techniques/Teaching-arm-triangle.jpg	1	rWu32GbjI0A	6	1	2008-01-21 06:00:00+00	\N	\N
6	8	De La Riva Knee-turning Sweep	He is in your open guard. He is standing	1.  Grab both sleeves and raise your hips on to his right knee.\n   2. Grab his right heel with your left hand.\n   3. Grab his right sleeve with your left hand\n   4. As you bridge to your left shoulder, thread your left leg behind his right leg and in front of his left leg. Put\nyour right foot on his left thigh.\n   5. Drive both legs straight forward, he will be forced to the ground. This is caused by great pressure put on his\nright knee.	De La Riva	201	1	1	1	\N	\N	\N	5	1	\N	\N	\N
5	5	De La Riva Guard to Back Control	He is standing in your open guard.	1.  Grab his right sleeve with your right hand and pull to your right\n2. Wrap your left leg around his right thigh and drive your foot in front of his left thigh.\n3. Fish your right hook around the side of his right knee\n4. Take his back, pulling him down to you	De La Riva	199	1	1	12	\N	\N	i7MkUAFl_bY	5	2	2008-01-23 06:00:00+00	\N	\N
3	2	Attacks from Kesa Gatame - 3 variations	You have him in kesa gatame on his right side you have underhooks with your left arm and have his right arm controlled\non your near side.	1. Americana: If his hands are not locked around you, press his right wrist to the ground with your left hand. Put his\nwrist under your right ankle. You should be able to tap him with a slight drag of your right ankle to the left (toward\nhis feet). If that doesn't tap him, you can press his right elbow towards his head with your left hand. Generally, if\nelbow pressure is needed, you didn't get his wrist out far enough down your leg. \n2. Armbar. If his hands are not locked around you, grab his right wrist and drive it under your left thigh. Rotate your\nright knee towards the ceiling as you drop your left thigh to the floor. \n3. Kimura: If his hands are locked around you, and you are lacking the right underhook, you can get a great, unique\nshoulder lock on him. You have to see the video to believe this is possible, since it sounds like it would never work. \na. Reach your left forearm under his elbow in the same way you reach under a guy's heel to heel hook him (you are\n"grabbing with your forearm"). \nb. S grip your hands together\nc. Lift his elbow to your face by squeezing and pulling both of your hands up. Ka-Tap!	David Thomas (kimura variation only)	319	3	13	15	\N	\N	S7h3e-BWJt4	6	2	2008-01-19 06:00:00+00	89	1
2	5	Reverse Knee Guard Pass	He has you in open guard or half guard. This is a good alternative to the Basic Guard Pass if he presses against your\nknee as you drive it over his thigh.	1. Drive your right knee over his right thigh.Press his right leg to the ground.\n2. Grab his right sleeve or arm with your left hand\n3. Step your left leg around his right leg, maintaining your right knee.\n4. Grab under his left armpit with your right hand, grasping over his shouder. This underhook is crucial!\n5. Slide your right knee into the floor and move to Kesa Gatame. I call this sliding into home base.\nThis position is more difficult to get with wrestling shoes on. He can trap you in half guard.	\N	72	3	8	13	\N	\N	nR5J9VC4Wlo	1	1	2008-01-19 06:00:00+00	\N	\N
3	2	Triangle to Armbar from Guard	You have him in guard. You will be attacking his right arm	1. Triangle (see related technique)\n2. Keeping your legs clamped and hips close to his head, bring your left leg across his face and execute an armbar from\nguard.	\N	185	3	1	15	\N	\N	clmu1u3fGv0	8	2	2008-01-28 06:00:00+00	\N	\N
3	4	Hook Sweep Knee Bar	Opponent is attempting to pass your guard. You have on leg inside. Same setup as Hook Sweep. You have your instep under\nhis thigh. He thinks you are going for the sweep. Assuming you have your right instep under his left thigh.	1.  Grab his pant-leg at the ankle with your left hand going under your right leg. Envision this: you are setting up\na kneebar, so you need to be able to pull his leg through your legs.\n   2. Grab around his back to continue the feint\n   3. As you roll back, you will PULL his leg through yours and immediately clamp his leg in between your with figure 4\n   4. Hands to his heel; pull kneelock	\N	154	3	1	1	\N	\N	SLF47RdtoKY	8	3	2008-01-23 06:00:00+00	\N	\N
3	1	Triangle from Mount	You have mounted your opponent.	1. You need to get one leg over his shoulder. There are several ways to do this. Sometimes, he'll dig one \narm under your\nleg while attempting escape. Other times, you'll need to control one of his arms and step over. In this \ncase, assume his\nleft arm is on the inside.\n2. Step your right foot over his left shoulder. \n3. Sit off of him to your left. \n4. See referenced technique for triangle details.	\N	325	3	4	15	\N	\N	E8bimFhtdiU	6	2	2008-01-29 06:00:00+00	\N	\N
3	1	Double Lapel Choke from S-Mount Armbar Setup	The S-Mount. You will be attacking him as if you are going to armbar his right arm. See the referenced technique for setup.	1. Drive your right hand into his right lapel\n2. Put your left thumb into the lapel on the other side and turn your wrist in\n3. Lean forward as you pull your hands up.	\N	326	1	4	15	\N	\N	l80FTfcDDm4	6	2	2008-01-31 06:00:00+00	\N	\N
3	1	Rolling Loop Choke from Sprawl	You are on his back sprawling on him.	1. Reach your left hand under his chin, grabbing his lapel on his left side\n2. Reach your right hand behind his left armpit and pull his left arm toward you.\n3. Roll to your right, diving your head under his left armpit\n4. Drive your right hand behind his head\n5. Come up to your knees and pull your left hand	\N	327	1	7	15	\N	\N	8o_6vzkL7oE	7	2	2008-01-31 06:00:00+00	\N	\N
2	10	Escape from Knee-Up Mount	He is mounted in the knee-up mount with his right knee up. If he grabs your lower elbow, you can't do this move.	1.  Jiggle to your left side so you are not flat on your back. Drop head to mat to prevent choke; Pull arms in to\nprevent armbar\n   2. Coil your legs up to get your feet planted. As stated in the setup, if he grabs your lower elbow, you can't do\nthis move. You will need to use your coiled legs to roll to the other side and preposition for mount escape on the other\nside.\n   3. Use your planted feet to lift your hips\n   4. While your hips are up, slide your lower elbow under your body to get your palm around his planted heel\n   5. Clamp his heel and press it out as you push your hips back\n   6. Hook your upper instep behind his upper knee\n   7. Plant bottom foot and kick top foot out and escape	\N	38	3	6	1	\N	\N	\N	4	3	\N	\N	\N
2	9	Escapes from Kesa Gatame	He is holding you in right Kesa Gatame. This only works if his has his weight on you. It''s even easier if his weight is\nslightly overcommitted, which he will do if he''s trying to crush you.	There are a bunch of escapes: \nOption 1. Press your arms into his face and bring your left leg across his face\nOption 2. This is too easy to believe, but you should try it: bridge, then roll away to your left. It works!\nOption 3. If he "runs away" as you try to get your hips close, press into him "loading him up" then switch directions\nand bridge. Aw, heck, look at the video...	\N	27	3	6	3	\N	\N	G89T-SVVY5M	13	2	2008-02-14 06:00:00+00	\N	\N
2	9	Twister from Escape from Kesa Gatame	The Kesa Gatame side control is a major pain to get out of. There are a couple of well-know escapes that most good\nfighters can prevent. This escape is almost pure money since it isn't well known. \nIn this situation, you are trapped in a right kesa gatame side control.	1. Like the common "rolling bridge escape," you need to get your hips close to your opponent. Get close and capture his\nleft leg with your left leg by hooking your heel over his thigh. This could be a tough scramble if he's "running away\nfrom you."\n2. Immediately lock down his left leg by fishing your left instep behind your right knee and your right instep behind\nhis left heel. This will probably be very tight. This is a tough technique that assumes you can throw a lockdown on a\nguy very quickly in a tight spot.\n3. Since his right arm is already behind his neck, keep that trapped by arching your head back. Note: in the image\nbelow, I don't have this position. Tsk, tsk!\n4. Reach around his head with both arms and pull his head while you tighten the lockdown. Ka-twist!	David Thomas	288	3	6	15	http://austinjiujitsu.com/ajj/pictures/Techniques/Kesa-escape-twister2.jpg	1	aDEel-FXlso	13	3	2008-02-14 06:00:00+00	\N	\N
3	1	Baseball Choke or Bat Choke	This is called a baseball choke because the position of your hands on his gi lapel behind his neck is just like gripping\na baseball bat. This works without the gi also, but the grip is obviously different. I works from a control position\nlike side control, or knee on chest. In this example, you are choking with a on his right side.	1.  Reach your right hand, 4 fingers in, inside his gi collar very deep on the far side.\n   2. Reach your left hand, thumb in, inside his gi collar on the near side\n   3. Drop your right elbow across his throat as you move your weight off him. This allows you to put all your weight on\nyour elbow which puts pressure on his neck (via your right forearm).\n   4. Sink the choke by twisting your grip "in." In other words, pull your wrists together so your thumbs meet and pass.\nThis tightens the choke.	\N	162	1	3	3	\N	0	OaHLhRLoOTw	6	1	2007-12-23 06:00:00+00	70	1
3	1	Triangle Choke	he is in your guard	1.  Grab his right sleeve with your left hand.\n   2. Put your right foot on the inside of his left elbow.\n   3. Work the foot up to his shoulder\n   4. Simultaneously pull his right arm and extend your right leg over his neck.\n   5. Turn your body out to your right, like in an armbar (so your are almost perpendicular to him)\n   6. Put your right foot behind your left knee and squeeze\n   7. Some people like to grab behind his head and pull in toward you. It helps, but isn't always necessary\n\nHere are other setups for triangle:\n    *  From guard - Hold both of his wrists and push off both of his hips with your feet. This will give you the room to\nthrow a leg over.\n    * From guard - Put one foot on the inside of one of his elbows. Work the foot up to his shoulder, then over his neck.	\N	184	3	1	15	http://austinjiujitsu.com/ajj/pictures/Students/Grappling082406002.jpg	1	ors0aT9jd9g	8	1	2008-02-19 06:00:00+00	\N	\N
3	1	Scarf Choke	This choke is best executed from knee-up mount. \nHe is on his side and you have your right knee up mount. \nThis is not to be confused with the "scarf hold," also known as kesa gatame.	1. Push his right elbow towards his head with your right hand \n2. Grab his right wrist with your left hand behind his neck. His arm is now a "scarf" around his neck.\n3. Drive your right hand under his right forearm between his neck and his arm. Grab your left forearm with your right hand.\n4. Press both hands away. The leverage under his arm will force your left hand into his neck, choking him.	\N	324	2	4	15	\N	\N	R3En98hVCr0	6	3	2008-01-29 06:00:00+00	\N	\N
2	1	Triangle Escape to Choke	You are getting triangled, but your arm is not across your neck. This is much easier with the gi, but can be done no-gi\nalso.	1.  Pin his arm at his biceps to prevent him from pulling your head down\n   2. With your arm that is inside the triangle, grab his opposite lapel and push forearm across neck (elbow to floor)\n   3. With your other arm, grab his pants under his butt and lift his body weight over his neck. This will choke him.	\N	191	1	8	1	\N	\N	\N	15	2	\N	\N	\N
5	5	Mission Control - Rubber Guard	Opponent is in your closed guard.	1.  Pull him close by sitting up and pulling him down\n   2. Place your right foot on their left hip\n   3. Put your left calf high across the back of their neck\n   4. Hook your wrist behind your left ankle with your right wrist\n   5. Hug your left knee with your right hand\n   6. Optional: Cross your feet, if you can\n   7. Hold tight!	Eddie Bravo	219	2	1	1	http://austinjiujitsu.com/ajj/pictures/Women/Working%20the%20rubber%20guard.jpg	1	hc5zImDLQ7k	8	2	\N	\N	\N
3	1	Mission Control to Gogo Plata choke	Mission Control rubber guard	See related technique and video below.	Eddie Bravo	329	2	1	15	\N	\N	a88JI2yJ2QA	8	3	\N	\N	\N
3	1	Ham Choke from Under a Stacked Arm Bar Defense	You are trying the arm bar from the guard and he stacks you. The more weight he has on you, the better! I made this up\nrolling with Adam 3/2002	1.  Reach around behind his neck and grab his lapel tight\n   2. As you pull your calf into his neck (tightening your hamstrings to flex your leg) pull down hard on the back of\nhis lapel.	David Thomas	173	1	1	1	\N	\N	tUJG7JLFZCQ	8	3	\N	\N	\N
3	1	Choke Armbar Combination from Mount	\N	1.  Drive 4 fingers of your left hand deep behind his neck on his left side, under his lapel and grab.\n   2. Pull your left elbow tight against his chest. This puts pressure on him and makes it harder to block. You have\nlost your left posting arm, so you should always lean toward the right to compensate for this.\n   3. He will immediately begin to block this, sensing a choke\n   4. Drive your right knee higher up under his left shoulder and press his left elbow to your left. This isolates his\nleft arm for potential armbar.\n   5. Drive your right thumb deep under the lapel behind his neck on his right side and grab\n   6. To choke, lean forward until your head touches the ground, pulling hands together	\N	195	1	4	15	\N	\N	\N	6	2	\N	\N	\N
5	5	Lock-down Half Guard	Your opponent is on top of you. You have the half guard. Assume you have his right leg. The Lock-down is a half-guard\nthat is very tight. It is the way Eddie Bravo clamps the leg when setting up many positions.	1.  Get the underhooks: put your left arm under their right armpit and hold the back. If you can clamp both hands\nthis way, great.\n   2. Put your outside leg (your left leg) over the back of his calf.\n   3. Put your left instep behind your right calf\n   4. Put your right instep behind his right foot\n\nSlide this hold as low as possible on their leg. You might get a calf crush this way. Optimally, you should also have\ndouble-underhooks (both arms under his arms hugging him).	Eddie Bravo	224	3	2	2	\N	\N	4J-Avq3u804	8	1	2006-11-15 06:00:00+00	\N	\N
3	1	Reverse Guillotine Choke	This is executed when his head is in the middle of your chest, unlike the traditional guillotine.	1.  His head is in the middle of your chest such as in a clinch.\n   2. Reach your left arm across his body, under his chin to his left ear\n   3. Grab his head with your left hand and pull it to your chest\n   4. Reach your right arm over his head and grab your right biceps with your left hand\n   5. Reach your right arm across to choke	Igor Gracie	171	3	5	5	\N	\N	XNA0hvJXN_0	5	2	\N	\N	\N
3	1	Dave's Guillotine Escape	He is guillotining you with his right arm. I created this escape with the help of lots of students and partners who were\nhappy to keep attacking my neck when I shoot! :)	1.  Reach your left arm around his left hip (across his body) and your right arm over his right shoulder\n   2. Drop to the floor, sitting your butt directly under him. You feet go out to your right\n   3. He will come down with you\n   4. Put your head down and bridge and roll away from him. He will roll over you with the guillotine still in place\n   5. Step over (flop) to your left, putting him in side control.\n   6. Press your head back to open his guillotine and escape. You should be able to pillow choke (arm triangle) him if\nyou track his\nchoking arm with your head.	David Thomas	170	3	16	3	\N	\N	mX4x2irlVLo	15	3	\N	\N	\N
4	13	Sit Out - Getting out from under a sprawl	Imagine you are trapped under an opponent's sprawl. You are on all fours and he is on your back. Your goal is to "sit\nout" from under him. \n	1. Starting on your hands and knees, pick up your left arm against your chest (imagine grabbing his arm wrapped around you)\n2. Step your right foot all the way through the pocket between your left arm and left leg.\n3. Imagine your head going out your opponents right armpit (to your left). This is crucial. If your head doesn't end up\noutside his armpit, he will end up with a side control.\n4. As you sit out to your left make sure you land on your feet and shoulders (bridge). This is important in that it puts\nthe most weight on your opponent's back. \n5. Get back on all fours and repeat\n\nNow drill it with a partner. Be careful with his shoulder as you sit out. Make sure you keep lots of pressure on it with\na bridge, but if you explode through the move, you could injure his shoulder.\n\nAnother idea is to alternate this move with the compass "turn in" drill. It will make you dizzy, but is a good drill!	\N	309	3	7	6	\N	\N	\N	17	1	2008-05-19 05:00:00+00	\N	\N
4	13	Compass Drill - Practicing the Turn-in	This is a great drill to build explosiveness and prevent getting your guard passed. It really hammers home the\nimportance of a strong, square base. \nThe drill takes the student from their back to front to back quickly, around the points of the compass. Start on your\nback with your arms to your sides. Assume your head is pointing North at the beginning.	1. From your back, turn to your stomach to your left, 90 degrees. Now you are pointing East.\n2. From your stomach, turn to your back and end up with your head facing South. \n3. From your back, turn to your stomach to your left, 90 degrees. Now you are pointing West. \n4. Repeat step 2, ending back North.\n\nTry the turn-in with a partner as they go to pass your guard. Turn in and grab the single leg takedown.\nTry the turn-in with the sit out, alternating. It will make you dizzy, but it's a good drill!	David Thomas	308	3	6	6	\N	\N	\N	17	1	2008-05-19 05:00:00+00	\N	\N
2	5	Hip Hugger Cartwheel - Butterfly Guard Pass	You are inside his butterfly guard	1. Overhook both arms around his upper thighs and S Grip behind his butt. Make sure he can't underhook your arms or\ncross face (keep very tight)\n2. Driving your shoulder into his hip and "cartwheel" by bringing your legs and torso vertically over his hips. He will\nbe able to track your hips with his butterfly instep position until you get to about 70 degrees, but once you are over\nhim, he'll lose connection.\n3. Twist to one side or the other (whatever side you want side control on) and drive you trailing knee into his thigh to\nprevent him sneaking a leg in. For example, if you are passing to his left side (to your right), you will block with\nyour left knee.	Travis Tooke	331	3	8	3	\N	\N		6	3	\N	\N	\N
2	5	Shin Ride Guard Pass	You are standing inside his open guard	1. Detail needed - Dave checking his notes!	Travis Tooke	332	3	5	3	\N	\N		6	3	\N	\N	\N
2	11	Shrugging Rear Mount Escape to Brabo Choke	You are seated with him behind you in a seated rear mount. He has you in a body lock with his right arm over your right\nshoulder gripping his left hand under your left armpit. You are in immediate danger for a choke	1. Shrug your right shoulder and place your right palm under his right elbow\n2. Dig your left thumb under his right wrist and grip his wrist\n3. Lean to your left an shrug out from under his right arm as you press your right hand up and your left hand down\n4. As soon as you are out, grip his right triceps with your left hand and press your head to the left to trap his right arm\n5. Shed his right hook as you turn to your left\n6. Grab his head with your right arm and pull it to you as you jam your left forearm under his neck\n7. Sprawl on his right shoulder as you grip your right biceps - this will choke him	David Thomas	334	2	11	15	\N	\N		12	3	\N	\N	\N
3	1	Brabo Roll to Brabo Choke	I discovered this roll and choke combo on my own only to discover it already had a name! This works great from either\nthe back (he's on all 4s) or a side control where he is facing you (lying on his side)\n\nFrom his back with you on his left side.	1.  Reach under his chest through his left armpit with your right arm all the way through to his neck near his right\nshoulder\n   2. Grab his neck with your right palm\n   3. Gable grip your hands with your left forearm behind his neck.\n   4. Roll him over his neck to land on his side by pressing on the back of his head. This causes his head to buckle\nunder and his body will follow over\n   5. When he falls over it is critical that his left arm be trapped in your armpit. It should naturally go there, but\nif it doesn't you can adjust it quickly with your left palm.\n   6. Squeeze with gable grip or grab your left biceps with right hand to choke. This is just like an upside down arm\ntriangle.	David Thomas	177	3	7	15	\N	\N	IPT5H22fFSo	7	3	2008-03-05 06:00:00+00	\N	\N
3	1	Clock Choke - 2 lapels	You are controlling him from his back	1.  With your right hand, reach under his right arm and feed his right lapel to your left hand, which is under his\nleft armpit (hugging from behind)\n   2. Grasp his right lapel with your left hand\n   3. Reach around under his chin with your right hand and grab his left lapel\n   4. Come off his back and walk around to near his head. Your ribcage is keeping pressure on him as you walk around\nhim. It is the axis of rotation.\n   5. Tighten choke as you walk around. Press your head to the floor over his left shoulder.\n   6. Say goodnight.	\N	165	1	7	15	\N	\N	kA7muHEIN5E	9	2	\N	\N	\N
3	2	Rolling Armbar from Rear Mount	You have the rear mount. You will be attacking his left arm.	1. Scoop your left arm under his left armpit - keep control\n2. Pivot your body to the left so your head can come to the mat on his left side\n3. Turning your head to look at his feet, scoop his left arm with your right arm also\n4. Drive your right leg across his face\n5. Grab his ankle with your left hand as you begin to roll to your left\n6. Pull his ankle toward you as you roll left, forcing him over. Maintain control of his arm\n7. Finish the armbar as he rolls to his back	Robert Drysdale	335	3	12	15	\N	\N	mrcjnrIojSo	7	3	\N	\N	\N
3	14	Elbow on Chest Crush with Neck Crank	You are holding him in side control on his right side. You can also do this from knee on chest. This is a combination\nneck crank and chest crush.	1.  Grab his armpit with your right hand.\n   2. Grab behind his neck on his gi with your left hand. Dig deep and straighten your arm to push his head forward.\n   3. Pull your right elbow high up on his chest grasping his triceps.\n   4. Pull up on your left hand and drive down with your right elbow. Zowie!	Vandry	197	1	3	3	\N	\N	gRwv3vp6A1U	6	2	\N	\N	\N
3	1	Head Tilting Choke	You have a rear mount on him and are working on the double lapel choke. \n1. You have our right hand around his neck grabbing his far lapel\n2. He is blocking the other hand coming under his arm and clamping your choking hand, limiting your ability to finish\nthe choke.	1. Grab the top of his head with your left hand and pull to your left.	David Thomas	336	1	12	15	\N	\N	tTGczKeUG-U	11	3	\N	\N	\N
3	17	Arm Control Sweep to Arm Crush	He is in your open guard. You will be sweeping him to your left and attacking his right arm.	1. Grab his right wrist with your left hand. Keep a tight grip.\n2. Underhook his right arm, just above his elbow, with your right hand and press his right hand down toward your hips.\nThis is a key control point. Keeping his wrist low and his elbow forward gives you significant mechanical advantage. \n3. Pull his right arm in as you lean to your left shoulder. He will fall to your left.\n4. Position your right wrist, "sharp edge" up, under his right triceps. Sprawl on his right biceps to crush.	David Thomas	338	3	1	15	\N	\N	GpXACHzwXKg	8	3	\N	\N	\N
3	1	North South Choke	This is a great choke that champions like Marcelo Garcia have found great success with. \nYou are holding your opponent in north south position.	1. Reach your left arm under the back of his neck\n2. Twist so his chin is in your left armpit\n3. Grasp your left wrist with your right hand\n4. Turn your hips out to your right like you are going into kesa gatame. Squeeze! Another variation is to "sprawl back"\nand squeeze.	\N	285	2	10	15	http://austinjiujitsu.com/ajj/pictures/Techniques/North-South-choke.jpg	1	05OVdKtj0OA	6	3	\N	\N	\N
3	1	Gator Roll Choke	This is best set up from sprawling on your opponent when they attempt a takedown.	1. Sink your right arm deep under his chin like a guillotine, but rather than just under his neck, you drive the arm all\nthe way through his right armpit. \n2. Grab your left biceps with your right palm and bend your left arm 90 degrees. Make sure your left arm is blocking his\nright arm. This is important since his right side can post if you don't do this.\n3. Roll strongly to your left. He will roll.\n4. Squeeze the choke hard.	\N	282	2	7	15	http://austinjiujitsu.com/ajj/pictures/Techniques/Gator%20roll.jpg	1	sA2RtPbanO8	8	2	\N	\N	\N
3	1	Brabo Choke from Half-Nelson Side Control	You have him in side control on his right side	1. Overhook his head in a half nelson position with your left arm\n2. Move your left leg/hip way up pressing into his head\n3. Grab your left inner thigh with your overhooked left hand\n4. Step over his head with your left leg taking care to keep his arm trapped\n5. As you drop your left knee to the floor, scoop deep under his neck to assure position of your left arm\n6. Grab your right biceps and squeeze to choke	Travis Tooke	333	2	3	15	\N	\N	qKJDKE85ZqI	6	3	\N	\N	\N
3	1	X Choke from North/South	The X Choke from North/South is an easy transition from the Bat Choke from Side Control. If your opponent blocks the bat\nchoke, this is the best way to cinch the choke. \nYou are starting in a left side control working the bat choke. He blocks it.	1. Pivot to north/south position and pull. Done!	\N	339	1	3	15	\N	\N	z8pjMYau5JE	6	2	\N	\N	\N
3	1	Tilt Choke with the Elbow	While executing the tilt choke, your opponent falls or leans left, making the tilt difficult. Here's how you finish it.	1. Reach your left elbow pas his right ear and lean on his head\n2. Pull with our right hand. Tap!	David Thomas	340	1	12	11	\N	\N	VoXdBMKex00	15	3	\N	\N	\N
5	9	Knee on Chest	You have him in side control on his right side	1.  Right hand grab his belt or pant waist near his left side. No gi: Grab behind his left knee\n   2. Left hand grab his collar on his right side. No gi: grab behind his neck.\n   3. Drive your right knee on to his stomach/lower chest.\n   4. Grip tightly and press up.\n   5. Sometimes, given enough upward pressure with your arms, and downward pressure with your knee, you can submit from\nhere.	\N	78	3	3	3	http://austinjiujitsu.com/ajj/pictures/Techniques/Knee%20on%20belly	2	q6S2Qd9PdNI	6	1	\N	\N	\N
3	2	Armbar from Knee on Stomach	You have him in knee on chest side control, on his right side. \nYou will be attacking his left arm.	1. To attempt escape he presses on your knee with his hands. \n2. Dig your right elbow hard between his arm and his chest. Make a circular motion with your arm to end up hugging his\nleft arm with your right.\n3. Step your left leg over his head\n4. Turn 180 degrees, sit on the opposite side of his head into armbar.	\N	117	3	3	15	\N	\N	q6S2Qd9PdNI	6	1	\N	85	7
2	9	Knee on Stomach Escape - Pressing knee	Note: This is a beginner technique. Any seasoned jiu jitsu student will armbar you from this escape easily.\n\nHe has his right knee on your chest from the right side	1.  Press your left hand into his knee and your left hand into his leg and scoot away\n	\N	84	3	6	1	\N	\N	q6S2Qd9PdNI	3	1	\N	\N	\N
2	9	Knee on Chest Escape - Grab neck and roll away	He has just put his knee on you and has not straightened up. His head is still close to you. This only works from the\nside control conversion.	1.  Grab behind his neck to keep him close to you. It is easier the closer he is.\n   2. With your near arm, reach under his shin grabbing his rear to clamp.\n   3. Roll away from him. He will fall forward over you as you roll.\n   4. If he posts, bridge up over your head (change direction)	\N	79	3	6	3	\N	\N	ddvJes8bVWQ	3	2	\N	\N	\N
3	17	Biggie Slicer from the Back using the Crucifix Hook Setup	Your opponent is on all four. You have back control from his right side. No hooks, just weight on his back and \n"one on one" arm control with your left arm over his back around his left arm. You will be attacking his right arm.	1. Drive your left knee under his right armpit to isolate his right arm from his body.\n2. Hook your right heel under his right forearm to trap his arm in the Crucifix Hook.\n3. If he pulls his right arm back to center, this is easier. Grab his right wrist with your right hand.\n4. Post your forehead on the ground over his left shoulder\n5. Reach under his chest to grab his right wrist with your left hand\n6. Press your right knee to the ground and pull his wrist to crush his biceps and forearm. Tap!	David Thomas	341	2	12	15	\N	\N	LqHmKZtSlfk	7	3	\N	\N	\N
2	9	Knee on Chest Escape - Trapping his Foot	His knee is on your chest. DO NOT focus on the knee.	1.  Grab under his foot (of the leg that is on you) and clamp on to the back of his pants. This will trap his foot.\n   2. Grab his lower arm at the tricep \n   3. Pull the leg (salute) and the pull the arm down and back - toward your feet NOT toward your gut!\n   4. Sit up and put wrong knee on his stomach, then switch.	\N	83	3	6	3	\N	\N	MHi8IIG-w7s	3	2	\N	\N	\N
3	1	Crucifix Loop Choke from Rear Control	You are controlling him while he is in turtle position on his left side.	1. Drive your right knee between his left elbow and knee on the floor. This makes space for your right foot to hook\naround his left forearm.\n2. Hook your left foot around his forearm and figure 4 lock your legs.\n3. Your right arm is on his shoulder on his right side.\n4. Roll over his back, kicking your legs over\n5. "Salute" your right arm up to trap his right arm\n6. Reach under his neck with your left arm and grab his right side lapel like in a loop choke.\n7. Pull to choke\n\nThere is a no-gi variation of this on Austin Jiu-Jitsu's video web site.	\N	328	3	7	15	\N	\N	58ELE0iqBk4	9	3	2008-01-31 06:00:00+00	\N	\N
3	3	Thighmaster Americana	Your opponent is on all fours. You have back control from his right side. No hooks, just weight on his back and\n"one on one" arm control with your left arm over his back around his left arm. You will be attacking his right arm.	1. Drive your left knee under his right armpit to isolate his right arm from his body.\n2. Hook your right heel under his right forearm to trap his arm in the Crucifix Hook.\n3. Grab his right wrist with your right hand. Pull it up to your right knee.\n4. Open your knees slightly (do the "thighmaster") to submit him with the Americana Shoulder Lock	David Thomas	342	2	12	15	\N	\N	24n512Se-Os	7	3	\N	\N	\N
3	1	Crucifix Tilt Choke from Rear Control	This is the no-gi variation of the Crucifix Loop Choke from Rear Control.\nYour opponent is on all fours. You have back control from his right side. No hooks, just weight on his back and\n"one on one" arm control with your left arm over his back around his left arm.	1. Drive your left knee under his right armpit to isolate his right arm from his body.\n2. Hook your right heel under his right forearm to trap his arm in the Crucifix Hook.\n3. Roll over his back to flip him over\n4. Hook your left hand behind your head to control his left arm\n5. Hook your right arm under his neck like a rear choke. Grab his left shoulder with your right hand.\n6. Pull your right forearm under his jaw line and raise your right shoulder to execute the tilt choke	David Thomas	343	2	12	1	\N	\N	w4CUG17zM0A	7	3	\N	\N	\N
3	14	Stocks from Crucifix	Your opponent is on all fours. You have back control from his right side. No hooks, just weight on his back and\n"one on one" arm control with your left arm over his back around his left arm.	1. Drive your left knee under his right armpit to isolate his right arm from his body.\n2. Hook your right heel under his right forearm to trap his arm in the Crucifix Hook.\n3. Roll over his back to flip him over\n4. Barrel roll slowly to your left toward him, replacing your left arm with your right around his left arm. \n5. To avoid losing control of his right arm between your legs, reach your left hand under you and grab your right thigh\nunder his armpit Now you can drive your right knee to the ground and trap his right arm\n6. You will end up in a position sitting out leaning toward his head. Keep leaning back until he taps.	David Thomas	344	3	12	15	\N	\N	b0bucesJ6Yg	7	3	\N	\N	\N
3	4	Reverse Hook Sweep Kneebar	This is the no-gi variation also documented under the Helicopter Knee Bar	\N	\N	345	3	1	15	\N	\N	dnylJWrabp8	8	2	\N	\N	\N
3	4	Helicopter kneebar	Your opponent is passing your guard to your right, squashing leg. You are on your side.	1.  As opponent passes your right leg it is underneath him, keep your right foot hooked under his upper \nright thigh.\n   2. With your right hand, either grab behind his back on his left side (if you can). If you can't, reach \ndown and grab his outside right pant leg as low as you can, but watch out for the cross face. The leg you \nare holding is not the one you are attacking for kneebar.\n   3. As he passes to your right, sweep, pulling your knee high to your face. This will pull his weight on you \nso you can spin him 90 degrees to your right to get his left leg.\n   4. Catch his left leg in a figure 4. Kneebar.	Vandry	155	3	6	15	\N	\N	bZRHq4w0oCg	7	3	2008-01-23 06:00:00+00	\N	\N
3	2	Arm bar from mount	You are in mount position. You are going to arm bar his right arm.	1.  Mount high by pushing your knees into his armpits and your hips toward his head. This will isolate his arms and\nreduce the chance his bumping will throw you off. \n2. Turn to your right with your hips. This will line up his right arm between your legs.\n3. Hug his right arm with your left arm and place your right arm on the ground on his left side. \n4. Lean to your right. You need to lean far enough over to make it easy to take the weight off your left knee.\n5. Step your left leg over his face. Don't just fall back; keep your balance. This continues the pressure to prevent escape.\n6. Sit down directly on the mats under his right shoulder as close as possible.\n7. Clamp your knees immediately when you hit the mat\n8. Lean back and bridge to complete the arm lock. Make sure his thumb is pointing away from the direction you pull.\n\nNote: the video is the S-Mount version of the technique.	\N	110	3	4	15	http://lh5.ggpht.com/dthomasjiujitsu/SKdg8tkTeaI/AAAAAAAABqg/8-IlT6hfmbM/IMG_6782.JPG?imgmax=512	1	d1juHOQRy-g	6	1	2008-01-09 06:00:00+00	\N	\N
3	2	Reverse Armbar from Side	You have him in right side control, head in arm position. He is hugging you.	1.  Bring your left arm over his head and break the hug by driving your left hand into the left side of his neck as you\npress your head toward his left hip. Keep your head posted on the floor throughout this technique.\n2. Step over his head with your left leg, keep your left knee on the floor. If you can drive your left calf behind his\nhead, it will control him better.\n3. Trap his left arm by clamping his wrist between your right ear and your shoulder and his triceps between your right\nwrist and your chest\n4. Squeeze to armbar. You might get a muscle crush first.	\N	10	3	3	15	http://lh3.ggpht.com/dthomasjiujitsu/SKdhpC87H6I/AAAAAAAABqs/ozPvOQUdzaA/IMG_6823.JPG?imgmax=576	1	iUtvpwpfgjM	6	2	2007-12-23 06:00:00+00	\N	\N
3	2	Reverse Armbar from Side Control - Vertical	You are holding him in a right head-in-arm position	1. Bring your left arm over his head and break the hug by driving your left hand into the left side of his neck as you\npull him to his side. Keep your chest close to his chest. You are not kneeling in a vertical position, pressing down on\nhis head with your left hand.\n2. Step over his head with your left leg, planting your left foot on the floor. Control him by sitting on his head and\nclamping your legs around his torso.\n3. Trap his left arm by clamping his wrist between your right ear and your shoulder and his triceps between your right\nwrist and your chest\n4. Squeeze to armbar. You might get a muscle crush first.	\N	295	3	3	15	http://lh5.ggpht.com/dthomasjiujitsu/SKdiTjcvPPI/AAAAAAAABq0/sTHU9T58rxs/IMG_6940.JPG?imgmax=512	1	NTDs2V3p3Gw	6	2	2007-12-11 06:00:00+00	\N	\N
2	5	Log Splitter Guard Pass	You are kneeling or standing inside the closed guard. This works great against those guys with strong legs \nwhere you can't crack them open any other way.	1. Put your hands in his armpits, 4 fingers down, thumbs up. This prevents him from "creeping up" on you \nas you try to position your knee in the middle. Keep pressure on him to prevent him from moving.\n2. Put your right knee in the center as close as you can to your belly button. It is crucial you keep this \nknee tight. \n3. Keeping knee pressure inside, press your butt down to the rear to wedge your knee in between his legs.\nHis legs may open, if they do, keep pressure on his thighs with your hands to keep him from re-closing. \nEven if they don't open, you can pass his guard if your knee is in between his legs. I call this solid base \nposition "position 2."	\N	347	3	8	3	\N	\N	oxf7KJ_mPCo	6	1	\N	\N	\N
3	1	Lion Choke a.k.a. Peruvian Necktie	You are on top. For example, sprawling from a takedown attempt.	1. Reach your right arm under his left armpit\n2. Reach your left arm around his neck from his right side\n3. S-grip under his neck\n4. Press your hips forward. It is crucial that you keep his head "crowded" to prevent him escaping the choke. \n5. Step your left leg over his head. Now his head is trapped under your left thigh.\n6. Sit back, as you would pulling to guard.\n7. Put your right leg over his back.\n8. Pull to choke	\N	346	2	7	15	\N	\N	1fUQmQEdwYQ	9	3	\N	\N	\N
2	5	Turn-In Guard Pass Defense to Takedown	You are in guard defending against the guard pass. He is coming around your legs, so you have to be \nready to move fast! This is an excellent alternative to the old and tired shrimping defense.	1. As he comes around your legs, you have to dive toward his legs as fast as you can. I call this a "turn-in" \nsince you are turning in to him, rather than shrimping away.\n2. Try to get your head near his hips near his belly to avoid the cross-face, guillotine, or head pressure.\n3. Snatch his legs low around his thighs and pull in, following proper form for a double-leg take-down.	\N	348	3	1	3	\N	\N	My6mC3gxfNg	8	2	\N	\N	\N
2	11	Head Control Rear Mount Escape	He has a rear mount	1. Immediately defend the choke by shrugging your shoulders and dropping your chin. Work for hand \ncontrol on at least one hand.\n2. Grab behind you to the back of his head and pull it forward, using both hands if possible\n3. Turn and face him	David Thomas	349	3	11	8	\N	\N	caHTzWum98g	12	3	\N	\N	\N
2	5	Stand-Squat Guard Pass	He is holding you in closed guard.	1.  Grab his lapel near his neck with bent arms. Keep your elbows in throughout technique\n   2. Come off knee for one foot. Plant foot. Then do the same on the other side\n   3. Pick up your rear end, then lift him off the ground, holding his lapels tight\n   4. Squat driving your elbows into his inner thighs. Shake well ;-)\n   5. When he falls to the floor, drive your knee into one of his legs or up the middle. Go to basic guard \npass.	\N	60	1	8	3	\N	\N	\N	1	2	\N	\N	\N
3	1	Brabo Chokes from Side Control - Two on One	You have him in right side control, or kesa. This is an opportunistic technique if he reaches his far arm \n(left) across your face.	1. Grab his left wrist with your left hand and pull it all the way to your left, then grab with both hands. Hold \ntight!\n2. Dig your right hand under his neck deep\n3. Roll to a sprawl position over his right shoulder and make sure your right hand is as deep as possible \naround his neck.\n4. Grab your left biceps with your right hand and sprawl and squeeze to choke.	David Thomas	350	2	13	15	\N	\N	0bQLCldy82U	6	3	\N	\N	\N
3	1	Mount to Triangle	Mount	1.  The key to this move is grabbing his left hand and pinning it to the floor with your right hand\n   2. Lean on his face in a high mount as you creep your right foot up to his left armpit\n   3. Reach under his head with your left hand and help your right foot drive behind his neck\n   4. Press your left leg high up to get figure 4\n   5. Either triangle him from the top or sit back to finish	\N	249	3	4	15	\N	\N	E8bimFhtdiU	6	2	\N	\N	\N
6	8	Kickstand Sweep	You are on your back, holding him in guard. He steps one foot out so you can grab under it. His foot acts \nas a "kickstand" -- once you knock it out, he falls over.	1.  With your left hand, pull his left sleeve across to your left\n   2. (his left foot is out) - Reach your right arm under and scoop his leg at the ankle to have him sit back \non his butt\n   3. Press your left palm on the floor next to your left ear and press your hips forward and right. This will \nfurther knock him back\n   4. Step over his face with your left leg and armbar him	Travis Tooke	109	1	1	3	\N	\N	\N	8	3	\N	\N	\N
3	1	Power Half to Vice Choke	You are scrambling for control. Both opponents are on all fours.	1. Overhook (wizzer) his left arm with your right arm\n2. To set up the power half, place your left hand on top of his head and grab your left wrist with your right \nhand. \n3. Press his head down to the mats, keeping the power half grip. \n4. Stuff his head under his body. I like to tell my guys to make him look at his own belly button. Keep the \npower half. This will flatten him out on his side, where you can breadroll him to his back. \n5. Your right arm should be pressed into his neck. Your left hand can let go of his head and go under his \nneck. \n6. Look at the vice choke or no-gi bat choke notes for how to grasp behind his neck to finish this choke.		357	3	7	15	\N	\N		7	3	\N	\N	\N
3	2	Flying Scissors Armbar	You will be armbarring his right arm\n1. Grab him with a 2 on one control, with 2 hands on his right arm. \n2. Keep hold of his wrist with your right hand and step sideways to control his right arm around his biceps \nwith your left hand. \n3. Pull his arm up against your chest with your shoulder driving forward. This is a tight control position.\nYou are standing slightly off to his right pressing into his arm with your chest. Hold tight!	1. Throw your right leg against his chest at the same time as you throw your left leg behind his back. All of \nyour body weight will be on him causing him to fall back.\n2. Drop to the ground, holding tight\n3. Before his weight settles on his back, throw your left leg across his face and clamp tightly behind his \nneck with your calf/hamstring. \n4. Extend hips to tap\n\n\n\n	\N	355	3	5	15	\N	\N	Ke_zokGUAqQ	5	3	\N	\N	\N
3	2	Flying Armbar: Foot on the hip	You are both standing in the clinch. Your right hand is behind his neck and your left hand is in the crook of \nhis right elbow. You will be attacking his right arm.	1. Step your right foot on his left upper thigh near his hip.\n2. Drop to the ground, holding tight on the clinch\n3. Throw your left leg across his face and clamp tightly behind his neck with your calf/hamstring. This is \njust like armbar from guard.\n4. Extend hips to tap	\N	353	3	5	15	\N	\N	teJOvOnrff8	5	3	\N	\N	\N
3	17	Biggie Slicer - Biceps Crush from guard	You have him in your guard. You are attacking his left arm. This is an amazing move. You can gatch guys \nfrom your guard\nin this from the most hopeless looking defensive positions that it is usually a totally surprise.	1.  Work your foot into place by doing a half spider guard. Grab his left triceps with your left hand. Grab his \nleft\nwrist with your right hand.\n   2. Put your left foot over on his left hip with your knee across his midsection. He will be eager to attempt \nto pass\nyour guard now. \n   3. As he leans forward, he falls into the trap. If he doesn't lean forward, you can pull him down on you. \nIf he isn't\nvery close to you, you will have to keep hold of his left wrist with his right hand. If he's close, you can let it \ngo. \n   4. Gable grip around the back of his left shoulder. \n   5. Pull/squeeze to crush. Press your right shin into his muscle by flexing your glutes and pulling him into \nyou.	\N	141	3	1	1	http://austinjiujitsu.com/ajj/pictures/Techniques/Biggie%20Slicer%20from%20Guard.jpg	1	ZhGc3GxoEBg	8	3	2007-12-28 06:00:00+00	\N	\N
6	8	Biggie Slicer Biceps Crush Sweep	He is standing above you. You have him in Spider Guard, gripping his left sleeve tightly with your right \nhand. You will\nbe sweeping him to your right and attacking his left arm with your right leg.	1. Change your right foot from a spider guard to a biggie slicer setup position by running your foot over \nthe top of his\narm and jamming your foot into his armpit. Begin to lead him forward over you, as in the spider guard \nsweep. \n2. Put your left shin across his belly, with your left foot near his left hip. \n3. As he loses balance, he will usually lie forward on you. Hug him to keep him close. This is key to an \neasy sweep. \n4. Sweep him to your right. His left arm is still trapped.\n5. With his left arm trapped under your shin, drive your hips forward to crush his biceps.	David Thomas	305	3	1	15	\N	\N	mdYDjaqIwHE	5	3	2007-12-28 06:00:00+00	\N	\N
1	5	Turn In Guard Pass Defense	He is passing your guard to your left. \nThere is a great drill called Compass Drill for getting the hang of this move.	1. As he comes around to your left, "dive" to your left on your stomach. This is a 90 degree turn in to him \n(hence "Turn In"). \n2. Reach out and grab either of his legs tightly\n3. Pull your legs under you. \n4. You can get one of many variations on single leg or double leg takedown from here.	David Thomas	68	3	1	8	\N	\N	\N	8	1	\N	\N	\N
2	1	Brabo Choke Escape to Trap and Roll Sweep	He is setting up a Brabo choke from your right side. His right arm is under your left armpit, working to sink \nthe Brabo (Darce) choke.	1. Quickly grab outside your left upper thigh with your left hand. Press to the left with you back muscles to \nprevent him from squeezing in with his choke. \n2. move to your right to try to get your hips close to his.\n3. Clamp your left armpit to trap his right arm\n4. Roll to your left. He will fall over you. \n5. Get side control	David Thomas	356	3	6	3	\N	\N	X6auEaacmtA	15	3	\N	\N	\N
3	2	Flying Armbar: Shin Across The Belly	You are both standing in the clinch. Your right hand is behind his neck and your left hand is in the crook of \nhis right elbow. You will be attacking his right arm.	1. Place your right shin across his belly with your right foot hooking in front of his right hip.\n2. Holding the clinch tightly, drop to the ground with your head off to his left.\n3. Throw your left leg across his face and clamp tightly behind his neck with your calf/hamstring. This is \njust like armbar from guard.\n4. Extend hips to tap	David Thomas	351	3	5	15	\N	\N	teJOvOnrff8	5	3	\N	\N	\N
2	5	Pivoting Pass of De la Riva Guard to Clamping Kneebar	You are standing inside his guard. He is setting up any variation of the De la Riva guard where his leg is \nwrapped around your lead leg. This might include him also gripping your sleeve and applying pressure to your \nrear leg with his other foot. Much of this technique applies to gi only, but can be adapted for no-gi. \nIn this example, his left leg is wrapped around your right lead leg.	1. Grab the end of his left pant leg with your left hand. You will be reaching slightly under your right thigh \nto reach this. \n2. Quickly turn your hips, pivoting on your right foot, spinning your left leg behind you. While you are \nturning your back to him, you will maintain control of his right leg and land tight around his left thigh. \n3. Immediately and strongly clamp your left thigh on his left leg above his knee. Your right foot should be \nplanted inside his left thigh and should be touching your left thigh. This will ensure you are as tight as \npossible. \n4. Grab his belt or the top of his pants with your right hand. This will maintain control of him as you \nkneebar him and will help prevent him from improving position momentarily.\n5. Lie to your left and extend the kneebar	David Thomas	358	1	5	15	\N	\N	2qrdL2CPyuw	1	3	\N	\N	\N
5	10	Figure 4 Mount	This is an excellent mount transition from side control. You are holding him in side control on his right side \nand are moving into mount. This prepares you for a low mount, opening a good grapevine position.\n	1. Pull his left leg toward you\n2. Hook his left leg behind the knee with your right heel (throw your heel high over the back)\n3. Strongly press your right foot to the floor behind his knees\n4. Drive your left knee under his right hip to meet your right foot\n5. Create a figure 4 lock with your feet behind his legs\n\nBridge with your hips strong into him. As you mount him, you should be very stable. Open the figure 4 \nonce mounted and grapevine a leg or transition higher.	David Thomas	361	3	3	4	\N	\N	qH4xuHfIH44	6	3	\N	\N	\N
2	5	Calf Control Half-guard Pass	You are working on a guard pass and you have one leg inside. Your opponent has not closed the half \nguard yet.  This is a very strong, reliable half-guard pass. I often tell my students to have the top man \ntake control of the bottom man's trapped leg as if you have him in half-guard. This is an interesting role \nreversal in that the bottom man often feels trapped and wishes they didn't pull half guard to begin with!\n\nThe key to this pass is preventing him from closing the half-guard. Much of the move is designed to keep \nhis legs far apart.\nIn this example, you have your right leg in between your opponents legs. You are on top, preparing to \npass the half guard to your left.	1. Drive your left arm under his left armpit and crowd him by pressing your elbow high into his armpit\n2. Scoop his left leg with your right arm. Make sure you are below his knee. Your biceps, scooping his leg, \nshould be at his calf. If it is in the crook of his knee or on his thigh, he can lock closed guard. \n3. Drive your left knee deep under his right thigh, so deep that the weight of his leg should rest on your \nknee\n4. Your right leg is still between his legs. Slowly drag your right heel, flat footed on the floor, down the \nback of his leg to his Achilles heel. \n5. Using both legs, straighten out his trapped leg by pressing hard with your left leg on his upper thigh and \nyour right leg behind his heel. Keep his other leg scooped high!\n6. Pass the guard	David Thomas	360	3	8	3	\N	\N	qH4xuHfIH44	2	3	\N	\N	\N
5	5	Sumo Squat Guard Defense	This is a defense against an aggressive open guard. You are standing over your opponent and they are \npressing an offense from their guard.	Piece of cake: Squat in a Sumo-like position, diagonally toward your opponent (one knee forward), keeping \nyour weight back and arms in. The lower you get, the more stability you will have. Press your leading knee \ninto him to crowd his guard.	David Thomas	359	3	5	5	\N	\N	qH4xuHfIH44	1	2	\N	\N	\N
6	8	Old School Sweep from Achilles Half Guard	You are holding him in Achilles half-guard with his right leg trapped	1. Get him in an Achilles half-guard\n2. See the referenced technique for execution of old school sweep	David Thomas and Jean Jacques Machado	363	3	2	3	\N	\N	Cf1TPhv8sRA	8	3	\N	\N	\N
6	8	Plan B Sweep from Achilles Half-guard	You are holding him in Achilles half-guard with his right leg trapped	1. Get him in an Achilles half-guard\n2. As with old school, you are going to work to scoop his left leg behind the knee with your right hand. He \nposts out in this case, making old school impossible. \n3. Change directions and roll to your left, sweeping him to his right. \n4. Pass the guard and go to side control	Eddie Bravo and David Thomas	364	3	2	3	\N	\N	QOLTmuzwSGo	8	2	\N	\N	\N
5	5	Achilles Half Guard	This is a nifty alternative to the lockdown. It produces less pain on your opponent and less control than the \nlockdown half-guard, so you might wonder "Why would I ever want less pain and less control?" The answer \nis that it trades these benefits for improved mobility. I'm not a huge fan of calf-crushing my opponents, \nespecially if I'm just <a href="http://jitshappens.com/jitshappens/article.php?id=6"flow rolling</a> or when \nI'm trying to keep my game more dynamic. I find myself grappling more statically with lockdown and \nwanted an alternative. Welcome to the Achilles Half Guard! Like other half guards, this is a good starting \npoint for lots of other moves.\nIn this description, you are holding your opponent's right leg in your half guard.	1. Your right leg is behind his right thigh with your calf over his calf, much like a traditional half-guard.\n2. Your left foot is behind his right leg at the top of his calf. \n3. Keeping your left foot pressure on the ground, drag your heel down to the back of his right Achilles. As \nyou move down below his knee, pull your left foot to your left. This will apply pressure to his right knee, so \ndon't overdo it. \nThe important point here is that, with his right foot pulled to his right, his right leg is completely out of his \ncontrol. It provides no base.	David Thomas	362	3	2	2	\N	\N	Cf1TPhv8sRA	8	3	\N	\N	\N
2	9	Old School Escape from Side Control using the Achilles Trap	He has just passed your guard and is settling into side control on your left side.	1. Get double underhooks\n2. Turn in toward him. He will wizzer your right arm with his left arm (or else you can take his back!)\n3. Try to get your head close to his hips and hug around his hips. If you can reach around and grab his \nright foot with both hands, the sweep is much easier.\n4. Get your knees under you and drive.\n5. As he collapses, keep your hips pressed into his left leg to prevent him from pulling guard.	David Thomas	365	3	6	3	\N	\N	0ZS8i5ObKDU	3	3	\N	\N	\N
3	2	Near Side Armbar from Side Control Stepping over the Head	You are holding your opponent in right head-in-arm side control. You will be attacking his right arm.	1. Take your left arm out from under his neck and press your left elbow into his left ear (far side). This is \nintended to keep his head in place as you do step 2\n2. Maintaining pressure, step your left foot over his head. This is difficult to do in one step, or if he lifts his \nhead up, so gradually work your foot into place next to his left ear.\n3. Reach your left arm back around your left knee and grab your left shin\n4. Clamp tight! You now have his right arm trapped for the submission.\n5. Raise your torso up, hugging his far arm with your right arm\n6. Press your hips forward to submit him	David Thomas	370	3	3	15	\N	\N	A4HE77evFbg	6	3	\N	\N	\N
3	1	Neck Knuckler with Under Arm Lapel Control from Mount	You have mounted your opponent. This is a neck crush or choke depending on your opponent's ability to \nwithstand the initial pain of the neck crush.	1. From the mount, drive your left knee high toward his head. \n2. Put your right knee on his left biceps\n3. Using your left arm and left leg, roll him up on his left side so his right arm is on top. Keep your left \nknee driving inward behind his right shoulder. \n4. Reach under his right arm with your left hand and grip his far lapel, 4 fingers inside.\n5. Press your right fist, knuckles under his jawline just below his right ear, with a straight arm.\n	David Thomas	367	1	4	15	\N	\N	-5GlQplLXec	6	2	\N	\N	\N
2	9	Plan B Escape from Side Control using the Achilles Trap	He has just passed your guard and is settling into side control on your left side.	1. Get double underhooks\n2. Turn in toward him. He will wizzer your right arm with his left arm (or else you can take his back!)\n3. Try to get your head close to his hips and hug around his hips. If you can reach around and grab his \n4. He will sense the old school sweep so he posts his right leg. \n5. Put your left hand inside his right thigh, get your hips close under him and quickly roll to your right, \nsweeping him to his left. \n6. Pass the guard and go to side control	David Thomas and Eddie Bravo	366	3	6	3	\N	\N	hYr_PnH7qrE	3	2	\N	\N	\N
3	4	Hip-bumping Kneebar from the Ground	Your opponent is standing above you inside your guard. You will be attacking his right leg.	1. Get butterfly guard - hook behind his right knee with your left foot.\n2. Grab behind his right heel with your left hand\n3. Pull with your left hand and foot and quickly turn toward his right leg and raise your hips above his \nknee. Your hips must land on his upper leg for this to work. \n4. Press your weight back, causing him to fall backward as you clamp your arms and thighs tight around \nhis right leg.\n5. Press and bridge your hips into his lower thigh above his knee to tap him. This can happen before, \nduring, or after the fall, but I generally finish after he falls.	\N	372	3	1	15	\N	\N	YWPfPCk76ko	5	3	\N	\N	\N
2	9	Over-hooking Cross-Lapel Sweep from Side Control to Neck Knuckler	You are holding your opponent in side control. He gets a far-side underhook, allowing him to turn in or plan-B \nescape. This technique involves a specific gi grip allowing you to reverse a previous reversal from side control. \nGranted, this shouldn't have happened, but the point of this technique is for you to recover from your mistake \nof letting him reverse you.\nIn this technique, we describe the position as if you were originally holding him in right side control.	1. With the underhook, he turns in to you, beginning his escape from side control.\n2. Press your chest into him as he turns in and reach an overhooking right arm around his left arm. Grab \nhis right side collar from this overhook. Make sure it is tight, so quickly use your left hand to tighten the \ngrip.\n3. He escapes side and reverses you. See plan B for one option of how he can do this. \n4. You are now stuck in right side control. This is important, since you are trapping his left (near-side) arm \nwith your overhook still. This removes an important base for him momentarily.\n5. Reach your left arm across his back, as is done with the barrel roll side control escape referenced below, \nthen explosively bridge and roll him from your right side, over your head to "the top left corner."	David Thomas	373	1	3	15	\N	\N	aS-w9BAAOBQ	6	3	\N	\N	\N
3	4	Kneebar Attack Against Achilles Lock Sweep Setup	You are holding your opponent in right side control. He is working the underhooks and setting up an Achilles \nLock Plan B sweep. Your response will be a defense of the sweep followed by a kneebar.	1. As he gets underhooks and the Achilles Lock half guard, you know your time is short. The first response \nis to overhook to defend his underhook\n2. Get your weight off him, since the Plan B sweep capitalizes on your weight being committed on him. \nPivot your chest to your left, maintaining the overhook. This has a secondary benefit of locking his left arm \neven deeper in the overhook. Some guys can get an armbar (especially in gi) since the grip is so deep \nand tight.\n3. Reach your left leg back, over your Achilles Lock-trapped right leg. Drive your left knee behind his left \nknee. \n4. Strongly press your left knee behind his knee. This has 2 benefits: breaking his Achilles Lock and \nisolating his leg to set up the kneebar. Maintain that overhook!\n5. Reach your left arm and grab his left leg at the ankle. \n6. Twist just slightly to your left, facing the kneebar a bit more, clamp your left leg tighter, and pull with \nyour left arm to complete the kneebar. Sometimes, I'll do the "eensy weensy spider" crawl with my left \nhand to "walk" my hand up toward my head to finish the kneebar. No reason, really, just fun to tap a guy \nthis way. :)	David Thomas	374	3	3	15	\N	\N	l6q0wTpOb2s	6	3	\N	\N	\N
3	3	Americana from Kesa Gatame with Arm Lockdown	Similar to a popular Americana submission from Kesa, this move introduces a new lockdown control on your \nopponent's arm. This control position, similar to the lockdown half-guard, but against a single arm, effectively \ncontrols the opponent's arm from "straight-arm" defenses to this attack. \nYou are holding your opponent in right side control, attacking his right arm.	1. In kesa position, you need to make sure your right leg is under his left shoulder. Your thigh acts as a \ncritical fulcrum point in this move to ensure maximum leverage on his shoulder\n2. Grab his right wrist with your left hand and press it to the ground\n3. Drive your right foot over his biceps near the crook of his elbow and behind your left knee\n4. Wrap your left foot under his wrist. This completes the lockdown on his shoulder\n5. Extend your legs to create a good Americana angle on his shoulder. Your left foot is key to this, so \nensure you have it low enough on his wrist so he can't "straight arm" out. Of course, if he straight arms \nyou, you can submit him with an armbar over your thigh. \n6. To complete the submission, simply cross face with your left arm and hug underhooks on his farm arm. \nThis creates shoulder pressure to make him tap.	David Thomas	375	3	13	15	\N	\N	5EiBdazR1Jo	6	3	\N	\N	\N
3	2	Switching Armbar Recovery	Your opponent has escaped an arm bar from guard by pulling their arm out from between your legs. This \ntechnique describes how to quickly attack their other arm. You recover the arm bar by switching to the other \narm. In this example, you are initially attacking his right arm and switching to his left.	1. After he pulls his right arm out, you have your left leg over his neck and your right leg behind his left \narm. You will now switch your attack to this arm.\n2. Grab your left hand behind his neck to allow you to switch your hip position. \n3. Maintaining hold of his neck, turn your left leg almost 180 degrees by pulling your shin under his neck \nand holding his neck with your instep.\n4. Pivot your hips to the left so you can swing your right leg around his neck\n5. Using your right and left legs, clamp his neck tightly so he can't posture up\n6. Bridge your hips to tap him\n7. Bonus - Ham choke by grabbing your right shin with your right arm and squeezing!	Ham choke - David Thomas	376	3	1	15	\N	\N	B42bXtnTA7Q	5	3	\N	\N	\N
2	4	Near Mount Escape to X-Guard to Kneebar	Just as your opponent goes to mount you, if you have one knee just barely protecting and the other leg \nalready passed, you have an opportunity to go to an X-guard then kneebar. In this move, your right knee is \nstill not passed.	1. Press your right forearm against the inside of his left thigh next to your knee and press your knee out. \nThis will make space for your left foot to go under his left thigh for X-guard\n2. Establish X-guard\n3. Shrug under "angry sweater" his right arm by pressing under his right armpit with your left palm as you \nduck your head under\n4. Press his right armpit away from you, switching off to your right hand. Press all the way down to your \nfeet. This will send his head toward your feet. Keep that X-guard!\n5. Pull your right knee to his right hip. His right leg should be in between your legs now\n6. Pull his right ankle to your right. This will cause him to fall to his side so you can attack the kneebar \nfrom a safe position.\n6. Bridge to kneebar	David Thomas	384	3	6	15	\N	\N	dzKZzdVHjFY	4	3	\N	\N	\N
3	2	Shin Clamp Armbar variations	This is a great option to strengthen your armbar in a couple of scenarios. It allows you go hold tighter by \nemploying new muscle groups to the way you grip the attacked arm. You are attacking him from both the side \ncontrol and mount in this technique	From "head in arm" left side control, you will be attacking his left (near side) arm\n1. Put pressure on his head with your right arm to prevent him from picking his head up and blocking as \nyou "walk" your right foot around his head, ending up with your right heel on the right side of his face.\n2. To prevent him from turning away from you, it's a good idea to scoop his right triceps with your left arm. \nYou aren't attacking this arm, just holding it for control. \n3. Reach your right arm around the outside of your knee and clamp your shin with your right palm. This will \ntrap his left arm. Clamp tight, using your obliques, lats, and arm. \n4. Extend your hips forward OR sit back to armbar.\n\nFrom left knee-up Mount (your left knee is high, left foot planted in front of him), attacking his left arm:\n1. He will be on his right side in this mount position, so his left arm will be on the high side of his body. \nTypically, he'll keep this protected by bending at the elbow and keeping his arm close to his body\n2. Dig your left elbow into the crook of his left elbow and pull it to your left\n3. Reach around your left knee and clamp, as above\n4. Extend OR sit back to armbar	David Thomas	377	3	3	15	\N	\N	ttF0CWof0kg	6	3	\N	\N	\N
2	9	See-Saw Sweep	This is a sweep and side control escape that is executed when your opponent steps over your head and \nexposes his thigh over your head. Typically when he steps over your head, he is a bit higher and not \npressed against your body completely. This allows you to sneak your knee into his belly, which provides a \nstrong fulcrum for the sweep. This is called a see-saw sweep since you are creating a fulcrum at the center \nof your opponent's body and pulling down one end and raising up the other. Like a see-saw.\nHe is holding you in a left head in arm side control.	1. He will step over your head with his right leg to set up an arm attack on your opposite side. As he does \nthis you will see the underside of his thigh above your head. \n2. Grab behind his neck with your right hand. Keep his head low this entire technique or you'll lose it. \n3. Place your left hand on the bottom of his thigh and slightly elevate him as you drive your left knee \nunder his belly. \n4. Simultaneously pull down on his head, push up on his thigh and press your knee into his midsection to \nbear his weight and provide a fulcrum for the "see-saw".\n5. As he rolls over you, keep your knee in his midsection so you can follow him up and end up with knee \non belly.	David Thomas	378	3	6	3	\N	\N	TqRPySjG_NA	3	2	\N	\N	\N
2	9	Knee on Biceps Side Control Escape to Lockdown	The knee on biceps side control is one of the great control positions. This escape takes advantage of a small \nweakness with the side control. The opponent, by placing all his weight on your arm, can be potentially given \nthe right timing. In this technique, we'll escape from an opponent on our right side control with his left knee \non our right arm.	1. Pummel your left arm under his right arm. \n2. Bridge explosively as you hoist as much of his body weight on your chest. This will force him up with your \nbridge. \n3. As you fall back from the bridge, you can capture his right leg in a lockdown.	David Thomas	380	3	6	3	\N	\N	wy4PCkzKySQ	3	2	\N	\N	\N
3	1	Arm Switch- Bridging Side Control Escape to Brabo Choke	This is a great way to finish a cool reversal from under side control. \nRefer to the Bridging Side Control Escape Switching Arms for the root technique. Here we cover the choke at \nthe end. He is in your right side control.	1. At the end of the bridging escape, your first goal is to ensure his shoulder remains trapped under your \nchest. This keeps his arm across his face and allows the Brabo choke to work.\n2. Switch directions, moving back across from his back to his front as he is lying on his side. From the \nfront, you can approach the choke.\n3. Ensure your left arm is deep under his neck and you are sprawling on his shoulder. \n4. Grip your right biceps with your left palm and squeeze.	David Thomas	382	3	6	15	\N	\N	G2t3YnxVry4	3	3	\N	\N	\N
2	9	Bridging Side Control Escape - Switching Arms	This is my 2nd favorite side control escape. It works on big guys, strong guys, and even guys who sprawl half \nway through assuming the sprawl kills any bridging escape. The sprawl has no effect on this one! \nIn this technique, you are reversing a head in arm side control from your right side.	1. Your opponent must have a head in arm control or else this will not work. To improve the chances he \nkeeps his arm under your head through this move, start by pressing your head into the mats.\n2. Reach your left arm across your face and over his left shoulder down his back. Make sure to press his \nhead away from you with the back of your arm to reduce the chance he arm triangles you. This is a real \ndanger!\n3. Reach your right arm under his belly across his right hip and "s" grip your hands together behind his \nback.\n4. Slightly walk your feet to your left to "reduce the perpendicularity." :) This will make him a bit easier to \nroll, especially if he's big. This step is not required, but helps. The more you can walk away, the more you \nbecome aligned with his direction, the easier the bridge is. Don't overdo it, since very little is necessary.\n5. Bridge and roll away from him to "the top left corner," meaning he should end up on his back just \nbehind where your left ear was before you rolled.\n\nOf course, like most techniques, all steps need to happen in about 2 seconds or less to actually surprise \nyour opponent. If he pulls his left arm out from behind your head, he can recover and defend this \nreversal!	David Thomas	381	3	6	3	\N	\N	t5ToWXlWODU	3	3	\N	\N	\N
6	7	Wizzer Defense Throw	You are overhooked and getting shoulder pressure from a wizzer on your right side. Whether you are on your \nside trying to get up, or on all fours, the wizzer against you will prevent you from making many offensive \nmoves, especially driving into him for a takedown or taking his back. This move shows a great throw that gets \neasier the harder he pushes on you!	1. Slide your body to the left so you get your weight under him. Make sure your left side is pressed against \nhim or under him.\n2. Grab under his right thigh with your left hand\n3. As with the Brabo escape sweep, clamp your right arm tight to your side to trap his wizzer or else he \ncould \npull it out while you roll him\n4. Explosively rotate right holding tight with both hands and concentrate pressing with your left hand under \nhis thigh. \n5. Go to side control.	\N	379	3	6	3	\N	\N	WahMcWX9z2Q	3	3	\N	\N	\N
2	1	Head Cradle Bridging Side Control Escape to Brabo Choke	He has you in side control on your right side. \n	1. Dive your right arm under his chest and grab the far side of his neck\n2. Pull strongly toward you to cradle his head with both hands\n3. Press his left arm across to your right between his chest and yours, then rotate slightly to clamp it \nbetween you, trapping his arm. This is absolutely necessary to stop him posting arm\n4. Reach your left arm behind his head and grab your left biceps with your right hand\n5. Bridge and roll to the upper left corner (over your left ear)\n6.  Maintaining the choking grip, sprawl on his shoulder, clamping tight until he taps	David Thomas	383	2	6	15	\N	\N	I_7gEkpwHvc	3	3	\N	\N	\N
3	3	Chest Expander Americana	You are holding your opponent in head in arm side control on his right, but he has his right arm inside. This \nopens an opportunity to attack this arm with an innovative attack.	1. Reach your right hand in between he chest and his wrist in between you. Move from top to bottom. You \nneed his wrist in your armpit.\n2. Gi: Grasp his far shoulder tight with your left arm which is under his neck. No gi: clamp his chin with your \nleft hand from under his neck. \n3. Turn to your right to "reverse ownage side control" where your left knee is pressed into his right hip. \n4. Hook his right leg with your right butterfly hook foot\n5. Keep turning away until you are parallel with him on your back. His right wrist is trapped in your right \narmpit and his right arm should be bent across your chest. \n6. Expand your chest to complete the americana	David Thomas	385	3	3	15	\N	\N	obt305SL6Pg	6	3	\N	\N	\N
3	17	Triceps Crush or Reverse Armbar from Inside Half Guard	You are fighting to pass his guard. As you come around to your left you will be controlling his right arm and \nattacking it directly from inside his guard. This muscle crush comes from a very strong 2-on-one position that \nmany people can't believe works, but try it. See the related technique for another great opportunity to hit this \nunique submission!	1. Grab his sleeve at his right wrist (gi) or his wrist (no gi) with your left hand. Hold very tight! As you come \npast half his guard, he may try to take your back. Your control of this arm will prevent that, if you hold \ntight!\n2. Momentarily pop his right arm up and put your right wrist, "blade up" under his triceps, just above the \nfulcrum point for an armbar.\n3. Immediately sprawl, chest first on his arm, crushing by clamping both of your hands together and \ndirecting the force of your right wrist's "blade" up. You may need to manipulate his arm a bit to direct the \nmost force into his muscle. As with all crushes, they work best when you are working perpendicular to the \ndirection of this muscle fibers.	David Thomas	386	3	5	15	\N	\N	cGNjuueQZIc	1	2	\N	\N	\N
2	5	2 on 1 Foot Control Guard Pass and Lockdown Defense	You are inside his open guard and will pass to your left.	1. Grab his right foot with both hands, making sure your right hand is strongly clamping the end of his foot \naround his toes. If you are in a shallow guard, his feet will be in front of you and easily accessible. If you \nare in a deeper guard, such as the beginning of a lockdown, his feet will be under you. If his feet are \nunder you, you will need to reach deep under your hips with both hands, leaning forward with your head \nposting on his hips (beware the guillotine). \n2. Once you have a strong grip, hold tight! Press his right foot into the center all the way into his groin and \nkeep it crowded there. His leg is very weak here and his foot can't get the straight strength it needs to \nextend and defend from here.\n3. Go around his right leg by driving your left knee past his right knee up his right thigh and press it in. \n4. Pivot around your knee (clockwise) to pass the guard\n5. A kneebar is close. See if you can get it.	David Thomas	387	3	8	15	\N	\N	guC-MUqMLgw	6	2	\N	\N	\N
3	17	Taffy Puller Hamstring Crush	This move is a fusion of a bunch of other techniques. If you are comfortable with the X Guard, Deep Half \nGuard, Biggie Slicer, and Kamikaze, you'll love this move. \nYou are on your back with opponent in your half left butterfly guard	1. Your left foot is behind his right knee in butterfly guard. Your right foot is on the ground. It can be \neither between his legs or pretty much anywhere, since you'll position it in a moment.\n2. You need to elevate him and turn him partially to his right. Reach your left hand under his left armpit \nand your right arm under his left leg as you elevate your butterfly guard. Press him up to raise him above \nyou. \n3. While he is aloft, quickly swing your right leg in front of his right instep and quickly pull your right leg \nback to you, trapping his right foot. Your left shin is still behind his right knee, deep (this is where the \ncrush is going to come from)\n4. Press your right foot against your left ankle, just like Kamikaze calf crush\n5. Reach both arms around his far (right) hip, S-grip and pull toward you as you press your legs away, into \nthe crush under his thigh (hamstring).	David Thomas	389	3	6	15	\N	\N	\N	8	3	\N	\N	\N
\.


--
-- TOC entry 2589 (class 0 OID 0)
-- Dependencies: 178
-- Name: technique_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('technique_id_seq', 389, true);


--
-- TOC entry 2577 (class 0 OID 48008)
-- Dependencies: 180
-- Data for Name: techniquetype; Type: TABLE DATA; Schema: public; Owner: -
--

COPY techniquetype (techniquetype, index) FROM stdin;
Defenses	1
Escapes	2
Submissions	3
Drills	4
Positions	5
Unbalancing	6
\.


--
-- TOC entry 2578 (class 0 OID 48011)
-- Dependencies: 181
-- Data for Name: topic; Type: TABLE DATA; Schema: public; Owner: -
--

COPY topic (topic, index) FROM stdin;
Chokes	1
Arm attacks	2
Shoulder attacks	3
Knee attacks	4
Guard	5
Takedowns and Throws	7
Sweeps	8
Side Controls	9
Mounts	10
Rear Mounts	11
Drill with Partner	12
Drill without Partner	13
Neck or back attacks	14
Ankle attacks	15
Foot attacks	16
Hip and thigh attacks	18
Conditioning or Flexibility	19
Crushes	17
\.


--
-- TOC entry 2579 (class 0 OID 48014)
-- Dependencies: 182
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY users (id, login, password, roleid, firstname, lastname, teamid) FROM stdin;
2	student	@jjRaWx!	2	\N	\N	\N
1	admin	tTtT4	1	David	Thomas	1
\.





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
