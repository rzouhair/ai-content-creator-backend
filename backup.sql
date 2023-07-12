--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2 (Debian 15.2-1.pgdg110+1)
-- Dumped by pg_dump version 15.2 (Debian 15.2-1.pgdg110+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO postgres;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_groups (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO postgres;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: content_generation_document; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.content_generation_document (
    _id uuid NOT NULL,
    content text NOT NULL,
    delta jsonb NOT NULL,
    name character varying(255) NOT NULL,
    "isPublic" boolean NOT NULL,
    status character varying(255) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    project_id uuid NOT NULL,
    suggestion_id uuid
);


ALTER TABLE public.content_generation_document OWNER TO postgres;

--
-- Name: content_generation_output; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.content_generation_output (
    _id uuid NOT NULL,
    text text NOT NULL,
    "completionId" character varying(255) NOT NULL,
    usage jsonb NOT NULL,
    "outputWordCount" integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    payload jsonb NOT NULL,
    skill_id uuid NOT NULL
);


ALTER TABLE public.content_generation_output OWNER TO postgres;

--
-- Name: content_generation_project; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.content_generation_project (
    _id uuid NOT NULL,
    name character varying(255) NOT NULL,
    description text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.content_generation_project OWNER TO postgres;

--
-- Name: content_generation_prompt; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.content_generation_prompt (
    _id uuid NOT NULL,
    prompt text NOT NULL,
    skill_id uuid NOT NULL
);


ALTER TABLE public.content_generation_prompt OWNER TO postgres;

--
-- Name: content_generation_recipe; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.content_generation_recipe (
    _id uuid NOT NULL,
    name text NOT NULL,
    body text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    last_used timestamp with time zone NOT NULL
);


ALTER TABLE public.content_generation_recipe OWNER TO postgres;

--
-- Name: content_generation_skill; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.content_generation_skill (
    _id uuid NOT NULL,
    name character varying(255) NOT NULL,
    description text NOT NULL,
    hidden boolean NOT NULL,
    beta boolean NOT NULL,
    icon character varying(50) NOT NULL,
    emoji character varying(5) NOT NULL,
    input_schema jsonb[] NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.content_generation_skill OWNER TO postgres;

--
-- Name: content_generation_skill_tags; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.content_generation_skill_tags (
    id bigint NOT NULL,
    skill_id uuid NOT NULL,
    tag_id uuid NOT NULL
);


ALTER TABLE public.content_generation_skill_tags OWNER TO postgres;

--
-- Name: content_generation_skill_tags_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.content_generation_skill_tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.content_generation_skill_tags_id_seq OWNER TO postgres;

--
-- Name: content_generation_skill_tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.content_generation_skill_tags_id_seq OWNED BY public.content_generation_skill_tags.id;


--
-- Name: content_generation_tag; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.content_generation_tag (
    _id uuid NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.content_generation_tag OWNER TO postgres;

--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_celery_results_chordcounter; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_celery_results_chordcounter (
    id integer NOT NULL,
    group_id character varying(255) NOT NULL,
    sub_tasks text NOT NULL,
    count integer NOT NULL,
    CONSTRAINT django_celery_results_chordcounter_count_check CHECK ((count >= 0))
);


ALTER TABLE public.django_celery_results_chordcounter OWNER TO postgres;

--
-- Name: django_celery_results_chordcounter_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_celery_results_chordcounter_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_celery_results_chordcounter_id_seq OWNER TO postgres;

--
-- Name: django_celery_results_chordcounter_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_celery_results_chordcounter_id_seq OWNED BY public.django_celery_results_chordcounter.id;


--
-- Name: django_celery_results_groupresult; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_celery_results_groupresult (
    id integer NOT NULL,
    group_id character varying(255) NOT NULL,
    date_created timestamp with time zone NOT NULL,
    date_done timestamp with time zone NOT NULL,
    content_type character varying(128) NOT NULL,
    content_encoding character varying(64) NOT NULL,
    result text
);


ALTER TABLE public.django_celery_results_groupresult OWNER TO postgres;

--
-- Name: django_celery_results_groupresult_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_celery_results_groupresult_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_celery_results_groupresult_id_seq OWNER TO postgres;

--
-- Name: django_celery_results_groupresult_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_celery_results_groupresult_id_seq OWNED BY public.django_celery_results_groupresult.id;


--
-- Name: django_celery_results_taskresult; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_celery_results_taskresult (
    id integer NOT NULL,
    task_id character varying(255) NOT NULL,
    status character varying(50) NOT NULL,
    content_type character varying(128) NOT NULL,
    content_encoding character varying(64) NOT NULL,
    result text,
    date_done timestamp with time zone NOT NULL,
    traceback text,
    meta text,
    task_args text,
    task_kwargs text,
    task_name character varying(255),
    worker character varying(100),
    date_created timestamp with time zone NOT NULL,
    periodic_task_name character varying(255)
);


ALTER TABLE public.django_celery_results_taskresult OWNER TO postgres;

--
-- Name: django_celery_results_taskresult_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_celery_results_taskresult_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_celery_results_taskresult_id_seq OWNER TO postgres;

--
-- Name: django_celery_results_taskresult_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_celery_results_taskresult_id_seq OWNED BY public.django_celery_results_taskresult.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: keywordresearch_article; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keywordresearch_article (
    _id uuid NOT NULL,
    title character varying(255) NOT NULL,
    meta_description character varying(255) NOT NULL,
    article_content text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    related_search_id_id uuid
);


ALTER TABLE public.keywordresearch_article OWNER TO postgres;

--
-- Name: keywordresearch_search; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keywordresearch_search (
    _id uuid NOT NULL,
    serps jsonb NOT NULL,
    questions jsonb NOT NULL,
    created_at timestamp with time zone NOT NULL,
    related_suggestion_id_id uuid
);


ALTER TABLE public.keywordresearch_search OWNER TO postgres;

--
-- Name: keywordresearch_suggestion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keywordresearch_suggestion (
    _id uuid NOT NULL,
    parent_keyword character varying(255) NOT NULL,
    search_query character varying(255) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    status character varying(255) NOT NULL,
    project_id uuid NOT NULL
);


ALTER TABLE public.keywordresearch_suggestion OWNER TO postgres;

--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: content_generation_skill_tags id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_generation_skill_tags ALTER COLUMN id SET DEFAULT nextval('public.content_generation_skill_tags_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_celery_results_chordcounter id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_celery_results_chordcounter ALTER COLUMN id SET DEFAULT nextval('public.django_celery_results_chordcounter_id_seq'::regclass);


--
-- Name: django_celery_results_groupresult id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_celery_results_groupresult ALTER COLUMN id SET DEFAULT nextval('public.django_celery_results_groupresult_id_seq'::regclass);


--
-- Name: django_celery_results_taskresult id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_celery_results_taskresult ALTER COLUMN id SET DEFAULT nextval('public.django_celery_results_taskresult_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add suggestion	1	add_suggestion
2	Can change suggestion	1	change_suggestion
3	Can delete suggestion	1	delete_suggestion
4	Can view suggestion	1	view_suggestion
5	Can add search	2	add_search
6	Can change search	2	change_search
7	Can delete search	2	delete_search
8	Can view search	2	view_search
9	Can add article	3	add_article
10	Can change article	3	change_article
11	Can delete article	3	delete_article
12	Can view article	3	view_article
13	Can add output	4	add_output
14	Can change output	4	change_output
15	Can delete output	4	delete_output
16	Can view output	4	view_output
17	Can add recipe	5	add_recipe
18	Can change recipe	5	change_recipe
19	Can delete recipe	5	delete_recipe
20	Can view recipe	5	view_recipe
21	Can add tag	6	add_tag
22	Can change tag	6	change_tag
23	Can delete tag	6	delete_tag
24	Can view tag	6	view_tag
25	Can add skill	7	add_skill
26	Can change skill	7	change_skill
27	Can delete skill	7	delete_skill
28	Can view skill	7	view_skill
29	Can add prompt	8	add_prompt
30	Can change prompt	8	change_prompt
31	Can delete prompt	8	delete_prompt
32	Can view prompt	8	view_prompt
33	Can add document	9	add_document
34	Can change document	9	change_document
35	Can delete document	9	delete_document
36	Can view document	9	view_document
37	Can add project	10	add_project
38	Can change project	10	change_project
39	Can delete project	10	delete_project
40	Can view project	10	view_project
41	Can add task result	11	add_taskresult
42	Can change task result	11	change_taskresult
43	Can delete task result	11	delete_taskresult
44	Can view task result	11	view_taskresult
45	Can add chord counter	12	add_chordcounter
46	Can change chord counter	12	change_chordcounter
47	Can delete chord counter	12	delete_chordcounter
48	Can view chord counter	12	view_chordcounter
49	Can add group result	13	add_groupresult
50	Can change group result	13	change_groupresult
51	Can delete group result	13	delete_groupresult
52	Can view group result	13	view_groupresult
53	Can add log entry	14	add_logentry
54	Can change log entry	14	change_logentry
55	Can delete log entry	14	delete_logentry
56	Can view log entry	14	view_logentry
57	Can add permission	15	add_permission
58	Can change permission	15	change_permission
59	Can delete permission	15	delete_permission
60	Can view permission	15	view_permission
61	Can add group	16	add_group
62	Can change group	16	change_group
63	Can delete group	16	delete_group
64	Can view group	16	view_group
65	Can add user	17	add_user
66	Can change user	17	change_user
67	Can delete user	17	delete_user
68	Can view user	17	view_user
69	Can add content type	18	add_contenttype
70	Can change content type	18	change_contenttype
71	Can delete content type	18	delete_contenttype
72	Can view content type	18	view_contenttype
73	Can add session	19	add_session
74	Can change session	19	change_session
75	Can delete session	19	delete_session
76	Can view session	19	view_session
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$260000$edRzVluIbMMz3XCY5gfZWV$Av2RffpTyOt8HIhaKxHQ7fq5SxW3x/lIKIB9Xy+aDU8=	2023-04-19 05:02:19.64356+00	t	root			roo@rrr.com	t	t	2023-04-19 04:04:43.387783+00
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: content_generation_document; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.content_generation_document (_id, content, delta, name, "isPublic", status, created_at, updated_at, project_id, suggestion_id) FROM stdin;
9b9ceeb7-f16b-490b-b1db-f7e8968c6fc3	Meta descriptions:\n- Learn how to tame and build trust with your baby cockatiels with our easy-to-follow guide. Make your pet sociable and interactive today!\n- Want to build a good relationship with your baby cockatiels? Check our tips to make them more sociable and enjoy a happier pet ownership experience.\n\nSteps to Follow for Taming Baby Cockatiels | A Comprehensive Guide\n\nIntroduction:\nBird lovers often enjoy interacting with their pets and building a deep connection with them. Baby cockatiels are an ideal choice for pet lovers who want a gentle and friendly pet bird. However, baby cockatiels may require taming and socialization to develop trust and become more sociable. This article will provide a step-by-step guide on the best ways to tame and socialize your baby cockatiel to help bird lovers have a more fulfilling experience with their pets.\n\nStep 1: Understanding Baby Cockatiels:\nIf you're a bird lover looking for a new pet, baby cockatiels might just be the perfect addition to your home. Understanding the behavior patterns of these adorable creatures is the first step in creating a strong bond and taming them.\nBaby cockatiels are highly sociable and bond easily with their owners, making them the ideal pet for those looking for a companion. These gentle birds are naturally curious and enjoy exploring their surroundings, so be sure to provide plenty of hanging toys and perches to keep them entertained.\nWith patience, love, and a little bit of training, you'll quickly form a close relationship with your new feathered friend.\n\nStep 2: Building Trust with Baby Cockatiels:\n\nBaby cockatiels are intelligent and social creatures that can make excellent pets for bird lovers. However, building trust with these cute little feathered friends requires patience and consistency.\nTo ensure a deep and lasting bond with baby cockatiels, it's essential to provide them with consistent care, positive interactions, and rewards-based training. Spending time with your bird every day, talking to them softly, and offering them treats when they do something good will help build their sociability and instill trust.\nRemember, building a bond with baby cockatiels takes time, so don't rush the process. Be patient and continue with the same routine every day until you begin to see results. Soon enough, your furry friend will begin to trust and bond with you, which will lead to an even more enjoyable pet ownership experience.\n\nStep 3: Taming Baby Cockatiels:\n\nTaming baby cockatiels takes time, patience, and consistency. As it is a common concern and can be achieved with patience and dedication.\nStart by hand-feeding your baby cockatiel and gradually introduce your hand, finger, and arm into their cage. Use positive reinforcement such as praises and treats whenever they approach you.\nStarting the taming process in a quiet and safe environment will help your baby cockatiel feel more comfortable and less frightened.\nWith time and effort, you can cultivate a strong bond between you and your baby cockatiel, achieving the sociability and companionship that bird lovers cherish.\n\nStep 4: Socialization of Baby Cockatiels:\n\nSocializing your baby cockatiel is an important step to take to help them become more outgoing and sociable. Introduce your baby cockatiel to new people, environments, and other pets to help them become familiar with different situations. Toys and music can also make their environment more stimulating and prevent boredom.\nStart by spending time with your bird every day, talking to them, and offering treats. Gradually introduce them to new people and gradually work up to new environments.\nIt's also important to provide a stimulating environment that includes toys and music to keep your bird engaged and entertained. By following these tips for socializing your baby cockatiel, you can help ensure a happy, sociable pet for years to come.\n\nHere are some potential heading outlines for the post above:\n\n1. Introduction \n- Bird lovers and baby cockatiels\n\n2. Understanding Baby Cockatiels\n- Behavior patterns \n- Sociability and curiosity \n- Forming a bond \n\n3. Building Trust with Baby Cockatiels\n- Providing consistent care \n- Positive interactions and rewards-based training \n- Patience and trust-building \n\n4. Taming Baby Cockatiels\n- Hand-feeding and introduction to your hand \n- Positive reinforcement \n- Starting in a quiet and safe environment \n- Cultivating a strong bond \n\n5. Socialization of Baby Cockatiels\n- Importance of socializing \n- Introducing to new people and environments \n- Stimulating environment with toys and music \n\n6. Conclusion \n- Achieving a happy, sociable pet with time and effort\nConclusion:\nIf you're a bird lover, taming and socializing your baby cockatiels can be a rewarding and fulfilling experience. Not only will your feathered friend be comfortable around you, but you'll also have a bond with them that surpasses any pet-owner relationship.\nTo sum up, taming and socializing your baby cockatiels can be a challenging task, but with the right approach, it can be a rewarding experience.\nRemember that understanding your bird's behavior is crucial to building trust and creating a bond. With patience and consistency, you can teach your baby cockatiel to be comfortable with you and other people.\nSo, what are you waiting for? Start taming and socializing your baby cockatiels today, and who knows? You might end up with a lifelong feathered friend. Happy bird training!\nFAQs\n\n1. Can you tame an adult cockatiel?\nYes, you can tame an adult cockatiel with patience, consistency, and trust-building techniques.\n\n2. How long does it take to tame a baby cockatiel?\nIt can take anywhere from a few weeks to a few months,Taming a baby cockatiel depends on their personality and temperament.\n\n3. Is it normal for baby cockatiels to be scared of humans?\nYes, it's normal for baby cockatiels to be scared of humans at first, but with patience and trust-building techniques, they can become more comfortable with human interaction.\n\n4. How often should I socialize my baby cockatiel?\nat least a few times a week, It's best to socialize your baby cockatiel regularly, to help them become more sociable and outgoing.\n\n5. What kind of toys should I get for my baby cockatiel?\nToys that are colorful, safe, and interactive, such as mirrors, swings, and puzzles, can help stimulate your baby cockatiel's mind and prevent boredom.\n\n6. What is the best age to start taming baby cockatiels?\nIt is best to start taming baby cockatiels as soon as they are weaned and able to eat on their own, which is typically around 8-12 weeks of age.\n\n7. How do I approach a baby cockatiel to start the taming process?\nApproach the bird slowly and calmly, using a soft voice and gentle movements. Offer treats such as millet spray to encourage the bird to come closer to you.\n\n8. What should I do if the baby cockatiel is scared and tries to fly away?\nIf the bird tries to fly away, do not chase after it or grab it forcefully. Simply step back and give it some space, then approach it again gradually and calmly.\n\n9. How can I build trust with a baby cockatiel?\nBuilding trust with a baby cockatiel takes time and patience. Spend time near the bird's cage or play area, and talk to it softly and offer treats. Gradually move closer to the bird and offer your hand or finger for it to perch on.\n\n10. What are some common mistakes to avoid when taming baby cockatiels?\nCommon mistakes include moving too quickly, handling the bird roughly, or not being consistent with your actions and expectations. It is also important to avoid using punishment or negative reinforcement, as this can damage the bird's trust in you.\n\n11. How long does it usually take to fully tame a baby cockatiel?\nThe time it takes to fully tame a baby cockatiel can vary depending on the bird's personality and previous experiences with humans. It can take anywhere from a few weeks to several months to establish a bond of trust and familiarity.\n\n12. How can I continue to socialize my cockatiel after it is fully tamed?\nAfter a cockatiel is fully tamed, continue to spend time with the bird on a daily basis and offer regular opportunities for interaction and play. Provide new toys and activities to keep the bird mentally and physically engaged.\n\n13. What should I do if my cockatiel suddenly becomes aggressive or fearful?\nIf your cockatiel suddenly becomes aggressive or fearful, it may be a sign of illness or discomfort. Consult a veterinarian to rule out any health issues and re-evaluate your taming approach to ensure you are creating a positive and safe environment for the bird.	{"ops": [{"insert": "Meta descriptions:\\n- Learn how to tame and build trust with your baby cockatiels with our easy-to-follow guide. Make your pet sociable and interactive today!\\n- Want to build a good relationship with your baby cockatiels? Check our tips to make them more sociable and enjoy a happier pet ownership experience.\\n\\nSteps to Follow for Taming Baby Cockatiels | A Comprehensive Guide"}, {"insert": "\\n", "attributes": {"header": 1}}, {"insert": "\\nIntroduction:"}, {"insert": "\\n", "attributes": {"header": 2}}, {"insert": "Bird lovers often enjoy interacting with their pets and building a deep connection with them. Baby cockatiels are an ideal choice for pet lovers who want a gentle and friendly pet bird. However, baby cockatiels may require taming and socialization to develop trust and become more sociable. This article will provide a step-by-step guide on the best ways to tame and socialize your baby cockatiel to help bird lovers have a more fulfilling experience with their pets.\\n\\nStep 1: Understanding Baby Cockatiels:"}, {"insert": "\\n", "attributes": {"header": 2}}, {"insert": "If you're a bird lover looking for a new pet, baby cockatiels might just be the perfect addition to your home. Understanding the behavior patterns of these adorable creatures is the first step in creating a strong bond and taming them.\\nBaby cockatiels are highly sociable and bond easily with their owners, making them the ideal pet for those looking for a companion. These gentle birds are naturally curious and enjoy exploring their surroundings, so be sure to provide plenty of hanging toys and perches to keep them entertained.\\nWith patience, love, and a little bit of training, you'll quickly form a close relationship with your new feathered friend.\\n\\nStep 2: Building Trust with Baby Cockatiels:"}, {"insert": "\\n", "attributes": {"header": 2}}, {"insert": "\\nBaby cockatiels are intelligent and social creatures that can make excellent pets for bird lovers. However, building trust with these cute little feathered friends requires patience and consistency.\\nTo ensure a deep and lasting bond with baby cockatiels, it's essential to provide them with consistent care, positive interactions, and rewards-based training. Spending time with your bird every day, talking to them softly, and offering them treats when they do something good will help build their sociability and instill trust.\\nRemember, building a bond with baby cockatiels takes time, so don't rush the process. Be patient and continue with the same routine every day until you begin to see results. Soon enough, your furry friend will begin to trust and bond with you, which will lead to an even more enjoyable pet ownership experience.\\n\\nStep 3: Taming Baby Cockatiels:"}, {"insert": "\\n", "attributes": {"header": 2}}, {"insert": "\\nTaming baby cockatiels takes time, patience, and consistency. As it is a common concern and can be achieved with patience and dedication.\\nStart by hand-feeding your baby cockatiel and gradually introduce your hand, finger, and arm into their cage. Use positive reinforcement such as praises and treats whenever they approach you.\\nStarting the taming process in a quiet and safe environment will help your baby cockatiel feel more comfortable and less frightened.\\nWith time and effort, you can cultivate a strong bond between you and your baby cockatiel, achieving the sociability and companionship that bird lovers cherish.\\n\\nStep 4: Socialization of Baby Cockatiels:"}, {"insert": "\\n", "attributes": {"header": 2}}, {"insert": "\\nSocializing your baby cockatiel is an important step to take to help them become more outgoing and sociable. Introduce your baby cockatiel to new people, environments, and other pets to help them become familiar with different situations. Toys and music can also make their environment more stimulating and prevent boredom.\\nStart by spending time with your bird every day, talking to them, and offering treats. Gradually introduce them to new people and gradually work up to new environments.\\nIt's also important to provide a stimulating environment that includes toys and music to keep your bird engaged and entertained. By following these tips for socializing your baby cockatiel, you can help ensure a happy, sociable pet for years to come.\\n\\nHere are some potential heading outlines for the post above:\\n\\n1. Introduction \\n- Bird lovers and baby cockatiels\\n\\n2. Understanding Baby Cockatiels\\n- Behavior patterns \\n- Sociability and curiosity \\n- Forming a bond \\n\\n3. Building Trust with Baby Cockatiels\\n- Providing consistent care \\n- Positive interactions and rewards-based training \\n- Patience and trust-building \\n\\n4. Taming Baby Cockatiels\\n- Hand-feeding and introduction to your hand \\n- Positive reinforcement \\n- Starting in a quiet and safe environment \\n- Cultivating a strong bond \\n\\n5. Socialization of Baby Cockatiels\\n- Importance of socializing \\n- Introducing to new people and environments \\n- Stimulating environment with toys and music \\n\\n6. Conclusion \\n- Achieving a happy, sociable pet with time and effort\\nConclusion:"}, {"insert": "\\n", "attributes": {"header": 2}}, {"insert": "If you're a bird lover, taming and socializing your baby cockatiels can be a rewarding and fulfilling experience. Not only will your feathered friend be comfortable around you, but you'll also have a bond with them that surpasses any pet-owner relationship.\\nTo sum up, taming and socializing your baby cockatiels can be a challenging task, but with the right approach, it can be a rewarding experience.\\nRemember that understanding your bird's behavior is crucial to building trust and creating a bond. With patience and consistency, you can teach your baby cockatiel to be comfortable with you and other people.\\nSo, what are you waiting for? Start taming and socializing your baby cockatiels today, and who knows? You might end up with a lifelong feathered friend. Happy bird training!\\nFAQs"}, {"insert": "\\n", "attributes": {"header": 2}}, {"insert": "\\n1. Can you tame an adult cockatiel?\\nYes, you can tame an adult cockatiel with patience, consistency, and trust-building techniques.\\n\\n2. How long does it take to tame a baby cockatiel?\\nIt can take anywhere from a few weeks to a few months,Taming a baby cockatiel depends on their personality and temperament.\\n\\n3. Is it normal for baby cockatiels to be scared of humans?\\nYes, it's normal for baby cockatiels to be scared of humans at first, but with patience and trust-building techniques, they can become more comfortable with human interaction.\\n\\n4. How often should I socialize my baby cockatiel?\\nat least a few times a week, It's best to socialize your baby cockatiel regularly, to help them become more sociable and outgoing.\\n\\n5. What kind of toys should I get for my baby cockatiel?\\nToys that are colorful, safe, and interactive, such as mirrors, swings, and puzzles, can help stimulate your baby cockatiel's mind and prevent boredom.\\n\\n6. What is the best age to start taming baby cockatiels?\\nIt is best to start taming baby cockatiels as soon as they are weaned and able to eat on their own, which is typically around 8-12 weeks of age.\\n\\n7. How do I approach a baby cockatiel to start the taming process?\\nApproach the bird slowly and calmly, using a soft voice and gentle movements. Offer treats such as millet spray to encourage the bird to come closer to you.\\n\\n8. What should I do if the baby cockatiel is scared and tries to fly away?\\nIf the bird tries to fly away, do not chase after it or grab it forcefully. Simply step back and give it some space, then approach it again gradually and calmly.\\n\\n9. How can I build trust with a baby cockatiel?\\nBuilding trust with a baby cockatiel takes time and patience. Spend time near the bird's cage or play area, and talk to it softly and offer treats. Gradually move closer to the bird and offer your hand or finger for it to perch on.\\n\\n10. What are some common mistakes to avoid when taming baby cockatiels?\\nCommon mistakes include moving too quickly, handling the bird roughly, or not being consistent with your actions and expectations. It is also important to avoid using punishment or negative reinforcement, as this can damage the bird's trust in you.\\n\\n11. How long does it usually take to fully tame a baby cockatiel?\\nThe time it takes to fully tame a baby cockatiel can vary depending on the bird's personality and previous experiences with humans. It can take anywhere from a few weeks to several months to establish a bond of trust and familiarity.\\n\\n12. How can I continue to socialize my cockatiel after it is fully tamed?\\nAfter a cockatiel is fully tamed, continue to spend time with the bird on a daily basis and offer regular opportunities for interaction and play. Provide new toys and activities to keep the bird mentally and physically engaged.\\n\\n13. What should I do if my cockatiel suddenly becomes aggressive or fearful?\\nIf your cockatiel suddenly becomes aggressive or fearful, it may be a sign of illness or discomfort. Consult a veterinarian to rule out any health issues and re-evaluate your taming approach to ensure you are creating a positive and safe environment for the bird.\\n"}]}	Test	t	CREATED	2023-04-24 10:55:45.885145+00	2023-04-24 11:01:06.151287+00	41fee383-6cac-4790-8828-4a7cdfa5f902	4c425af7-44e0-4c83-9e31-b68d802bf8d1
\.


--
-- Data for Name: content_generation_output; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.content_generation_output (_id, text, "completionId", usage, "outputWordCount", created_at, payload, skill_id) FROM stdin;
252cca16-e7c5-42bf-9ee1-1b0150e74204	Introduction:\r\n\r\nCockatiels are known for their playful attitude and chirpy behavior, but did you know that their sleep pattern is also an important aspect of their health? As a responsible cockatiel owner, it is crucial to understand your bird's sleep needs and provide them with the necessary conditions to ensure they get the rest they need.\r\n\r\nHeadings:\r\n\r\n1. Understanding Cockatiel Sleep Needs\r\n2. Creating a Comfortable Sleeping Environment\r\n3. Monitoring Your Cockatiel's Sleep Pattern\r\n4. Common Sleep Problems in Cockatiels\r\n5. Conclusion: Ensuring a Healthy Sleep Routine for Your Cockatiel\r\n\r\nUnderstanding Cockatiel Sleep Needs:\r\n\r\nLike humans, cockatiels need a certain amount of sleep to stay healthy and active throughout the day. A healthy adult cockatiel needs around 10-12 hours of sleep a day, while baby chicks may need up to 14 hours of sleep. It's important to consider these sleep needs when planning their daily routine and providing them with a comfortable sleep environment.\r\n\r\nCreating a Comfortable Sleeping Environment:\r\n\r\nCockatiels are sensitive to light and noise, which can disrupt their sleep pattern. To ensure your bird gets a good night's sleep, set up their sleeping area in a quiet, dark corner of the room. Cover their cage with a cloth or a fitted cage cover to block out any light and provide them with a sense of security.\r\n\r\nMonitoring Your Cockatiel's Sleep Pattern:\r\n\r\nObserving your cockatiel's sleep pattern is essential to ensure they are getting enough rest. A healthy cockatiel should be able to sleep through the night without any disturbances. If you notice any changes, such as excessive sleep or difficulty sleeping, it may be a sign of an underlying health issue.\r\n\r\nCommon Sleep Problems in Cockatiels:\r\n\r\nSome common sleep problems in cockatiels include sleeping during the day, restlessness at night, and excessive vocalization. These can be caused by factors such as uncomfortable surroundings, poor diet or exercise, or underlying health conditions. It's important to address any issues promptly and seek medical attention if necessary.\r\n\r\nConclusion: Ensuring a Healthy Sleep Routine for Your Cockatiel\r\n\r\nIn conclusion, understanding your cockatiel's sleep needs is essential to keep them healthy, happy, and active. By creating a comfortable sleeping environment, monitoring their sleep pattern, and identifying and addressing any sleep issues, you can ensure your feathered friend gets the rest they need. Remember to consult a veterinarian if you have any concerns about your cockatiel's sleep pattern or behavior. Happy sleeping!		{"total_tokens": 774, "prompt_tokens": 258, "completion_tokens": 516}	398	2023-04-21 22:13:47.596898+00	{"inputs": {"tone": "Informative and helpful", "blogtopic": "Cockatiel sleep pattern", "num_outputs": 2, "intendedaudience": "Cockatiel owners"}, "skill_id": "e064acb7-ca92-4986-a2a8-2592549f7e6a"}	e064acb7-ca92-4986-a2a8-2592549f7e6a
5221742b-876d-4300-9442-eea69fa6e7d2	Introduction:\r\nAs a cockatiel owner, you may have wondered about your feathered friend's sleep pattern. Well, you're not alone! Many cockatiel owners have questions about how much sleep their birds need and when they should be sleeping. In this blog post, we'll take a look at cockatiel sleep patterns, so you can better understand your pet's sleeping habits and ensure that they're getting the rest they need.\r\n\r\nWhy Do Cockatiels Need Their Sleep?\r\nJust like humans, Cockatiels need their rest too. Sleep is essential for keeping your pet healthy and happy. During sleep, the body repairs itself and consolidates memories, which helps in the learning process. A lack of sleep can lead to a variety of health problems, including weakened immune systems and behavioral issues.\r\n\r\nHow Much Sleep Do Cockatiels Need?\r\nCockatiels require 10 to 12 hours of sleep each day. This means that they should have a quiet, dark, and comfortable place to sleep for at least ten hours each night, ideally in a special designated sleep cage. This is different from their regular cage where they spend the day, where there will probably be more activity than they’re used to during the evening and across the day.\r\n\r\nDo Cockatiels Sleep at Night or During the Day?\r\nCockatiels are diurnal animals, which means that they are most active during the day, and tend to sleep at night. You may notice that your bird dozes off during the evening and awakens as the sun rises. However, you'll also notice that they might take naps throughout the day. This is normal and is essential to ensure that your pet gets the full amount of sleep they need each day.\r\n\r\nCreating the Ideal Sleeping Environment.\r\nTo create the ideal sleeping environment for your cockatiel, you'll want to ensure that their designated sleep cage is in a quiet, dark room at night-time. This will help to reduce any disturbances that might affect their sleep. You'll also want to make sure that they have access to clean water, with easy access to food in the case of an emergency, should they wake up and feel hungry.\r\n\r\nConclusion:\r\nEnsuring that your cockatiel gets the sleep they need each day is essential to keep them healthy, happy, and active. As a responsible pet owner, it's your job to provide them with the right environment to sleep in, and to make sure that they have a regular sleep pattern that works for them. By following the tips outlined in this blog post, you'll be able to provide your cockatiel with the perfect sleeping environment, and help them to get the rest they need to remain healthy and happy.		{"total_tokens": 798, "prompt_tokens": 258, "completion_tokens": 540}	441	2023-04-21 22:14:00.802705+00	{"inputs": {"tone": "Informative and helpful", "blogtopic": "Cockatiel sleep pattern", "num_outputs": 2, "intendedaudience": "Cockatiel owners"}, "skill_id": "e064acb7-ca92-4986-a2a8-2592549f7e6a"}	e064acb7-ca92-4986-a2a8-2592549f7e6a
e7b4bd1c-4cf7-4b30-b69a-cf8d36833e7a	1. Why do cockatiels sleep so much during the day?\n\nCockatiels are diurnal, meaning that they are most active during daylight hours. It is natural for them to sleep during the day as a way to conserve energy for when they are most active. Additionally, they sleep more during the day because they are more susceptible to predators during this time.\n\n2. How many hours of sleep do cockatiels need each day?\n\nCockatiels need around 10-12 hours of sleep each day. This sleep can be split between daytime naps and nighttime rest. It is important to provide your cockatiel with a quiet and dark sleeping area to ensure they get the rest they need.\n\n3. Can cockatiels sleep with lights on?\n\nIdeally, cockatiels should sleep with no lights on, as any source of light can disrupt their natural sleep patterns. It is best to provide them with a quiet, dark sleeping area to promote restful sleep.\n\n4. Should I cover my cockatiel's cage at night?\n\nCovering your cockatiel's cage at night can help promote restful sleep, as it blocks out any sources of light or noise that could disrupt their sleeping patterns. However, it is important to ensure that your cockatiel has access to fresh air and ventilation, and that the cover is not too tight or restrictive.\n\n5. How can I tell if my cockatiel is sleeping soundly?\n\nWhen cockatiels are sleeping soundly, they will typically have their eyes completely closed, with their head tucked into their feathers. They may also fluff up their feathers and lower their body temperature slightly to conserve energy. If your cockatiel is restless or agitated during sleep, it may be a sign that they are not getting enough rest.\n\n6. Is it normal for cockatiels to sleep standing up?\n\nCockatiels are able to relax and sleep while perched, as they have a specialized tendon that allows them to lock their feet in place while they rest. Some cockatiels may also sleep on the bottom of the cage, but this is less common. If your cockatiel seems comfortable and relaxed while sleeping, there is no need for concern.		{"total_tokens": 735, "prompt_tokens": 286, "completion_tokens": 449}	354	2023-04-21 22:22:12.331191+00	{"inputs": {"tone": "Informative and helpful", "topic": "The Surprising Science Behind Cockatiel Sleep Patterns", "num_outputs": 1, "productInfo": "6"}, "skill_id": "9e2f157f-76d9-4aef-9199-3fc2faceb10f"}	9e2f157f-76d9-4aef-9199-3fc2faceb10f
6af884f6-1e24-40c5-90f4-dddd6c6bc71b	Content Brief\n\nThe article on "Steps to Follow for Taming Baby Cockatiels" is targeted towards bird lovers, especially those who own baby cockatiels as pets. The article aims to provide a step-by-step guide on how to tame these birds, how to bond with them, and how to make them more sociable.\n\nTop level Keywords:\n- Baby cockatiels\n- Taming\n- Bird lovers\n- Bonding\n- Sociability\n\nLongtail Keywords:\n- How to tame baby cockatiels\n- Building trust with baby cockatiels\n- Baby cockatiels socialization\n- Best ways to bond with baby cockatiels\n\nHeader Outline:\n- Introduction\n- Step 1: Understanding Baby Cockatiels\n- Step 2: Building Trust with Baby Cockatiels\n- Step 3: Taming Baby Cockatiels\n- Step 4: Socialization of Baby Cockatiels\n- Conclusion\n\nNotes for the Topic:\n- Understand the nature of baby cockatiels\n- Building a good relationship with them\n- Teach them to perch and fly\n- Make them more sociable\n\nTitle Tags:\n- Steps to Follow for Taming Baby Cockatiels | A Comprehensive Guide\n- Building Trust and Sociability with Baby Cockatiels | Tips and Tricks\n\nMeta descriptions:\n- Learn how to tame and build trust with your baby cockatiels with our easy-to-follow guide. Make your pet sociable and interactive today!\n- Want to build a good relationship with your baby cockatiels? Check our tips to make them more sociable and enjoy a happier pet ownership experience.\n\nText and Explanation:\n\nIntroduction:\n- Introduce the topic and the purpose of the article, highlighting why it is important for bird lovers to tame and socialize their baby cockatiels.\n\nStep 1: Understanding Baby Cockatiels:\n- Explain the nature of baby cockatiels, their behavior patterns, and what makes them ideal pets. This will help readers understand what to expect from their new pets.\n\nStep 2: Building Trust with Baby Cockatiels:\n- Discuss tips for building trust with baby cockatiels, such as consistent care, positive interactions, and rewards-based training. Highlight the importance of patience and consistency in building trust.\n\nStep 3: Taming Baby Cockatiels:\n- Provide a step-by-step guide on how to tame baby cockatiels, starting with hand-feeding and gradually introducing them to hands, fingers, and arms. Highlight the importance of positive reinforcement and starting in a quiet and safe environment.\n\nStep 4: Socialization of Baby Cockatiels:\n- Discuss how to make baby cockatiels more sociable, such as introducing them to new people, environments, and other pets. Provide tips for making their environment more stimulating, such as toys and music.\n\nConclusion:\n- Summarize the key points of the article, reminding readers of the benefits of taming and socializing their baby cockatiels. Encourage them to implement the steps outlined in the article for a happier and more fulfilling pet ownership experience.		{"total_tokens": 754, "prompt_tokens": 132, "completion_tokens": 622}	450	2023-04-23 20:47:20.91701+00	{"inputs": {"topic": "Steps to Follow for Taming Baby Cockatiels", "num_outputs": 1}, "skill_id": "e1f5f2c4-78d1-4f25-a08d-0ce4f5af97d5"}	e1f5f2c4-78d1-4f25-a08d-0ce4f5af97d5
47537173-aae9-4cba-8903-67df60de2a71	**Steps to Follow for Taming Baby Cockatiels**\n\nIntroduction:\n\nBird lovers often enjoy interacting with their pets and building a deep connection with them. Baby cockatiels are an ideal choice for pet lovers who want a gentle and friendly pet bird. However, baby cockatiels may require taming and socialization to develop trust and become more sociable. This article will provide a step-by-step guide on the best ways to tame and socialize your baby cockatiel to help bird lovers have a more fulfilling experience with their pets.\n\nStep 1: Understanding Baby Cockatiels:\n\nBefore attempting to tame and socialize your baby cockatiel, it's essential to understand their behavior patterns. Baby cockatiels are curious and playful birds and may get easily frightened by sudden movements or loud noises. They also crave attention and interaction from their owners. Understanding your baby cockatiel's behavior patterns will help you create a nurturing environment for them.\n\nStep 2: Building Trust with Baby Cockatiels:\n\nBuilding trust with your baby cockatiel is essential before you start the taming process. Consistent care, positive interactions, and rewards-based training are some of the ways to build trust with baby cockatiels. Let your baby cockatiel get comfortable with you by spending some time in their vicinity, talking or humming to them, and rewarding them with their favorite treats whenever they approach you.\n\nStep 3: Taming Baby Cockatiels:\n\nTaming baby cockatiels takes time, patience, and consistency. Start by hand-feeding your baby cockatiel and gradually introduce your hand, finger, and arm into their cage. Use positive reinforcement such as praises and treats whenever they approach you. Starting the taming process in a quiet and safe environment will help your baby cockatiel feel more comfortable and less frightened.\n\nStep 4: Socialization of Baby Cockatiels:\n\nSocializing your baby cockatiel is essential to help them become more outgoing and sociable. Introduce your baby cockatiel to new people, environments, and other pets to help them become familiar with different situations. Toys and music can also make their environment more stimulating and prevent boredom.\n\nConclusion:\n\nIn conclusion, taming and socializing baby cockatiels is an essential aspect of pet ownership for bird lovers. Understanding baby cockatiels' behavior patterns, building trust, taming them through positive reinforcement, and socializing them in new environments can help create a bond with your baby cockatiel. By implementing the steps outlined in this article, bird lovers can enjoy a happier and more fulfilling experience with their pet birds.\n\n**FAQs**\n\n1. Can you tame an adult cockatiel?\nYes, you can tame an adult cockatiel with patience, consistency, and trust-building techniques.\n\n2. How long does it take to tame a baby cockatiel?\nTaming a baby cockatiel depends on their personality and temperament but can take anywhere from a few weeks to a few months.\n\n3. Is it normal for baby cockatiels to be scared of humans?\nYes, it's normal for baby cockatiels to be scared of humans at first, but with patience and trust-building techniques, they can become more comfortable with human interaction.\n\n4. How often should I socialize my baby cockatiel?\nIt's best to socialize your baby cockatiel regularly, at least a few times a week, to help them become more sociable and outgoing.\n\n5. What kind of toys should I get for my baby cockatiel?\nToys that are colorful, safe, and interactive, such as mirrors, swings, and puzzles, can help stimulate your baby cockatiel's mind and prevent boredom.		{"total_tokens": 1451, "prompt_tokens": 704, "completion_tokens": 747}	560	2023-04-23 20:50:51.1075+00	{"inputs": {"tone": "Informative and helpful", "blogtopic": "Steps to Follow for Taming Baby Cockatiels\\nOutline:\\n\\nLongtail Keywords:\\n- How to tame baby cockatiels\\n- Building trust with baby cockatiels\\n- Baby cockatiels socialization\\n- Best ways to bond with baby cockatiels\\n\\nIntroduction:\\n\\n- Introduce the topic and the purpose of the article, highlighting why it is important for bird lovers to tame and socialize their baby cockatiels.\\n\\n\\n\\nStep 1: Understanding Baby Cockatiels:\\n\\n- Explain the nature of baby cockatiels, their behavior patterns, and what makes them ideal pets. This will help readers understand what to expect from their new pets.\\n\\n\\n\\nStep 2: Building Trust with Baby Cockatiels:\\n\\n- Discuss tips for building trust with baby cockatiels, such as consistent care, positive interactions, and rewards-based training. Highlight the importance of patience and consistency in building trust.\\n\\n\\n\\nStep 3: Taming Baby Cockatiels:\\n\\n- Provide a step-by-step guide on how to tame baby cockatiels, starting with hand-feeding and gradually introducing them to hands, fingers, and arms. Highlight the importance of positive reinforcement and starting in a quiet and safe environment.\\n\\n\\n\\nStep 4: Socialization of Baby Cockatiels:\\n\\n- Discuss how to make baby cockatiels more sociable, such as introducing them to new people, environments, and other pets. Provide tips for making their environment more stimulating, such as toys and music.\\n\\n\\n\\nConclusion:\\n\\n- Summarize the key points of the article, reminding readers of the benefits of taming and socializing their baby cockatiels. Encourage them to implement the steps outlined in the article for a happier and more fulfilling pet ownership experience.", "num_outputs": 1, "intendedaudience": "bird lovers and baby cockatiel owners"}, "skill_id": "57061e24-3241-4392-8e5d-ea10787471b6"}	57061e24-3241-4392-8e5d-ea10787471b6
58e58fd9-a127-407c-b5c7-3c5b5b123561	If you're a bird lover looking for a new pet, baby cockatiels might just be the perfect addition to your home. Understanding the behavior patterns of these adorable creatures is the first step in creating a strong bond and taming them. Baby cockatiels are highly sociable and bond easily with their owners, making them the ideal pet for those looking for a companion. These gentle birds are naturally curious and enjoy exploring their surroundings, so be sure to provide plenty of hanging toys and perches to keep them entertained. With patience, love, and a little bit of training, you'll quickly form a close relationship with your new feathered friend.		{"total_tokens": 429, "prompt_tokens": 299, "completion_tokens": 130}	109	2023-04-23 21:05:37.858635+00	{"inputs": {"tone": "", "topic": "Step 1: Understanding Baby Cockatiels:\\n\\n- Explain the nature of baby cockatiels, their behavior patterns, and what makes them ideal pets. This will help readers understand what to expect from their new pets.", "keywords": "Baby cockatiels  - Taming  - Bird lovers  - Bonding  - Sociability", "num_outputs": 1}, "skill_id": "7a6dccb1-c0c6-4014-b72c-d00fa412c80a"}	7a6dccb1-c0c6-4014-b72c-d00fa412c80a
5cddf079-6651-43fd-8674-0b972bbca212	Baby cockatiels are intelligent and social creatures that can make excellent pets for bird lovers. However, building trust with these cute little feathered friends requires patience and consistency. To ensure a deep and lasting bond with baby cockatiels, it's essential to provide them with consistent care, positive interactions, and rewards-based training. Spending time with your bird every day, talking to them softly, and offering them treats when they do something good will help build their sociability and instill trust. Remember, building a bond with baby cockatiels takes time, so don't rush the process. Be patient and continue with the same routine every day until you begin to see results. Soon enough, your furry friend will begin to trust and bond with you, which will lead to an even more enjoyable pet ownership experience.		{"total_tokens": 469, "prompt_tokens": 307, "completion_tokens": 162}	133	2023-04-23 21:06:36.427292+00	{"inputs": {"tone": "", "topic": "Step 2: Building Trust with Baby Cockatiels:\\n\\n- Discuss tips for building trust with baby cockatiels, such as consistent care, positive interactions, and rewards-based training. Highlight the importance of patience and consistency in building trust.", "keywords": "Baby cockatiels  - Taming  - Bird lovers  - Bonding  - Sociability", "num_outputs": 1}, "skill_id": "7a6dccb1-c0c6-4014-b72c-d00fa412c80a"}	7a6dccb1-c0c6-4014-b72c-d00fa412c80a
95791469-52fe-4cd7-a182-693a7d35d2e6	Are you the proud owner of a baby cockatiel but struggling to bond with your feathered friend? Fear not, as taming baby cockatiels is a common concern and can be achieved with patience and dedication. Start by hand-feeding your little one to establish trust and familiarity. From there, gradually introduce your hands, fingers, and arms while providing positive reinforcement for good behavior. Remember to always work in a quiet and safe environment to avoid overwhelming your bird. With time and effort, you can cultivate a strong bond between you and your baby cockatiel, achieving the sociability and companionship that bird lovers cherish.		{"total_tokens": 457, "prompt_tokens": 331, "completion_tokens": 126}	102	2023-04-23 21:07:24.670648+00	{"inputs": {"tone": "", "topic": "Step 3: Taming Baby Cockatiels:\\n\\n- Provide a step-by-step guide on how to tame baby cockatiels, starting with hand-feeding and gradually introducing them to hands, fingers, and arms. Highlight the importance of positive reinforcement and starting in a quiet and safe environment.\\n\\n", "keywords": "Baby cockatiels  - Taming  - Bird lovers  - Bonding  - Sociability", "num_outputs": 1}, "skill_id": "7a6dccb1-c0c6-4014-b72c-d00fa412c80a"}	7a6dccb1-c0c6-4014-b72c-d00fa412c80a
96447806-9384-435e-8e40-39ec97489f60	If you're a bird lover who wants to bond with their new baby cockatiel, socializing them is an important step to take. Taming a baby bird can be a slow process, but introducing them to new people, environments, and other pets can make a big difference. Start by spending time with your bird every day, talking to them and offering treats. Gradually introduce them to new people and gradually work up to new environments. It's also important to provide a stimulating environment that includes toys and music to keep your bird engaged and entertained. By following these tips for socializing your baby cockatiel, you can help ensure a happy, sociable pet for years to come.		{"total_tokens": 460, "prompt_tokens": 321, "completion_tokens": 139}	115	2023-04-23 21:09:28.865026+00	{"inputs": {"tone": "", "topic": "Step 4: Socialization of Baby Cockatiels:\\n\\n- Discuss how to make baby cockatiels more sociable, such as introducing them to new people, environments, and other pets. Provide tips for making their environment more stimulating, such as toys and music.\\n\\n", "keywords": "Baby cockatiels  - Taming  - Bird lovers  - Bonding  - Sociability", "num_outputs": 1}, "skill_id": "7a6dccb1-c0c6-4014-b72c-d00fa412c80a"}	7a6dccb1-c0c6-4014-b72c-d00fa412c80a
fc2ed9b2-01b2-49ba-ba0f-f98ea24f8893	If you're a bird lover, taming and socializing your baby cockatiels can be a rewarding and fulfilling experience. Not only will your feathered friend be comfortable around you, but you'll also have a bond with them that surpasses any pet-owner relationship. However, the process of taming and socializing your baby cockatiels requires patience, consistency, and dedication. In this article, we've outlined several steps you can take to help your baby cockatiels feel more comfortable around you and become more sociable. We've also discussed the benefits of taming and socializing your baby cockatiels, including improved health, behavior, and overall happiness. By implementing these steps and following our advice, you can create a stronger bond with your baby cockatiels and enjoy a more rewarding and fulfilling pet ownership experience. So, what are you waiting for? Start taming and socializing your baby cockatiels today!		{"total_tokens": 503, "prompt_tokens": 315, "completion_tokens": 188}	141	2023-04-23 21:10:49.869426+00	{"inputs": {"tone": "", "topic": "\\nConclusion:\\n\\n- Summarize the key points of the article, reminding readers of the benefits of taming and socializing their baby cockatiels. Encourage them to implement the steps outlined in the article for a happier and more fulfilling pet ownership experience.", "keywords": "Baby cockatiels  - Taming  - Bird lovers  - Bonding  - Sociability", "num_outputs": 1}, "skill_id": "7a6dccb1-c0c6-4014-b72c-d00fa412c80a"}	7a6dccb1-c0c6-4014-b72c-d00fa412c80a
1dcb97a6-9219-4b18-bcb6-399dbd12ae16	In conclusion, taming and socializing baby cockatiels is a process that requires patience, dedication, and a deep understanding of the birds. It starts with building trust, gradually introducing hands and toys, and ensuring that your pet feels comfortable around other people and animals. Remember to provide a safe and stimulating environment, and to reward positive behavior with treats and affection. By following the steps outlined in this post, you can create a strong bond with your pet and enjoy years of companionship and entertainment. So, what are you waiting for? Start implementing these tips today and watch your baby cockatiels thrive!		{"total_tokens": 431, "prompt_tokens": 309, "completion_tokens": 122}	101	2023-04-23 21:11:59.505195+00	{"inputs": {"cta": "So, what are you waiting for? Start taming and socializing your baby cockatiels today!", "tone": "", "num_outputs": 1, "blogPostMainPoints": "Header Outline:\\n\\n- Introduction\\n\\n- Step 1: Understanding Baby Cockatiels\\n\\n- Step 2: Building Trust with Baby Cockatiels\\n\\n- Step 3: Taming Baby Cockatiels\\n\\n- Step 4: Socialization of Baby Cockatiels\\n\\n- Conclusion"}, "skill_id": "855f2a04-0313-41b2-b198-a6d8fab25cf6"}	855f2a04-0313-41b2-b198-a6d8fab25cf6
aa8327a4-caba-41c4-a196-1eeadfc81521	In conclusion, understanding, trusting, taming, and socializing a baby cockatiel requires patience, dedication, and love. It takes time and effort, but it’s worth it in the end when you have a happy, well-adjusted, and friendly pet bird. Remember to take things slowly, gain their trust, and introduce them to new experiences gradually. Keep in mind that every bird is different and they have their own unique personality, so what works for one might not work for another. Finally, don’t forget to enjoy the journey and have fun bonding with your furry little friend. So, what are you waiting for? Start your journey of taming and socializing your baby cockatiel today!		{"total_tokens": 455, "prompt_tokens": 312, "completion_tokens": 143}	110	2023-04-23 21:12:35.039433+00	{"inputs": {"cta": "So, what are you waiting for? Start taming and socializing your baby cockatiels today!", "tone": "Funny and motivating", "num_outputs": 1, "blogPostMainPoints": "Header Outline:\\n\\n- Introduction\\n\\n- Step 1: Understanding Baby Cockatiels\\n\\n- Step 2: Building Trust with Baby Cockatiels\\n\\n- Step 3: Taming Baby Cockatiels\\n\\n- Step 4: Socialization of Baby Cockatiels\\n\\n- Conclusion"}, "skill_id": "855f2a04-0313-41b2-b198-a6d8fab25cf6"}	855f2a04-0313-41b2-b198-a6d8fab25cf6
b624452c-9f98-422a-810e-5b4f7c1506d5	In conclusion, raising baby cockatiels is a wonderful and rewarding experience, but it requires effort and patience. Understanding your baby cockatiels, building trust with them, taming them, and socializing them are the four main steps that will ensure a strong bond between you and your feathered friend. Remember to use a gentle approach, positive reinforcement, and plenty of love and patience. So, what are you waiting for? Start taming and socializing your baby cockatiels today! With time and dedication, your little bird will become a loyal and loving companion for life.		{"total_tokens": 429, "prompt_tokens": 312, "completion_tokens": 117}	91	2023-04-23 21:12:51.67103+00	{"inputs": {"cta": "So, what are you waiting for? Start taming and socializing your baby cockatiels today!", "tone": "Comedy and motivating", "num_outputs": 1, "blogPostMainPoints": "Header Outline:\\n\\n- Introduction\\n\\n- Step 1: Understanding Baby Cockatiels\\n\\n- Step 2: Building Trust with Baby Cockatiels\\n\\n- Step 3: Taming Baby Cockatiels\\n\\n- Step 4: Socialization of Baby Cockatiels\\n\\n- Conclusion"}, "skill_id": "855f2a04-0313-41b2-b198-a6d8fab25cf6"}	855f2a04-0313-41b2-b198-a6d8fab25cf6
c0f55e6f-5cbb-458d-87cc-300a45c359c0	To sum up, taming and socializing your baby cockatiels can be a challenging task, but with the right approach, it can be a rewarding experience. Remember that understanding your bird's behavior is crucial to building trust and creating a bond. With patience and consistency, you can teach your baby cockatiel to be comfortable with you and other people. So, what are you waiting for? Start taming and socializing your baby cockatiels today, and who knows? You might end up with a lifelong feathered friend. Happy bird training!		{"total_tokens": 423, "prompt_tokens": 311, "completion_tokens": 112}	87	2023-04-23 21:13:07.78113+00	{"inputs": {"cta": "So, what are you waiting for? Start taming and socializing your baby cockatiels today!", "tone": "Comedy style", "num_outputs": 1, "blogPostMainPoints": "Header Outline:\\n\\n- Introduction\\n\\n- Step 1: Understanding Baby Cockatiels\\n\\n- Step 2: Building Trust with Baby Cockatiels\\n\\n- Step 3: Taming Baby Cockatiels\\n\\n- Step 4: Socialization of Baby Cockatiels\\n\\n- Conclusion"}, "skill_id": "855f2a04-0313-41b2-b198-a6d8fab25cf6"}	855f2a04-0313-41b2-b198-a6d8fab25cf6
419c49a9-04e5-4b7f-b145-e46dedf11eba	1. What is the best age to start taming baby cockatiels?\nIt is best to start taming baby cockatiels as soon as they are weaned and able to eat on their own, which is typically around 8-12 weeks of age.\n\n2. How do I approach a baby cockatiel to start the taming process?\nApproach the bird slowly and calmly, using a soft voice and gentle movements. Offer treats such as millet spray to encourage the bird to come closer to you.\n\n3. What should I do if the baby cockatiel is scared and tries to fly away?\nIf the bird tries to fly away, do not chase after it or grab it forcefully. Simply step back and give it some space, then approach it again gradually and calmly.\n\n4. How can I build trust with a baby cockatiel?\nBuilding trust with a baby cockatiel takes time and patience. Spend time near the bird's cage or play area, and talk to it softly and offer treats. Gradually move closer to the bird and offer your hand or finger for it to perch on.\n\n5. What are some common mistakes to avoid when taming baby cockatiels?\nCommon mistakes include moving too quickly, handling the bird roughly, or not being consistent with your actions and expectations. It is also important to avoid using punishment or negative reinforcement, as this can damage the bird's trust in you.\n\n6. How long does it usually take to fully tame a baby cockatiel?\nThe time it takes to fully tame a baby cockatiel can vary depending on the bird's personality and previous experiences with humans. It can take anywhere from a few weeks to several months to establish a bond of trust and familiarity.\n\n7. How can I continue to socialize my cockatiel after it is fully tamed?\nAfter a cockatiel is fully tamed, continue to spend time with the bird on a daily basis and offer regular opportunities for interaction and play. Provide new toys and activities to keep the bird mentally and physically engaged.\n\n8. What should I do if my cockatiel suddenly becomes aggressive or fearful?\nIf your cockatiel suddenly becomes aggressive or fearful, it may be a sign of illness or discomfort. Consult a veterinarian to rule out any health issues and re-evaluate your taming approach to ensure you are creating a positive and safe environment for the bird.		{"total_tokens": 772, "prompt_tokens": 288, "completion_tokens": 484}	396	2023-04-23 21:14:02.050706+00	{"inputs": {"tone": "", "topic": "Steps to Follow for Taming Baby Cockatiels | A Comprehensive Guide", "num_outputs": 1, "productInfo": "8"}, "skill_id": "9e2f157f-76d9-4aef-9199-3fc2faceb10f"}	9e2f157f-76d9-4aef-9199-3fc2faceb10f
\.


--
-- Data for Name: content_generation_project; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.content_generation_project (_id, name, description, created_at, updated_at) FROM stdin;
41fee383-6cac-4790-8828-4a7cdfa5f902	Project 1	Project 1 description	2023-04-19 04:05:10.791598+00	2023-04-19 04:05:10.79162+00
\.


--
-- Data for Name: content_generation_prompt; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.content_generation_prompt (_id, prompt, skill_id) FROM stdin;
34677952-fb22-4ba3-81db-0da1c47cba63	Prompt:\r\n\r\nWrite a blog post on the topic of [Blog topic], targeting [Intended audience] and using a [Tone of voice] tone.\r\n\r\nThe blog post should contain an introduction, and answer if the topic is a question, 4-5 headings and a conclusion. don't use the famous AI narration with words like, "First," - "Furthermore" - "In summary" - "Finally". the blog post should be html formatted\r\n\r\nIn your post, aim to provide your audience with a clear and concise overview of [Blog topic], making sure to highlight key concepts and ideas, and providing concrete examples where possible.\r\n\r\nUse a tone that is appropriate for your intended audience, and that reflects the overall tone of your blog. If you're writing for a professional audience, adopt a more formal tone, while if you're writing for a more general audience, you may want to use a more conversational or informal style.\r\n\r\nFinally, make sure to provide your readers with some actionable takeaways or advice, so that they can apply the concepts you've discussed to their own work or life.\r\n\r\n---\r\n\r\nBlog topic: {blogtopic}\r\n\r\nTone of voice: {tone}\r\n\r\nIntended audience: {intendedaudience}	e064acb7-ca92-4986-a2a8-2592549f7e6a
4a6b611c-f812-40d0-9cd4-ce3f4dd3067b	Prompt: Please generate a one-shot landing page with H1, H2, and H3 headings using the following background information and tone of voice.\r\n\r\nThe landing page should effectively communicate the purpose of the page and encourage visitors to take the desired action. Please generate content for the landing page based on these requirements.\r\n\r\nBackground information: {productDescription}\r\n\r\nTone of voice: {tone}	8ea5b56b-b08a-4cda-84de-a0e9a28a096f
67b76210-8332-486c-b0ac-6bc988e512a3	Prompt: Generate paragraphs that will captivate your readers.\r\nit should contain relevant and accurate information about the topic being discussed. The paragraph should be well-structured, easy to read, and engaging, using relevant keywords to optimize for search engines. Additionally, the paragraph should contain actionable advice or insights that the reader can use to address a particular problem or achieve a specific goal relevant to the topic. It should also use internal and external links to provide additional resources or supporting evidence. Including images or videos can also enhance the user experience and add visual interest to the content. Above all, the paragraph should be focused on providing value to the reader, answering questions they might have related to the topic and addressing their needs and interests as a niche audience.\r\n\r\nWhat is your paragraph about?: {topic}\r\n\r\nKeywords to include: {keywords}\r\n\r\nTone of voice: {topic}\r\n\r\nPlease generate a paragraph that effectively communicates the topic and tone of voice, considering any optional keywords provided.	7a6dccb1-c0c6-4014-b72c-d00fa412c80a
160330d0-6fdb-4f74-b42c-17f5410cbba2	Please generate an SEO optimized Title tag and Meta Description for a blog post based on the following guidelines:\r\n\r\nTitle:\r\n\r\n1. Keep it under 60 characters.\r\n2. Include primary and secondary keywords in the title.\r\n3. Ensure the headline conveys the main message of the post.\r\n4. Must be unique to the specific blog post.\r\n\r\nMeta Description:\r\n\r\n1. Keep it under 160 characters.\r\n2. Accurately summarize what the blog post is about.\r\n3. Entice users to click through to the content.\r\n4. Must be unique to the specific blog post.\r\n5. Highlight the value proposition of your post.\r\n6. Include a call-to-action to encourage clicks.\r\n\r\nPlease generate a title and meta description that meets the above guidelines to maximize the effectiveness of your blog post and encourage clicks.\r\n\r\nFor more context the prompt accepting the inputs "Company/Product Name" "Blog post title: *" "Blog post description:" "Keyword:"\r\n\r\nCompany/Product Name: {companyName}\r\n\r\nBlog post title: {blogPostTitle}\r\n\r\nBlog post description: {blogPostDescription}\r\n\r\nKeyword: {keyword}	454ab3a0-6dd5-4b56-8610-e1a019a0f641
c560a0f5-2750-4336-9984-8bdfdb48fd9c	Prompt: Please summarize the following text in a concise and clear manner.\r\n\r\nTips:\r\n- Read the text thoroughly to understand the main points and ideas.\r\n- Identify the most important ideas and eliminate any unnecessary details.\r\n- Use your own words to convey the essence of the text.\r\n- Keep the summary to 1-3 sentences.\r\n- Ensure that the summary accurately represents the key points of the text.\r\n\r\nText: {blandContent}\r\n\r\nPlease provide a concise and clear summary of the provided text based on the above guidelines.	f83298b4-6ba3-4242-88b0-27eb5c9e5921
9446b538-bca3-40ab-b163-96dc010b2319	Prompt: Please identify the tone of voice used in the following content description.\r\n\r\nTips:\r\n- Read the content description carefully to identify any emotional cues or language that may indicate the tone.\r\n- Consider the context of the content and the intended audience when identifying the tone.\r\n- Look for language that conveys positive, negative, or neutral sentiment.\r\n- Pay attention to the author's use of rhetorical devices, such as metaphors or exaggeration, as they can indicate tone.\r\n- Consider using an emotion detection tool to aid in the identification of the tone.\r\n\r\nContent Description: {productDescription}\r\n\r\nPlease identify the tone of voice used in the content description based on the above guidelines. The tone may be positive, negative, or neutral, and understanding it is crucial to ensure effective communication with your audience.	8d57cbd6-a84d-45ee-b841-c89f5d720768
a0ad015f-4b2f-4609-91aa-2e1103bb6634	Prompt: Please generate a conclusion paragraph for your blog post based on the following inputs.\r\n\r\nTips:\r\n- Summarize the main points of the post and reiterate the thesis in the conclusion.\r\n- End the conclusion with a call to action or a thought-provoking question that encourages engagement.\r\n- Use clear and concise language that effectively communicates the main points of the post.\r\n- Consider the tone of voice used throughout the blog post and ensure it is consistent in the conclusion.\r\n- Use appropriate formatting and bullet points to make the conclusion visually appealing and easy to read.\r\n\r\nInputs:\r\n- What are the main points or outline of your blog post?: {blogPostMainPoints}\r\n- Call to action (optional): {cta}\r\n- Tone of voice (optional): {tone}\r\n\r\nPlease generate a conclusion paragraph for your blog post based on the above inputs. Ensure that the conclusion effectively summarizes the main points of the post and encourages engagement with a call to action or thought-provoking question. Use clear and concise language and appropriate formatting to create a visually appealing conclusion that is easy to read. Additionally, consider the tone of voice used in the post to ensure consistency in the conclusion.	855f2a04-0313-41b2-b198-a6d8fab25cf6
f9478f19-4f74-474e-af03-d4101dd19f5b	Prompt: Please execute the following chat GPT command: {command}\r\n\r\nAdditional Background Information:\r\n\r\n{content}\r\n\r\nThe background information should be used as additional context to assist GPT in executing the command provided. Please ensure that the output is accurate and relevant to the context provided.	7919810c-1783-4402-97ff-707f65353591
d9673f64-54fc-4325-8da8-60e36e97dd20	Prompt: Please rephrase the following text to make it more easily understood by an audience with a target grade level of {grade}.\r\n\r\nTips:\r\n- Use simpler sentence structures and avoid using overly complex or technical language.\r\n- Break down complex concepts into smaller, more easily digestible pieces of information.\r\n- Use shorter paragraphs and bullet points to make the text more visually appealing and easier to read.\r\n- Consider using visuals or examples to help illustrate key points.\r\n- Edit the text multiple times for accuracy, grammar, and tone.\r\n\r\nText: {input}\r\n\r\nPlease provide a rephrased version of the text that is more accessible to an audience with a target grade level of {grade}. Ensure that the rephrased text accurately conveys the key information while being simpler and more straightforward to understand.	ec586e76-104a-4112-81f4-304bf2e45553
48992764-5406-49b7-bc90-d1c77ddc1b0a	Prompt: Please generate a listicle with {count} items on the topic of {topic}, using a {tone} tone of voice.\r\n\r\nTips:\r\n\r\nChoose a clear and concise topic that is relevant to your audience.\r\nResearch the topic thoroughly and choose the most important points to include in the listicle.\r\nUse a consistent tone of voice throughout the listicle, and ensure it aligns with your brand's overall voice and values.\r\nUse an attention-grabbing headline for the listicle that accurately reflects the content.\r\nNumber the list items in a logical and easy-to-follow order.\r\nUse brief and concise descriptions for each list item to avoid overwhelming the reader with too much detail.\r\nUse visuals and/or examples to help illustrate key points.\r\nEdit and proofread the listicle multiple times for accuracy, grammar, and tone.\r\nPlease generate a listicle with {count} items that provides a helpful and engaging overview of the topic of {topic}, using a {tone} tone of voice. Use the tips above to help create a high-quality and effective listicle that will engage and educate your audience.	c3e5cb12-b51c-40e7-833b-96a13961bf58
21135cce-5b7f-408c-9351-3bd6bd624c1f	Prompt: Please generate a numbered list of FAQs on the topic of {topic} using a {tone} tone of voice, with {productInfo} questions.\r\n\r\nTips:\r\n- Research the topic thoroughly to identify common questions and concerns related to it.\r\n- Choose the most relevant and helpful questions to include in the FAQs list, based on the needs and interests of your audience.\r\n- Use a tone of voice that aligns with your brand and reflects the type of relationship you have with your readers (i.e. professional, conversational, etc.).\r\n- Avoid using jargon and technical terms that may confuse your readers, unless your blog is aimed at a technical audience.\r\n- Provide clear and concise answers for each question, using simple language and avoiding any unnecessary detail.\r\n- Use formatting such as bold and italics to highlight key points in your answers.\r\n- Consider adding images or videos to supplement your answers where appropriate.\r\n- Edit and proofread the FAQs list multiple times for accuracy, clarity, and tone.\r\n\r\nPlease generate a numbered list of FAQs that provides answers to {productInfo} common questions about {topic}, using a {tone} tone of voice. Use the tips above to help you create a well-structured and informative FAQs list that will engage and educate your readers, and provide a valuable resource for your blog post.	9e2f157f-76d9-4aef-9199-3fc2faceb10f
56a606c6-8bff-4035-81e7-e537789c6036	Prompt: Can you brainstorm new blog post topics related to {productDescription} that will be of interest to {audience}, using a {tone} tone of voice? If possible, include examples from {examples} that you can draw inspiration from. \r\n\r\nTips:\r\n- Know your audience: understand who they are, what they care about, and what they want to read.\r\n- Stay up-to-date with industry trends and news to ensure your content is timely and relevant.\r\n- Use the product description to identify features, benefits, and potential use cases that are worth exploring in blog post topics. \r\n- Use the company name to add personalization and authority to your blog post titles and content.\r\n- Create catchy headlines that accurately reflect the content of the post and compel readers to click.\r\n- Ensure your content is well-structured, easy to read, and includes plenty of headings, subheadings, and bullet points.\r\n- Include multimedia elements such as images, videos, and infographics to enhance the readability and visual appeal of the post.\r\n- Edit and proofread thoroughly to ensure your post is free of errors and optimized for SEO.\r\n\r\nPlease brainstorm some new blog post topics related to {productDescription} that will appeal to {audience}, using a {tone} tone of voice. If possible, include examples from {examples} that will inspire new ideas. Use the tips above to create high-quality and engaging content that will attract and retain your audience, and help your blog rank higher on Google. You might use {companyName} as a company name.	696e5a27-520f-4f82-ab86-18bb752ad53e
31783ea7-75a8-4fb8-9695-8ce42d434eeb	Prompt: Create a detailed content brief for "{topic}" in English. Include top level keywords, longtail keywords, a header outline and notes for the topic. Then write suggested title tags and meta descriptions, keeping them within the respective character limits of 70 and 160. After that, write some text underneath each sub header. Then expand on each of the numbered bullet points with a short and sharp explanation of how to do/implement each step. Put all this content into a structured blog post in language English.\nTopic: {topic}	e1f5f2c4-78d1-4f25-a08d-0ce4f5af97d5
e9ecf9d9-d84d-4e72-804f-5c533e5f7f35	Prompt: I Want You To Act As A Content Writer Very Proficient SEO Writer Writes Fluently English. First Create Two Tables. First Table Should be the Outline of the Article and the Second Should be the Article. Bold the Heading of the Second Table using Markdown language. Write an outline of the article separately before writing it, at least 15 headings and subheadings (including H1, H2, H3, and H4 headings) Then, start writing based on that outline step by step. Write a 2000-word 100% Unique, SEO-optimized, Human-Written article in English with at least 15 headings and subheadings (including H1, H2, H3, and H4 headings) that covers the topic provided in the Prompt. Write The article In Your Own Words Rather Than Copying And Pasting From Other Sources. Consider perplexity and burstiness when creating content, ensuring high levels of both without losing specificity or context. Use fully detailed paragraphs that engage the reader. Write In A Conversational Style As Written By A Human (Use An Informal Tone, Utilize Personal Pronouns, Keep It Simple, Engage The Reader, Use The Active Voice, Keep It Brief, Use Rhetorical Questions, and Incorporate Analogies And Metaphors).  End with a conclusion paragraph and 5 unique FAQs After The Conclusion. this is important to Bold the Title and all headings of the article, and use appropriate headings for H tags. And  In The Very Bottom of article Write This Custom Massage "\nNow Write An Article On This Topic "{blogtopic}" using this tone of voice (optional) "{tone}" and targetted to this audience (optional): {intendedaudience}	57061e24-3241-4392-8e5d-ea10787471b6
\.


--
-- Data for Name: content_generation_recipe; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.content_generation_recipe (_id, name, body, created_at, last_used) FROM stdin;
\.


--
-- Data for Name: content_generation_skill; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.content_generation_skill (_id, name, description, hidden, beta, icon, emoji, input_schema, created_at, updated_at) FROM stdin;
26b894c5-a141-4713-9232-c3e393371b45	Amazon Product Description (paragraph)	Create compelling product descriptions for Amazon listings.	f	f	amazon		{"{\\"id\\": \\"productName\\", \\"type\\": \\"text\\", \\"label\\": \\"Product name\\", \\"required\\": true, \\"placeholder\\": \\"Khombu OrthoLite X25 Insoles\\"}","{\\"id\\": \\"productBenefits\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Key benefits/features\\", \\"required\\": true, \\"placeholder\\": \\"High rebound cushion. Eco-friendly & Sustainable. Manage Moisture. High level breathability. Antimicrobial & Light.\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Witty\\"}"}	2023-04-20 03:35:50.729294+00	2023-04-20 03:35:50.729402+00
e064acb7-ca92-4986-a2a8-2592549f7e6a	One-Shot Blog Post	Generate a full blog post with intro, body, and conclusion.	f	f		⚡	{"{\\"id\\": \\"blogtopic\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Blog Topic\\", \\"required\\": true, \\"placeholder\\": \\"SEO, Social Media\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Professional\\"}","{\\"id\\": \\"intendedaudience\\", \\"type\\": \\"text\\", \\"label\\": \\"Intended Audience\\", \\"required\\": false, \\"placeholder\\": \\"CMO's, CIO's\\"}"}	2023-04-20 03:35:50.731213+00	2023-04-20 03:35:50.731223+00
8ea5b56b-b08a-4cda-84de-a0e9a28a096f	One-Shot Landing Page	Generate a full landing page with H1, H2 and H3s.	f	t		⚡️	{"{\\"id\\": \\"productDescription\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Background Information\\", \\"required\\": true, \\"placeholder\\": \\"New Nespresso Vertuo reviving origins pack. We partner with farmers to help restore coffee regions.\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": true, \\"placeholder\\": \\"Educational, Clever\\"}"}	2023-04-20 03:35:50.736952+00	2023-04-20 03:35:50.736964+00
7a6dccb1-c0c6-4014-b72c-d00fa412c80a	Paragraph Generator	Generate paragraphs that will captivate your readers.	f	f		📜	{"{\\"id\\": \\"topic\\", \\"type\\": \\"textarea\\", \\"label\\": \\"What is your paragraph about?\\", \\"required\\": true, \\"placeholder\\": \\"What are the best foods for every season?\\"}","{\\"id\\": \\"keywords\\", \\"type\\": \\"text\\", \\"label\\": \\"Keywords to include\\", \\"tooltip\\": \\"Separate keywords with a comma. Do not use a space after the comma.\\", \\"required\\": false, \\"placeholder\\": \\"vegetables,healthy\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Informative\\"}"}	2023-04-20 03:35:50.762853+00	2023-04-20 03:35:50.762866+00
7791a6bc-898a-44e0-add1-2482dd6eea8a	Perfect Headline	Trained with formulas from the world's best copywriters, this template is sure to create high-converting headlines for your business.	f	f	headline		{"{\\"id\\": \\"productDescription\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Product description\\", \\"required\\": true, \\"placeholder\\": \\"Gym software that helps gym owners manage their gym with less stress and make more money.\\"}","{\\"id\\": \\"productName\\", \\"type\\": \\"text\\", \\"label\\": \\"Company/Product Name\\", \\"required\\": false, \\"placeholder\\": \\"Pushpress\\"}","{\\"id\\": \\"customerAvatar\\", \\"type\\": \\"text\\", \\"label\\": \\"Customer Avatar\\", \\"required\\": false, \\"placeholder\\": \\"Gym Owners\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Funny.\\"}"}	2023-04-20 03:35:50.767077+00	2023-04-20 03:35:50.767087+00
f46d6ba6-20e6-4372-9716-c668038a205d	PAS Framework	Problem-Agitate-Solution. A valuable framework for creating new marketing copy ideas.	f	f	pas		{"{\\"id\\": \\"companyName\\", \\"type\\": \\"text\\", \\"label\\": \\"Company/Product name\\", \\"required\\": false, \\"placeholder\\": \\"Otter AI\\"}","{\\"id\\": \\"productDescription\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Product description\\", \\"required\\": true, \\"placeholder\\": \\"Generate rich notes for meetings, interviews, lectures, and other important voice conversations with Otter, your AI-powered assistant.\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Witty\\"}"}	2023-04-20 03:35:50.769985+00	2023-04-20 03:35:50.769996+00
67ffd3b0-bcaa-4bdd-b780-86d092950df2	AIDA Framework	Use the oldest marketing framework in the world. Attention, Interest, Desire, Action.	f	f	aida		{"{\\"id\\": \\"companyName\\", \\"type\\": \\"text\\", \\"label\\": \\"Company/Product name\\", \\"required\\": false, \\"placeholder\\": \\"Otter AI\\"}","{\\"id\\": \\"productDescription\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Product description\\", \\"required\\": true, \\"placeholder\\": \\"Generate rich notes for meetings, interviews, lectures, and other important voice conversations with Otter, your AI-powered assistant.\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Witty\\"}"}	2023-04-20 03:35:50.783908+00	2023-04-20 03:35:50.783922+00
44b898db-d83a-4159-9947-1d3200b922a1	Personal Bio	Write a creative personal bio that captures attention.	f	f		👩‍💻	{"{\\"id\\": \\"personalInformation\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Personal Information\\", \\"required\\": true, \\"placeholder\\": \\"Dave Rogenmoser. CEO of Conversion.ai. CEO of Proof. Y Combinator 2018. Play basketball. 3 boys and a lovely wife. Love reading books of crazy survival stories. Extremely tall.\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Witty\\"}","{\\"id\\": \\"pointOfView\\", \\"type\\": \\"text\\", \\"label\\": \\"Point of view (First Person or Third Person)\\", \\"required\\": false, \\"placeholder\\": \\"Third person\\"}"}	2023-04-20 03:35:50.788484+00	2023-04-20 03:35:50.788497+00
2ce761be-7cab-49bc-83f3-dd0a56545291	Personalized Cold Emails	Write cold emails that actually work and get responses.	f	f		📨	{"{\\"id\\": \\"productDescription\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Tell us about your product\\", \\"required\\": true, \\"placeholder\\": \\"Gym software that helps gym owners manage their gym with less stress and make more money.\\"}","{\\"id\\": \\"productName\\", \\"type\\": \\"text\\", \\"label\\": \\"Your Company/Product Name\\", \\"required\\": false, \\"placeholder\\": \\"Pushpress\\"}","{\\"id\\": \\"emailReplyInstructions\\", \\"type\\": \\"text\\", \\"label\\": \\"Context to include in the email\\", \\"required\\": false, \\"placeholder\\": \\"I saw that you own a gym in Austin TX\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Witty\\"}"}	2023-04-20 03:35:50.789493+00	2023-04-20 03:35:50.789503+00
7487f3cc-cfae-4bd0-a271-94f19db7b1f6	Photo Post Captions	Write catchy captions for your Instagram posts	f	f	instagram		{"{\\"id\\": \\"postTopic\\", \\"type\\": \\"textarea\\", \\"label\\": \\"What is your post about?\\", \\"required\\": true, \\"placeholder\\": \\"Traveling to South Africa to see some Rhinos on a Safari\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Witty\\"}"}	2023-04-20 03:35:51.165118+00	2023-04-20 03:35:51.16514+00
75f4a7d2-4c6c-4bbf-b998-7f7f6ec6c1d3	Personal LinkedIn Post	Stand out from the crowd with creative, long LinkedIn posts. Build your brand, own your voice and engage your audience.	f	f		🔗	{"{\\"id\\": \\"companyName\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Problem\\", \\"required\\": true, \\"placeholder\\": \\"Marketers are stuck. They can't be financially free. \\"}","{\\"id\\": \\"productName\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Solution\\", \\"required\\": true, \\"placeholder\\": \\"Reverse your thinking. Offer a service, productize that service as a consultant, turn that into a digital product, offer a starter option, and then turn that into a workshop. \\"}","{\\"id\\": \\"productDescription\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Other Information\\", \\"required\\": true, \\"placeholder\\": \\"The process took me 5 years but was worth it. Don't exhaust demand by trying to make a cheap product first and then scale up.\\"}","{\\"id\\": \\"keywords\\", \\"type\\": \\"text\\", \\"label\\": \\"Intended Audience\\", \\"required\\": true, \\"placeholder\\": \\"Millennial Marketer\\"}","{\\"id\\": \\"topic\\", \\"type\\": \\"text\\", \\"label\\": \\"CTA\\", \\"required\\": true, \\"placeholder\\": \\"Think most people can do this? Leave a comment below. 👇\\"}"}	2023-04-20 03:35:51.165868+00	2023-04-20 03:35:51.165876+00
2ceeee17-4bb3-4e45-9c2e-e99b2b26a099	Pinterest Pin Title & Description	Create great Pinterest pin titles and descriptions that drive engagement, traffic, and reach.	f	f			{"{\\"id\\": \\"productInformation\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Tell us about the pin\\", \\"required\\": true, \\"placeholder\\": \\"Cutest tiny homes that are affordable\\"}","{\\"id\\": \\"keyword\\", \\"type\\": \\"text\\", \\"label\\": \\"Keywords\\", \\"placeholder\\": \\"tiny homes\\"}","{\\"id\\": \\"productName\\", \\"type\\": \\"text\\", \\"label\\": \\"Company/Product Name\\", \\"placeholder\\": \\"Home Away\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Professional\\"}"}	2023-04-20 03:35:51.166479+00	2023-04-20 03:35:51.166489+00
17340f6a-e849-451a-8b1f-7480143bb46d	Persuasive Bullet Points	Generate persuasive bullet points to insert into landing pages, emails, and more.	f	f		⚫	{"{\\"id\\": \\"companyName\\", \\"type\\": \\"text\\", \\"label\\": \\"Company/Product Name\\", \\"required\\": true, \\"placeholder\\": \\"Pushpress\\"}","{\\"id\\": \\"productDescription\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Product description\\", \\"required\\": true, \\"placeholder\\": \\"Gym software that helps gym owners manage their gym with less stress and make more money.\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Witty\\"}"}	2023-04-20 03:35:51.172681+00	2023-04-20 03:35:51.172693+00
137679f8-9b37-4aef-881c-be44dcd6f31f	Poll Questions & Multiple Choice Answers	Engage your community and get to know them on a deeper level. Create questions with multiple choice answers.	f	f		🗳	{"{\\"id\\": \\"topic\\", \\"type\\": \\"text\\", \\"label\\": \\"Topic\\", \\"required\\": false, \\"placeholder\\": \\"Bitcoin price rising\\"}","{\\"id\\": \\"Audience\\", \\"type\\": \\"text\\", \\"label\\": \\"Audience\\", \\"required\\": false, \\"placeholder\\": \\"Gold investors\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Casual\\"}"}	2023-04-20 03:35:51.189035+00	2023-04-20 03:35:51.189049+00
fe64c54a-344a-454d-9e92-785d59e4ad8a	Press Release	Inform your audience of your recent updates and news. Include all facts and quotes you want Jasper to reference.	f	f		📰	{"{\\"id\\": \\"topic\\", \\"type\\": \\"text\\", \\"label\\": \\"Whats your press release about?\\", \\"required\\": true, \\"placeholder\\": \\"Happsy is Making Organic Mattresses Accessible for Everyone\\"}","{\\"id\\": \\"productDescription\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Facts + Quotes to Include\\", \\"required\\": true, \\"placeholder\\": \\"First organic bed-in-a-box, our mission is to make healthier mattresses more affordable. We are celebrating becoming 100% climate neutral certified and joining the conservation alliance. \\\\\\"Happsy was started to make organic, healthier, non-toxic mattresses more accessible to more people\\\\\\" - Dale Luckwitz, Brand Manager at Happsy.\\"}"}	2023-04-20 03:35:51.198733+00	2023-04-20 03:35:51.198746+00
dad800ac-700f-4ceb-b7ac-5bd4255b50b7	Press Release Title & Intro	Write the opening paragraph of a press release that people will actually want to read.	f	f		📰	{"{\\"id\\": \\"blandContent\\", \\"type\\": \\"textarea\\", \\"label\\": \\"What is your Press Release about?\\", \\"required\\": true, \\"placeholder\\": \\"Conversion AI launches new product called Long Form Assistant. Instantly generate high quality long form copy for blogs using AI.\\"}","{\\"id\\": \\"companyName\\", \\"type\\": \\"text\\", \\"label\\": \\"Company/Product Name\\", \\"required\\": true, \\"placeholder\\": \\"Conversion AI\\"}","{\\"id\\": \\"keyword\\", \\"type\\": \\"text\\", \\"label\\": \\"keyword\\", \\"required\\": false, \\"placeholder\\": \\"artificial intelligence\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Professional\\"}"}	2023-04-20 03:35:51.208212+00	2023-04-20 03:35:51.208232+00
3557f7ae-0381-4061-8a4f-68abfcbf0eb2	Product Description	Create compelling product descriptions to be used on websites, emails and social media.	f	f		💭	{"{\\"id\\": \\"productName\\", \\"type\\": \\"text\\", \\"label\\": \\"Product Name\\", \\"required\\": true, \\"placeholder\\": \\"Sherlock Holmes Adventure Escape Room\\"}","{\\"id\\": \\"productDescription\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Tell us about the product\\", \\"required\\": true, \\"placeholder\\": \\"Try out a variety of options, including product spec lists\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice or brand style\\", \\"required\\": false, \\"placeholder\\": \\"Happy Theme Park\\"}","{\\"id\\": \\"audience\\", \\"type\\": \\"text\\", \\"label\\": \\"Target audience\\", \\"required\\": false, \\"placeholder\\": \\"Underdog office workers who want to change the world\\"}"}	2023-04-20 03:35:51.21862+00	2023-04-20 03:35:51.218631+00
c0f63716-511e-4ad7-b127-c77a790d0d25	Quora Answers	Intelligent answers for tough questions.	f	f		🙋	{"{\\"id\\": \\"question\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Question\\", \\"required\\": true, \\"placeholder\\": \\"What are some realistic ways to get rich in 5 years?\\"}","{\\"id\\": \\"information\\", \\"type\\": \\"text\\", \\"label\\": \\"Information to include in the answer\\", \\"required\\": false, \\"placeholder\\": \\"start a business\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Casual\\"}"}	2023-04-20 03:35:51.222351+00	2023-04-20 03:35:51.222368+00
c42ab866-b701-46d1-834a-f49de8ccc4d5	Real Estate Listing - Residential	Creative captivating real estate listings that sell homes quickly.	f	f		🏡	{"{\\"id\\": \\"homeInfo\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Information about the home to include in the listing\\", \\"required\\": true, \\"placeholder\\": \\"5 Beds. 6 Baths. Barton Creek Community. 1.1 acre lot. Huge foyer. wood floors. chef style kitchen. covered patio. fruit trees. Next to Barton Creek Golf course.\\"}"}	2023-04-20 03:35:51.224713+00	2023-04-20 03:35:51.224726+00
c9a4bda8-7890-433c-8c2a-2d6fba636925	Review Responder	Write responses to public customer reviews that are winsome, professional, and delightful.	f	f		📣	{"{\\"id\\": \\"review\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Customer review\\", \\"required\\": true, \\"placeholder\\": \\"Copy and paste the full customer review\\"}","{\\"id\\": \\"productName\\", \\"type\\": \\"text\\", \\"label\\": \\"Company/Product Name\\", \\"required\\": false, \\"placeholder\\": \\"Single Grain Marketing Agency\\"}","{\\"id\\": \\"name\\", \\"type\\": \\"text\\", \\"label\\": \\"Reviewer name\\", \\"tooltip\\": \\"Input the headline this sub-head will go underneath.\\", \\"required\\": false, \\"placeholder\\": \\"Jessica\\"}","{\\"id\\": \\"stars\\", \\"type\\": \\"text\\", \\"label\\": \\"Star rating from reviewer (from 1-5)\\", \\"required\\": false, \\"placeholder\\": \\"5\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Friendly\\"}"}	2023-04-20 03:35:51.233993+00	2023-04-20 03:35:51.234006+00
7b27caea-7550-46c3-bf2a-1031396ff4ce	Ridiculous Marketing Ideas	A fun template that generates bad marketing ideas that might get you on the front page of the paper for all the wrong reasons. We are not responsible for you ending up in jail or losing all your customers if you attempt these. This is a joke.	f	f	smile		{"{\\"id\\": \\"companyName\\", \\"type\\": \\"text\\", \\"label\\": \\"Company/Product Name\\", \\"required\\": false, \\"placeholder\\": \\"Pushpress\\"}","{\\"id\\": \\"productDescription\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Product description\\", \\"required\\": true, \\"placeholder\\": \\"Gym software that helps gym owners manage their gym with less stress and make more money.\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Professional. Friendly. Funny.\\"}"}	2023-04-20 03:35:51.248413+00	2023-04-20 03:35:51.248427+00
ed575495-c9be-47bf-a039-07991ed7ed6a	Sentence Expander	Expand a short sentence or a few words into multiple sentences.	f	f	expand		{"{\\"id\\": \\"input\\", \\"type\\": \\"textarea\\", \\"label\\": \\"A few words or a short sentence you'd like to expand on\\", \\"required\\": true, \\"placeholder\\": \\"The key to getting good results from Jasper is to have high quality inputs.\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Excited.\\"}"}	2023-04-20 03:35:51.251523+00	2023-04-20 03:35:51.251536+00
454ab3a0-6dd5-4b56-8610-e1a019a0f641	SEO - Blog Posts - Title and Meta Descriptions	Write SEO optimized title tags and meta descriptions for blog posts that will rank well on Google.	f	f		🔍	{"{\\"id\\": \\"companyName\\", \\"type\\": \\"text\\", \\"label\\": \\"Company/Product Name\\", \\"required\\": false, \\"placeholder\\": \\"Hubspot\\"}","{\\"id\\": \\"blogPostTitle\\", \\"type\\": \\"text\\", \\"label\\": \\"Blog post title:\\", \\"required\\": true, \\"placeholder\\": \\"The Who, What, Why, & How of Digital Marketing\\"}","{\\"id\\": \\"blogPostDescription\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Blog post description:\\", \\"required\\": false, \\"placeholder\\": \\"Learn the basic fundamentals of digital marketing.\\"}","{\\"id\\": \\"keyword\\", \\"type\\": \\"text\\", \\"label\\": \\"Keyword:\\", \\"required\\": false, \\"placeholder\\": \\"Digital Marketing\\"}"}	2023-04-20 03:35:51.258797+00	2023-04-20 03:35:51.25881+00
ebf510d8-b77b-40be-8f39-f465787eef31	SEO - Homepage - Title and Meta Descriptions	Write SEO optimized title tags and meta descriptions for homepages that will rank well on Google.	f	f		🔍	{"{\\"id\\": \\"companyName\\", \\"type\\": \\"text\\", \\"label\\": \\"Company/Product Name\\", \\"required\\": true, \\"placeholder\\": \\"Clickfunnels\\"}","{\\"id\\": \\"productDescription\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Product description\\", \\"required\\": true, \\"placeholder\\": \\"Clickfunnels helps you quickly create beautiful marketing funnels that convert your visitors into leads and then customers. ClickFunnels Is A Website And Sales Funnel Builder For Entrepreneurs.\\"}","{\\"id\\": \\"keyword\\", \\"type\\": \\"text\\", \\"label\\": \\"Keyword:\\", \\"required\\": false, \\"placeholder\\": \\"Marketing Funnel\\"}"}	2023-04-20 03:35:51.26964+00	2023-04-20 03:35:51.269656+00
b509dd17-3056-483f-972e-3ad3131cd701	SEO - Product Page - Title and Meta Descriptions	Write SEO optimized title tags and meta descriptions that will rank well on Google for product pages.	f	f		🔍	{"{\\"id\\": \\"companyName\\", \\"type\\": \\"text\\", \\"label\\": \\"Company Name\\", \\"required\\": true, \\"placeholder\\": \\"Anthropology\\"}","{\\"id\\": \\"productName\\", \\"type\\": \\"text\\", \\"label\\": \\"Product name:\\", \\"required\\": true, \\"placeholder\\": \\"Pilcro The Wanderer Jeans\\"}","{\\"id\\": \\"productDescription\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Product description:\\", \\"required\\": true, \\"placeholder\\": \\"A reimagining of our beloved Wanderer silhouette, the Denim Wanderer features an easygoing fit with subtle, well-loved touches - like this pair's subtle fading and double front button - and patch pockets aplenty. Try styling them with a ruffled blouse or buttondown for a playfully polished ensemble. 96% cotton, 3% polyester, 1% elastane. Relaxed fit. Machine wash.\\"}","{\\"id\\": \\"keywordInclude\\", \\"type\\": \\"text\\", \\"label\\": \\"Keyword:\\", \\"required\\": false, \\"placeholder\\": \\"Pilcro The Wanderer Jeans\\"}"}	2023-04-20 03:35:51.280973+00	2023-04-20 03:35:51.280987+00
b1bc3905-fcaf-4065-ae8b-e4e9b1280ef4	SEO - Services Pages - Title and Meta Descriptions	Write SEO optimized title tags and meta descriptions that will rank well on Google for company services pages.	f	f		🔍	{"{\\"id\\": \\"companyName\\", \\"type\\": \\"text\\", \\"label\\": \\"Company Name\\", \\"required\\": true, \\"placeholder\\": \\"Bert Roofing\\"}","{\\"id\\": \\"descriptionOfService\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Description of Service:\\", \\"required\\": true, \\"placeholder\\": \\"Roof Repair in Dallas Texas.\\"}","{\\"id\\": \\"keywordInclude\\", \\"type\\": \\"text\\", \\"label\\": \\"Keyword:\\", \\"required\\": false, \\"placeholder\\": \\"Roof Repair\\"}"}	2023-04-20 03:35:51.28523+00	2023-04-20 03:35:51.285244+00
f83298b4-6ba3-4242-88b0-27eb5c9e5921	Text Summarizer	Get the key points from a piece of text.	f	f		🧙	{"{\\"id\\": \\"blandContent\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Text\\", \\"required\\": true, \\"placeholder\\": \\"This AI is freaking incredible. Writing content for my company used to take hours and my brain would be mush at the end of each day. With conversion.ai, I can spark creativity at any point in the day - whether I'm building out trainings, copywriting for social media, or creating books for lead generation. My only wish is that I could have met Jarvis (the AI's name) sooner! I have shown a brief glimpse at what the AI does to other friends of mine in business and they were shocked just with one tool - BUT the team is constantly expanding the types of content that the AI produces.\\"}"}	2023-04-20 03:35:51.291705+00	2023-04-20 03:35:51.291718+00
a196cd5e-a090-4d23-a984-5eb7bde27d82	Before-After-Bridge Framework	Create marketing copy using the BAB framework. Before, After, Bridge.	f	f		🌁	{"{\\"id\\": \\"companyName\\", \\"type\\": \\"text\\", \\"label\\": \\"Company/Product Name\\", \\"required\\": true, \\"placeholder\\": \\"Pushpress\\"}","{\\"id\\": \\"productDescription\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Content description\\", \\"required\\": true, \\"placeholder\\": \\"Gym software that helps gym owners manage their gym with less stress and make more money.\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Witty\\"}"}	2023-04-20 03:35:51.298738+00	2023-04-20 03:35:51.298752+00
a0d004bc-c1e0-43cc-b13e-39e9cbef2bae	Amazon Product Features (bullets)	Create key feature and benefit bullet points for Amazon listings under the "about this item" section.	f	f	amazon		{"{\\"id\\": \\"productName\\", \\"type\\": \\"text\\", \\"label\\": \\"Product name\\", \\"required\\": true, \\"placeholder\\": \\"Khombu OrthoLite X25 Insoles\\"}","{\\"id\\": \\"productInfo\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Product info\\", \\"required\\": true, \\"placeholder\\": \\"Khombu OrthoLite X25 High-Performance Orthotic Insoles for Men - Full-Length Thin FoamShoe Inserts - Cushion, Comfort, Arch/Heel/Foot Support for Sport, Running, Work\\"}","{\\"id\\": \\"productBenefits\\", \\"type\\": \\"text\\", \\"label\\": \\"Key benefits/features\\", \\"required\\": false, \\"placeholder\\": \\"High rebound cushion. Eco-friendly & Sustainable. Manage Moisture. High level breathability. Antimicrobial & Light.\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Professional. Friendly. Funny.\\"}","{\\"id\\": \\"examples\\"}"}	2023-04-20 03:35:51.310639+00	2023-04-20 03:35:51.310653+00
3af73099-8755-44cd-9738-356e1f728eec	A Thousand Words is Worth a Picture	Get image prompt ideas to use with Jasper Art	f	t		🖼️	{"{\\"id\\": \\"sourcecontent\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Source content\\", \\"required\\": true, \\"placeholder\\": \\"The blog post, article, tweet, etc. you'd like an image for\\"}","{\\"id\\": \\"artisticvision\\", \\"type\\": \\"text\\", \\"label\\": \\"Artistic Vision (optional)\\", \\"tooltip\\": \\"Separate languages with a comma. Do not use a space after the comma.\\", \\"required\\": false, \\"placeholder\\": \\"in the style a comic book\\"}"}	2023-04-20 03:35:51.316556+00	2023-04-20 03:35:51.316567+00
0469bcdd-27de-4047-a617-de55c6df3d1e	TikTok Video Captions	Generate viral captions for your TikTok videos.	f	f		🤳	{"{\\"id\\": \\"topic\\", \\"type\\": \\"textarea\\", \\"label\\": \\"What is your video about?\\", \\"required\\": true, \\"placeholder\\": \\"Bitcoin is going to the moon\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Sarcastic\\"}","{\\"id\\": \\"keywords\\", \\"type\\": \\"text\\", \\"label\\": \\"Keywords to include\\", \\"tooltip\\": \\"Separate keywords with a comma. Do not use a space after the comma.\\", \\"required\\": false, \\"placeholder\\": \\"Ethereum,Bitcoin\\"}"}	2023-04-20 03:35:51.333316+00	2023-04-20 03:35:51.333329+00
eb973af6-3729-427d-90b7-67a4f626e5fe	Tweet Machine	Generate viral tweets for Twitter.	f	t		🐥	{"{\\"id\\": \\"tweet topic\\", \\"type\\": \\"textarea\\", \\"label\\": \\"What is your tweet about?\\", \\"required\\": true, \\"placeholder\\": \\"Updates about the James Webb telescope, our company just announced...\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice:\\", \\"required\\": false, \\"placeholder\\": \\"Factual yet witty\\"}"}	2023-04-20 03:35:51.338686+00	2023-04-20 03:35:51.3387+00
8d57cbd6-a84d-45ee-b841-c89f5d720768	Tone Detector	Discover your unique tone of voice with the help of Jasper. Simply paste previously written content in, and Jasper will tell you.	f	f		🎶	{"{\\"id\\": \\"productDescription\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Content Description\\", \\"required\\": false, \\"placeholder\\": \\"You only need a paragraph or two for Jasper to be able to tell you your tone of voice\\"}"}	2023-04-20 03:35:51.343276+00	2023-04-20 03:35:51.343288+00
664554c8-d6bc-4ba1-9edb-a722cd04dd91	Unique Value Propositions	Create a clear statement that describes the benefit of your offer in a powerful way.	f	f			{"{\\"id\\": \\"productDescription\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Product description\\", \\"required\\": true, \\"placeholder\\": \\"We help agencies automate their daily tasks so they can scale better and faster with less effort.\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Witty\\"}"}	2023-04-20 03:35:51.352207+00	2023-04-20 03:35:51.352224+00
9741337f-d32a-4468-a954-db325bf90d46	Video Description - YouTube	Create unique descriptions for Youtube videos that rank well in search.	f	f	youtube		{"{\\"id\\": \\"videoTitle\\", \\"type\\": \\"text\\", \\"label\\": \\"Video title\\", \\"required\\": true, \\"placeholder\\": \\"COMPLETE Shopify Tutorial For Beginners 2020 - How To Create A Profitable Shopify Store From Scratch\\"}","{\\"id\\": \\"keyword\\", \\"type\\": \\"text\\", \\"label\\": \\"Keyword to rank for:\\", \\"required\\": false, \\"placeholder\\": \\"Shopify\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Witty\\"}"}	2023-04-20 03:35:51.38229+00	2023-04-20 03:35:51.38231+00
1e9b48d0-fbe4-41b8-a1b3-1f6803bbe6ea	Video Script Hook and Introduction	Create a video intro that will capture your viewers attention and compel them to watch all the way through.	f	f	youtube		{"{\\"id\\": \\"videoTitle\\", \\"type\\": \\"text\\", \\"label\\": \\"Video title\\", \\"required\\": true, \\"placeholder\\": \\"COMPLETE Shopify Tutorial For Beginners 2020 - How To Create A Profitable Shopify Store From Scratch\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Witty\\"}"}	2023-04-20 03:35:51.386331+00	2023-04-20 03:35:51.386354+00
756728a1-afcb-443d-bd30-b94f79716a42	Video Script Outline	Create script outlines for your videos. Works best for "Listicle" and "How to" style videos.	f	f	youtube		{"{\\"id\\": \\"title\\", \\"type\\": \\"text\\", \\"label\\": \\"Video title/topic\\", \\"required\\": true, \\"placeholder\\": \\"8 strategies for lowering your risk of heart attack.\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Witty\\"}"}	2023-04-20 03:35:51.399418+00	2023-04-20 03:35:51.399442+00
b8f3b343-fa00-429d-b4d7-c244c0e26c8b	Video Titles	Create engaging, click-worthy titles for your videos that will rank on Youtube.	f	f	youtube		{"{\\"id\\": \\"videoTopic\\", \\"type\\": \\"text\\", \\"label\\": \\"What is the video about?\\", \\"required\\": true, \\"placeholder\\": \\"How  to build a Shopify business\\"}","{\\"id\\": \\"keyword\\", \\"type\\": \\"text\\", \\"label\\": \\"Keyword to rank for:\\", \\"required\\": false, \\"placeholder\\": \\"Shopify\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Witty\\"}"}	2023-04-20 03:35:51.401077+00	2023-04-20 03:35:51.401087+00
855f2a04-0313-41b2-b198-a6d8fab25cf6	Blog Post Conclusion Paragraph	Wrap up your blog posts with an engaging conclusion paragraph.	f	f		🏁	{"{\\"id\\": \\"blogPostMainPoints\\", \\"type\\": \\"textarea\\", \\"label\\": \\"What are the main points or outline of your blog post?\\", \\"required\\": true, \\"placeholder\\": \\"You need a puppy in your life. Puppies are so cute and cuddly! You will have a friend for life. Dogs make great companions!\\"}","{\\"id\\": \\"cta\\", \\"type\\": \\"text\\", \\"label\\": \\"Call to action\\", \\"required\\": false, \\"placeholder\\": \\"What type of dog do you have? Let me know in the comments below!\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Casual\\"}"}	2023-04-20 03:35:51.407187+00	2023-04-20 03:35:51.407201+00
c24afec3-e5da-4a0b-b2d4-be5610bb72b1	Video Topic Ideas	Brainstorm new video topics that will engage viewers and rank well on YouTube.	f	f	youtube		{"{\\"id\\": \\"videoTopic\\", \\"type\\": \\"text\\", \\"label\\": \\"What topic should the videos be about?\\", \\"required\\": true, \\"placeholder\\": \\"Making homemade bread\\"}","{\\"id\\": \\"keyword\\", \\"type\\": \\"text\\", \\"label\\": \\"Keyword to rank for:\\", \\"required\\": false, \\"placeholder\\": \\"Homemade Bread\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Witty\\"}"}	2023-04-20 03:35:51.427048+00	2023-04-20 03:35:51.427061+00
18e46b19-7c5c-4788-a2f1-c0246bc61459	Website Sub-headline	Create delightfully informative sub-headlines (H2) for your websites and landing pages.	f	f	subheadline		{"{\\"id\\": \\"productName\\", \\"type\\": \\"text\\", \\"label\\": \\"Company/Product Name\\", \\"required\\": true, \\"placeholder\\": \\"Single Grain\\"}","{\\"id\\": \\"productDescription\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Product description\\", \\"required\\": true, \\"placeholder\\": \\"Single Grain is a high performance marketing agency that helps fast growing companies do PPC and SEO.\\"}","{\\"id\\": \\"headline\\", \\"type\\": \\"text\\", \\"label\\": \\"Headline\\", \\"tooltip\\": \\"Input the headline this sub-head will go underneath.\\", \\"required\\": false, \\"placeholder\\": \\"We drive persistent growth for remarkable companies\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Witty\\"}","{\\"id\\": \\"examples\\", \\"tooltip\\": \\"Adding 1-3 examples of quality outputs may help Jarvis produce better results.\\"}"}	2023-04-20 03:35:51.431052+00	2023-04-20 03:35:51.431064+00
55424c55-cbc1-4f16-b5be-c6c47aadeca3	Blog Post Intro Paragraph	Blast through writers block by letting Jasper write your opening paragraph	f	f			{"{\\"id\\": \\"blogPostTitle\\", \\"type\\": \\"text\\", \\"label\\": \\"Blog post title\\", \\"required\\": true, \\"placeholder\\": \\"Emerging Digital Marketing Trends That You Should Pay Attention To\\"}","{\\"id\\": \\"audience\\", \\"type\\": \\"text\\", \\"label\\": \\"Audience\\", \\"required\\": false, \\"placeholder\\": \\"Marketers. Moms. Bitcoin holders.\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Casual\\"}"}	2023-04-20 03:35:51.436284+00	2023-04-20 03:35:51.436296+00
7919810c-1783-4402-97ff-707f65353591	Commands	Tell Jasper exactly what to write with a command	f	f		🗣️	{"{\\"id\\": \\"command\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Your command for Jasper\\", \\"required\\": true, \\"placeholder\\": \\"Write a creative story about Tobby flying to the moon in Matthew McConaughey's tone of voice\\"}","{\\"id\\": \\"content\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Do you have any background information for Jasper?\\", \\"useJbv\\": true, \\"placeholder\\": \\"Tobby was a happy dog that loved to sneak around eating people's food\\", \\"jbvMaxLength\\": 1500}"}	2023-04-20 03:35:51.480428+00	2023-04-20 03:35:51.480442+00
2a665778-b0ec-4b2e-a8e9-4b931aff2260	Blog Post Outline	Create lists and outlines for articles. Works best for "Listicle" and "How to" style blog posts or articles.	f	f			{"{\\"id\\": \\"title\\", \\"type\\": \\"text\\", \\"label\\": \\"Blog post title/topic\\", \\"required\\": true, \\"placeholder\\": \\"Digital Marketing Trends That You Should Pay Attention To\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Witty\\"}"}	2023-04-20 03:35:51.495342+00	2023-04-20 03:35:51.495357+00
696e5a27-520f-4f82-ab86-18bb752ad53e	Blog Post Topic Ideas	Brainstorm new blog post topics that will engage readers and rank well on Google.	f	f			{"{\\"id\\": \\"companyName\\", \\"type\\": \\"text\\", \\"label\\": \\"Company name\\", \\"required\\": false, \\"placeholder\\": \\"Otter AI\\"}","{\\"id\\": \\"productDescription\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Product description\\", \\"required\\": true, \\"placeholder\\": \\"Generate rich notes for meetings, interviews, lectures, and other important voice conversations with Otter, your AI-powered assistant.\\"}","{\\"id\\": \\"audience\\", \\"type\\": \\"text\\", \\"label\\": \\"Audience\\", \\"required\\": false, \\"placeholder\\": \\"Marketers. Moms. Bitcoin holders.\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Witty\\"}","{\\"id\\": \\"examples\\"}"}	2023-04-20 03:35:51.498581+00	2023-04-20 03:35:51.498597+00
3bc38676-d466-4cdc-ac55-3391b61237bf	Business or Product Name	Generate a winning name for your business or product.	f	f		💈	{"{\\"id\\": \\"description\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Tell us about your business or product\\", \\"required\\": true, \\"placeholder\\": \\"Gym software that helps gym owners manage their gym with less stress and make more money.\\"}","{\\"id\\": \\"keywords\\", \\"type\\": \\"text\\", \\"label\\": \\"Keywords to include\\", \\"required\\": false, \\"placeholder\\": \\"ninja\\"}"}	2023-04-20 03:35:51.503+00	2023-04-20 03:35:51.503018+00
1fd7fc24-d8da-41fb-a38a-38570ac247d2	Company Bio	Tell your company's story with a captivating bio.	f	f		💼	{"{\\"id\\": \\"companyName\\", \\"type\\": \\"text\\", \\"label\\": \\"Company Name\\", \\"required\\": false, \\"placeholder\\": \\"Proof\\"}","{\\"id\\": \\"companyInformation\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Company information\\", \\"required\\": true, \\"placeholder\\": \\"Proof helps digital marketers boost website conversions using the power of social proof. Founded in 2017. Located in Austin TX. Software company in the digital marketing space.\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Witty\\"}"}	2023-04-20 03:35:51.521425+00	2023-04-20 03:35:51.521436+00
fa891993-1609-46a3-bd03-fbb4382b4272	Creative Story	Write wildly creative stories to engage your readers.	f	f		🦸‍♀️	{"{\\"id\\": \\"storyPlot\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Plot\\", \\"required\\": true, \\"placeholder\\": \\"Jane and Gerald are two mad scientists living in the Amazon Rainforest. Jane discovers a mysterious shiny object. The scientists are mesmerized and frightened.\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Witty\\"}"}	2023-04-20 03:35:51.527924+00	2023-04-20 03:35:51.527934+00
1f33885d-cf31-4e88-8c9a-9a87ad8b0c2d	Content Improver	Take a piece of content and rewrite it to make it more interesting, creative, and engaging.	f	f	stars	🪄	{"{\\"id\\": \\"blandContent\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Content\\", \\"required\\": true, \\"placeholder\\": \\"We help agencies automate their daily tasks so they can scale better and faster with less effort.\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Funny\\"}"}	2023-04-20 03:35:51.530408+00	2023-04-20 03:35:51.530418+00
ddd78b1f-1200-49ac-abd1-c729d92888fa	Email Subject Lines	Write compelling email subject lines that get readers to open.	f	f		📨	{"{\\"id\\": \\"companyName\\", \\"type\\": \\"text\\", \\"label\\": \\"Company/Product Name\\", \\"required\\": false, \\"placeholder\\": \\"Conversion.ai\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Witty\\"}","{\\"id\\": \\"emailContent\\", \\"type\\": \\"textarea\\", \\"label\\": \\"What is your email about?\\", \\"required\\": true, \\"placeholder\\": \\"This email is promoting the launch of our new software tool that uses AI to write high performing marketing copy. The offer is a 50% discount.\\"}"}	2023-04-20 03:35:51.539548+00	2023-04-20 03:35:51.539558+00
28ecb27b-b32a-4c3a-ad99-116055d4e695	Engaging Questions	Create a form to ask your audience creative questions to increase engagement.	f	f		🤔	{"{\\"id\\": \\"topic\\", \\"type\\": \\"text\\", \\"label\\": \\"Topic\\", \\"required\\": false, \\"placeholder\\": \\"Bitcoin price rising\\"}","{\\"id\\": \\"Audience\\", \\"type\\": \\"text\\", \\"label\\": \\"Audience\\", \\"required\\": false, \\"placeholder\\": \\"Gold investors\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Casual\\"}"}	2023-04-20 03:35:51.544611+00	2023-04-20 03:35:51.544621+00
ec586e76-104a-4112-81f4-304bf2e45553	Explain It To a Child	Rephrase text to make it easier to read and understand.	f	f		👶	{"{\\"id\\": \\"input\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Input text\\", \\"required\\": true, \\"placeholder\\": \\"Open houses are an excellent way to showcase your home and get it in front of as many potential buyers as possible. You'll want to do this on a day when you're sure that you will be able to have the house open for the whole time so people won't show up and there's no one around. They're also best during times when most people don't work since they might not be able to make it out if they can't take off from their jobs.\\"}","{\\"id\\": \\"grade\\", \\"type\\": \\"text\\", \\"label\\": \\"Output Grade level\\", \\"required\\": false, \\"placeholder\\": \\"8\\"}"}	2023-04-20 03:35:51.558226+00	2023-04-20 03:35:51.558238+00
043cb704-9559-495e-930c-98f13b132d77	Facebook Ad Headline	Generate scroll-stopping headlines for your Facebook Ads to get prospects to click, and ultimately buy.	f	f	facebook		{"{\\"id\\": \\"companyName\\", \\"type\\": \\"text\\", \\"label\\": \\"Company/Product Name\\", \\"required\\": true, \\"placeholder\\": \\"Otter AI\\"}","{\\"id\\": \\"productDescription\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Product description\\", \\"required\\": true, \\"placeholder\\": \\"Generate rich notes for meetings, interviews, lectures, and other important voice conversations with Otter, your AI-powered assistant.\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Professional.\\"}","{\\"id\\": \\"examples\\"}"}	2023-04-20 03:35:51.559738+00	2023-04-20 03:35:51.559748+00
a559442c-55a5-4a27-bdb3-fe7520aaf4e8	Facebook Ad Primary Text	Create high converting copy for the "Primary Text" section of your Facebook ads.	f	f	facebook		{"{\\"id\\": \\"companyName\\", \\"type\\": \\"text\\", \\"label\\": \\"Company/Product Name\\", \\"required\\": true, \\"placeholder\\": \\"Pushpress\\"}","{\\"id\\": \\"productDescription\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Product description\\", \\"required\\": true, \\"placeholder\\": \\"Gym software that helps gym owners manage their gym with less stress and make more money.\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Excited.\\"}"}	2023-04-20 03:35:51.565768+00	2023-04-20 03:35:51.565778+00
9e2f157f-76d9-4aef-9199-3fc2faceb10f	FAQ Generator	Finish your blog post with some FAQs about your topic.	f	f		❓	{"{\\"id\\": \\"topic\\", \\"type\\": \\"text\\", \\"label\\": \\"Topic\\", \\"required\\": true, \\"placeholder\\": \\"Slack\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Tongue in Cheek\\"}","{\\"id\\": \\"productInfo\\", \\"type\\": \\"text\\", \\"label\\": \\"Number of Questions\\", \\"required\\": false, \\"placeholder\\": \\"8\\"}"}	2023-04-20 03:35:51.568922+00	2023-04-20 03:35:51.568932+00
4db7bfee-36bb-489d-ae38-66892ad22c07	Feature to Benefit	Turn your product features into benefits that compel action.	f	f			{"{\\"id\\": \\"productDescription\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Product description\\", \\"required\\": true, \\"placeholder\\": \\"We help agencies automate their daily tasks so they can scale better and faster with less effort.\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Witty\\"}"}	2023-04-20 03:35:51.576099+00	2023-04-20 03:35:51.576111+00
066e3200-59b2-4a7e-8cca-016bb9c20af7	Google Ads Description	Create high converting copy for the "Description" section of your Google Ads.	f	f	google		{"{\\"id\\": \\"companyName\\", \\"type\\": \\"text\\", \\"label\\": \\"Company/Product Name\\", \\"required\\": true, \\"placeholder\\": \\"Pushpress\\"}","{\\"id\\": \\"productDescription\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Product description\\", \\"required\\": true, \\"placeholder\\": \\"Gym software that helps gym owners manage their gym with less stress and make more money.\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Professional.\\"}","{\\"id\\": \\"examples\\"}"}	2023-04-20 03:35:51.580448+00	2023-04-20 03:35:51.58046+00
93964ee0-f3e0-44d9-88d5-4010cfec05ae	Google Ads Headline	Create high converting copy for the "Headlines" section of your Google Ads.	f	f	google		{"{\\"id\\": \\"companyName\\", \\"type\\": \\"text\\", \\"label\\": \\"Company/Product Name\\", \\"required\\": true, \\"placeholder\\": \\"Pushpress\\"}","{\\"id\\": \\"productDescription\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Product description\\", \\"required\\": true, \\"placeholder\\": \\"Gym software that helps gym owners manage their gym with less stress and make more money.\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Friendly.\\"}","{\\"id\\": \\"examples\\"}"}	2023-04-20 03:35:51.590316+00	2023-04-20 03:35:51.590329+00
d740038b-6bc1-405e-b519-18facb148a8d	Google My Business - Event Post	Generate event details for your Google My Business event posts	f	f	google		{"{\\"id\\": \\"eventInformation\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Tell us about your event\\", \\"required\\": true, \\"placeholder\\": \\"Yoga class on our outdoor patio. Free pint of beer and socializing afterward. Saturday Mar 27th 5-9pm.\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Professional.\\"}"}	2023-04-20 03:35:51.594443+00	2023-04-20 03:35:51.594455+00
cec5bd84-c3c6-4312-93ee-a982a5a2aa7f	Google My Business - Offer Post	Generate offer details for your Google My Business offer posts	f	f	google		{"{\\"id\\": \\"description\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Tell us about your offer\\", \\"required\\": true, \\"placeholder\\": \\"Free teeth cleaning for new patients\\"}","{\\"id\\": \\"companyName\\", \\"type\\": \\"text\\", \\"label\\": \\"Company/Product Name\\", \\"required\\": false, \\"placeholder\\": \\"Daisy Dental\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Professional.\\"}"}	2023-04-20 03:35:51.59627+00	2023-04-20 03:35:51.59628+00
f105a877-5303-41c4-8894-bda14f0aac76	Google My Business - Product Description	Generate product descriptions for your Google My Business	f	f	google		{"{\\"id\\": \\"productName\\", \\"type\\": \\"text\\", \\"label\\": \\"Company/Product Name\\", \\"required\\": false, \\"placeholder\\": \\"Pushpress\\"}","{\\"id\\": \\"productInformation\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Tell us about the product\\", \\"required\\": true, \\"placeholder\\": \\"Gym software that helps gym owners manage their gym with less stress and make more money.\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Professional.\\"}"}	2023-04-20 03:35:51.601722+00	2023-04-20 03:35:51.601732+00
c54e5f83-bdb5-47db-9623-9519d04c82ef	Jasper.ai Testimonial Helper	Use this template to generate testimonials for Jasper.ai. If this goes well, we'll open it up for you to collect testimonials from all of your customers.	f	t		😍	{"{\\"id\\": \\"productReview\\", \\"type\\": \\"textarea\\", \\"label\\": \\"What do you like about Jasper.ai?\\", \\"required\\": true, \\"placeholder\\": \\"Super easy to use. Gives me copywriting superpowers. Love the Facebook ads templates. Saves me so much time.\\"}"}	2023-04-20 03:35:51.616814+00	2023-04-20 03:35:51.616825+00
69f154a6-01d1-4988-a1a4-7d8d79d9e2aa	Google My Business - What's New Post	Generate What's New post updates for Google My Business	f	f	google		{"{\\"id\\": \\"description\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Tell us about your business update\\", \\"required\\": true, \\"placeholder\\": \\"We now offer garbage disposal repairs. We are plumbing company. Serving Austin Texas.\\"}","{\\"id\\": \\"companyName\\", \\"type\\": \\"text\\", \\"label\\": \\"Company/Product Name\\", \\"required\\": false, \\"placeholder\\": \\"Tom's plumbing\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Professional.\\"}"}	2023-04-20 03:35:51.618596+00	2023-04-20 03:35:51.618606+00
30605088-4a7b-46e2-bfad-104ad282680f	LinkedIn Single Image Ads	Use Jasper with LinkedIn Single Image Ads to reach the right professional audience	f	t		🧑‍💼	{"{\\"id\\": \\"productDescription\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Background Info\\", \\"required\\": true, \\"placeholder\\": \\"Tell us about your company or product. Include all key details to be mentioned throughout the posts. \\"}","{\\"id\\": \\"keywords\\", \\"type\\": \\"text\\", \\"label\\": \\"Intended Audience\\", \\"required\\": false, \\"placeholder\\": \\"Tech startups\\"}"}	2023-04-20 03:35:51.62103+00	2023-04-20 03:35:51.621039+00
c3e5cb12-b51c-40e7-833b-96a13961bf58	Listicle ✨	Generate a numbered list based on a topic. Perfect for filling in detail of a blog post.	f	f		📓	{"{\\"id\\": \\"topic\\", \\"type\\": \\"text\\", \\"label\\": \\"Topic\\", \\"required\\": true, \\"placeholder\\": \\"Wine regions in France\\"}","{\\"id\\": \\"count\\", \\"type\\": \\"text\\", \\"label\\": \\"List count\\", \\"required\\": true, \\"placeholder\\": \\"How many paragraphs do you want?\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Clever, casual\\"}"}	2023-04-20 03:35:51.629361+00	2023-04-20 03:35:51.629371+00
ddaa0736-fe40-4512-9b25-51543f30451f	LinkedIn Text Ads	Use Jasper with LinkedIn Text Ads to reach the right professional audience	f	t		🧑‍💼	{"{\\"id\\": \\"productDescription\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Background Info\\", \\"required\\": true, \\"placeholder\\": \\"Tell us about your company or product. Include all key details to be mentioned throughout the posts. \\"}","{\\"id\\": \\"keywords\\", \\"type\\": \\"text\\", \\"label\\": \\"Intended Audience\\", \\"required\\": false, \\"placeholder\\": \\"Tech startups\\"}"}	2023-04-20 03:35:51.633379+00	2023-04-20 03:35:51.63339+00
dd2daa79-718e-4965-a63d-cfac9c331919	Marketing Angles	Brainstorm different angles to add vibrancy to your marketing.	f	f		📐	{"{\\"id\\": \\"companyName\\", \\"type\\": \\"text\\", \\"label\\": \\"Company/Product Name\\", \\"required\\": false, \\"placeholder\\": \\"Pushpress\\"}","{\\"id\\": \\"productDescription\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Product description\\", \\"required\\": true, \\"placeholder\\": \\"Gym software that helps gym owners manage their gym with less stress and make more money.\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Witty\\"}"}	2023-04-20 03:35:51.636544+00	2023-04-20 03:35:51.636555+00
136598f1-2975-4eb6-92b3-1078a4af288d	Mini-VSL (Video Sales Letter)	Write a captivating 60-90 second script for a video that generates interest for your offer. Created by expert copywriter and inventor of the VSL, Jon Benson.	f	f		💰	{"{\\"id\\": \\"yourName\\", \\"type\\": \\"text\\", \\"label\\": \\"Your Name\\", \\"required\\": false, \\"placeholder\\": \\"Sarah\\"}","{\\"id\\": \\"companyName\\", \\"type\\": \\"text\\", \\"label\\": \\"Company Name\\", \\"required\\": false, \\"placeholder\\": \\"Shade Matcha\\"}","{\\"id\\": \\"audience\\", \\"type\\": \\"text\\", \\"label\\": \\"Who is your ideal buyer audience?\\", \\"required\\": false, \\"placeholder\\": \\"Women under 40 who drink coffee or energy drinks\\"}","{\\"id\\": \\"productBenefits\\", \\"type\\": \\"textarea\\", \\"label\\": \\"List your key benefits & features\\", \\"required\\": false, \\"placeholder\\": \\"Lasting energy and focus\\"}","{\\"id\\": \\"negativePain\\", \\"type\\": \\"text\\", \\"label\\": \\"What current pain or negative circumstance is your customer facing now?\\", \\"required\\": false, \\"placeholder\\": \\"Mid-day energy crash, bad gut health, etc.\\"}","{\\"id\\": \\"negativeScaryFact\\", \\"type\\": \\"text\\", \\"label\\": \\"What's a true negative or scary fact?\\", \\"required\\": false, \\"placeholder\\": \\"Fact: 65% of people feel anxiety after drinking energy drinks.\\"}","{\\"id\\": \\"bigIdea\\", \\"type\\": \\"text\\", \\"label\\": \\"What's the big idea in 2-3 words? What hook makes your product different?\\", \\"required\\": false, \\"placeholder\\": \\"Plant-Based Productivity. (Don't say your product yet)\\"}","{\\"id\\": \\"numberCustomers\\", \\"type\\": \\"text\\", \\"label\\": \\"Number of customers for social proof\\", \\"required\\": false, \\"placeholder\\": \\"50,000\\"}","{\\"id\\": \\"niche\\", \\"type\\": \\"text\\", \\"label\\": \\"What is your niche? A more narrow focus of your audience.\\", \\"required\\": false, \\"placeholder\\": \\"Students, Business Professionals, Busy Parents, etc...\\"}","{\\"id\\": \\"goal\\", \\"type\\": \\"text\\", \\"label\\": \\"What are customers' initial goal?\\", \\"required\\": false, \\"placeholder\\": \\"To feel awake with lasting energy the entire day\\"}","{\\"id\\": \\"bigGoal\\", \\"type\\": \\"text\\", \\"label\\": \\"What are customers' ultimate goal that results from the initial goal?\\", \\"required\\": false, \\"placeholder\\": \\"Crush goals at work, actively play with kids, live longer, look younger. \\"}","{\\"id\\": \\"deliverable\\", \\"type\\": \\"text\\", \\"label\\": \\"How is your product delivered?\\", \\"required\\": false, \\"placeholder\\": \\"Tea Powder, Online Course, Digital Report, Software Tool\\"}","{\\"id\\": \\"productName\\", \\"type\\": \\"text\\", \\"label\\": \\"What is your product name?\\", \\"required\\": false, \\"placeholder\\": \\"Ceremonial Matcha, Model XYZ, etc. \\"}","{\\"id\\": \\"productPrice\\", \\"type\\": \\"text\\", \\"label\\": \\"What is your product's price?\\", \\"required\\": false, \\"placeholder\\": \\"$49.99, $19/mo, free, etc.\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Natural, Excited, Informative, etc..\\"}"}	2023-04-20 03:35:51.64715+00	2023-04-20 03:35:51.64716+00
e1f5f2c4-78d1-4f25-a08d-0ce4f5af97d5	Content brief	Create a detailed content brief for your topic	f	f		📄	{"{\\"id\\": \\"topic\\", \\"type\\": \\"text\\", \\"label\\": \\"Topic\\", \\"required\\": true, \\"placeholder\\": \\"Best lovebird cages 2023\\"}"}	2023-04-23 20:39:36.099023+00	2023-04-23 20:39:36.099124+00
57061e24-3241-4392-8e5d-ea10787471b6	One-Shot Blog Post #2	Generate a full blog post with intro, headings, body, and conclusion.	f	f		⚡	{"{\\"id\\": \\"blogtopic\\", \\"type\\": \\"textarea\\", \\"label\\": \\"Blog Topic\\", \\"required\\": true, \\"placeholder\\": \\"SEO, Social Media\\"}","{\\"id\\": \\"tone\\", \\"type\\": \\"text\\", \\"label\\": \\"Tone of voice\\", \\"required\\": false, \\"placeholder\\": \\"Professional\\"}","{\\"id\\": \\"intendedaudience\\", \\"type\\": \\"text\\", \\"label\\": \\"Intended Audience\\", \\"required\\": false, \\"placeholder\\": \\"CMO's, CIO's\\"}"}	2023-04-23 20:43:46.86006+00	2023-04-23 20:43:46.860073+00
\.


--
-- Data for Name: content_generation_skill_tags; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.content_generation_skill_tags (id, skill_id, tag_id) FROM stdin;
1	e064acb7-ca92-4986-a2a8-2592549f7e6a	b7d54590-f96c-459a-bb7b-71d132349432
4	e064acb7-ca92-4986-a2a8-2592549f7e6a	77430b56-23aa-4eb0-9abc-7f0b97443414
2	26b894c5-a141-4713-9232-c3e393371b45	07f8913c-6831-4d3d-ac10-e8bbbe0faef2
92	28ecb27b-b32a-4c3a-ad99-116055d4e695	2c1a1847-2176-4d2f-a8c7-0dbe7f2fff88
8	7a6dccb1-c0c6-4014-b72c-d00fa412c80a	2c1a1847-2176-4d2f-a8c7-0dbe7f2fff88
9	7a6dccb1-c0c6-4014-b72c-d00fa412c80a	b8e2f70b-15f2-4ba2-a95a-e35d5b0ebb72
10	7a6dccb1-c0c6-4014-b72c-d00fa412c80a	b7d54590-f96c-459a-bb7b-71d132349432
11	7a6dccb1-c0c6-4014-b72c-d00fa412c80a	27a05412-2ccf-4766-8019-7a50b287fe80
93	ec586e76-104a-4112-81f4-304bf2e45553	b7d54590-f96c-459a-bb7b-71d132349432
12	7791a6bc-898a-44e0-add1-2482dd6eea8a	27a05412-2ccf-4766-8019-7a50b287fe80
94	043cb704-9559-495e-930c-98f13b132d77	d295e793-0657-4d79-8d42-baa5a260216d
13	f46d6ba6-20e6-4372-9716-c668038a205d	2c1a1847-2176-4d2f-a8c7-0dbe7f2fff88
14	f46d6ba6-20e6-4372-9716-c668038a205d	07f8913c-6831-4d3d-ac10-e8bbbe0faef2
15	f46d6ba6-20e6-4372-9716-c668038a205d	d295e793-0657-4d79-8d42-baa5a260216d
16	f46d6ba6-20e6-4372-9716-c668038a205d	c80384b1-f7ef-4eb8-a711-71bd3f7ef11f
95	a559442c-55a5-4a27-bdb3-fe7520aaf4e8	d295e793-0657-4d79-8d42-baa5a260216d
17	67ffd3b0-bcaa-4bdd-b780-86d092950df2	2c1a1847-2176-4d2f-a8c7-0dbe7f2fff88
18	67ffd3b0-bcaa-4bdd-b780-86d092950df2	07f8913c-6831-4d3d-ac10-e8bbbe0faef2
19	67ffd3b0-bcaa-4bdd-b780-86d092950df2	d295e793-0657-4d79-8d42-baa5a260216d
20	67ffd3b0-bcaa-4bdd-b780-86d092950df2	c80384b1-f7ef-4eb8-a711-71bd3f7ef11f
96	9e2f157f-76d9-4aef-9199-3fc2faceb10f	2c1a1847-2176-4d2f-a8c7-0dbe7f2fff88
97	9e2f157f-76d9-4aef-9199-3fc2faceb10f	b7d54590-f96c-459a-bb7b-71d132349432
98	9e2f157f-76d9-4aef-9199-3fc2faceb10f	77430b56-23aa-4eb0-9abc-7f0b97443414
99	9e2f157f-76d9-4aef-9199-3fc2faceb10f	4cde42d2-864f-423f-aa11-d0479b3ff5c7
100	9e2f157f-76d9-4aef-9199-3fc2faceb10f	27a05412-2ccf-4766-8019-7a50b287fe80
21	44b898db-d83a-4159-9947-1d3200b922a1	2c1a1847-2176-4d2f-a8c7-0dbe7f2fff88
101	4db7bfee-36bb-489d-ae38-66892ad22c07	07f8913c-6831-4d3d-ac10-e8bbbe0faef2
102	4db7bfee-36bb-489d-ae38-66892ad22c07	c6efdd26-00f6-4288-a017-3a023f574a6d
103	4db7bfee-36bb-489d-ae38-66892ad22c07	27a05412-2ccf-4766-8019-7a50b287fe80
104	4db7bfee-36bb-489d-ae38-66892ad22c07	c80384b1-f7ef-4eb8-a711-71bd3f7ef11f
22	2ce761be-7cab-49bc-83f3-dd0a56545291	c6efdd26-00f6-4288-a017-3a023f574a6d
105	066e3200-59b2-4a7e-8cca-016bb9c20af7	9b7213bb-6aeb-43d7-ba28-3eae50c1d586
106	066e3200-59b2-4a7e-8cca-016bb9c20af7	d295e793-0657-4d79-8d42-baa5a260216d
23	7487f3cc-cfae-4bd0-a271-94f19db7b1f6	2c1a1847-2176-4d2f-a8c7-0dbe7f2fff88
107	93964ee0-f3e0-44d9-88d5-4010cfec05ae	9b7213bb-6aeb-43d7-ba28-3eae50c1d586
108	93964ee0-f3e0-44d9-88d5-4010cfec05ae	d295e793-0657-4d79-8d42-baa5a260216d
24	75f4a7d2-4c6c-4bbf-b998-7f7f6ec6c1d3	2c1a1847-2176-4d2f-a8c7-0dbe7f2fff88
25	75f4a7d2-4c6c-4bbf-b998-7f7f6ec6c1d3	27a05412-2ccf-4766-8019-7a50b287fe80
26	75f4a7d2-4c6c-4bbf-b998-7f7f6ec6c1d3	77430b56-23aa-4eb0-9abc-7f0b97443414
27	75f4a7d2-4c6c-4bbf-b998-7f7f6ec6c1d3	4cde42d2-864f-423f-aa11-d0479b3ff5c7
109	d740038b-6bc1-405e-b519-18facb148a8d	9b7213bb-6aeb-43d7-ba28-3eae50c1d586
28	2ceeee17-4bb3-4e45-9c2e-e99b2b26a099	2c1a1847-2176-4d2f-a8c7-0dbe7f2fff88
110	cec5bd84-c3c6-4312-93ee-a982a5a2aa7f	9b7213bb-6aeb-43d7-ba28-3eae50c1d586
29	17340f6a-e849-451a-8b1f-7480143bb46d	c6efdd26-00f6-4288-a017-3a023f574a6d
30	17340f6a-e849-451a-8b1f-7480143bb46d	27a05412-2ccf-4766-8019-7a50b287fe80
111	f105a877-5303-41c4-8894-bda14f0aac76	9b7213bb-6aeb-43d7-ba28-3eae50c1d586
31	fe64c54a-344a-454d-9e92-785d59e4ad8a	c6efdd26-00f6-4288-a017-3a023f574a6d
32	fe64c54a-344a-454d-9e92-785d59e4ad8a	27a05412-2ccf-4766-8019-7a50b287fe80
33	fe64c54a-344a-454d-9e92-785d59e4ad8a	77430b56-23aa-4eb0-9abc-7f0b97443414
34	fe64c54a-344a-454d-9e92-785d59e4ad8a	4cde42d2-864f-423f-aa11-d0479b3ff5c7
112	69f154a6-01d1-4988-a1a4-7d8d79d9e2aa	9b7213bb-6aeb-43d7-ba28-3eae50c1d586
35	3557f7ae-0381-4061-8a4f-68abfcbf0eb2	07f8913c-6831-4d3d-ac10-e8bbbe0faef2
113	30605088-4a7b-46e2-bfad-104ad282680f	2c1a1847-2176-4d2f-a8c7-0dbe7f2fff88
114	30605088-4a7b-46e2-bfad-104ad282680f	65de851d-9ff9-44f5-943e-b997529a4bfb
115	30605088-4a7b-46e2-bfad-104ad282680f	77430b56-23aa-4eb0-9abc-7f0b97443414
116	30605088-4a7b-46e2-bfad-104ad282680f	4cde42d2-864f-423f-aa11-d0479b3ff5c7
36	c0f63716-511e-4ad7-b127-c77a790d0d25	2c1a1847-2176-4d2f-a8c7-0dbe7f2fff88
117	c3e5cb12-b51c-40e7-833b-96a13961bf58	b7d54590-f96c-459a-bb7b-71d132349432
118	c3e5cb12-b51c-40e7-833b-96a13961bf58	4cde42d2-864f-423f-aa11-d0479b3ff5c7
37	454ab3a0-6dd5-4b56-8610-e1a019a0f641	b7d54590-f96c-459a-bb7b-71d132349432
38	454ab3a0-6dd5-4b56-8610-e1a019a0f641	b8e2f70b-15f2-4ba2-a95a-e35d5b0ebb72
119	ddaa0736-fe40-4512-9b25-51543f30451f	2c1a1847-2176-4d2f-a8c7-0dbe7f2fff88
120	ddaa0736-fe40-4512-9b25-51543f30451f	65de851d-9ff9-44f5-943e-b997529a4bfb
121	ddaa0736-fe40-4512-9b25-51543f30451f	77430b56-23aa-4eb0-9abc-7f0b97443414
122	ddaa0736-fe40-4512-9b25-51543f30451f	4cde42d2-864f-423f-aa11-d0479b3ff5c7
39	ebf510d8-b77b-40be-8f39-f465787eef31	b8e2f70b-15f2-4ba2-a95a-e35d5b0ebb72
123	136598f1-2975-4eb6-92b3-1078a4af288d	0ac0b826-7389-44c0-98e7-0da23065b455
40	b1bc3905-fcaf-4065-ae8b-e4e9b1280ef4	b8e2f70b-15f2-4ba2-a95a-e35d5b0ebb72
124	e1f5f2c4-78d1-4f25-a08d-0ce4f5af97d5	90038e22-c2c2-46f2-9bf5-c2a7e6541ec9
125	e1f5f2c4-78d1-4f25-a08d-0ce4f5af97d5	b8e2f70b-15f2-4ba2-a95a-e35d5b0ebb72
41	b509dd17-3056-483f-972e-3ad3131cd701	07f8913c-6831-4d3d-ac10-e8bbbe0faef2
42	b509dd17-3056-483f-972e-3ad3131cd701	b8e2f70b-15f2-4ba2-a95a-e35d5b0ebb72
126	57061e24-3241-4392-8e5d-ea10787471b6	b7d54590-f96c-459a-bb7b-71d132349432
127	57061e24-3241-4392-8e5d-ea10787471b6	77430b56-23aa-4eb0-9abc-7f0b97443414
43	f83298b4-6ba3-4242-88b0-27eb5c9e5921	2c1a1847-2176-4d2f-a8c7-0dbe7f2fff88
44	f83298b4-6ba3-4242-88b0-27eb5c9e5921	b7d54590-f96c-459a-bb7b-71d132349432
45	f83298b4-6ba3-4242-88b0-27eb5c9e5921	27a05412-2ccf-4766-8019-7a50b287fe80
46	a196cd5e-a090-4d23-a984-5eb7bde27d82	c80384b1-f7ef-4eb8-a711-71bd3f7ef11f
47	a0d004bc-c1e0-43cc-b13e-39e9cbef2bae	07f8913c-6831-4d3d-ac10-e8bbbe0faef2
48	0469bcdd-27de-4047-a617-de55c6df3d1e	2c1a1847-2176-4d2f-a8c7-0dbe7f2fff88
49	0469bcdd-27de-4047-a617-de55c6df3d1e	0ac0b826-7389-44c0-98e7-0da23065b455
50	0469bcdd-27de-4047-a617-de55c6df3d1e	4cde42d2-864f-423f-aa11-d0479b3ff5c7
51	eb973af6-3729-427d-90b7-67a4f626e5fe	2c1a1847-2176-4d2f-a8c7-0dbe7f2fff88
52	eb973af6-3729-427d-90b7-67a4f626e5fe	4cde42d2-864f-423f-aa11-d0479b3ff5c7
53	8d57cbd6-a84d-45ee-b841-c89f5d720768	07f8913c-6831-4d3d-ac10-e8bbbe0faef2
54	8d57cbd6-a84d-45ee-b841-c89f5d720768	c6efdd26-00f6-4288-a017-3a023f574a6d
55	8d57cbd6-a84d-45ee-b841-c89f5d720768	d295e793-0657-4d79-8d42-baa5a260216d
56	8d57cbd6-a84d-45ee-b841-c89f5d720768	2c1a1847-2176-4d2f-a8c7-0dbe7f2fff88
57	8d57cbd6-a84d-45ee-b841-c89f5d720768	b7d54590-f96c-459a-bb7b-71d132349432
58	8d57cbd6-a84d-45ee-b841-c89f5d720768	77430b56-23aa-4eb0-9abc-7f0b97443414
59	8d57cbd6-a84d-45ee-b841-c89f5d720768	4cde42d2-864f-423f-aa11-d0479b3ff5c7
60	8d57cbd6-a84d-45ee-b841-c89f5d720768	27a05412-2ccf-4766-8019-7a50b287fe80
61	664554c8-d6bc-4ba1-9edb-a722cd04dd91	27a05412-2ccf-4766-8019-7a50b287fe80
62	9741337f-d32a-4468-a954-db325bf90d46	0ac0b826-7389-44c0-98e7-0da23065b455
63	1e9b48d0-fbe4-41b8-a1b3-1f6803bbe6ea	0ac0b826-7389-44c0-98e7-0da23065b455
64	756728a1-afcb-443d-bd30-b94f79716a42	0ac0b826-7389-44c0-98e7-0da23065b455
65	b8f3b343-fa00-429d-b4d7-c244c0e26c8b	0ac0b826-7389-44c0-98e7-0da23065b455
66	855f2a04-0313-41b2-b198-a6d8fab25cf6	b7d54590-f96c-459a-bb7b-71d132349432
67	c24afec3-e5da-4a0b-b2d4-be5610bb72b1	0ac0b826-7389-44c0-98e7-0da23065b455
68	18e46b19-7c5c-4788-a2f1-c0246bc61459	27a05412-2ccf-4766-8019-7a50b287fe80
69	55424c55-cbc1-4f16-b5be-c6c47aadeca3	b7d54590-f96c-459a-bb7b-71d132349432
70	7919810c-1783-4402-97ff-707f65353591	07f8913c-6831-4d3d-ac10-e8bbbe0faef2
71	7919810c-1783-4402-97ff-707f65353591	c6efdd26-00f6-4288-a017-3a023f574a6d
72	7919810c-1783-4402-97ff-707f65353591	9b7213bb-6aeb-43d7-ba28-3eae50c1d586
73	7919810c-1783-4402-97ff-707f65353591	d295e793-0657-4d79-8d42-baa5a260216d
74	7919810c-1783-4402-97ff-707f65353591	2c1a1847-2176-4d2f-a8c7-0dbe7f2fff88
75	7919810c-1783-4402-97ff-707f65353591	4cde42d2-864f-423f-aa11-d0479b3ff5c7
76	7919810c-1783-4402-97ff-707f65353591	b7d54590-f96c-459a-bb7b-71d132349432
77	7919810c-1783-4402-97ff-707f65353591	c80384b1-f7ef-4eb8-a711-71bd3f7ef11f
78	7919810c-1783-4402-97ff-707f65353591	b8e2f70b-15f2-4ba2-a95a-e35d5b0ebb72
79	7919810c-1783-4402-97ff-707f65353591	0ac0b826-7389-44c0-98e7-0da23065b455
80	7919810c-1783-4402-97ff-707f65353591	27a05412-2ccf-4766-8019-7a50b287fe80
81	2a665778-b0ec-4b2e-a8e9-4b931aff2260	b7d54590-f96c-459a-bb7b-71d132349432
82	696e5a27-520f-4f82-ab86-18bb752ad53e	b7d54590-f96c-459a-bb7b-71d132349432
83	1fd7fc24-d8da-41fb-a38a-38570ac247d2	27a05412-2ccf-4766-8019-7a50b287fe80
84	fa891993-1609-46a3-bd03-fbb4382b4272	2c1a1847-2176-4d2f-a8c7-0dbe7f2fff88
85	1f33885d-cf31-4e88-8c9a-9a87ad8b0c2d	07f8913c-6831-4d3d-ac10-e8bbbe0faef2
86	1f33885d-cf31-4e88-8c9a-9a87ad8b0c2d	c6efdd26-00f6-4288-a017-3a023f574a6d
87	1f33885d-cf31-4e88-8c9a-9a87ad8b0c2d	d295e793-0657-4d79-8d42-baa5a260216d
88	1f33885d-cf31-4e88-8c9a-9a87ad8b0c2d	2c1a1847-2176-4d2f-a8c7-0dbe7f2fff88
89	1f33885d-cf31-4e88-8c9a-9a87ad8b0c2d	b7d54590-f96c-459a-bb7b-71d132349432
90	1f33885d-cf31-4e88-8c9a-9a87ad8b0c2d	27a05412-2ccf-4766-8019-7a50b287fe80
91	ddd78b1f-1200-49ac-abd1-c729d92888fa	c6efdd26-00f6-4288-a017-3a023f574a6d
3	8ea5b56b-b08a-4cda-84de-a0e9a28a096f	07f8913c-6831-4d3d-ac10-e8bbbe0faef2
5	8ea5b56b-b08a-4cda-84de-a0e9a28a096f	b8e2f70b-15f2-4ba2-a95a-e35d5b0ebb72
6	8ea5b56b-b08a-4cda-84de-a0e9a28a096f	27a05412-2ccf-4766-8019-7a50b287fe80
7	8ea5b56b-b08a-4cda-84de-a0e9a28a096f	4cde42d2-864f-423f-aa11-d0479b3ff5c7
\.


--
-- Data for Name: content_generation_tag; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.content_generation_tag (_id, name) FROM stdin;
b7d54590-f96c-459a-bb7b-71d132349432	Blog
07f8913c-6831-4d3d-ac10-e8bbbe0faef2	Ecommerce
c6efdd26-00f6-4288-a017-3a023f574a6d	Email
2c1a1847-2176-4d2f-a8c7-0dbe7f2fff88	Social Media
b8e2f70b-15f2-4ba2-a95a-e35d5b0ebb72	SEO
0ac0b826-7389-44c0-98e7-0da23065b455	Video
d295e793-0657-4d79-8d42-baa5a260216d	Ads
9b7213bb-6aeb-43d7-ba28-3eae50c1d586	Google
77430b56-23aa-4eb0-9abc-7f0b97443414	Marketing
4cde42d2-864f-423f-aa11-d0479b3ff5c7	New
c80384b1-f7ef-4eb8-a711-71bd3f7ef11f	Frameworks
579baa04-5e5d-439c-95d2-0a05caabcab7	Social Media
615402d8-12c4-421c-b0b9-fe17175e453e	Ecommerce
87efbd84-f01b-4ef8-bfba-ba46f14af90b	Ads
90038e22-c2c2-46f2-9bf5-c2a7e6541ec9	Blog
981473c4-fe7c-47d8-9a41-93050a6d2ebd	Email
e51029ad-25cf-4cc1-b7d8-e17eeb138785	SEO
ef3b24e1-5984-4677-97fc-56cd751b5ccc	Google
35cb15f6-36f9-4006-b3bd-ee8f42653953	Video
27a05412-2ccf-4766-8019-7a50b287fe80	Website
775a6fd9-3b0c-4b9d-952a-341cb1cebd56	New
13df7392-8098-48ae-be97-5145f003f1d8	Marketing
65de851d-9ff9-44f5-943e-b997529a4bfb	Business
b0935b2f-366c-4677-9c71-9c40e332a522	Business
88897d90-25f2-4a21-9446-2b1733bb2b06	Frameworks
81930229-2aa9-4807-9131-025559c50d38	Website
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2023-04-19 05:02:30.343407+00	589301a6-98d9-445b-b3c5-977708ad6112	tips for road cycling in the rain	2	[{"changed": {"fields": ["Status"]}}]	1	1
\.


--
-- Data for Name: django_celery_results_chordcounter; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_celery_results_chordcounter (id, group_id, sub_tasks, count) FROM stdin;
\.


--
-- Data for Name: django_celery_results_groupresult; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_celery_results_groupresult (id, group_id, date_created, date_done, content_type, content_encoding, result) FROM stdin;
\.


--
-- Data for Name: django_celery_results_taskresult; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_celery_results_taskresult (id, task_id, status, content_type, content_encoding, result, date_done, traceback, meta, task_args, task_kwargs, task_name, worker, date_created, periodic_task_name) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	keywordresearch	suggestion
2	keywordresearch	search
3	keywordresearch	article
4	content_generation	output
5	content_generation	recipe
6	content_generation	tag
7	content_generation	skill
8	content_generation	prompt
9	content_generation	document
10	content_generation	project
11	django_celery_results	taskresult
12	django_celery_results	chordcounter
13	django_celery_results	groupresult
14	admin	logentry
15	auth	permission
16	auth	group
17	auth	user
18	contenttypes	contenttype
19	sessions	session
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2023-04-19 04:04:05.744395+00
2	auth	0001_initial	2023-04-19 04:04:05.780453+00
3	admin	0001_initial	2023-04-19 04:04:05.792252+00
4	admin	0002_logentry_remove_auto_add	2023-04-19 04:04:05.79614+00
5	admin	0003_logentry_add_action_flag_choices	2023-04-19 04:04:05.799207+00
6	contenttypes	0002_remove_content_type_name	2023-04-19 04:04:05.805651+00
7	auth	0002_alter_permission_name_max_length	2023-04-19 04:04:05.810101+00
8	auth	0003_alter_user_email_max_length	2023-04-19 04:04:05.814385+00
9	auth	0004_alter_user_username_opts	2023-04-19 04:04:05.817841+00
10	auth	0005_alter_user_last_login_null	2023-04-19 04:04:05.822249+00
11	auth	0006_require_contenttypes_0002	2023-04-19 04:04:05.823231+00
12	auth	0007_alter_validators_add_error_messages	2023-04-19 04:04:05.82795+00
13	auth	0008_alter_user_username_max_length	2023-04-19 04:04:05.833014+00
14	auth	0009_alter_user_last_name_max_length	2023-04-19 04:04:05.837158+00
15	auth	0010_alter_group_name_max_length	2023-04-19 04:04:05.841689+00
16	auth	0011_update_proxy_permissions	2023-04-19 04:04:05.845212+00
17	auth	0012_alter_user_first_name_max_length	2023-04-19 04:04:05.848627+00
18	keywordresearch	0001_initial	2023-04-19 04:04:05.863653+00
19	keywordresearch	0002_suggestion_status	2023-04-19 04:04:05.865614+00
20	content_generation	0001_initial	2023-04-19 04:04:05.890606+00
21	content_generation	0002_auto_20230409_0303	2023-04-19 04:04:05.90584+00
22	content_generation	0003_alter_skill_name	2023-04-19 04:04:05.910844+00
23	content_generation	0004_auto_20230409_0756	2023-04-19 04:04:05.91574+00
24	content_generation	0005_alter_output_payload	2023-04-19 04:04:05.918973+00
25	content_generation	0006_alter_output_payload	2023-04-19 04:04:05.922262+00
26	content_generation	0007_alter_output_payload	2023-04-19 04:04:05.924938+00
27	content_generation	0008_rename_skill_id_output_skill	2023-04-19 04:04:05.929504+00
28	content_generation	0009_document	2023-04-19 04:04:05.933633+00
29	content_generation	0010_alter_document_delta	2023-04-19 04:04:05.936232+00
30	content_generation	0011_alter_document_name	2023-04-19 04:04:05.939807+00
31	content_generation	0012_auto_20230411_0549	2023-04-19 04:04:05.949714+00
32	content_generation	0013_document_suggestion	2023-04-19 04:04:05.953721+00
33	django_celery_results	0001_initial	2023-04-19 04:04:05.96079+00
34	django_celery_results	0002_add_task_name_args_kwargs	2023-04-19 04:04:05.964289+00
35	django_celery_results	0003_auto_20181106_1101	2023-04-19 04:04:05.965992+00
36	django_celery_results	0004_auto_20190516_0412	2023-04-19 04:04:05.979687+00
37	django_celery_results	0005_taskresult_worker	2023-04-19 04:04:05.98355+00
38	django_celery_results	0006_taskresult_date_created	2023-04-19 04:04:05.992472+00
39	django_celery_results	0007_remove_taskresult_hidden	2023-04-19 04:04:05.99421+00
40	django_celery_results	0008_chordcounter	2023-04-19 04:04:05.999905+00
41	django_celery_results	0009_groupresult	2023-04-19 04:04:06.034507+00
42	django_celery_results	0010_remove_duplicate_indices	2023-04-19 04:04:06.037884+00
43	django_celery_results	0011_taskresult_periodic_task_name	2023-04-19 04:04:06.039718+00
44	keywordresearch	0003_suggestion_project	2023-04-19 04:04:06.044138+00
45	sessions	0001_initial	2023-04-19 04:04:06.049768+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
7fmpiwrz6kgeqk7qsglayj2unq3apwjm	.eJxVjEEOgkAMRe8yazNhKHSmLt17hkmhraAGEgZWxrsrCQvd_vfef7nM2zrkreiSR3FnF9zpd-u4f-i0A7nzdJt9P0_rMnZ-V_xBi7_Oos_L4f4dDFyGb20CUZEqFrIGg6RAARBaqyTWRE3NbIiKkqrIQAAKycQiaZ0AW3XvD9UyN24:1pozxT:jWJ1MnmVZLJx0abOxwMMq0INcR45FfqMDXbiM2--k_A	2023-05-03 05:02:19.644754+00
\.


--
-- Data for Name: keywordresearch_article; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keywordresearch_article (_id, title, meta_description, article_content, created_at, related_search_id_id) FROM stdin;
\.


--
-- Data for Name: keywordresearch_search; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keywordresearch_search (_id, serps, questions, created_at, related_suggestion_id_id) FROM stdin;
520d596f-14c5-4289-b017-e3a87f38885b	[{"link": "https://exoticdirect.co.uk/news/how-feed-your-cockatiel/#:~:text=If%20your%20Cockatiel%20stops%20eating,will%20need%20time%20to%20adjust.", "title": "How to feed your Cockatiel - Exotic Direct", "domain": "exoticdirect.co.uk", "snippet": {"html": "<span class=\\"hgKElc\\">If your Cockatiel stops eating <b>it's usually a sign of stress or illness</b>. Some owners find that after buying a new Cockatiel from a pet store, they stop eating. Cockatiels can become stressed if they find themselves in unfamiliar surroundings and they will need time to adjust.</span>", "content": "If your Cockatiel stops eating it's usually a sign of stress or illness. Some owners find that after buying a new Cockatiel from a pet store, they stop eating. Cockatiels can become stressed if they find themselves in unfamiliar surroundings and they will need time to adjust.", "highlighted_word": "it's usually a sign of stress or illness"}, "position": 1, "serp_header": {"title": "How to feed your Cockatiel - Exotic Direct", "displayed_link": "https://exoticdirect.co.uk › news › how-feed-your-cockat...", "displayed_name": "Exotic Direct"}, "post_content": {"toc": [{"id": null, "name": "", "level": "h2"}, {"id": null, "name": "", "level": "h2"}, {"id": null, "name": "Housing your Cockatiel", "level": "h2"}, {"id": null, "name": "What can Cockatiels eat?", "level": "h2"}, {"id": null, "name": "Should I feed my Cockatiel pellets or seeds?", "level": "h2"}, {"id": null, "name": "What fruit and vegetables can Cockatiels eat?", "level": "h2"}, {"id": null, "name": "Sprouting seeds and legumes", "level": "h2"}, {"id": null, "name": "Other natural food", "level": "h2"}, {"id": null, "name": "What can Cockatiels not eat?", "level": "h2"}, {"id": null, "name": "How often should you feed Cockatiels?", "level": "h2"}, {"id": null, "name": "Water and general hygiene", "level": "h2"}, {"id": null, "name": "Why has my Cockatiel stopped eating food?", "level": "h2"}, {"id": null, "name": "What does a healthy Cockatiel look like?", "level": "h2"}, {"id": null, "name": "Keeping your Cockatiel healthy", "level": "h2"}, {"id": null, "name": "More News", "level": "h2"}], "link": {"count": 192, "details": [{"link": "https://www.exoticdirect.co.uk/small-bird-insurance", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://www.feefo.com/en_GB/reviews/exotic-direct?displayFeedbackType=SERVICE&timeFrame=YEAR%20", "domain": "feefo.com", "is_internal": false}, {"link": "https://www.exoticdirect.co.uk/news/how-feed-your-cockatiel#housing", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://www.exoticdirect.co.uk/news/how-feed-your-cockatiel#eat", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://www.exoticdirect.co.uk/news/how-feed-your-cockatiel#pellets", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://www.exoticdirect.co.uk/news/how-feed-your-cockatiel#fruit", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://www.exoticdirect.co.uk/news/how-feed-your-cockatiel#sprouting", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://www.exoticdirect.co.uk/news/how-feed-your-cockatiel#natural", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://www.exoticdirect.co.uk/news/how-feed-your-cockatiel#cockatiels", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://www.exoticdirect.co.uk/news/how-feed-your-cockatiel#feed", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://www.exoticdirect.co.uk/news/how-feed-your-cockatiel#water", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://www.exoticdirect.co.uk/news/how-feed-your-cockatiel#stopped", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://www.exoticdirect.co.uk/news/how-feed-your-cockatiel#healthy", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://www.exoticdirect.co.uk/news/how-feed-your-cockatiel#keeping", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://www.exoticdirect.co.uk/small-bird-insurance", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://www.exoticdirect.co.uk/find-a-vet", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://www.exoticdirect.co.uk/small-bird-insurance", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://www.feefo.com/en_GB/reviews/exotic-direct?displayFeedbackType=SERVICE&timeFrame=YEAR%20", "domain": "feefo.com", "is_internal": false}, {"link": "https://exoticdirect.co.uk/news/quick-and-easy-ways-save-money-tortoise-owner/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/pets-and-childrens-mental-health-exploring-the-purpose-of-pets-in-childrens-lives/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/how-pets-can-benefit-childrens-learning-and-development/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/guinea-pig-noises-and-their-meanings/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/all-you-need-know-about-owning-reptiles-family-pets/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/tortoises-and-hibernation/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/owning-domestic-pets-and-reptiles-same-house/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/top-tips-save-money-parrot-owner/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/10-ideas-homemade-parrot-toys/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/parrot-food-what-your-parrot-can-eat-diet-and-food-ideas/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/great-ways-save-money-guinea-pig-owner/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/ways-save-money-rabbit-owner/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/top-tips-save-money-bearded-dragon-owner/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/when-can-guinea-pigs-go-outside-temperature-security-and-other-care-advice/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/can-pet-rabbits-live-outside-how-keep-your-bunny-safe-outside-winter-and-summer/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/what-set-do-i-need-my-bearded-dragon/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/how-control-your-bearded-dragons-heat-when-its-hot-weather/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/how-setup-parrot-cage-buying-cage-size-location-cleaning-perches/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/ultimate-guinea-pig-guide/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/gut-stasis-guinea-pigs/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/feather-plucking-uv-and-d3-in-indoor-birds-part-five/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/fighting-feather-plucking/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/what-do-chameleons-eat/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/tackling-rabbit-dental-problems/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/how-choose-correct-lighting-for-your-bird-part-four/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/calcium-magnesium-uv-preventing-feather-plucking-part-three/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/parrots-and-aspergillosis/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/benefits-uv-lighting-birds-part-two/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/importance-correct-lighting-for-birds-part-one/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/how-build-aviary/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/getting-grips-gut-stasis/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/foster-bird-insurance-from-exotic-direct/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/how-to-groom-a-rabbit/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/fatty-liver-disease-parrots/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/what-can-african-grey-parrots-eat/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/tortoise-names/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/introducing-new-bearded-dragon-your-home/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/can-a-ferret-live-outside-ideal-outside-temperature-cold-hot-weather-housing/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/parrots-cold-weather/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/pets-fireworks/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/tortoise-care-essentials/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/what-can-blue-tongued-skinks-eat/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/what-parrots-can-live-together/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/tortoise-parasites-worms/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/bearded-dragon-brumation/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/guinea-pig-names/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/visiting-vet-during-coronavirus-outbreak/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/parrots-and-sleeping/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/best-pet-lizards/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/keeping-tortoises-secure-outside/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/how-are-exoticdirect-handling-covid-19/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/pygmy-hedgehog-setup/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/tortoise-respiratory-infection/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/what-do-parakeets-eat/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/covid-19-advice-for-pet-owners/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/bird-security/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/iguana-vivarium-setup/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/how-stop-rabbits-chewing/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/bearded-dragon-costs/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/feeding-corn-snakes/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/what-can-budgies-eat/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/bird-safety-keeping-your-bird-safe-during-the-holidays-and-at-christmas/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/rabbit-names-female-male-funny-famous-rabbit-names/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/crested-gecko-setup-how-setup-complete-crested-gecko-terrarium/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/tortoise-skin-problems/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/feeding-your-rabbit-importance-healthy-diet/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/what-can-guinea-pigs-eat-food-unsafe-food-and-dietary-requirements/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/tortoise-shell-problems/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/what-do-iguanas-eat/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/how-bond-parrot/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/what-are-good-lizard-names-male-female-famous-and-fictional/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/do-tortoises-need-pellets-as-part-of-their-diet/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/how-feed-your-cockatiel/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/how-care-tortoise-after-hibernation/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/bearded-dragon-information-and-facts/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/crested-gecko-diet-what-to-feed-your-crested-gecko/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/feeding-royal-ball-pythons/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/how-train-a-parrot-to-come-you/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/how-much-does-it-cost-keep-ferret/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/leopard-gecko-vivarium-set-up/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/are-christmas-trees-safe-pet-birds/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/python-costs-how-much-does-it-cost-keep-royal-ball-python/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/sexing-your-bearded-dragon/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/reviews-exoticdirect-2/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/reviews-exoticdirect/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/how-much-does-it-cost-own-parrot/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/do-you-need-a-licence-for-a-bird-prey/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/guinea-pig-costs-how-much-does-it-cost-keep-guinea-pig/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/african-grey-and-timneh-grey-parrots-cites-appendix-1/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/best-parrots-have-pets/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/ball-pythons-as-pets-and-what-setup-you-need/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/tortoise-behaviour/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/10-fun-facts-about-micropigs/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/what-can-pygmy-hedgehogs-eat-best-diet-your-pet-hedgehog/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/which-tortoise-should-i-get/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/why-do-parrots-dance/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/what-set-do-i-need-my-bird/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/mini-pig-diet-whats-best-food-your-pet-pig/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/are-green-cheeked-conures-good-pets/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/parrot-names-male-female-famous-and-not-so-famous/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/10-fun-facts-about-chameleons/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/why-is-my-tortoise-always-sleeping/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/tortoise-care-while-on-holiday/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/how-to-train-your-bird-to-step-into-a-carrier/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/how-to-build-an-outdoor-tortoise-enclosure/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/what-can-chinchillas-eat-best-diet-for-pet-chinchillas/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/how-to-look-after-ferrets-cage-setup-cleaning-toxic-litter-and-wood/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/micro-pig-care-advice-how-to-look-after-a-pet-pig/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/why-is-my-parrot-screaming/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/what-should-leopard-geckos-eat-food-and-dietary-requirements/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/corn-snake-setup-costs/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/how-to-stop-guinea-pigs-from-fighting-and-biting/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/how-much-does-it-cost-to-own-a-chameleon/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/chameleon-vivarium-setup-advice/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/parrot-body-language/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/corn-snake-set-up-advice/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/how-to-bird-proof-your-home/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/bird-scam-uk-2017/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/10-fun-facts-about-parrots/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/how-to-set-up-a-guinea-pig-cage/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/what-do-ferrets-eat/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/how-much-does-it-cost-own-leopard-gecko/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/tortoise-costs/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/10-weird-and-wonderful-things-about-reptiles/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/tortoise-insurance-what-you-need-know/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/bearded-dragon-shedding/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/safe-food-and-plants-list-parrots/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/in-sickness-and-in-health-the-illnesses-you-didnt-know-pets-could-suffer-from/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/taking-parrots-outside-and-benefits-harness-training/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/keeping-your-parrot-safe-security-and-identification/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/baby-tortoise-care/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/looking-after-and-caring-ferret/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/most-common-bird-diseases-seen-exoticdirect/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/fearless-exotic-pet-owners-give-their-pets-unusual-and-exotic-names/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/how-train-bird-using-positive-reinforcement/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/degu-food-advice-what-your-degu-should-be-eating-not-eating-diabetes-and-other-advice/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/biting-and-feather-plucking-parrots/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/tortoise-diet-calcium-vitamin-d3-and-not-eating/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/christmas-time-giving-it-time-giving-pets/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/tortoise-food-and-diet-advice/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/how-and-why-do-parrots-talk-best-talking-parrot-and-teaching-your-parrot-talk/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/lost-and-found-parrot-yashas-great-escape/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/bearded-dragon-insurance-what-you-need-know/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/parrot-insurance-can-you-afford-not-2/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/how-train-parrot-step-up/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/aviary-security-advice/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/loss-appetite-reptiles/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/tortoises-old-older-oldest/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/caring-parrot-an-owners-guide/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/five-things-you-need-know-about-purchasing-bird/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/pros-and-cons-exotic-pet-insurance/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/were-proud-be-sponsoring-barn-own-centre-glouceste/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/everything-you-need-to-know-about-applying-for-a-dangerous-wild-animal-licence-and-caring-for-your-pet/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/what-should-you-look-when-choosing-vet/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/advice-reptile-vivariums-heating-and-lighting/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/your-guinea-pigs-diet/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/parrots-12-essential-points-you-should-know/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/reptile-care-advice-lizards-snakes/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/fur-free-doesnt-mean-carefree-report/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/parrot-identification-long-term-security-our-pets/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/security-advice-tortoise/", "domain": "exoticdirect.co.uk", "is_internal": true}, {"link": "https://exoticdirect.co.uk/news/lost-and-found-parrot-register-does-it-again/", "domain": "exoticdirect.co.uk", "is_internal": true}], "external": 2, "internal": 178}, "blog_title": "How to feed your Cockatiel", "word_count": 3134, "links_count": 192, "images_count": 4, "headings_count": 16, "paragraphs_count": 64, "word_count_without_headings": 3065}, "block_position": 1, "about_this_result": null}, {"link": "https://cockatielenthusiast.com/cockatiel-wont-eating/", "title": "10 Possible Reasons Why Your Cockatiel Won't Eat", "domain": "cockatielenthusiast.com", "position": 2, "serp_header": {"title": "10 Possible Reasons Why Your Cockatiel Won't Eat", "displayed_link": "https://cockatielenthusiast.com › Blog", "displayed_name": "Cockatiel Enthusiast"}, "post_content": {"toc": [{"id": "10-possible-reasons-why-your-cockatiel-wont-eat", "name": "10 Possible Reasons Why Your Cockatiel Won’t Eat", "level": "h2"}, {"id": "1-digestive-system-diseases", "name": "1. Digestive system diseases", "level": "h3"}, {"id": "2-respiratory-diseases", "name": "2. Respiratory diseases", "level": "h3"}, {"id": "3-injury", "name": "3. Injury", "level": "h3"}, {"id": "4-changes-in-food", "name": "4. Changes in food", "level": "h3"}, {"id": "5-bored-with-food", "name": "5. Bored with food", "level": "h3"}, {"id": "6-stress-from-a-new-environment", "name": "6. Stress from a new environment", "level": "h3"}, {"id": "7-safety", "name": "7. Safety", "level": "h3"}, {"id": "8-overfeeding", "name": "8. Overfeeding", "level": "h3"}, {"id": "9-picky-with-food", "name": "9. Picky with food", "level": "h3"}, {"id": "10-stubbornness", "name": "10. Stubbornness", "level": "h3"}, {"id": "what-to-do-if-your-cockatiel-isnt-eating", "name": "What To Do If Your Cockatiel Isn’t Eating?", "level": "h2"}, {"id": "1-clean-your-cockatiels-cage", "name": "1. Clean your cockatiel’s cage", "level": "h3"}, {"id": "2-provide-a-variety-of-foods", "name": "2. Provide a variety of foods", "level": "h3"}, {"id": "3-hand-feed-your-cockatiel", "name": "3. Hand feed your cockatiel", "level": "h3"}, {"id": "4-make-your-cockatiel-feel-safe", "name": "4. Make your cockatiel feel safe", "level": "h3"}], "link": {"count": 11, "details": [{"link": "https://cockatielenthusiast.com/why-does-my-cockatiel-have-diarrhea/", "domain": "cockatielenthusiast.com", "is_internal": true}, {"link": "https://cockatielenthusiast.com/why-is-my-cockatiel-breathing-fast/", "domain": "cockatielenthusiast.com", "is_internal": true}, {"link": "https://cockatielenthusiast.com/how-can-you-tell-if-a-cockatiels-wing-is-broken/", "domain": "cockatielenthusiast.com", "is_internal": true}, {"link": "https://cockatielenthusiast.com/cockatiels-picky-eaters/", "domain": "cockatielenthusiast.com", "is_internal": true}, {"link": "https://cockatielenthusiast.com/cockatiel-eat-too-much-millet/", "domain": "cockatielenthusiast.com", "is_internal": true}, {"link": "https://cockatielenthusiast.com/can-cockatiels-eat-strawberries/", "domain": "cockatielenthusiast.com", "is_internal": true}, {"link": "https://cockatielenthusiast.com/can-cockatiels-eat-cucumbers/", "domain": "cockatielenthusiast.com", "is_internal": true}, {"link": "https://cockatielenthusiast.com/can-cockatiels-eat-lettuce/", "domain": "cockatielenthusiast.com", "is_internal": true}, {"link": "https://cockatielenthusiast.com/is-mold-bad-for-cockatiels/", "domain": "cockatielenthusiast.com", "is_internal": true}, {"link": "https://cockatielenthusiast.com/what-can-cockatiels-eat-and-what-cannot/", "domain": "cockatielenthusiast.com", "is_internal": true}, {"link": "https://lafeber.com/pet-birds/avoid-feeding-mistakes/", "domain": "lafeber.com", "is_internal": false}], "external": 1, "internal": 10}, "blog_title": "10 Possible Reasons Why Your Cockatiel Won’t Eat", "word_count": 2030, "links_count": 11, "images_count": 136, "headings_count": 17, "paragraphs_count": 58, "word_count_without_headings": 1945}, "block_position": 2, "meta_description": {"date": "Aug 25, 2022", "html": "<span>Cockatiels won't eat for various reasons such as stress, upset stomach, overfeeding, or behavior issues. Additionally, <em>sudden loss of appetite</em> ...</span>", "text": "Cockatiels won't eat for various reasons such as stress, upset stomach, overfeeding, or behavior issues. Additionally, sudden loss of appetite ...", "highlighted_words": ["sudden loss of appetite"]}, "about_this_result": null}, {"link": "https://www.acstiels.com/help-my-new-pet-cockatiel-wont-eat", "title": "Help, My New Pet Cockatiel Won't Eat!", "domain": "acstiels.com", "position": 3, "serp_header": {"title": "Help, My New Pet Cockatiel Won't Eat!", "displayed_link": "https://www.acstiels.com › help-my-new-pet-cockatiel-...", "displayed_name": "acstiels"}, "post_content": {"toc": [], "link": {"count": 0, "details": [], "external": 0, "internal": 0}, "blog_title": null, "word_count": 593, "links_count": 0, "images_count": 0, "headings_count": 0, "paragraphs_count": 14, "word_count_without_headings": 583}, "block_position": 3, "meta_description": {"date": null, "html": "<span><em>Due to the stress of changing homes</em>, some young cockatiels that were recently weaned or recently taken away from their clutch mates refuse to eat.</span>", "text": "Due to the stress of changing homes, some young cockatiels that were recently weaned or recently taken away from their clutch mates refuse to eat.", "highlighted_words": ["Due to the stress of changing homes"]}, "about_this_result": null}, {"link": "https://lafeber.com/pet-birds/questions/should-i-feed-baby-cockatiel-if-it-doesnt-beg-for-food/", "title": "Should I feed baby cockatiel if it doesn't beg for food?", "domain": "lafeber.com", "position": 4, "serp_header": {"title": "Should I feed baby cockatiel if it doesn't beg for food?", "displayed_link": "https://lafeber.com › Home › questions", "displayed_name": "Lafeber Company"}, "post_content": null, "block_position": 4, "meta_description": {"date": "Aug 6, 2020", "html": "<span>Yes, the parents will feed a chick a lot more, but they are not feeding the chick a liquid formula. <em>A chick should never be force fed</em> – this ...</span>", "text": "Yes, the parents will feed a chick a lot more, but they are not feeding the chick a liquid formula. A chick should never be force fed – this ...", "highlighted_words": ["A chick should never be force fed"]}, "about_this_result": null}, {"link": "https://www.talkcockatiels.com/threads/baby-cockatiel-wont-eat-please-help.37536/", "serp": {"footer": "<div class=\\"Z26q7c UK95Uc\\" data-sncf=\\"2\\" data-snf=\\"M7eMpf\\"><div data-ved=\\"2ahUKEwiqkNeyj7X-AhVVVqQEHTQyDi8QqwJ6BAg0EAA\\"><div class=\\"P1usbc\\"><div class=\\"VNLkW\\"><div class=\\"i4vd5e\\"><div class=\\"wrBvFf OSrXXb\\"><a class=\\"fl\\" href=\\"https://www.talkcockatiels.com/threads/if-your-new-cockatiel-wont-eat.27080/\\" jsaction=\\"rcuQ6b:npT2md\\" jscontroller=\\"M9mgyc\\" jsname=\\"qOiK6e\\" ping=\\"/url?sa=t&amp;source=web&amp;rct=j&amp;url=https://www.talkcockatiels.com/threads/if-your-new-cockatiel-wont-eat.27080/&amp;ved=2ahUKEwiqkNeyj7X-AhVVVqQEHTQyDi8QrAIoAHoECDQQAQ\\"><span>If your new <em>cockatiel won't eat</em></span></a></div></div><div class=\\"G1Rrjc\\"><div class=\\"wrBvFf OSrXXb\\"><span>Jan 11, 2012</span></div></div></div><div class=\\"VNLkW\\"><div class=\\"i4vd5e\\"><div class=\\"wrBvFf OSrXXb\\"><a class=\\"fl\\" href=\\"https://www.talkcockatiels.com/threads/baby-cockatiel-not-eating-much.20580/\\" jsaction=\\"rcuQ6b:npT2md\\" jscontroller=\\"M9mgyc\\" jsname=\\"qOiK6e\\" ping=\\"/url?sa=t&amp;source=web&amp;rct=j&amp;url=https://www.talkcockatiels.com/threads/baby-cockatiel-not-eating-much.20580/&amp;ved=2ahUKEwiqkNeyj7X-AhVVVqQEHTQyDi8QrAIoAXoECDQQAg\\"><span><em>Baby Cockatiel</em> Not <em>Eating</em> Much</span></a></div></div><div class=\\"G1Rrjc\\"><div class=\\"wrBvFf OSrXXb\\"><span>May 30, 2011</span></div></div></div><div class=\\"VNLkW\\"><div class=\\"i4vd5e\\"><div class=\\"wrBvFf OSrXXb\\"><a class=\\"fl\\" href=\\"https://www.talkcockatiels.com/threads/not-eating-no-noise-no-nothing.14629/\\" jsaction=\\"rcuQ6b:npT2md\\" jscontroller=\\"M9mgyc\\" jsname=\\"qOiK6e\\" ping=\\"/url?sa=t&amp;source=web&amp;rct=j&amp;url=https://www.talkcockatiels.com/threads/not-eating-no-noise-no-nothing.14629/&amp;ved=2ahUKEwiqkNeyj7X-AhVVVqQEHTQyDi8QrAIoAnoECDQQAw\\"><span>Not <em>eating</em>, no noise.. no nothing. - Talk Cockatiels Forum</span></a></div></div><div class=\\"G1Rrjc\\"><div class=\\"wrBvFf OSrXXb\\"><span>Jul 19, 2010</span></div></div></div><div class=\\"VNLkW\\"><div class=\\"i4vd5e\\"><div class=\\"wrBvFf OSrXXb\\"><a class=\\"fl\\" href=\\"https://www.talkcockatiels.com/threads/babies-wont-eat.30684/\\" jsaction=\\"rcuQ6b:npT2md\\" jscontroller=\\"M9mgyc\\" jsname=\\"qOiK6e\\" ping=\\"/url?sa=t&amp;source=web&amp;rct=j&amp;url=https://www.talkcockatiels.com/threads/babies-wont-eat.30684/&amp;ved=2ahUKEwiqkNeyj7X-AhVVVqQEHTQyDi8QrAIoA3oECDQQBA\\"><span><em>Babies won't eat</em>. | Talk <em>Cockatiels</em> Forum</span></a></div></div><div class=\\"G1Rrjc\\"><div class=\\"wrBvFf OSrXXb\\"><span>Jun 10, 2012</span></div></div></div><div class=\\"k6DEPe\\"><div class=\\"i4vd5e\\"><div class=\\"wrBvFf OSrXXb\\"><a class=\\"fl\\" href=\\"/search?q=baby+cockatiel+won't+eat+site:www.talkcockatiels.com&amp;gl=us&amp;sa=X&amp;ved=2ahUKEwiqkNeyj7X-AhVVVqQEHTQyDi8QrQIoBHoECDQQBQ\\" jsaction=\\"rcuQ6b:npT2md\\" jscontroller=\\"M9mgyc\\" jsname=\\"qOiK6e\\"><span>More results from www.talkcockatiels.com</span></a></div></div></div></div></div></div>"}, "title": "Baby Cockatiel won't eat, please help!", "domain": "talkcockatiels.com", "position": 5, "serp_header": {"title": "Baby Cockatiel won't eat, please help!", "displayed_link": "https://www.talkcockatiels.com › threads › baby-cocka...", "displayed_name": "Talk Cockatiels Forum"}, "post_content": null, "block_position": 5, "meta_description": {"date": "Feb 3, 2013", "html": "<span><em>See if he's willing to eat formula from a spoon instead of a syringe</em>. If he hasn't been handfed before, he isn't familiar with this kind of food ...</span>", "text": "See if he's willing to eat formula from a spoon instead of a syringe. If he hasn't been handfed before, he isn't familiar with this kind of food ...", "highlighted_words": ["See if he's willing to eat formula from a spoon instead of a syringe"]}, "about_this_result": null}, {"link": "https://forums.avianavenue.com/index.php?threads/my-baby-cockatiel-wont-eat-or-drink.272488/", "serp": {"footer": "<div class=\\"Z26q7c UK95Uc\\" data-sncf=\\"2\\" data-snf=\\"M7eMpf\\"><div data-ved=\\"2ahUKEwiqkNeyj7X-AhVVVqQEHTQyDi8QqwJ6BAg8EAA\\"><div class=\\"P1usbc\\"><div class=\\"VNLkW\\"><div class=\\"i4vd5e\\"><div class=\\"wrBvFf OSrXXb\\"><a class=\\"fl\\" href=\\"https://forums.avianavenue.com/index.php?threads/cockatiel-is-sick-and-he-won%E2%80%99t-eat-food-or-water.219878/\\" jsaction=\\"rcuQ6b:npT2md\\" jscontroller=\\"M9mgyc\\" jsname=\\"qOiK6e\\" ping=\\"/url?sa=t&amp;source=web&amp;rct=j&amp;url=https://forums.avianavenue.com/index.php%3Fthreads/cockatiel-is-sick-and-he-won%25E2%2580%2599t-eat-food-or-water.219878/&amp;ved=2ahUKEwiqkNeyj7X-AhVVVqQEHTQyDi8QrAIoAHoECDwQAQ\\"><span><em>Cockatiel</em> is sick and he <em>won't eat</em> food or water. - Avian Avenue</span></a></div></div><div class=\\"G1Rrjc\\"><div class=\\"wrBvFf OSrXXb\\"><span>Dec 30, 2018</span></div></div></div><div class=\\"VNLkW\\"><div class=\\"i4vd5e\\"><div class=\\"wrBvFf OSrXXb\\"><a class=\\"fl\\" href=\\"https://forums.avianavenue.com/index.php?threads/new-seven-week-old-cockatiel-won%E2%80%99t-eat-formula.237164/post-3193791\\" jsaction=\\"rcuQ6b:npT2md\\" jscontroller=\\"M9mgyc\\" jsname=\\"qOiK6e\\" ping=\\"/url?sa=t&amp;source=web&amp;rct=j&amp;url=https://forums.avianavenue.com/index.php%3Fthreads/new-seven-week-old-cockatiel-won%25E2%2580%2599t-eat-formula.237164/post-3193791&amp;ved=2ahUKEwiqkNeyj7X-AhVVVqQEHTQyDi8QrAIoAXoECDwQAg\\"><span>New seven week old <em>cockatiel won't eat</em> formula - Avian Avenue</span></a></div></div><div class=\\"G1Rrjc\\"><div class=\\"wrBvFf OSrXXb\\"><span>Jan 31, 2020</span></div></div></div><div class=\\"VNLkW\\"><div class=\\"i4vd5e\\"><div class=\\"wrBvFf OSrXXb\\"><a class=\\"fl\\" href=\\"https://forums.avianavenue.com/index.php?threads/8-week-old-cockatiel-not-eating.243950/\\" jsaction=\\"rcuQ6b:npT2md\\" jscontroller=\\"M9mgyc\\" jsname=\\"qOiK6e\\" ping=\\"/url?sa=t&amp;source=web&amp;rct=j&amp;url=https://forums.avianavenue.com/index.php%3Fthreads/8-week-old-cockatiel-not-eating.243950/&amp;ved=2ahUKEwiqkNeyj7X-AhVVVqQEHTQyDi8QrAIoAnoECDwQAw\\"><span>8 Week old <em>cockatiel</em> not <em>eating</em>. | Avian Avenue Parrot Forum</span></a></div></div><div class=\\"G1Rrjc\\"><div class=\\"wrBvFf OSrXXb\\"><span>May 30, 2020</span></div></div></div><div class=\\"VNLkW\\"><div class=\\"i4vd5e\\"><div class=\\"wrBvFf OSrXXb\\"><a class=\\"fl\\" href=\\"https://forums.avianavenue.com/index.php?threads/cockatiel-chick-not-eating.264910/\\" jsaction=\\"rcuQ6b:npT2md\\" jscontroller=\\"M9mgyc\\" jsname=\\"qOiK6e\\" ping=\\"/url?sa=t&amp;source=web&amp;rct=j&amp;url=https://forums.avianavenue.com/index.php%3Fthreads/cockatiel-chick-not-eating.264910/&amp;ved=2ahUKEwiqkNeyj7X-AhVVVqQEHTQyDi8QrAIoA3oECDwQBA\\"><span><em>Cockatiel</em> chick not <em>eating</em> | Avian Avenue Parrot Forum</span></a></div></div><div class=\\"G1Rrjc\\"><div class=\\"wrBvFf OSrXXb\\"><span>Jun 8, 2021</span></div></div></div><div class=\\"k6DEPe\\"><div class=\\"i4vd5e\\"><div class=\\"wrBvFf OSrXXb\\"><a class=\\"fl\\" href=\\"/search?q=baby+cockatiel+won't+eat+site:forums.avianavenue.com&amp;gl=us&amp;sa=X&amp;ved=2ahUKEwiqkNeyj7X-AhVVVqQEHTQyDi8QrQIoBHoECDwQBQ\\" jsaction=\\"rcuQ6b:npT2md\\" jscontroller=\\"M9mgyc\\" jsname=\\"qOiK6e\\"><span>More results from forums.avianavenue.com</span></a></div></div></div></div></div></div>"}, "title": "My Baby Cockatiel Won't Eat or Drink", "domain": "forums.avianavenue.com", "position": 6, "serp_header": {"title": "My Baby Cockatiel Won't Eat or Drink", "displayed_link": "https://forums.avianavenue.com › ... › Cockatiel Corner", "displayed_name": "Avian Avenue"}, "post_content": {"toc": [], "link": {"count": 5, "details": [{"link": "/index.php?members/picklez.53215/", "domain": "index.php?members", "is_internal": true}, {"link": "/index.php?members/picklez.53215/", "domain": "index.php?members", "is_internal": true}, {"link": "/index.php?threads/my-baby-cockatiel-wont-eat-or-drink.272488/post-3539546", "domain": "index.php?threads", "is_internal": true}, {"link": "/index.php?threads/my-baby-cockatiel-wont-eat-or-drink.272488/post-3539546", "domain": "index.php?threads", "is_internal": true}, {"link": "/index.php?threads/my-baby-cockatiel-wont-eat-or-drink.272488/post-3539546", "domain": "index.php?threads", "is_internal": true}], "external": 5, "internal": 0}, "blog_title": "My Baby Cockatiel Won't Eat or Drink", "word_count": 173, "links_count": 5, "images_count": 1, "headings_count": 1, "paragraphs_count": 0, "word_count_without_headings": 97}, "block_position": 6, "meta_description": {"date": "Nov 22, 2021", "html": "<span><em>Veggies have water especially leafy</em>. Experiment &amp; give them all sort of veggies. You can make some oatmeal with peas &amp; corn. Mashed sweet potato ...</span>", "text": "Veggies have water especially leafy. Experiment & give them all sort of veggies. You can make some oatmeal with peas & corn. Mashed sweet potato ...", "highlighted_words": ["Veggies have water especially leafy"]}, "about_this_result": null}, {"link": "https://www.quora.com/My-4-week-old-cockatiel-is-not-eating-his-formula-Before-he-would-eat-all-of-it-now-he-barely-wants-it-I-feel-like-he-is-sick-Is-there-any-way-I-can-help-him", "serp": {"footer": "<div class=\\"Z26q7c UK95Uc\\" data-sncf=\\"2\\" data-snf=\\"sYEzk\\"><div><div class=\\"YkS8D\\"><a class=\\"YjtGef\\" href=\\"https://www.quora.com/My-4-week-old-cockatiel-is-not-eating-his-formula-Before-he-would-eat-all-of-it-now-he-barely-wants-it-I-feel-like-he-is-sick-Is-there-any-way-I-can-help-him?top_ans=279550783\\" ping=\\"/url?sa=t&amp;source=web&amp;rct=j&amp;url=https://www.quora.com/My-4-week-old-cockatiel-is-not-eating-his-formula-Before-he-would-eat-all-of-it-now-he-barely-wants-it-I-feel-like-he-is-sick-Is-there-any-way-I-can-help-him%3Ftop_ans%3D279550783&amp;ved=2ahUKEwiqkNeyj7X-AhVVVqQEHTQyDi8Q4-4CegQIMBAB\\">3 answers</a> <span class=\\"Bxc0O\\"> · </span> <span class=\\"EFv1uc\\">1 vote: </span><span class=\\"EETcFd OSrXXb\\">You might need to get him checked out at a vet just in case.\\n\\nAre you feeding him when his ...</span></div></div></div>"}, "title": "My 4-week-old cockatiel is not eating his formula. Before ...", "domain": "quora.com", "position": 7, "serp_header": {"title": "My 4-week-old cockatiel is not eating his formula. Before ...", "displayed_link": "https://www.quora.com › My-4-week-old-cockatiel-is-no...", "displayed_name": "Quora"}, "post_content": null, "block_position": 7, "meta_description": {"date": "May 7, 2021", "html": "<span><em>Get it to a breeder or an avian vet immediately</em>. Call the American Federation of Aviculture, ask for a breeder near you and call them. They will help you. DO IT ...</span>", "text": "Get it to a breeder or an avian vet immediately. Call the American Federation of Aviculture, ask for a breeder near you and call them. They will help you. DO IT ...", "highlighted_words": ["Get it to a breeder or an avian vet immediately"]}, "about_this_result": null}, {"link": "https://mickaboo.org/resources/eating-problems", "serp": {"footer": "<div class=\\"Z26q7c UK95Uc\\" data-sncf=\\"2\\" data-snf=\\"oyZ5Hb\\"><div class=\\"TXwUJf\\"><span>Not in this result:</span> <s><span>baby</span></s> ‎| Must include: <a class=\\"fl\\" href=\\"/search?gl=us&amp;q=%22baby%22+cockatiel+won't+eat&amp;sa=X&amp;ved=2ahUKEwiqkNeyj7X-AhVVVqQEHTQyDi8Q5t4CegQIMhAB\\" jsaction=\\"rcuQ6b:npT2md\\" jscontroller=\\"M9mgyc\\" jsname=\\"qOiK6e\\"><span>baby</span></a></div></div>"}, "title": "Eating Problems", "domain": "mickaboo.org", "position": 8, "serp_header": {"title": "Eating Problems", "displayed_link": "https://mickaboo.org › resources › eating-problems", "displayed_name": "Mickaboo"}, "post_content": {"toc": [], "link": {"count": 1, "details": [{"link": "/resources/diet", "domain": "resources", "is_internal": true}], "external": 1, "internal": 0}, "blog_title": "Eating Problems", "word_count": 1535, "links_count": 1, "images_count": 2, "headings_count": 1, "paragraphs_count": 12, "word_count_without_headings": 1499}, "block_position": 8, "meta_description": {"date": null, "html": "<span><em>Due to the stress of changing homes</em>, some cockatiels refuse to eat. They need time to adjust to their new environment and a little help from you. Here's what ...</span>", "text": "Due to the stress of changing homes, some cockatiels refuse to eat. They need time to adjust to their new environment and a little help from you. Here's what ...", "highlighted_words": ["Due to the stress of changing homes"]}, "about_this_result": null}, {"link": "https://be.chewy.com/care-for-an-abandoned-baby-cockatiel/", "title": "Care For An Abandoned Baby Cockatiel", "domain": "be.chewy.com", "position": 9, "serp_header": {"title": "Care For An Abandoned Baby Cockatiel", "displayed_link": "https://be.chewy.com › BeWell", "displayed_name": "Chewy.com"}, "post_content": null, "block_position": 9, "meta_description": {"date": "Jun 11, 2016", "html": "<span>In general, 3-week old cockatiel babies usually <em>require five feeds per day</em>; 4-week old babies require four feeds; 5-week old babies need three ...</span>", "text": "In general, 3-week old cockatiel babies usually require five feeds per day; 4-week old babies require four feeds; 5-week old babies need three ...", "highlighted_words": ["require five feeds per day"]}, "about_this_result": null}]	"[{\\"question\\": \\"What to do if baby cockatiel won't eat?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 2}, {\\"question\\": \\"How do you get a baby cockatiel to eat?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 2}, {\\"question\\": \\"How long can a baby cockatiel go without eating?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 2}, {\\"question\\": \\"Why is my baby cockatiel always crying for food?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 2}, {\\"question\\": \\"how long can baby cockatiels go without food\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 12}, {\\"question\\": \\"my cockatiel is not eating or drinking\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 12}, {\\"question\\": \\"cockatiel not eating and sleeping\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 12}, {\\"question\\": \\"when do baby cockatiels start eating on their own\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 12}, {\\"question\\": \\"when do baby cockatiels start drinking water\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 12}, {\\"question\\": \\"millet spray\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 12}, {\\"question\\": \\"cockatiel eating less\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 12}, {\\"question\\": \\"At what age do baby cockatiels start eating?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 3}, {\\"question\\": \\"How do you feed a baby cockatiel?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How do you feed a 3 week old cockatiel?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How often do baby cockatiels need to be fed?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 2}, {\\"question\\": \\"How long can a cockatiel survive without eating?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 2}, {\\"question\\": \\"How often do 3 week old cockatiels eat?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What to do if my baby cockatiel is not eating?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Can you overfeed a baby cockatiel?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How do I get my baby cockatiel to stop screaming?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How often do you feed a baby cockatiel?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Why won't my baby bird stop crying?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How much should a 4 week old cockatiel eat?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How long does it take for a baby cockatiels crop to empty?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What do I do if my cockatiel is not eating?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How long can a cockatiel go without eating or drinking?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Why is my bird not eating or drinking?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What are signs of illness in cockatiels?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Why is my cockatiel always sleeping and not eating?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What are the signs of a sick cockatiel?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Why is my cockatiel suddenly not eating?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 2}, {\\"question\\": \\"How long can cockatiels go without eating?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How do I get my cockatiel to eat on its own?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How long do baby cockatiels need to be hand fed?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Why is my 4 week old cockatiel not eating?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How do I get my cockatiel to drink water?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How do you teach a baby bird to drink water?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How long does it take for a baby cockatiel to eat on its own?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"When can cockatiels drink water?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What is millet spray?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Is Spray Millet good for birds?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Do wild birds eat Spray Millet?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How do you make millet spray?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What does Spray Millet taste like?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How long is Spray Millet good for birds?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How much should a cockatiel eat a day?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How long can a cockatiel last without eating?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How can I get my cockatiel to eat more?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}]"	2023-04-19 04:36:20.874183+00	1bc5d219-637a-459f-8e7c-0fc4c0fdfef8
12a5ae4f-3413-48e4-8938-5ee547a8478d	[{"link": "https://hincapie.com/ride-with-us/stories-from-the-saddle/20-tips-cycling-rain/", "title": "20 Tips for Cycling in the Rain - Hincapie", "domain": "hincapie.com", "position": 1, "serp_header": {"title": "20 Tips for Cycling in the Rain - Hincapie", "displayed_link": "https://hincapie.com › Stories from the Saddle", "displayed_name": "Hincapie Sportswear"}, "post_content": null, "block_position": 1, "about_this_result": null}, {"link": "https://www.cyclingweekly.com/news/latest-news/cycling-in-the-rain-how-to-survive-it-19050", "serp": {"footer": "<div class=\\"Z26q7c UK95Uc\\" data-sncf=\\"2\\" data-snf=\\"gdePb\\"><div class=\\"HiHjCd\\">‎<a href=\\"https://www.cyclingweekly.com/news/latest-news/cycling-in-the-rain-how-to-survive-it-19050#section-2-keep-splash-off-with-mudguards-or-fenders\\" ping=\\"/url?sa=t&amp;source=web&amp;rct=j&amp;url=https://www.cyclingweekly.com/news/latest-news/cycling-in-the-rain-how-to-survive-it-19050%23section-2-keep-splash-off-with-mudguards-or-fenders&amp;ved=2ahUKEwi-_PS7lbX-AhXNVKQEHa1iCHIQ0gIoAHoECAoQAQ\\">Keep splash off with...</a> · ‎<a href=\\"https://www.cyclingweekly.com/news/latest-news/cycling-in-the-rain-how-to-survive-it-19050#section-5-wear-a-cycling-cap\\" ping=\\"/url?sa=t&amp;source=web&amp;rct=j&amp;url=https://www.cyclingweekly.com/news/latest-news/cycling-in-the-rain-how-to-survive-it-19050%23section-5-wear-a-cycling-cap&amp;ved=2ahUKEwi-_PS7lbX-AhXNVKQEHa1iCHIQ0gIoAXoECAoQAg\\">Wear a cycling cap</a> · ‎<a href=\\"https://www.cyclingweekly.com/news/latest-news/cycling-in-the-rain-how-to-survive-it-19050#section-7-check-your-tires-and-reduce-the-pressure\\" ping=\\"/url?sa=t&amp;source=web&amp;rct=j&amp;url=https://www.cyclingweekly.com/news/latest-news/cycling-in-the-rain-how-to-survive-it-19050%23section-7-check-your-tires-and-reduce-the-pressure&amp;ved=2ahUKEwi-_PS7lbX-AhXNVKQEHa1iCHIQ0gIoAnoECAoQAw\\">Check your tires and reduce...</a></div></div>"}, "title": "11 tips for cycling in the rain: essentials for riding out ...", "domain": "cyclingweekly.com", "position": 2, "serp_header": {"title": "11 tips for cycling in the rain: essentials for riding out ...", "displayed_link": "https://www.cyclingweekly.com › Fitness", "displayed_name": "Cycling Weekly"}, "post_content": {"toc": [{"id": "11-top-tips-for-cycling-in-the-rain-3", "name": "11 top tips for cycling in the rain", "level": "h2"}, {"id": "section-1-invest-in-a-good-waterproof-jacket", "name": "1. Invest in a good waterproof jacket", "level": "h3"}, {"id": "section-2-keep-splash-off-with-mudguards-or-fenders", "name": "2. Keep splash off with mudguards or fenders", "level": "h3"}, {"id": "section-3-wear-overshoes-and-gloves", "name": "3. Wear overshoes and gloves", "level": "h3"}, {"id": "section-4-use-chain-degreaser", "name": "4. Use chain degreaser", "level": "h3"}, {"id": "section-5-wear-a-cycling-cap", "name": "5. Wear a cycling cap", "level": "h3"}, {"id": "section-6-avoid-standing-water", "name": "6. Avoid standing water", "level": "h3"}, {"id": "section-7-check-your-tires-and-reduce-the-pressure", "name": "7. Check your tires and reduce the pressure", "level": "h3"}, {"id": "section-8-utilise-plastic-bags", "name": "8. Utilise plastic bags", "level": "h3"}, {"id": "section-9-use-lights", "name": "9. Use lights", "level": "h3"}, {"id": "section-10-just-get-on-the-turbo", "name": "10. Just get on the turbo", "level": "h3"}, {"id": "section-11-don-t-always-hide-from-the-rain", "name": "11. Don’t always hide from the rain", "level": "h3"}], "link": {"count": 126, "details": [{"link": "#section-1-invest-in-a-good-waterproof-jacket", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "#section-2-keep-splash-off-with-mudguards-or-fenders", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "#section-3-wear-overshoes-and-gloves", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "#section-4-use-chain-degreaser", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "#section-5-wear-a-cycling-cap", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "#section-6-avoid-standing-water", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "#section-7-check-your-tires-and-reduce-the-pressure", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "#section-8-utilise-plastic-bags", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "#section-9-use-lights", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "#section-10-just-get-on-the-turbo", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "#section-11-don-t-always-hide-from-the-rain", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.cyclingweekly.com/author/simon-richardson", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.cyclingweekly.com/group-tests/cycling-jackets-wet-weather-139198", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-1309738126463922000&p=31131939667&a=103504&m=15692", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-1309738126463922000&p=31131939667&a=103504&m=15692", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-1309738126463922000&p=31131939667&a=103504&m=15692", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-1309738126463922000&p=31131939667&a=103504&m=15692", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-1309738126463922000&p=31131939667&a=103504&m=15692", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.cyclingweekly.com/deals/compare?origin=news&model_name=Le%20Col%20Pro%20Rain%20Jacket&article_id=19050", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-5114496802021798000&p=32923822801&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-5114496802021798000&p=32923822801&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-5114496802021798000&p=32923822801&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-5114496802021798000&p=32923822801&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-5114496802021798000&p=32923822801&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-5114496802021798000&p=32923822801&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.cyclingweekly.com/deals/compare?origin=news&model_name=dhb%20Lab%20Aeron%20Ultralight%20Waterproof%20Jacket&article_id=19050", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.cyclingweekly.com/group-tests/best-bike-mudguards-4765", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB01N7SZCLG%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-1269558742124821000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB01N7SZCLG%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-1269558742124821000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB01N7SZCLG%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-1269558742124821000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB01N7SZCLG%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-1269558742124821000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB01N7SZCLG%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-1269558742124821000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB01N7SZCLG%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-1269558742124821000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://www.cyclingweekly.com/deals/compare?origin=news&model_name=SKS%20Bluemels%20Stingray%20mudguards&article_id=19050", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-1167941367765871000&p=25010790887&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-1167941367765871000&p=25010790887&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-1167941367765871000&p=25010790887&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-1167941367765871000&p=25010790887&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-1167941367765871000&p=25010790887&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.cyclingweekly.com/deals/compare?origin=news&model_name=Crud%20Roadracer%20Mk3%20mudguards&article_id=19050", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.cyclingweekly.com/group-tests/the-best-cycling-overshoes-150945", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.cyclingweekly.com/group-tests/winter-cycling-gloves-grouptest-21239", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB079SFTX95%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-6494163866014289000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB079SFTX95%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-6494163866014289000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB079SFTX95%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-6494163866014289000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB079SFTX95%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-6494163866014289000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB079SFTX95%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-6494163866014289000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB079SFTX95%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-6494163866014289000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://www.cyclingweekly.com/deals/compare?origin=news&model_name=GripGrab%20Ride%20Waterproof%20Shoe%20Cover&article_id=19050", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-9049356113173970000&p=27448786713&a=103504&m=3462", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-9049356113173970000&p=27448786713&a=103504&m=3462", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-9049356113173970000&p=27448786713&a=103504&m=3462", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-9049356113173970000&p=27448786713&a=103504&m=3462", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-9049356113173970000&p=27448786713&a=103504&m=3462", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-9049356113173970000&p=27448786713&a=103504&m=3462", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.cyclingweekly.com/deals/compare?origin=news&model_name=Endura%20Freezing%20Point%20Overshoes&article_id=19050", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07WQYCS49%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-9415680570732995000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07WQYCS49%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-9415680570732995000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07WQYCS49%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-9415680570732995000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07WQYCS49%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-9415680570732995000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07WQYCS49%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-9415680570732995000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://www.cyclingweekly.com/deals/compare?origin=news&model_name=Castelli%20Perfetto%20RoS%20gloves&article_id=19050", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-7919062850919710000&p=31707540775&a=103504&m=6821", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-7919062850919710000&p=31707540775&a=103504&m=6821", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-7919062850919710000&p=31707540775&a=103504&m=6821", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-7919062850919710000&p=31707540775&a=103504&m=6821", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-7919062850919710000&p=31707540775&a=103504&m=6821", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-7919062850919710000&p=31707540775&a=103504&m=6821", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.cyclingweekly.com/deals/compare?origin=news&model_name=Altura%20Firestorm%20Reflective%20Gloves&article_id=19050", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.cyclingweekly.com/video/how-to-clean-your-bike-221294", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.cyclingweekly.com/group-tests/cycling-caps-346553", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07R8WQPFY%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-8443514723119062000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07R8WQPFY%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-8443514723119062000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07R8WQPFY%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-8443514723119062000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07R8WQPFY%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-8443514723119062000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07R8WQPFY%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-8443514723119062000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://www.cyclingweekly.com/deals/compare?origin=news&model_name=Sealskinz%20Waterproof%20All%20Weather%20Cycle%20Cap&article_id=19050", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.cyclingweekly.com/news/product-news/fix-a-puncture-142674", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.cyclingweekly.com/news/best-winter-tyres-for-road-cycling-462830", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.cyclingweekly.com/news/product-news/whats-the-correct-road-bike-tyre-pressure-270668", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07DRGH6KN%2Fref%3Dasc_df_B07DRGH6KN1681673160000%2F%3Ftag%3Dhawk-future-21%26creative%3D22374%26creativeASIN%3DB07DRGH6KN%26linkCode%3Ddf0%26ascsubtag%3Dcyclingweekly-gb-6013750091652864000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07DRGH6KN%2Fref%3Dasc_df_B07DRGH6KN1681673160000%2F%3Ftag%3Dhawk-future-21%26creative%3D22374%26creativeASIN%3DB07DRGH6KN%26linkCode%3Ddf0%26ascsubtag%3Dcyclingweekly-gb-6013750091652864000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07DRGH6KN%2Fref%3Dasc_df_B07DRGH6KN1681673160000%2F%3Ftag%3Dhawk-future-21%26creative%3D22374%26creativeASIN%3DB07DRGH6KN%26linkCode%3Ddf0%26ascsubtag%3Dcyclingweekly-gb-6013750091652864000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07DRGH6KN%2Fref%3Dasc_df_B07DRGH6KN1681673160000%2F%3Ftag%3Dhawk-future-21%26creative%3D22374%26creativeASIN%3DB07DRGH6KN%26linkCode%3Ddf0%26ascsubtag%3Dcyclingweekly-gb-6013750091652864000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07DRGH6KN%2Fref%3Dasc_df_B07DRGH6KN1681673160000%2F%3Ftag%3Dhawk-future-21%26creative%3D22374%26creativeASIN%3DB07DRGH6KN%26linkCode%3Ddf0%26ascsubtag%3Dcyclingweekly-gb-6013750091652864000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://www.cyclingweekly.com/deals/compare?origin=news&model_name=Pirelli%20Cinturato%20Velo%20TLR%20Tyre&article_id=19050", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-3940457740718006000&p=25010860215&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-3940457740718006000&p=25010860215&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-3940457740718006000&p=25010860215&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-3940457740718006000&p=25010860215&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-3940457740718006000&p=25010860215&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-3940457740718006000&p=25010860215&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.cyclingweekly.com/deals/compare?origin=news&model_name=Michelin%20Pro4%20ENDURANCE%20V2%20road%20bike%20tyres&article_id=19050", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.cyclingweekly.com/reviews/socks/sealskinz-waterproof-all-weather-ankle-length-sock-with-hydrostop", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07R8WSN2S%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-2324799222025969000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07R8WSN2S%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-2324799222025969000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07R8WSN2S%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-2324799222025969000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07R8WSN2S%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-2324799222025969000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://www.cyclingweekly.com/group-tests/cycling-lights-buyers-guide-141811", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07W7S2RR4%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-1179685437505824300-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07W7S2RR4%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-1179685437505824300-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07W7S2RR4%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-1179685437505824300-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07W7S2RR4%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-1179685437505824300-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07W7S2RR4%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-1179685437505824300-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://www.cyclingweekly.com/deals/compare?origin=news&model_name=Lezyne%20Micro%20Drive%20600XL%20and%20KTV%20Pro%20lightset&article_id=19050", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-6825863950815744000&p=25010790347&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-6825863950815744000&p=25010790347&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-6825863950815744000&p=25010790347&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-6825863950815744000&p=25010790347&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-6825863950815744000&p=25010790347&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.cyclingweekly.com/deals/compare?origin=news&model_name=Exposure%20Trace%20and%20TraceR%20Lightset&article_id=19050", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.cyclingweekly.com/group-tests/smart-turbo-trainers-buyers-guide-326710", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.cyclingweekly.com/fitness/indoor-cycling-apps-364282", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.cyclingweekly.com/news/product-news/zwift-turbo-trainer-game-171798", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.cyclingweekly.com/fitness/training/eight-hiit-workouts-for-faster-rides-476818", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.cyclingweekly.com/fitness/training/100-mile-sportive-170890", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.cyclingweekly.com/fitness/training/bike-handling-techniques-improve-cornering-148960", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.cyclingweekly.com/author/simon-richardson", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.strava.com/dashboard", "domain": "strava.com", "is_internal": false}, {"link": "mailto:simon.richardson@futurenet.com", "domain": "futurenet.com", "is_internal": false}, {"link": "https://www.magazinesdirect.com/az-magazines/34206751/cycling-weekly-subscription.thtml", "domain": "magazinesdirect.com", "is_internal": false}, {"link": "", "domain": "", "is_internal": false}, {"link": "https://www.cyclingweekly.com/racing/lizzie-deignan-a-possibility-for-trek-segafredo-at-fleche-wallonne-and-liegebastogneliege", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.cyclingweekly.com/racing/i-have-a-lot-of-confidence-in-tao-ineos-ds-backs-geoghegan-hart-for-tour-of-the-alps-success", "domain": "cyclingweekly.com", "is_internal": true}], "external": 79, "internal": 45}, "blog_title": "11 tips for cycling in the rain: essentials for riding out the wet weather", "word_count": 2269, "links_count": 126, "images_count": 41, "headings_count": 13, "paragraphs_count": 51, "word_count_without_headings": 2180}, "block_position": 2, "meta_description": {"date": "Oct 24, 2022", "html": "<span>11 top <em>tips</em> for <em>cycling in the rain</em> · 1. Invest in a good waterproof jacket · 2. Keep splash off with mudguards or fenders · 3. Wear overshoes and ...</span>", "text": "11 top tips for cycling in the rain · 1. Invest in a good waterproof jacket · 2. Keep splash off with mudguards or fenders · 3. Wear overshoes and ...", "highlighted_words": ["tips", "cycling in the rain"]}, "about_this_result": null}, {"link": "https://road.cc/content/feature/9-top-survival-tips-cycling-rain-170309", "title": "9 top survival tips for cycling in the rain", "domain": "road.cc", "position": 3, "serp_header": {"title": "9 top survival tips for cycling in the rain", "displayed_link": "https://road.cc › content › feature › 9-top-survival-tips...", "displayed_name": "Road.cc"}, "post_content": {"toc": [], "link": {"count": 11, "details": [{"link": "#", "domain": "road.cc", "is_internal": true}, {"link": "#", "domain": "road.cc", "is_internal": true}, {"link": "#", "domain": "road.cc", "is_internal": true}, {"link": "#", "domain": "road.cc", "is_internal": true}, {"link": "http://fantasy.road.cc", "domain": "fantasy.road.cc", "is_internal": false}, {"link": "https://bikelive.road.cc", "domain": "bikelive.road.cc", "is_internal": false}, {"link": "https://shop.road.cc/", "domain": "shop.road.cc", "is_internal": false}, {"link": "https://tours.road.cc", "domain": "tours.road.cc", "is_internal": false}, {"link": "#", "domain": "road.cc", "is_internal": true}, {"link": "/user/login?destination=node/170309", "domain": "user", "is_internal": true}, {"link": "/user/register", "domain": "user", "is_internal": true}], "external": 6, "internal": 5}, "blog_title": "9 top survival tips for cycling in the rain", "word_count": 104, "links_count": 11, "images_count": 0, "headings_count": 1, "paragraphs_count": 0, "word_count_without_headings": 14}, "block_position": 3, "meta_description": {"date": "Jul 11, 2020", "html": "<span>9 top survival <em>tips</em> for <em>cycling in the rain</em> · 1. Waterproof jacket and tights · 3. Waterproof gloves · 4. Keep your head dry · 5. Mudguards · 6.</span>", "text": "9 top survival tips for cycling in the rain · 1. Waterproof jacket and tights · 3. Waterproof gloves · 4. Keep your head dry · 5. Mudguards · 6.", "highlighted_words": ["tips", "cycling in the rain"]}, "about_this_result": null}, {"link": "https://www.rei.com/learn/expert-advice/biking-in-the-rain.html", "title": "How to Bike in the Rain Successfully | REI Co-op", "domain": "rei.com", "position": 4, "serp_header": {"title": "How to Bike in the Rain Successfully | REI Co-op", "displayed_link": "https://www.rei.com › Expert Advice › Cycling", "displayed_name": "REI"}, "post_content": {"toc": [{"id": null, "name": "Tips for Biking in the Rain", "level": "h1"}, {"id": null, "name": "Dress for Warmth and Breathability", "level": "h2"}, {"id": null, "name": "Pack Dry Clothes for Your Destination", "level": "h2"}, {"id": null, "name": "Get Your Bike Ready for Rain", "level": "h2"}, {"id": null, "name": "Route and Riding Tactics", "level": "h2"}, {"id": null, "name": "Stay Motivated", "level": "h2"}, {"id": "related-links-heading", "name": "Shop products from this article on REI.com", "level": "h2"}, {"id": "article-authors", "name": "Authors", "level": "h2"}, {"id": null, "name": "Lily Krass", "level": "h3"}, {"id": "article-experts", "name": "Contributing Experts", "level": "h2"}, {"id": null, "name": "Reginald \\"Doc\\" Wilson", "level": "h3"}, {"id": null, "name": "Martha Brown", "level": "h3"}], "link": {"count": 27, "details": [{"link": "/learn/expert-advice", "domain": "learn", "is_internal": true}, {"link": "/learn/c/cycling", "domain": "learn", "is_internal": true}, {"link": "https://www.facebook.com/sharer/sharer.php?u=https://www.rei.com/learn/expert-advice/biking-in-the-rain.htmlcm_mmc=sm_fb-_-share&picture=https://www.rei.com/assets/img/seo/evergreen/rei-og.jpg&name=Tips for Biking in the Rain", "domain": "facebook.com", "is_internal": false}, {"link": "https://twitter.com/intent/tweet?text=Tips for Biking in the Rain&url=https://www.rei.com/learn/expert-advice/biking-in-the-rain.html?cm_mmc=sm_tw-_-share&related=rei", "domain": "twitter.com", "is_internal": false}, {"link": "https://pinterest.com/pin/create/button/?url=https://www.rei.com/learn/expert-advice/biking-in-the-rain.html?cm_mmc=sm_pin-_-share&media=https://www.rei.com/assets/img/seo/evergreen/rei-og.jpg&description=Tips for Biking in the Rain", "domain": "pinterest.com", "is_internal": false}, {"link": "/blog/cycle/peace-peloton-uplifting-black-businesses", "domain": "blog", "is_internal": true}, {"link": "/adventures", "domain": "adventures", "is_internal": true}, {"link": "/learn/expert-advice/winter-bicycling.html", "domain": "learn", "is_internal": true}, {"link": "/c/cycling-jackets", "domain": "c", "is_internal": true}, {"link": "/c/cycling-tights", "domain": "c", "is_internal": true}, {"link": "/c/cycling-pants", "domain": "c", "is_internal": true}, {"link": "/learn/expert-advice/best-cycling-jackets.html", "domain": "learn", "is_internal": true}, {"link": "/c/cycling-headwear", "domain": "c", "is_internal": true}, {"link": "/c/cycling-gloves", "domain": "c", "is_internal": true}, {"link": "/c/cycling-shoes", "domain": "c", "is_internal": true}, {"link": "/c/cycling-shoe-covers", "domain": "c", "is_internal": true}, {"link": "/c/bike-fenders", "domain": "c", "is_internal": true}, {"link": "/c/bike-lubricants", "domain": "c", "is_internal": true}, {"link": "/c/bike-tires", "domain": "c", "is_internal": true}, {"link": "/c/bike-lights", "domain": "c", "is_internal": true}, {"link": "https://www.rei.com/b/maxxis/f/pl-rekon", "domain": "rei.com", "is_internal": true}, {"link": "https://www.rei.com/c/rear-bike-lights", "domain": "rei.com", "is_internal": true}, {"link": "https://www.rei.com/c/rain-jackets/f/fet-dryvent", "domain": "rei.com", "is_internal": true}, {"link": "https://www.rei.com/c/bike-lights", "domain": "rei.com", "is_internal": true}, {"link": "https://www.rei.com/c/kids-rain-jackets", "domain": "rei.com", "is_internal": true}, {"link": "https://www.rei.com/c/rain-jackets/f/scd-deals", "domain": "rei.com", "is_internal": true}, {"link": "#container", "domain": "rei.com", "is_internal": true}], "external": 20, "internal": 7}, "blog_title": "Tips for Biking in the Rain", "word_count": 1592, "links_count": 27, "images_count": 6, "headings_count": 13, "paragraphs_count": 35, "word_count_without_headings": 1529}, "block_position": 4, "meta_description": {"date": "Jun 30, 2022", "html": "<span>Always ride with a front and rear light, and make sure your bags don't block them, says Brown. She also tells <em>cyclists</em> to choose reflective ...</span>", "text": "Always ride with a front and rear light, and make sure your bags don't block them, says Brown. She also tells cyclists to choose reflective ...", "highlighted_words": ["cyclists"]}, "about_this_result": null}, {"link": "https://wheretheroadforks.com/25-tips-for-cycling-in-the-rain/", "title": "25 Tips for Cycling in the Rain", "domain": "wheretheroadforks.com", "position": 5, "serp_header": {"title": "25 Tips for Cycling in the Rain", "displayed_link": "https://wheretheroadforks.com › Bikes and Cycling", "displayed_name": "Where The Road Forks"}, "post_content": null, "block_position": 5, "meta_description": {"date": "Mar 13, 2022", "html": "<span>Before you ride in the <em>rain</em>, apply a dry lube to your chain. Dry lube goes on <em>wet</em> then quickly dries into a wax-like film that doesn't wash away ...</span>", "text": "Before you ride in the rain, apply a dry lube to your chain. Dry lube goes on wet then quickly dries into a wax-like film that doesn't wash away ...", "highlighted_words": ["rain", "wet"]}, "about_this_result": null}, {"link": "https://www.roadbikerider.com/top-tips-for-before-during-and-after-rainy-rides-d3/", "title": "Top Tips for Road Cycling in the Rain", "domain": "roadbikerider.com", "position": 6, "serp_header": {"title": "Top Tips for Road Cycling in the Rain", "displayed_link": "https://www.roadbikerider.com › blog", "displayed_name": "Road Bike Rider"}, "post_content": {"toc": [{"id": null, "name": "", "level": "h3"}, {"id": null, "name": "Tips for before rainy rides", "level": "h3"}, {"id": null, "name": "Tips for during rainy rides", "level": "h3"}, {"id": null, "name": "Tips for after rainy rides", "level": "h3"}], "link": {"count": 1, "details": [{"link": "https://www.roadbikerider.com/jim-langley/", "domain": "roadbikerider.com", "is_internal": true}], "external": 0, "internal": 1}, "blog_title": "Top Tips for Road Cycling in the Rain", "word_count": 1352, "links_count": 1, "images_count": 4, "headings_count": 5, "paragraphs_count": 22, "word_count_without_headings": 1282}, "block_position": 6, "meta_description": {"date": null, "html": null, "text": null, "highlighted_words": null}, "about_this_result": null}, {"link": "https://www.active.com/cycling/articles/10-tips-for-riding-in-the-rain", "serp": {"footer": "<div class=\\"Z26q7c UK95Uc\\" data-sncf=\\"2\\" data-snf=\\"xz63Wb\\"><div class=\\"P1usbc\\" data-ved=\\"2ahUKEwi-_PS7lbX-AhXNVKQEHa1iCHIQpwZ6BAgpEAA\\"><div class=\\"VNLkW\\"><div class=\\"i4vd5e\\"><div class=\\"wrBvFf OSrXXb\\"><span>Tue, Apr 18</span></div></div><div class=\\"G1Rrjc\\" data-ved=\\"2ahUKEwi-_PS7lbX-AhXNVKQEHa1iCHIQrwYoAHoECCkQAQ\\"><div class=\\"wrBvFf OSrXXb\\"><a class=\\"fl\\" href=\\"https://www.active.com/york-unitedkingdom/cycling/camps/10-00am-11-00am-2023-90189366?int=19N-DP120-BND10-SD100-DM10-eventsnearyouwidget-pos4\\" jsaction=\\"rcuQ6b:npT2md\\" jscontroller=\\"M9mgyc\\" jsname=\\"qOiK6e\\" ping=\\"/url?sa=t&amp;source=web&amp;rct=j&amp;url=https://www.active.com/york-unitedkingdom/cycling/camps/10-00am-11-00am-2023-90189366%3Fint%3D19N-DP120-BND10-SD100-DM10-eventsnearyouwidget-pos4&amp;ved=2ahUKEwi-_PS7lbX-AhXNVKQEHa1iCHIQ4wYoAHoECCkQAg\\"><span>10:00am - 11:00am</span></a></div></div></div></div></div>"}, "title": "10 Tips for Riding in the Rain", "domain": "active.com", "position": 7, "serp_header": {"title": "10 Tips for Riding in the Rain", "displayed_link": "https://www.active.com › Cycling › Articles", "displayed_name": "ACTIVE"}, "post_content": {"toc": [], "link": {"count": 1, "details": [{"link": "javascript:void(0);", "domain": "javascript", "is_internal": false}], "external": 1, "internal": 0}, "blog_title": "10 Tips for Riding in the Rain", "word_count": 278, "links_count": 1, "images_count": 1, "headings_count": 1, "paragraphs_count": 1, "word_count_without_headings": 20}, "block_position": 7, "meta_description": {"date": "Jan 11, 2023", "html": "<span>Jan 11, 2023</span>", "text": "Jan 11, 2023", "highlighted_words": null}, "about_this_result": null}, {"link": "https://bicyclingaustralia.com.au/news/wet-weather-top-tips-for-riding-in-the-rain/", "title": "Rain, Rain, Go Away: Tips For Wet Weather Riding & ...", "domain": "bicyclingaustralia.com.au", "position": 8, "serp_header": {"title": "Rain, Rain, Go Away: Tips For Wet Weather Riding & ...", "displayed_link": "https://bicyclingaustralia.com.au › news › wet-weather...", "displayed_name": "Bicycling Australia"}, "post_content": {"toc": [], "link": {"count": 0, "details": [], "external": 0, "internal": 0}, "blog_title": "Rain, Rain, Go Away: Tips For Wet Weather Riding & Staying Bike Fit", "word_count": 1152, "links_count": 0, "images_count": 4, "headings_count": 1, "paragraphs_count": 20, "word_count_without_headings": 885}, "block_position": 8, "meta_description": {"date": null, "html": "<span>Front and rear lights are highly recommended while <em>cycling in the rain</em>. Keep them on, keep them flashing, and do your best to be seen. Planning to ride the next ...</span>", "text": "Front and rear lights are highly recommended while cycling in the rain. Keep them on, keep them flashing, and do your best to be seen. Planning to ride the next ...", "highlighted_words": ["cycling in the rain"]}, "about_this_result": null}]	"[{\\"question\\": \\"Is it okay to road bike in the rain?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How do you cycle on a rainy day?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How do you ride a bike in the rain without getting wet?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How do I keep my feet dry cycling in the rain?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"cycling in rain benefits\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 12}, {\\"question\\": \\"how to bike in the rain without getting wet\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 12}, {\\"question\\": \\"cycling in rain reddit\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 12}, {\\"question\\": \\"cycling in the rain commuting\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 12}, {\\"question\\": \\"how to cycle in the rain with glasses\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 12}, {\\"question\\": \\"is it bad for your bike to ride in the rain\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 12}, {\\"question\\": \\"cycling in the rain clothing\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 12}, {\\"question\\": \\"Can you ride a road bike in rain?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Is it safe to road bike on wet roads?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Is it bad if my bicycle gets rained on?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How long can a bike sit in the rain?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How do you cycle safely in the rain?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How do people bike in the rain?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What do cyclists do when it rains?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 3}, {\\"question\\": \\"How do you stay dry when cycling in the rain?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What do you wear when riding a bike in the rain?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 2}, {\\"question\\": \\"Is it OK to ride a bike in the rain?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 3}, {\\"question\\": \\"How do you keep your bike in wet weather?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How do I keep my feet dry when cycling in the rain?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How do you not get wet when cycling?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Is it OK to ride bike in rain?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 2}, {\\"question\\": \\"How do I keep my feet warm and dry cycling?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Is it healthy to cycle in the rain?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How much slower is cycling in the rain?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 2}, {\\"question\\": \\"Do you cycle faster in the rain?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How do I keep my legs dry when cycling in the rain?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Is it OK to bike in the rain Reddit?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Should you bike commute in rain?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How do you commute with a bike in the rain?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How do you stay dry on a bike commute?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Can you wear glasses while cycling in the rain?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How do you keep rain out of your eyes when cycling?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How do you deal with rain when wearing glasses?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Can I wear my glasses for cycling?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Is it OK for my bike to get rained on?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How do I prepare my bike for rain?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Does riding in the rain damage your motorcycle?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What do you wear riding a bike in the rain?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Do you need a rain jacket for cycling?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What do you wear on your legs when cycling in the rain?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What pants to wear biking in rain?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}]"	2023-04-19 05:03:22.364491+00	589301a6-98d9-445b-b3c5-977708ad6112
84ea610e-1017-4a04-993f-16b466570413	[{"link": "https://www.cyclingweekly.com/news/latest-news/cycling-in-the-rain-how-to-survive-it-19050", "title": "11 tips for cycling in the rain: essentials for riding out the wet ...", "domain": "cyclingweekly.com", "position": 1, "serp_header": {"title": "11 tips for cycling in the rain: essentials for riding out the wet ...", "displayed_link": "https://www.cyclingweekly.com › Fitness", "displayed_name": "Cycling Weekly"}, "post_content": {"toc": [{"id": "11-top-tips-for-cycling-in-the-rain-3", "name": "11 top tips for cycling in the rain", "level": "h2"}, {"id": "section-1-invest-in-a-good-waterproof-jacket", "name": "1. Invest in a good waterproof jacket", "level": "h3"}, {"id": "section-2-keep-splash-off-with-mudguards-or-fenders", "name": "2. Keep splash off with mudguards or fenders", "level": "h3"}, {"id": "section-3-wear-overshoes-and-gloves", "name": "3. Wear overshoes and gloves", "level": "h3"}, {"id": "section-4-use-chain-degreaser", "name": "4. Use chain degreaser", "level": "h3"}, {"id": "section-5-wear-a-cycling-cap", "name": "5. Wear a cycling cap", "level": "h3"}, {"id": "section-6-avoid-standing-water", "name": "6. Avoid standing water", "level": "h3"}, {"id": "section-7-check-your-tires-and-reduce-the-pressure", "name": "7. Check your tires and reduce the pressure", "level": "h3"}, {"id": "section-8-utilise-plastic-bags", "name": "8. Utilise plastic bags", "level": "h3"}, {"id": "section-9-use-lights", "name": "9. Use lights", "level": "h3"}, {"id": "section-10-just-get-on-the-turbo", "name": "10. Just get on the turbo", "level": "h3"}, {"id": "section-11-don-t-always-hide-from-the-rain", "name": "11. Don’t always hide from the rain", "level": "h3"}], "link": {"count": 126, "details": [{"link": "#section-1-invest-in-a-good-waterproof-jacket", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "#section-2-keep-splash-off-with-mudguards-or-fenders", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "#section-3-wear-overshoes-and-gloves", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "#section-4-use-chain-degreaser", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "#section-5-wear-a-cycling-cap", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "#section-6-avoid-standing-water", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "#section-7-check-your-tires-and-reduce-the-pressure", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "#section-8-utilise-plastic-bags", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "#section-9-use-lights", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "#section-10-just-get-on-the-turbo", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "#section-11-don-t-always-hide-from-the-rain", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.cyclingweekly.com/author/simon-richardson", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.cyclingweekly.com/group-tests/cycling-jackets-wet-weather-139198", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-1309738126463922000&p=31131939667&a=103504&m=15692", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-1309738126463922000&p=31131939667&a=103504&m=15692", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-1309738126463922000&p=31131939667&a=103504&m=15692", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-1309738126463922000&p=31131939667&a=103504&m=15692", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-1309738126463922000&p=31131939667&a=103504&m=15692", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.cyclingweekly.com/deals/compare?origin=news&model_name=Le%20Col%20Pro%20Rain%20Jacket&article_id=19050", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-5114496802021798000&p=32923822801&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-5114496802021798000&p=32923822801&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-5114496802021798000&p=32923822801&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-5114496802021798000&p=32923822801&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-5114496802021798000&p=32923822801&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-5114496802021798000&p=32923822801&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.cyclingweekly.com/deals/compare?origin=news&model_name=dhb%20Lab%20Aeron%20Ultralight%20Waterproof%20Jacket&article_id=19050", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.cyclingweekly.com/group-tests/best-bike-mudguards-4765", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB01N7SZCLG%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-1269558742124821000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB01N7SZCLG%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-1269558742124821000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB01N7SZCLG%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-1269558742124821000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB01N7SZCLG%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-1269558742124821000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB01N7SZCLG%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-1269558742124821000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB01N7SZCLG%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-1269558742124821000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://www.cyclingweekly.com/deals/compare?origin=news&model_name=SKS%20Bluemels%20Stingray%20mudguards&article_id=19050", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-1167941367765871000&p=25010790887&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-1167941367765871000&p=25010790887&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-1167941367765871000&p=25010790887&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-1167941367765871000&p=25010790887&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-1167941367765871000&p=25010790887&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.cyclingweekly.com/deals/compare?origin=news&model_name=Crud%20Roadracer%20Mk3%20mudguards&article_id=19050", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.cyclingweekly.com/group-tests/the-best-cycling-overshoes-150945", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.cyclingweekly.com/group-tests/winter-cycling-gloves-grouptest-21239", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB079SFTX95%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-6494163866014289000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB079SFTX95%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-6494163866014289000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB079SFTX95%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-6494163866014289000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB079SFTX95%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-6494163866014289000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB079SFTX95%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-6494163866014289000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB079SFTX95%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-6494163866014289000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://www.cyclingweekly.com/deals/compare?origin=news&model_name=GripGrab%20Ride%20Waterproof%20Shoe%20Cover&article_id=19050", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-9049356113173970000&p=27448786713&a=103504&m=3462", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-9049356113173970000&p=27448786713&a=103504&m=3462", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-9049356113173970000&p=27448786713&a=103504&m=3462", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-9049356113173970000&p=27448786713&a=103504&m=3462", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-9049356113173970000&p=27448786713&a=103504&m=3462", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-9049356113173970000&p=27448786713&a=103504&m=3462", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.cyclingweekly.com/deals/compare?origin=news&model_name=Endura%20Freezing%20Point%20Overshoes&article_id=19050", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07WQYCS49%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-9415680570732995000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07WQYCS49%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-9415680570732995000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07WQYCS49%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-9415680570732995000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07WQYCS49%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-9415680570732995000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07WQYCS49%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-9415680570732995000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://www.cyclingweekly.com/deals/compare?origin=news&model_name=Castelli%20Perfetto%20RoS%20gloves&article_id=19050", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-7919062850919710000&p=31707540775&a=103504&m=6821", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-7919062850919710000&p=31707540775&a=103504&m=6821", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-7919062850919710000&p=31707540775&a=103504&m=6821", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-7919062850919710000&p=31707540775&a=103504&m=6821", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-7919062850919710000&p=31707540775&a=103504&m=6821", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-7919062850919710000&p=31707540775&a=103504&m=6821", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.cyclingweekly.com/deals/compare?origin=news&model_name=Altura%20Firestorm%20Reflective%20Gloves&article_id=19050", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.cyclingweekly.com/video/how-to-clean-your-bike-221294", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.cyclingweekly.com/group-tests/cycling-caps-346553", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07R8WQPFY%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-8443514723119062000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07R8WQPFY%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-8443514723119062000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07R8WQPFY%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-8443514723119062000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07R8WQPFY%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-8443514723119062000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07R8WQPFY%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-8443514723119062000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://www.cyclingweekly.com/deals/compare?origin=news&model_name=Sealskinz%20Waterproof%20All%20Weather%20Cycle%20Cap&article_id=19050", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.cyclingweekly.com/news/product-news/fix-a-puncture-142674", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.cyclingweekly.com/news/best-winter-tyres-for-road-cycling-462830", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.cyclingweekly.com/news/product-news/whats-the-correct-road-bike-tyre-pressure-270668", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07DRGH6KN%2Fref%3Dasc_df_B07DRGH6KN1681673160000%2F%3Ftag%3Dhawk-future-21%26creative%3D22374%26creativeASIN%3DB07DRGH6KN%26linkCode%3Ddf0%26ascsubtag%3Dcyclingweekly-gb-6013750091652864000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07DRGH6KN%2Fref%3Dasc_df_B07DRGH6KN1681673160000%2F%3Ftag%3Dhawk-future-21%26creative%3D22374%26creativeASIN%3DB07DRGH6KN%26linkCode%3Ddf0%26ascsubtag%3Dcyclingweekly-gb-6013750091652864000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07DRGH6KN%2Fref%3Dasc_df_B07DRGH6KN1681673160000%2F%3Ftag%3Dhawk-future-21%26creative%3D22374%26creativeASIN%3DB07DRGH6KN%26linkCode%3Ddf0%26ascsubtag%3Dcyclingweekly-gb-6013750091652864000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07DRGH6KN%2Fref%3Dasc_df_B07DRGH6KN1681673160000%2F%3Ftag%3Dhawk-future-21%26creative%3D22374%26creativeASIN%3DB07DRGH6KN%26linkCode%3Ddf0%26ascsubtag%3Dcyclingweekly-gb-6013750091652864000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07DRGH6KN%2Fref%3Dasc_df_B07DRGH6KN1681673160000%2F%3Ftag%3Dhawk-future-21%26creative%3D22374%26creativeASIN%3DB07DRGH6KN%26linkCode%3Ddf0%26ascsubtag%3Dcyclingweekly-gb-6013750091652864000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://www.cyclingweekly.com/deals/compare?origin=news&model_name=Pirelli%20Cinturato%20Velo%20TLR%20Tyre&article_id=19050", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-3940457740718006000&p=25010860215&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-3940457740718006000&p=25010860215&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-3940457740718006000&p=25010860215&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-3940457740718006000&p=25010860215&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-3940457740718006000&p=25010860215&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-3940457740718006000&p=25010860215&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.cyclingweekly.com/deals/compare?origin=news&model_name=Michelin%20Pro4%20ENDURANCE%20V2%20road%20bike%20tyres&article_id=19050", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.cyclingweekly.com/reviews/socks/sealskinz-waterproof-all-weather-ankle-length-sock-with-hydrostop", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07R8WSN2S%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-2324799222025969000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07R8WSN2S%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-2324799222025969000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07R8WSN2S%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-2324799222025969000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07R8WSN2S%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-2324799222025969000-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://www.cyclingweekly.com/group-tests/cycling-lights-buyers-guide-141811", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07W7S2RR4%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-1179685437505824300-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07W7S2RR4%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-1179685437505824300-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07W7S2RR4%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-1179685437505824300-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07W7S2RR4%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-1179685437505824300-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://target.georiot.com/Proxy.ashx?tsid=107654&GR_URL=https%3A%2F%2Fwww.amazon.co.uk%2Fdp%2FB07W7S2RR4%3Ftag%3Dhawk-future-21%26linkCode%3Dogi%26th%3D1%26psc%3D1%26ascsubtag%3Dcyclingweekly-gb-1179685437505824300-21", "domain": "target.georiot.com", "is_internal": false}, {"link": "https://www.cyclingweekly.com/deals/compare?origin=news&model_name=Lezyne%20Micro%20Drive%20600XL%20and%20KTV%20Pro%20lightset&article_id=19050", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-6825863950815744000&p=25010790347&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-6825863950815744000&p=25010790347&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-6825863950815744000&p=25010790347&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-6825863950815744000&p=25010790347&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.awin1.com/pclick.php?clickref=cyclingweekly-gb-6825863950815744000&p=25010790347&a=103504&m=2698", "domain": "awin1.com", "is_internal": false}, {"link": "https://www.cyclingweekly.com/deals/compare?origin=news&model_name=Exposure%20Trace%20and%20TraceR%20Lightset&article_id=19050", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.cyclingweekly.com/group-tests/smart-turbo-trainers-buyers-guide-326710", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.cyclingweekly.com/fitness/indoor-cycling-apps-364282", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.cyclingweekly.com/news/product-news/zwift-turbo-trainer-game-171798", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.cyclingweekly.com/fitness/training/eight-hiit-workouts-for-faster-rides-476818", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.cyclingweekly.com/fitness/training/100-mile-sportive-170890", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.cyclingweekly.com/fitness/training/bike-handling-techniques-improve-cornering-148960", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.cyclingweekly.com/author/simon-richardson", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.strava.com/dashboard", "domain": "strava.com", "is_internal": false}, {"link": "mailto:simon.richardson@futurenet.com", "domain": "futurenet.com", "is_internal": false}, {"link": "https://www.magazinesdirect.com/az-magazines/34206751/cycling-weekly-subscription.thtml", "domain": "magazinesdirect.com", "is_internal": false}, {"link": "", "domain": "", "is_internal": false}, {"link": "https://www.cyclingweekly.com/racing/lizzie-deignan-a-possibility-for-trek-segafredo-at-fleche-wallonne-and-liegebastogneliege", "domain": "cyclingweekly.com", "is_internal": true}, {"link": "https://www.cyclingweekly.com/racing/i-have-a-lot-of-confidence-in-tao-ineos-ds-backs-geoghegan-hart-for-tour-of-the-alps-success", "domain": "cyclingweekly.com", "is_internal": true}], "external": 79, "internal": 45}, "blog_title": "11 tips for cycling in the rain: essentials for riding out the wet weather", "word_count": 2269, "links_count": 126, "images_count": 41, "headings_count": 13, "paragraphs_count": 51, "word_count_without_headings": 2180}, "block_position": 1, "about_this_result": null}, {"link": "https://hincapie.com/ride-with-us/stories-from-the-saddle/20-tips-cycling-rain/", "serp": {"footer": "<div class=\\"Z26q7c UK95Uc\\" data-sncf=\\"2\\" data-snf=\\"gdePb\\"><div class=\\"HiHjCd\\">‎<a href=\\"https://hincapie.com/ride-with-us/stories-from-the-saddle/20-tips-cycling-rain/#:~:text=1.%20Wear%20a%20waterproof%20jacket%20to%20keep%20you%20warm%20and%20dry.\\" ping=\\"/url?sa=t&amp;source=web&amp;rct=j&amp;url=https://hincapie.com/ride-with-us/stories-from-the-saddle/20-tips-cycling-rain/%23:~:text%3D1.%2520Wear%2520a%2520waterproof%2520jacket%2520to%2520keep%2520you%2520warm%2520and%2520dry.&amp;ved=2ahUKEwi16p_X_7b-AhWPVKQEHXNvCgsQp5kIKAB6BAgTEAE\\">1. Wear A Waterproof Jacket...</a> · ‎<a href=\\"https://hincapie.com/ride-with-us/stories-from-the-saddle/20-tips-cycling-rain/#:~:text=2.%20Wear%20a%20merino%20wool%20base%20layer%20for%20extra%20warmth.\\" ping=\\"/url?sa=t&amp;source=web&amp;rct=j&amp;url=https://hincapie.com/ride-with-us/stories-from-the-saddle/20-tips-cycling-rain/%23:~:text%3D2.%2520Wear%2520a%2520merino%2520wool%2520base%2520layer%2520for%2520extra%2520warmth.&amp;ved=2ahUKEwi16p_X_7b-AhWPVKQEHXNvCgsQp5kIKAF6BAgTEAI\\">2. Wear A Merino Wool Base...</a> · ‎<a href=\\"https://hincapie.com/ride-with-us/stories-from-the-saddle/20-tips-cycling-rain/#:~:text=3.%20Wear%20a%20brimmed%20cap%20to%20keep%20the%20rain%20out%20of%20your%20eyes.\\" ping=\\"/url?sa=t&amp;source=web&amp;rct=j&amp;url=https://hincapie.com/ride-with-us/stories-from-the-saddle/20-tips-cycling-rain/%23:~:text%3D3.%2520Wear%2520a%2520brimmed%2520cap%2520to%2520keep%2520the%2520rain%2520out%2520of%2520your%2520eyes.&amp;ved=2ahUKEwi16p_X_7b-AhWPVKQEHXNvCgsQp5kIKAJ6BAgTEAM\\">3. Wear A Brimmed Cap To...</a></div></div>"}, "title": "20 Tips for Cycling in the Rain", "domain": "hincapie.com", "position": 2, "serp_header": {"title": "20 Tips for Cycling in the Rain", "displayed_link": "https://hincapie.com › Stories from the Saddle", "displayed_name": "Hincapie Sportswear"}, "post_content": null, "block_position": 2, "meta_description": {"date": "Apr 1, 2022", "html": "<span>20 <em>tips for cycling in the rain</em> · 1. Wear a waterproof jacket to keep you warm and dry. · 2. Wear a merino wool base layer for extra warmth. · 3.</span>", "text": "20 tips for cycling in the rain · 1. Wear a waterproof jacket to keep you warm and dry. · 2. Wear a merino wool base layer for extra warmth. · 3.", "highlighted_words": ["tips for cycling in the rain"]}, "about_this_result": null}, {"link": "https://www.rei.com/learn/expert-advice/biking-in-the-rain.html", "serp": {"footer": "<div class=\\"Z26q7c UK95Uc\\" data-sncf=\\"2\\" data-snf=\\"gdePb\\"><div class=\\"HiHjCd\\">‎<a href=\\"https://www.rei.com/learn/expert-advice/biking-in-the-rain.html#:~:text=Dress%20for%20Warmth%20and%20Breathability\\" ping=\\"/url?sa=t&amp;source=web&amp;rct=j&amp;url=https://www.rei.com/learn/expert-advice/biking-in-the-rain.html%23:~:text%3DDress%2520for%2520Warmth%2520and%2520Breathability&amp;ved=2ahUKEwi16p_X_7b-AhWPVKQEHXNvCgsQp5kIKAB6BAg0EAE\\">Dress For Warmth And...</a> · ‎<a href=\\"https://www.rei.com/learn/expert-advice/biking-in-the-rain.html#:~:text=Get%20Your%20Bike%20Ready%20for%20Rain\\" ping=\\"/url?sa=t&amp;source=web&amp;rct=j&amp;url=https://www.rei.com/learn/expert-advice/biking-in-the-rain.html%23:~:text%3DGet%2520Your%2520Bike%2520Ready%2520for%2520Rain&amp;ved=2ahUKEwi16p_X_7b-AhWPVKQEHXNvCgsQp5kIKAF6BAg0EAI\\">Get Your Bike Ready For Rain</a> · ‎<a href=\\"https://www.rei.com/learn/expert-advice/biking-in-the-rain.html#:~:text=Route%20and%20Riding%20Tactics\\" ping=\\"/url?sa=t&amp;source=web&amp;rct=j&amp;url=https://www.rei.com/learn/expert-advice/biking-in-the-rain.html%23:~:text%3DRoute%2520and%2520Riding%2520Tactics&amp;ved=2ahUKEwi16p_X_7b-AhWPVKQEHXNvCgsQp5kIKAJ6BAg0EAM\\">Route And Riding Tactics</a></div></div>"}, "title": "How to Bike in the Rain Successfully | REI Co-op", "domain": "rei.com", "position": 3, "serp_header": {"title": "How to Bike in the Rain Successfully | REI Co-op", "displayed_link": "https://www.rei.com › Expert Advice › Cycling", "displayed_name": "REI"}, "post_content": null, "block_position": 3, "meta_description": {"date": "Jun 30, 2022", "html": "<span>Always ride with a front and rear light, and make sure your bags don't block them, says Brown. She also tells <em>cyclists</em> to choose reflective ...</span>", "text": "Always ride with a front and rear light, and make sure your bags don't block them, says Brown. She also tells cyclists to choose reflective ...", "highlighted_words": ["cyclists"]}, "about_this_result": null}, {"link": "https://road.cc/content/feature/9-top-survival-tips-cycling-rain-170309", "title": "9 top survival tips for cycling in the rain", "domain": "road.cc", "position": 4, "serp_header": {"title": "9 top survival tips for cycling in the rain", "displayed_link": "https://road.cc › content › feature › 9-top-survival-tips...", "displayed_name": "Road.cc"}, "post_content": null, "block_position": 4, "meta_description": {"date": "Jul 11, 2020", "html": "<span>9 top survival <em>tips for cycling in the rain</em> · 1. Waterproof jacket and tights · 3. Waterproof gloves · 4. Keep your head dry · 5. Mudguards · 6.</span>", "text": "9 top survival tips for cycling in the rain · 1. Waterproof jacket and tights · 3. Waterproof gloves · 4. Keep your head dry · 5. Mudguards · 6.", "highlighted_words": ["tips for cycling in the rain"]}, "about_this_result": null}, {"link": "https://wheretheroadforks.com/25-tips-for-cycling-in-the-rain/", "title": "25 Tips for Cycling in the Rain", "domain": "wheretheroadforks.com", "position": 5, "serp_header": {"title": "25 Tips for Cycling in the Rain", "displayed_link": "https://wheretheroadforks.com › Bikes and Cycling", "displayed_name": "Where The Road Forks"}, "post_content": null, "block_position": 5, "meta_description": {"date": "Mar 13, 2022", "html": "<span>Wear a <em>Rain</em> Jacket. Your most important piece of clothing for <em>cycling in the rain</em> is your <em>rain</em> jacket. It keeps you warm by keeping your torso ...</span>", "text": "Wear a Rain Jacket. Your most important piece of clothing for cycling in the rain is your rain jacket. It keeps you warm by keeping your torso ...", "highlighted_words": ["Rain", "cycling in the rain", "rain"]}, "about_this_result": null}, {"link": "https://www.roadbikerider.com/top-tips-for-before-during-and-after-rainy-rides-d3/", "title": "Top Tips for Road Cycling in the Rain", "domain": "roadbikerider.com", "position": 6, "serp_header": {"title": "Top Tips for Road Cycling in the Rain", "displayed_link": "https://www.roadbikerider.com › blog", "displayed_name": "Road Bike Rider"}, "post_content": null, "block_position": 6, "meta_description": {"date": null, "html": null, "text": null, "highlighted_words": null}, "about_this_result": null}, {"link": "https://momentummag.com/everything-you-need-to-know-about-cycling-in-the-rain-and-loving-it/", "title": "Everything you need to know about cycling in the rain and ...", "domain": "momentummag.com", "position": 7, "serp_header": {"title": "Everything you need to know about cycling in the rain and ...", "displayed_link": "https://momentummag.com › everything-you-need-to-...", "displayed_name": "Momentum Mag"}, "post_content": null, "block_position": 7, "meta_description": {"date": "Apr 6, 2023", "html": "<span>In addition to the torso, if <em>cycling</em> often in the <em>rain</em>, consider wearing a covering for your helmet, or even an all-weather cap or balaclava ...</span>", "text": "In addition to the torso, if cycling often in the rain, consider wearing a covering for your helmet, or even an all-weather cap or balaclava ...", "highlighted_words": ["cycling", "rain"]}, "about_this_result": null}, {"link": "https://www.cyclist.co.uk/in-depth/cyclist-guide-to-wet-weather-riding", "serp": {"footer": "<div class=\\"Z26q7c UK95Uc\\" data-sncf=\\"2\\" data-snf=\\"qNNggc\\"><div class=\\"IsZvec\\"><div class=\\"U2yc5 OjgaSe\\"><div class=\\"ic6VBe OSrXXb uYZpsf U09Jxd s8bAkb\\">1. Preparation is key</div><div class=\\"ic6VBe OSrXXb uYZpsf U09Jxd s8bAkb\\">2. Get a proper waterproof jacket</div><div class=\\"ic6VBe OSrXXb uYZpsf U09Jxd s8bAkb\\">3. Protect your head</div><div class=\\"ic6VBe OSrXXb uYZpsf U09Jxd vRhlo s8bAkb\\">5. Choose slick tyres for more grip</div><div class=\\"ic6VBe OSrXXb uYZpsf U09Jxd vRhlo s8bAkb\\">7. Watch out for punctures</div><div class=\\"ic6VBe OSrXXb uYZpsf U09Jxd vRhlo s8bAkb\\">8. Consider going tubeless</div><div class=\\"ic6VBe OSrXXb uYZpsf U09Jxd vRhlo s8bAkb\\">9. Use your brakes wisely</div></div></div></div>"}, "title": "How to ride in the rain: Wet weather cycling guide", "domain": "cyclist.co.uk", "position": 8, "serp_header": {"title": "How to ride in the rain: Wet weather cycling guide", "displayed_link": "https://www.cyclist.co.uk › in-depth › cyclist-guide-to-w...", "displayed_name": "Cyclist"}, "post_content": null, "block_position": 8, "meta_description": {"date": "Nov 12, 2021", "html": "<span>Nov 12, 2021</span>", "text": "Nov 12, 2021", "highlighted_words": null}, "about_this_result": null}, {"link": "https://bicyclingaustralia.com.au/news/wet-weather-top-tips-for-riding-in-the-rain/", "title": "Rain, Rain, Go Away: Tips For Wet Weather Riding & ...", "domain": "bicyclingaustralia.com.au", "position": 9, "serp_header": {"title": "Rain, Rain, Go Away: Tips For Wet Weather Riding & ...", "displayed_link": "https://bicyclingaustralia.com.au › news › wet-weather...", "displayed_name": "Bicycling Australia"}, "post_content": null, "block_position": 9, "meta_description": {"date": null, "html": "<span>Front and rear lights are highly recommended while <em>cycling in the rain</em>. Keep them on, keep them flashing, and do your best to be seen. Planning to ride the next ...</span>", "text": "Front and rear lights are highly recommended while cycling in the rain. Keep them on, keep them flashing, and do your best to be seen. Planning to ride the next ...", "highlighted_words": ["cycling in the rain"]}, "about_this_result": null}]	"[{\\"question\\": \\"Is it a good idea to cycle in the rain?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How do I keep my legs dry when cycling in the rain?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 2}, {\\"question\\": \\"cycling in rain benefits\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 11}, {\\"question\\": \\"cycling in the rain commuting\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 11}, {\\"question\\": \\"how to bike in the rain without getting wet\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 11}, {\\"question\\": \\"mountain biking in the rain\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 11}, {\\"question\\": \\"is it bad for your bike to ride in the rain\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 11}, {\\"question\\": \\"road cycling in the rain\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 11}, {\\"question\\": \\"how to cycle in the rain with glasses\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 11}, {\\"question\\": \\"cycling in rain reddit\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 11}, {\\"question\\": \\"Is it OK to ride bike in rain?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 3}, {\\"question\\": \\"What do cyclists do when it rains?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 4}, {\\"question\\": \\"How do you cycle safely in the rain?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How do you keep your legs dry in the rain?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How do you ride a bike in the rain without getting wet?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How do I stop sweating when cycling?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Is it healthy to cycle in the rain?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 2}, {\\"question\\": \\"How much slower is cycling in the rain?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 2}, {\\"question\\": \\"Do you cycle faster in the rain?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Should you bike commute in rain?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How do you commute with a bike in the rain?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Is it OK to ride a bike in the rain?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 2}, {\\"question\\": \\"How do you stay dry on a bike commute?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What do you wear when riding a bike in the rain?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Is it OK to mountain bike in the rain?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Is it OK to ride my bike in the rain?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Is it bad to mountain bike on wet trails?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How do I prepare my bike for rain?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Does riding in the rain damage your motorcycle?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Can I ride road bike in rain?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Can you wear glasses while cycling in the rain?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How do you keep rain out of your eyes when cycling?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How do you deal with rain when wearing glasses?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Can I wear my glasses for cycling?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Is it OK to bike in the rain Reddit?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}]"	2023-04-19 22:31:13.945684+00	8880102b-2871-43a1-9f4d-8381554f9c72
fadc470a-82ee-4385-9311-6d38669aba0a	[{"link": "https://cockatielenthusiast.com/cockatiel-wont-eating/", "title": "10 Possible Reasons Why Your Cockatiel Won't Eat", "domain": "cockatielenthusiast.com", "position": 1, "serp_header": {"title": "10 Possible Reasons Why Your Cockatiel Won't Eat", "displayed_link": "https://cockatielenthusiast.com › co...", "displayed_name": "Cockatiel Enthusiast"}, "post_content": {"toc": [{"id": "10-possible-reasons-why-your-cockatiel-wont-eat", "name": "10 Possible Reasons Why Your Cockatiel Won’t Eat", "level": "h2"}, {"id": "1-digestive-system-diseases", "name": "1. Digestive system diseases", "level": "h3"}, {"id": "2-respiratory-diseases", "name": "2. Respiratory diseases", "level": "h3"}, {"id": "3-injury", "name": "3. Injury", "level": "h3"}, {"id": "4-changes-in-food", "name": "4. Changes in food", "level": "h3"}, {"id": "5-bored-with-food", "name": "5. Bored with food", "level": "h3"}, {"id": "6-stress-from-a-new-environment", "name": "6. Stress from a new environment", "level": "h3"}, {"id": "7-safety", "name": "7. Safety", "level": "h3"}, {"id": "8-overfeeding", "name": "8. Overfeeding", "level": "h3"}, {"id": "9-picky-with-food", "name": "9. Picky with food", "level": "h3"}, {"id": "10-stubbornness", "name": "10. Stubbornness", "level": "h3"}, {"id": "what-to-do-if-your-cockatiel-isnt-eating", "name": "What To Do If Your Cockatiel Isn’t Eating?", "level": "h2"}, {"id": "1-clean-your-cockatiels-cage", "name": "1. Clean your cockatiel’s cage", "level": "h3"}, {"id": "2-provide-a-variety-of-foods", "name": "2. Provide a variety of foods", "level": "h3"}, {"id": "3-hand-feed-your-cockatiel", "name": "3. Hand feed your cockatiel", "level": "h3"}, {"id": "4-make-your-cockatiel-feel-safe", "name": "4. Make your cockatiel feel safe", "level": "h3"}], "link": {"count": 14, "details": [{"link": "https://cockatielenthusiast.com/why-does-my-cockatiel-have-diarrhea/", "domain": "cockatielenthusiast.com", "is_internal": true}, {"link": "https://cockatielenthusiast.com/why-is-my-cockatiel-breathing-fast/", "domain": "cockatielenthusiast.com", "is_internal": true}, {"link": "https://cockatielenthusiast.com/how-can-you-tell-if-a-cockatiels-wing-is-broken/", "domain": "cockatielenthusiast.com", "is_internal": true}, {"link": "https://cockatielenthusiast.com/cockatiels-picky-eaters/", "domain": "cockatielenthusiast.com", "is_internal": true}, {"link": "https://cockatielenthusiast.com/cockatiel-eat-too-much-millet/", "domain": "cockatielenthusiast.com", "is_internal": true}, {"link": "https://cockatielenthusiast.com/can-cockatiels-eat-strawberries/", "domain": "cockatielenthusiast.com", "is_internal": true}, {"link": "https://cockatielenthusiast.com/can-cockatiels-eat-cucumbers/", "domain": "cockatielenthusiast.com", "is_internal": true}, {"link": "https://cockatielenthusiast.com/can-cockatiels-eat-lettuce/", "domain": "cockatielenthusiast.com", "is_internal": true}, {"link": "https://cockatielenthusiast.com/is-mold-bad-for-cockatiels/", "domain": "cockatielenthusiast.com", "is_internal": true}, {"link": "https://cockatielenthusiast.com/what-can-cockatiels-eat-and-what-cannot/", "domain": "cockatielenthusiast.com", "is_internal": true}, {"link": "https://lafeber.com/pet-birds/avoid-feeding-mistakes/", "domain": "lafeber.com", "is_internal": false}, {"link": "#", "domain": "cockatielenthusiast.com", "is_internal": true}, {"link": "#", "domain": "cockatielenthusiast.com", "is_internal": true}, {"link": "#", "domain": "cockatielenthusiast.com", "is_internal": true}], "external": 1, "internal": 13}, "blog_title": "10 Possible Reasons Why Your Cockatiel Won’t Eat", "word_count": 2035, "links_count": 14, "images_count": 136, "headings_count": 17, "paragraphs_count": 59, "word_count_without_headings": 1950}, "block_position": 1, "meta_description": {"date": "25 août 2022", "html": "<span><em>Cockatiels won</em>'t eat for various reasons such as stress, upset stomach, overfeeding, or behavior issues. Additionally, sudden loss of ...</span>", "text": "Cockatiels won't eat for various reasons such as stress, upset stomach, overfeeding, or behavior issues. Additionally, sudden loss of ...", "highlighted_words": ["Cockatiels won"]}, "about_this_result": null}, {"link": "https://www.quora.com/I-ve-had-my-cockatiel-for-about-2-months-he-still-doesn-t-let-me-pet-him-or-hold-him-what-can-I-do-to-get-him-to-trust-me", "serp": {"footer": "<div class=\\"Z26q7c UK95Uc\\" data-sncf=\\"2\\" data-snf=\\"sYEzk\\"><div><div class=\\"YkS8D\\"><a class=\\"YjtGef\\" href=\\"https://www.quora.com/I-ve-had-my-cockatiel-for-about-2-months-he-still-doesn-t-let-me-pet-him-or-hold-him-what-can-I-do-to-get-him-to-trust-me?top_ans=226005178\\" ping=\\"/url?sa=t&amp;source=web&amp;rct=j&amp;url=https://www.quora.com/I-ve-had-my-cockatiel-for-about-2-months-he-still-doesn-t-let-me-pet-him-or-hold-him-what-can-I-do-to-get-him-to-trust-me%3Ftop_ans%3D226005178&amp;ved=2ahUKEwjO4JLY_bv-AhUJesAKHbi8B90Q4-4CegQIDhAB\\">4 réponses</a> <span class=\\"Bxc0O\\"> · </span> <span class=\\"N6jJud\\">Meilleure réponse: </span><span class=\\"EETcFd OSrXXb\\">I don’t usually speak negatively of others’ answers, but I totally disagree with Donya. ...</span></div></div></div>"}, "title": "I've had my cockatiel for about 2 months, he still doesn't let ...", "domain": "quora.com", "position": 2, "serp_header": {"title": "I've had my cockatiel for about 2 months, he still doesn't let ...", "displayed_link": "https://www.quora.com › I-ve-had-my-cockatiel-for-abo...", "displayed_name": "Quora"}, "post_content": null, "block_position": 2, "meta_description": {"date": "8 juil. 2020", "html": "<span>If your <em>cockatiel got</em> lost, you'd want her returned, right? Be patient and give it some time. Take the bird to a qualified avian vet to be checked out; ...</span>", "text": "If your cockatiel got lost, you'd want her returned, right? Be patient and give it some time. Take the bird to a qualified avian vet to be checked out; ...", "highlighted_words": ["cockatiel got"]}, "about_this_result": null}, {"link": "https://www.reddit.com/r/Pets/comments/16zpxj/our_cockatiel_is_almost_two_years_old_and_wont/", "title": "Our cockatiel is almost two years old and won't shut up.", "domain": "reddit.com", "position": 3, "serp_header": {"title": "Our cockatiel is almost two years old and won't shut up.", "displayed_link": "https://www.reddit.com › comments", "displayed_name": "Reddit"}, "post_content": {"toc": [], "link": {"count": 0, "details": [], "external": 0, "internal": 0}, "blog_title": "Our cockatiel is almost two years old and won't shut up.", "word_count": 88, "links_count": 0, "images_count": 0, "headings_count": 1, "paragraphs_count": 2, "word_count_without_headings": 68}, "block_position": 3, "meta_description": {"date": null, "html": "<span>Our <em>cockatiel</em> is almost two years old and <em>won</em>'t shut up. I don't know how it could be for attention, my girlfriend and I are literally holding her and ...</span>", "text": "Our cockatiel is almost two years old and won't shut up. I don't know how it could be for attention, my girlfriend and I are literally holding her and ...", "highlighted_words": ["cockatiel", "won"]}, "about_this_result": null}, {"link": "https://www.smallpets101.com/cockatiel-wont-stop-chirping-why-this-happens-what-to-do/", "title": "Cockatiel Won't Stop Chirping: Why This Happens & What To Do", "domain": "smallpets101.com", "position": 4, "serp_header": {"title": "Cockatiel Won't Stop Chirping: Why This Happens & What To Do", "displayed_link": "https://www.smallpets101.com › co...", "displayed_name": "smallpets101.com"}, "post_content": {"toc": [{"id": null, "name": "Cockatiel Won’t Stop Chirping", "level": "h2"}, {"id": null, "name": "Learn About Common Cockatiel Sounds and Meanings", "level": "h2"}, {"id": null, "name": "Why Do Cockatiels Chirp", "level": "h2"}, {"id": null, "name": "The contact called cockatiel chirp", "level": "h3"}, {"id": null, "name": "The danger-danger call cockatiel chirp", "level": "h3"}, {"id": null, "name": "The distress call cockatiel chirp", "level": "h3"}, {"id": null, "name": "The boredom or loneliness screeching cockatiel chirp", "level": "h3"}, {"id": null, "name": "The reinforced screaming cockatiel chirp", "level": "h3"}, {"id": null, "name": "Male Versus Female Cockatiel Chirping", "level": "h2"}, {"id": null, "name": "What To Do If Your Cockatiel Won’t Stop Chirping", "level": "h2"}], "link": {"count": 17, "details": [{"link": "#", "domain": "smallpets101.com", "is_internal": true}, {"link": "#Cockatiel_Wont_Stop_Chirping", "domain": "smallpets101.com", "is_internal": true}, {"link": "#Learn_About_Common_Cockatiel_Sounds_and_Meanings", "domain": "smallpets101.com", "is_internal": true}, {"link": "#Why_Do_Cockatiels_Chirp", "domain": "smallpets101.com", "is_internal": true}, {"link": "#The_contact_called_cockatiel_chirp", "domain": "smallpets101.com", "is_internal": true}, {"link": "#The_danger-danger_call_cockatiel_chirp", "domain": "smallpets101.com", "is_internal": true}, {"link": "#The_distress_call_cockatiel_chirp", "domain": "smallpets101.com", "is_internal": true}, {"link": "#The_boredom_or_loneliness_screeching_cockatiel_chirp", "domain": "smallpets101.com", "is_internal": true}, {"link": "#The_reinforced_screaming_cockatiel_chirp", "domain": "smallpets101.com", "is_internal": true}, {"link": "#Male_Versus_Female_Cockatiel_Chirping", "domain": "smallpets101.com", "is_internal": true}, {"link": "#What_To_Do_If_Your_Cockatiel_Wont_Stop_Chirping", "domain": "smallpets101.com", "is_internal": true}, {"link": "http://www.tailfeathersnetwork.com/community/showthread.php/12495-Chirping-constantly!-What-should-I-do", "domain": "tailfeathersnetwork.com", "is_internal": false}, {"link": "https://www.cockatielcottage.net/screaming.html", "domain": "cockatielcottage.net", "is_internal": false}, {"link": "https://goodbirdinc.blogspot.com/2008/05/stop-you-parrot-from-screaming-for.html", "domain": "goodbirdinc.blogspot.com", "is_internal": false}, {"link": "https://www.smallpets101.com/cockatiel-scream-why-your-bird-screams-and-what-it-means/", "domain": "smallpets101.com", "is_internal": true}, {"link": "https://www.smallpets101.com/male-vs-female-cockatiel-how-to-tell-your-cockatiel-gender/", "domain": "smallpets101.com", "is_internal": true}, {"link": "https://www.talkcockatiels.com/threads/are-there-quiet-males.27444/", "domain": "talkcockatiels.com", "is_internal": false}], "external": 4, "internal": 13}, "blog_title": "Cockatiel Won’t Stop Chirping: Why This Happens & What To Do", "word_count": 1374, "links_count": 17, "images_count": 0, "headings_count": 11, "paragraphs_count": 45, "word_count_without_headings": 1239}, "block_position": 4, "meta_description": {"date": "26 nov. 2022", "html": "<span>In this article, we will discuss what <em>cockatiel</em> chirping is and what it sounds like and compare chirping to the other sounds <em>cockatiels</em> make.</span>", "text": "In this article, we will discuss what cockatiel chirping is and what it sounds like and compare chirping to the other sounds cockatiels make.", "highlighted_words": ["cockatiel", "cockatiels"]}, "about_this_result": null}, {"link": "https://forums.avianavenue.com/index.php?threads/help-cockatiel-wont-step-up.259854/", "serp": {"footer": "<div class=\\"Z26q7c UK95Uc\\" data-sncf=\\"2\\" data-snf=\\"M7eMpf\\"><div data-ved=\\"2ahUKEwjO4JLY_bv-AhUJesAKHbi8B90QqwJ6BAgREAA\\"><div class=\\"P1usbc\\"><div class=\\"VNLkW\\"><div class=\\"i4vd5e\\"><div class=\\"wrBvFf OSrXXb\\"><a class=\\"fl\\" href=\\"https://forums.avianavenue.com/index.php?threads/my-cockatiel-wont-become-tame.221665/\\" jsaction=\\"rcuQ6b:npT2md\\" jscontroller=\\"M9mgyc\\" jsname=\\"qOiK6e\\" ping=\\"/url?sa=t&amp;source=web&amp;rct=j&amp;url=https://forums.avianavenue.com/index.php%3Fthreads/my-cockatiel-wont-become-tame.221665/&amp;ved=2ahUKEwjO4JLY_bv-AhUJesAKHbi8B90QrAIoAHoECBEQAQ\\"><span>My <em>cockatiel won</em>'t become tame! | Avian Avenue Parrot Forum</span></a></div></div><div class=\\"G1Rrjc\\"><div class=\\"wrBvFf OSrXXb\\"><span>8 fév. 2019</span></div></div></div><div class=\\"VNLkW\\"><div class=\\"i4vd5e\\"><div class=\\"wrBvFf OSrXXb\\"><a class=\\"fl\\" href=\\"https://forums.avianavenue.com/index.php?threads/cockatiel-won-t-stop-screaming.278081/\\" jsaction=\\"rcuQ6b:npT2md\\" jscontroller=\\"M9mgyc\\" jsname=\\"qOiK6e\\" ping=\\"/url?sa=t&amp;source=web&amp;rct=j&amp;url=https://forums.avianavenue.com/index.php%3Fthreads/cockatiel-won-t-stop-screaming.278081/&amp;ved=2ahUKEwjO4JLY_bv-AhUJesAKHbi8B90QrAIoAXoECBEQAg\\"><span><em>Cockatiel won</em> t stop screaming | Avian Avenue Parrot Forum</span></a></div></div><div class=\\"G1Rrjc\\"><div class=\\"wrBvFf OSrXXb\\"><span>23 avr. 2022</span></div></div></div><div class=\\"VNLkW\\"><div class=\\"i4vd5e\\"><div class=\\"wrBvFf OSrXXb\\"><a class=\\"fl\\" href=\\"https://forums.avianavenue.com/index.php?threads/my-baby-cockatiel-wont-eat-or-drink.272488/\\" jsaction=\\"rcuQ6b:npT2md\\" jscontroller=\\"M9mgyc\\" jsname=\\"qOiK6e\\" ping=\\"/url?sa=t&amp;source=web&amp;rct=j&amp;url=https://forums.avianavenue.com/index.php%3Fthreads/my-baby-cockatiel-wont-eat-or-drink.272488/&amp;ved=2ahUKEwjO4JLY_bv-AhUJesAKHbi8B90QrAIoAnoECBEQAw\\"><span>My Baby <em>Cockatiel Won</em>'t Eat or Drink - Avian Avenue</span></a></div></div><div class=\\"G1Rrjc\\"><div class=\\"wrBvFf OSrXXb\\"><span>22 nov. 2021</span></div></div></div><div class=\\"VNLkW\\"><div class=\\"i4vd5e\\"><div class=\\"wrBvFf OSrXXb\\"><a class=\\"fl\\" href=\\"https://forums.avianavenue.com/index.php?threads/my-cockatiel-wont-eat-sunflower-seeds-or-anything-hard-how-do-i-teach-him.238505/\\" jsaction=\\"rcuQ6b:npT2md\\" jscontroller=\\"M9mgyc\\" jsname=\\"qOiK6e\\" ping=\\"/url?sa=t&amp;source=web&amp;rct=j&amp;url=https://forums.avianavenue.com/index.php%3Fthreads/my-cockatiel-wont-eat-sunflower-seeds-or-anything-hard-how-do-i-teach-him.238505/&amp;ved=2ahUKEwjO4JLY_bv-AhUJesAKHbi8B90QrAIoA3oECBEQBA\\"><span>My <em>cockatiel won</em>'t eat sunflower seeds or anything hard!! How ...</span></a></div></div><div class=\\"G1Rrjc\\"><div class=\\"wrBvFf OSrXXb\\"><span>28 fév. 2020</span></div></div></div><div class=\\"k6DEPe\\"><div class=\\"i4vd5e\\"><div class=\\"wrBvFf OSrXXb\\"><a class=\\"fl\\" href=\\"/search?q=cockatiel+won+site:forums.avianavenue.com&amp;sa=X&amp;ved=2ahUKEwjO4JLY_bv-AhUJesAKHbi8B90QrQIoBHoECBEQBQ\\" jsaction=\\"rcuQ6b:npT2md\\" jscontroller=\\"M9mgyc\\" jsname=\\"qOiK6e\\"><span>Autres résultats sur forums.avianavenue.com</span></a></div></div></div></div></div></div>"}, "title": "Help! Cockatiel won't step up!", "domain": "forums.avianavenue.com", "position": 5, "serp_header": {"title": "Help! Cockatiel won't step up!", "displayed_link": "https://forums.avianavenue.com › ...", "displayed_name": "Avian Avenue"}, "post_content": {"toc": [], "link": {"count": 5, "details": [{"link": "/index.php?members/outstrech.44921/", "domain": "index.php?members", "is_internal": true}, {"link": "/index.php?members/outstrech.44921/", "domain": "index.php?members", "is_internal": true}, {"link": "/index.php?threads/help-cockatiel-wont-step-up.259854/post-3435398", "domain": "index.php?threads", "is_internal": true}, {"link": "/index.php?threads/help-cockatiel-wont-step-up.259854/post-3435398", "domain": "index.php?threads", "is_internal": true}, {"link": "/index.php?threads/help-cockatiel-wont-step-up.259854/post-3435398", "domain": "index.php?threads", "is_internal": true}], "external": 5, "internal": 0}, "blog_title": "Help! Cockatiel won't step up!", "word_count": 246, "links_count": 5, "images_count": 2, "headings_count": 1, "paragraphs_count": 0, "word_count_without_headings": 186}, "block_position": 5, "meta_description": {"date": "11 mar. 2021", "html": "<span>I have a cockatiel named Sunflower. ... <em>Cockatiel won</em>'t step up! ... The pet store I got him from had a owner that didn't really care for ...</span>", "text": "I have a cockatiel named Sunflower. ... Cockatiel won't step up! ... The pet store I got him from had a owner that didn't really care for ...", "highlighted_words": ["Cockatiel won"]}, "about_this_result": null}, {"link": "https://beakcraze.com/why-your-cockatiel-is-screaming-all-the-time/", "title": "7 Reasons Why Your Cockatiel Is Screaming All The Time", "domain": "beakcraze.com", "position": 6, "serp_header": {"title": "7 Reasons Why Your Cockatiel Is Screaming All The Time", "displayed_link": "https://beakcraze.com › why-your-...", "displayed_name": "Beak Craze"}, "post_content": null, "block_position": 6, "meta_description": {"date": "2 jan. 2019", "html": "<span>This will ensure that you are feeding treats to your <em>bird</em> that <em>won</em>´t cause any problems.</span>", "text": "This will ensure that you are feeding treats to your bird that won´t cause any problems.", "highlighted_words": ["bird", "won"]}, "about_this_result": null}, {"link": "https://newpetsowner.com/why-is-my-cockatiel-chirping-nonstop-explained/", "title": "Why is My Cockatiel Chirping Nonstop? (Explained)", "domain": "newpetsowner.com", "position": 7, "serp_header": {"title": "Why is My Cockatiel Chirping Nonstop? (Explained)", "displayed_link": "https://newpetsowner.com › why-is...", "displayed_name": "newpetsowner.com"}, "post_content": null, "block_position": 7, "meta_description": {"date": "31 mai 2022", "html": "<span>So I decided to research the topic and figure out why your <em>cockatiel won</em>'t stop chirping. Here is what I found out: In general, cockatiels chirp ...</span>", "text": "So I decided to research the topic and figure out why your cockatiel won't stop chirping. Here is what I found out: In general, cockatiels chirp ...", "highlighted_words": ["cockatiel won"]}, "about_this_result": null}, {"link": "https://www.parrotforums.com/threads/my-cockatiel-wont-let-me-touch-him.94924/", "title": "My cockatiel won't let me touch him", "domain": "parrotforums.com", "position": 8, "serp_header": {"title": "My cockatiel won't let me touch him", "displayed_link": "https://www.parrotforums.com › m...", "displayed_name": "parrotforums.com"}, "post_content": {"toc": [], "link": {"count": 5, "details": [{"link": "/members/punkanaofbirds.44037/", "domain": "members", "is_internal": true}, {"link": "/members/punkanaofbirds.44037/", "domain": "members", "is_internal": true}, {"link": "/threads/my-cockatiel-wont-let-me-touch-him.94924/post-1006997", "domain": "threads", "is_internal": true}, {"link": "/threads/my-cockatiel-wont-let-me-touch-him.94924/post-1006997", "domain": "threads", "is_internal": true}, {"link": "/threads/my-cockatiel-wont-let-me-touch-him.94924/post-1006997", "domain": "threads", "is_internal": true}], "external": 5, "internal": 0}, "blog_title": "My cockatiel won’t let me touch him", "word_count": 222, "links_count": 5, "images_count": 1, "headings_count": 1, "paragraphs_count": 0, "word_count_without_headings": 158}, "block_position": 8, "meta_description": {"date": "13 jui. 2022", "html": "<span>I am Ana and I have had my <em>cockatiel</em> since march. it is june now and he ... be touched but not all <em>cockatiels</em> can be touched when I just <em>got</em> ...</span>", "text": "I am Ana and I have had my cockatiel since march. it is june now and he ... be touched but not all cockatiels can be touched when I just got ...", "highlighted_words": ["cockatiel", "cockatiels", "got"]}, "about_this_result": null}]	"[{\\"question\\": \\"cockatiel not eating on first day\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 9}, {\\"question\\": \\"new cockatiel not eating or drinking\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 9}, {\\"question\\": \\"cockatiel not eating and sleeping\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 9}, {\\"question\\": \\"millet spray\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 9}, {\\"question\\": \\"cockatiel lifespan\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 9}, {\\"question\\": \\"cockatiel pellets\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 9}, {\\"question\\": \\"how to bond with cockatiel\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 9}, {\\"question\\": \\"my cockatiel hates me\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 9}, {\\"question\\": \\"Is it normal for a new cockatiel to not eat?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How long does it take for a cockatiel to get used to a new home?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What do you feed a 1 day old cockatiel?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What to do if your cockatiel won't eat?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What to do if my new cockatiel is not eating?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How long does it take for a cockatiel to adjust to its new home?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How long can a cockatiel go without eating or drinking?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Why won't my new cockatiel drink water?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Why is my cockatiel sleeping and not eating?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What to do if your cockatiel is not eating?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Why is my cockatiel suddenly lethargic?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What does a sick cockatiel look like?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What is millet spray?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Is Spray Millet good for birds?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Do wild birds eat Spray Millet?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How do you make millet spray?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How long do cockatiels live for as a pet?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Can a cockatiel live for 20 years?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Can cockatiels live to be 30 years old?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Can 1 cockatiel live alone?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Are pellets good for cockatiels?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What pellets should I feed my cockatiel?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How much pellets do cockatiels need a day?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Why do cockatiels need pellets?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How long does it take for a cockatiel to bond with you?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How do you get your cockatiel to trust you?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Do cockatiels bond with one person?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How do cockatiels bond with humans?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How do I get my cockatiel to like me?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Why is my cockatiel so mean?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Why does my cockatiel keep attacking me?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How do I bond with my cockatiel?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}]"	2023-04-21 22:05:41.218648+00	9bf02150-a4d1-44d7-8696-6dfe58a96829
ec102ca7-260b-46de-a9d0-77207f6782d4	[{"link": "https://www.amazon.com/cockatiel-food/s?k=cockatiel+food", "serp": {"footer": "<div class=\\"Z26q7c UK95Uc VGXe8\\" data-sncf=\\"2\\" data-snf=\\"nke7rc\\" style=\\"grid-area:nke7rc\\"><div class=\\"VwiC3b yXK7lf MUxGbd yDYNvb lyLwlc\\"><span>Kaytee Supreme <em>Cockatiel Food</em> 5 lb · Kaytee Forti-Diet Pro Health Cockatiel Pet Bird Food with Safflower, 4 Pound · Wild Harvest Cockatiel Advanced Nutrition Diet ...</span></div></div>"}, "title": "Cockatiel Food", "domain": "amazon.com", "snippet": {}, "position": 1, "serp_header": {"title": "Cockatiel Food", "displayed_link": "https://www.amazon.com › cockatiel-food › k=cockati...", "displayed_name": "Amazon.com"}, "post_content": null, "block_position": 1, "about_this_result": null}, {"link": "https://www.petco.com/shop/en/petcostore/category/bird/bird-food-and-treats/bird-food/cockatiel-food", "serp": {"footer": "<div class=\\"Z26q7c UK95Uc\\" data-sncf=\\"2\\" data-snf=\\"nke7rc\\"><div class=\\"VwiC3b yXK7lf MUxGbd yDYNvb lyLwlc lEBKkf\\" style=\\"-webkit-line-clamp:2\\"><span class=\\"MUxGbd wuQ4Ob WZ8Tjf\\"><span>Results 1 - 48 of 48</span> — </span><span>A well-balanced <em>cockatiel</em> diet consists of specialized pellets that should make up to 60-70% of their diet, plus fresh vegetables and fruits ...</span></div></div>"}, "title": "Cockatiel Food, Pellets & Bird Seed", "domain": "petco.com", "snippet": {}, "position": 2, "serp_header": {"title": "Cockatiel Food, Pellets & Bird Seed", "displayed_link": "https://www.petco.com › ... › Bird Food", "displayed_name": "Petco"}, "post_content": null, "block_position": 2, "meta_description": {"date": null, "html": null, "text": null, "highlighted_words": null}, "about_this_result": null}, {"link": "https://beautyofbirds.com/healthy-cockatiel-food-list/", "serp": {"footer": "<div class=\\"Z26q7c UK95Uc VGXe8\\" data-sncf=\\"2\\" data-snf=\\"nke7rc\\" style=\\"grid-area:nke7rc\\"><div class=\\"VwiC3b yXK7lf MUxGbd yDYNvb lyLwlc\\"><span class=\\"MUxGbd wuQ4Ob WZ8Tjf\\"><span>Dec 15, 2022</span> — </span><span>You should feed your <em>cockatiel</em> only fresh and organic grapes, and only after washing them thoroughly in warm water. Also, keep it restricted to ...</span></div></div>"}, "title": "Cockatiel Food List - Diet For Healthy Cockatiels", "domain": "beautyofbirds.com", "snippet": {}, "position": 3, "serp_header": {"title": "Cockatiel Food List - Diet For Healthy Cockatiels", "displayed_link": "https://beautyofbirds.com › Pet Birds", "displayed_name": "Beauty of Birds"}, "post_content": {"toc": [{"id": null, "name": "What Can Cockatiels Eat?", "level": "h2"}, {"id": null, "name": "What Can Cockatiels Not Eat?", "level": "h2"}, {"id": null, "name": "How To Feed My Cockatiel?", "level": "h2"}, {"id": null, "name": "What Fruits Can Cockatiels Eat?", "level": "h2"}, {"id": null, "name": "What Vegetables Can Cockatiels Eat?", "level": "h2"}, {"id": null, "name": "What Seeds Can Cockatiels Eat?", "level": "h2"}, {"id": null, "name": "Sprouting Seeds: The Powerful Way of Feeding Birds", "level": "h3"}, {"id": null, "name": "Can Cockatiels Eat Grass?", "level": "h2"}, {"id": null, "name": "What Herbs Can They Eat?", "level": "h2"}, {"id": null, "name": "Can Cockatiels Eat Nuts?", "level": "h2"}, {"id": null, "name": "Can Cockatiels Eat Dried Fruit?", "level": "h2"}, {"id": null, "name": "Can Cockatiel Eat Rice?", "level": "h2"}, {"id": null, "name": "Can Cockatiels Eat Honey?", "level": "h2"}, {"id": null, "name": "Can Cockatiels Eat Human Treats?", "level": "h2"}, {"id": null, "name": "What Do Cockatiels Eat For Treats?", "level": "h2"}, {"id": null, "name": "Can Cockatiels Eat Parakeet Or Budgie Food?", "level": "h2"}, {"id": null, "name": "Are Cockatiels Omnivores? Do They Eat Meat?", "level": "h2"}, {"id": null, "name": "What Insects Can Cockatiels Eat?", "level": "h3"}, {"id": null, "name": "Can Cockatiels Eat Eggs?", "level": "h3"}, {"id": null, "name": "Best Food For Cockatiels", "level": "h2"}, {"id": null, "name": "Best Overall – RoudyBush Daily Maintenance Bird Food Crumbles", "level": "h3"}, {"id": null, "name": "Best Treat – Vitakraft Fruit Cocktail Parrot & Cockatiel Treat", "level": "h3"}, {"id": null, "name": "Best Organic – Harrison’s Bird Foods High Potency Fine", "level": "h3"}, {"id": null, "name": "Best for Baby cockatiels – Kaytee Exact Hand Feeding Formula Baby Bird Food", "level": "h3"}, {"id": null, "name": "Best for Fruit Content – ZuPreem FruitBlend with Natural Fruit Flavors Medium Bird Food", "level": "h3"}, {"id": null, "name": "Best Natural Birdfeed – Bird Street Bistro Sample Pack Bird Food", "level": "h3"}, {"id": null, "name": "Cockatiel Feeding Schedule", "level": "h2"}, {"id": null, "name": "How Long Can A Cockatiel Go Without Food?", "level": "h2"}, {"id": null, "name": "Why Do Cockatiels Eat Too Much Sometimes?", "level": "h2"}, {"id": null, "name": "Frequently Asked Questions", "level": "h2"}, {"id": null, "name": "What Can I Feed My Cockatiel Besides Seeds?", "level": "h3"}, {"id": null, "name": "Can cockatiels eat fruit every day?", "level": "h3"}, {"id": null, "name": "Can a cockatiel drink milk?", "level": "h3"}, {"id": null, "name": "Can cockatiels eat Cheese?", "level": "h3"}, {"id": null, "name": "Can cockatiels eat Cinnamon?", "level": "h3"}, {"id": null, "name": "Wrapping Up", "level": "h2"}], "link": {"count": 85, "details": [{"link": "https://beautyofbirds.com/bird-food-caution/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://www.academia.edu/75590320/Determination_of_amygdalin_in_apple_seeds_fresh_apples_and_processed_apple_juices", "domain": "academia.edu", "is_internal": false}, {"link": "https://beautyofbirds.com/cockatiel-facts-habitat-diet-lifecycle/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-apples/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-grapes/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-mango/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-banana/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-coconut/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-papaya/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-oranges-or-peels/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-oranges-or-peels/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-pumpkin/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-watermelon/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-cantaloupe/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-cranberries/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-kiwi/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-peaches/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-bell-peppers/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-strawberries/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-blueberries/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-pineapple/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-raspberries/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-pomegranate/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-have-blackberries/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-cherries/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-tomatoes/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-avocado/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://vetmed.illinois.edu/pet-health-columns/bird-toxins-teflon-avocado-lead-zinc/", "domain": "vetmed.illinois.edu", "is_internal": false}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-spinach/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://lpi.oregonstate.edu/book/export/html/48", "domain": "lpi.oregonstate.edu", "is_internal": false}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-peas/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-cabbage/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-corn/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-lettuce/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-carrots/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-cucumber/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-cilantro-what-about-the-stems/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-green-beans/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-kale/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-fennel/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-curry-leaves/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-broccoli-cauliflower/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-celery/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-asparagus/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-broccoli-cauliflower/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-onions/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-poppy-seeds/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-sesame-seeds/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-flax-seeds/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-pumpkin/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-chia-seeds/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-oats-oatmeal/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-oats-oatmeal/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-quinoa/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/sprouting", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/simple-sprouts/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-grass/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-peanuts/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-walnuts/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-have-almonds/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-pistachios/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-cashews/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiel-eat-rice/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-honey/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/healthy-cockatiel-food-list/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-popcorn/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-french-fries/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-crackers-pretzels/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-crackers-pretzels/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://vet.tufts.edu/tufts-wildlife-clinic/resource-library/birdfeeders-and-wildlife", "domain": "vet.tufts.edu", "is_internal": false}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-parakeet-or-budgie-food/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/are-cockatiels-omnivores/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/what-insects-can-cockatiels-eat/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-eggs/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://www.amazon.com/dp/B000WFEK0Y", "domain": "amazon.com", "is_internal": false}, {"link": "https://www.amazon.com/dp/B0002AQDXQ", "domain": "amazon.com", "is_internal": false}, {"link": "https://www.amazon.com/dp/B0007LI108", "domain": "amazon.com", "is_internal": false}, {"link": "https://www.amazon.com/dp/B0002DGJH8/", "domain": "amazon.com", "is_internal": false}, {"link": "https://www.amazon.com/dp/B0054RV486", "domain": "amazon.com", "is_internal": false}, {"link": "https://www.amazon.com/dp/B086KLFSZQ?tag=thesprucepets-onsite-prod-20&linkCode=ogi&th=1&ascsubtag=4775697%7Cn329eba8f3fce4b30aa699e5639b9fd8419%7CB086KLFSZQ", "domain": "amazon.com", "is_internal": false}, {"link": "https://beautyofbirds.com/how-long-can-a-cockatiel-go-without-food/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/why-is-my-cockatiel-eating-so-much/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-drink-milk/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "http://cheese", "domain": "cheese", "is_internal": false}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-cinnamon/", "domain": "beautyofbirds.com", "is_internal": true}], "external": 11, "internal": 74}, "blog_title": "Cockatiel Food List – Diet For Healthy Cockatiels", "word_count": 5151, "links_count": 85, "images_count": 38, "headings_count": 37, "paragraphs_count": 242, "word_count_without_headings": 4920}, "block_position": 3, "about_this_result": null}, {"link": "https://www.chewy.com/b/food-946", "serp": {"footer": "<div class=\\"Z26q7c UK95Uc\\" data-sncf=\\"2\\" data-snf=\\"nke7rc\\"><div class=\\"VwiC3b yXK7lf MUxGbd yDYNvb lyLwlc lEBKkf\\" style=\\"-webkit-line-clamp:2\\"><span class=\\"MUxGbd wuQ4Ob WZ8Tjf\\"><span>Results 1 - 36 of 78</span> — </span><span>Growing <em>Cockatiels</em> will enjoy Kaytee Exact Hand Feeding Formula Baby Bird <em>Food</em>. It's a specially formulated bird <em>food</em> to help little birdies ...</span></div></div>"}, "title": "Cockatiel Food: Seed, Crumble, Pellets (Free Shipping)", "domain": "chewy.com", "snippet": {}, "position": 4, "serp_header": {"title": "Cockatiel Food: Seed, Crumble, Pellets (Free Shipping)", "displayed_link": "https://www.chewy.com › Bird › Shop by Bird › Cockatiel", "displayed_name": "Chewy.com"}, "post_content": null, "block_position": 4, "meta_description": {"date": null, "html": null, "text": null, "highlighted_words": null}, "about_this_result": null}, {"link": "https://www.thesprucepets.com/best-foods-for-cockatiels-4775697", "serp": {"footer": "<div class=\\"Z26q7c UK95Uc VGXe8\\" data-sncf=\\"2\\" data-snf=\\"nke7rc\\" style=\\"grid-area:nke7rc\\"><div class=\\"VwiC3b yXK7lf MUxGbd yDYNvb lyLwlc\\"><span class=\\"MUxGbd wuQ4Ob WZ8Tjf\\"><span>Mar 24, 2022</span> — </span><span>Similar to your own diet, a <em>cockatiel</em> thrives most when fed a variety of nutritious <em>foods</em>, including whole beans, vegetables, fruits, ...</span></div></div>"}, "title": "The 7 Best Foods for Cockatiels in 2023", "domain": "thesprucepets.com", "snippet": {}, "position": 5, "serp_header": {"title": "The 7 Best Foods for Cockatiels in 2023", "displayed_link": "https://www.thesprucepets.com › ... › Small Pet Products", "displayed_name": "The Spruce Pets"}, "post_content": null, "block_position": 5, "about_this_result": null}, {"link": "https://vcahospitals.com/know-your-pet/cockatiels-feeding", "serp": {"footer": "<div class=\\"Z26q7c UK95Uc VGXe8\\" data-sncf=\\"2\\" data-snf=\\"nke7rc\\" style=\\"grid-area:nke7rc\\"><div class=\\"VwiC3b yXK7lf MUxGbd yDYNvb lyLwlc\\"><span>What does a <em>cockatiel</em> naturally eat? ... <em>Cockatiels</em> eat a variety of seeds (grass seeds), fruits, berries and vegetation. They have been known to raid farmer's ...</span></div></div>"}, "title": "Cockatiels - Feeding | VCA Canada Animal Hospitals", "domain": "vcahospitals.com", "snippet": {}, "position": 6, "serp_header": {"title": "Cockatiels - Feeding | VCA Canada Animal Hospitals", "displayed_link": "https://vcahospitals.com › know-your-pet › cockatiels-...", "displayed_name": "VCA Animal Hospitals"}, "post_content": null, "block_position": 6, "about_this_result": null}, {"link": "https://www.petsmart.com/learning-center/bird-care/cockatiel-care-guide/A0065.html", "serp": {"footer": "<div class=\\"Z26q7c UK95Uc VGXe8\\" data-sncf=\\"2\\" data-snf=\\"nke7rc\\" style=\\"grid-area:nke7rc\\"><div class=\\"VwiC3b yXK7lf MUxGbd yDYNvb lyLwlc\\"><span>What do <em>cockatiels</em> eat? <em>Cockatiels</em> enjoy a range of <em>foods</em>, including commercial birdseed, pelleted <em>food</em>, vegetables, fruit and the occasional treat. A mixture ...</span></div></div>"}, "title": "Cockatiel Care Sheet: Tips, Basics, & Supplies", "domain": "petsmart.com", "snippet": {}, "position": 7, "serp_header": {"title": "Cockatiel Care Sheet: Tips, Basics, & Supplies", "displayed_link": "https://www.petsmart.com › learning-center › bird-care", "displayed_name": "PetSmart"}, "post_content": null, "block_position": 7, "about_this_result": null}, {"link": "https://www.psittacology.com/human-foods-for-cockatiels/", "serp": {"footer": "<div class=\\"Z26q7c UK95Uc VGXe8\\" data-sncf=\\"2\\" data-snf=\\"nke7rc\\" style=\\"grid-area:nke7rc\\"><div class=\\"VwiC3b yXK7lf MUxGbd yDYNvb lyLwlc\\"><span><em>Cockatiels</em> can be fed both live and dried mealworms, though dried mealworms tend to be the safer choice. Live mealworms could make your bird uncomfortable if ...</span></div></div>"}, "title": "16 Human Foods Safe For Cockatiels (And 9 That Aren't)", "domain": "psittacology.com", "snippet": {}, "position": 8, "serp_header": {"title": "16 Human Foods Safe For Cockatiels (And 9 That Aren't)", "displayed_link": "https://www.psittacology.com › human-foods-for-coc...", "displayed_name": "Psittacology"}, "post_content": {"toc": [{"id": null, "name": "Can cockatiels eat snacks for humans?", "level": "h2"}, {"id": null, "name": "16 safe human foods for cockatiels", "level": "h2"}, {"id": null, "name": "Can cockatiels eat shrimp?", "level": "h3"}, {"id": null, "name": "Can cockatiels eat pecans?", "level": "h3"}, {"id": null, "name": "Can cockatiels eat pumpkin seeds?", "level": "h3"}, {"id": null, "name": "Can cockatiels eat rice?", "level": "h3"}, {"id": null, "name": "Can cockatiels eat pine nuts?", "level": "h3"}, {"id": null, "name": "Can cockatiels eat pasta?", "level": "h3"}, {"id": null, "name": "Can cockatiels eat hard-boiled eggs?", "level": "h3"}, {"id": null, "name": "Can cockatiels eat mealworms?", "level": "h3"}, {"id": null, "name": "Can cockatiels eat meat?", "level": "h3"}, {"id": null, "name": "Can cockatiels eat pistachios?", "level": "h3"}, {"id": null, "name": "Can cockatiels eat peanuts?", "level": "h3"}, {"id": null, "name": "Can cockatiels eat peanut butter?", "level": "h3"}, {"id": null, "name": "Can cockatiels eat almonds?", "level": "h3"}, {"id": null, "name": "Can cockatiels eat walnuts?", "level": "h3"}, {"id": null, "name": "Can cockatiels eat flax seed?", "level": "h3"}, {"id": null, "name": "Can cockatiels eat oatmeal?", "level": "h3"}, {"id": null, "name": "Foods to avoid (or offer in very small amounts)", "level": "h2"}, {"id": null, "name": "Can cockatiels eat tortilla chips?", "level": "h3"}, {"id": null, "name": "Can cockatiels eat yogurt?", "level": "h3"}, {"id": null, "name": "Can cockatiels eat goldfish crackers?", "level": "h3"}, {"id": null, "name": "Can cockatiels eat graham crackers?", "level": "h3"}, {"id": null, "name": "Can cockatiels eat cereal?", "level": "h3"}, {"id": null, "name": "Can cockatiels eat chips?", "level": "h3"}, {"id": null, "name": "Can cockatiels eat cheese?", "level": "h3"}, {"id": null, "name": "Can cockatiels eat bread?", "level": "h3"}, {"id": null, "name": "Can cockatiels eat toast?", "level": "h3"}, {"id": null, "name": "Conclusion", "level": "h2"}], "link": {"count": 3, "details": [{"link": "https://www.psittacology.com/what-do-cockatiels-eat/", "domain": "psittacology.com", "is_internal": true}, {"link": "https://www.psittacology.com/what-does-parrot-eat-chop/", "domain": "psittacology.com", "is_internal": true}, {"link": "https://www.psittacology.com/parrot-foraging-toys/", "domain": "psittacology.com", "is_internal": true}], "external": 0, "internal": 3}, "blog_title": null, "word_count": 2138, "links_count": 3, "images_count": 2, "headings_count": 29, "paragraphs_count": 51, "word_count_without_headings": 1954}, "block_position": 8, "about_this_result": null}, {"link": "https://a-z-animals.com/blog/what-do-cockatiels-eat/", "serp": {"footer": "<div class=\\"Z26q7c UK95Uc VGXe8\\" data-sncf=\\"2\\" data-snf=\\"nke7rc\\" style=\\"grid-area:nke7rc\\"><div class=\\"VwiC3b yXK7lf MUxGbd yDYNvb lyLwlc\\"><span class=\\"MUxGbd wuQ4Ob WZ8Tjf\\"><span>Oct 13, 2022</span> — </span><span>Yellow pet <em>Cockatiel</em> sitting on a human hand. As pets, <em>cockatiels</em> eat a balanced diet of grass seeds, legumes, and pellets specially crafted for ...</span></div></div>"}, "title": "What Do Cockatiels Eat? A Guide to Their Diet", "domain": "a-z-animals.com", "snippet": {}, "position": 9, "serp_header": {"title": "What Do Cockatiels Eat? A Guide to Their Diet", "displayed_link": "https://a-z-animals.com › ... › Birds › Cockatiels", "displayed_name": "AZ Animals"}, "post_content": null, "block_position": 9, "about_this_result": null}]	"[{\\"question\\": \\"What is the best food for a cockatiel?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 2}, {\\"question\\": \\"What can cockatiels eat list?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What fruits and veggies can cockatiels eat?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 3}, {\\"question\\": \\"How many times a day should a cockatiel eat?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"best cockatiel food\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 11}, {\\"question\\": \\"cockatiel food recipes\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 11}, {\\"question\\": \\"cockatiel food walmart\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 11}, {\\"question\\": \\"petco cockatiel food\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 11}, {\\"question\\": \\"premium cockatiel food\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 11}, {\\"question\\": \\"higgins cockatiel food\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 11}, {\\"question\\": \\"What is the best food food for cockatiels?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What fruit and vegetables are good for cockatiels?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What is the best food for cockatiels pellets?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 2}, {\\"question\\": \\"What are the best seeds for cockatiels?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What foods are safe for cockatiels?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What fruits and veggies can cockatiels not eat?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What vegetables are good for cockatiels?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 2}, {\\"question\\": \\"What vegetables and fruits can cockatiels eat?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What fruits can cockatiels not eat?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What fruits are good for cockatiels?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How much should a cockatiel eat in one day?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How do I know if my cockatiel is hungry?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Should cockatiels eat all day?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What is the feeding schedule for a cockatiel?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What is the best food to feed a cockatiel?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What is the best seed for cockatiels?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What do you feed picky cockatiels?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How do you make homemade cockatiel food?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What's the best food to feed a cockatiel?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 2}, {\\"question\\": \\"What is the home food for cockatiel bird?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Can cockatiels eat hard boiled eggs?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What bird food can cockatiels eat?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How often should cockatiels eat?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Can cockatiels eat regular bird food?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What is the best food brand for cockatiels?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 2}, {\\"question\\": \\"What should I feed my cockatiel?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What can I feed my cockatiel if I run out of food?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"How much should a cockatiel eat a day?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What are cockatiels favorite food?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What not to feed a cockatiel?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 2}, {\\"question\\": \\"What food can cockatiels eat?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}]"	2023-04-24 10:59:37.154566+00	4c425af7-44e0-4c83-9e31-b68d802bf8d1
27774afc-f451-4b91-9984-c0ee15c25001	[{"link": "https://a-z-animals.com/blog/cockatiel-vs-parakeet-5-key-differences-to-decide-which-is-right-for-you/#:~:text=The%20main%20differences%20between%20parakeets,a%20wider%20variety%20of%20colors.", "title": "Cockatiel vs Parakeet: 5 Key Differences to Decide Which is ...", "domain": "a-z-animals.com", "snippet": {"heading": {"html": "<div aria-level=\\"3\\" class=\\"LGOjhe\\" data-attrid=\\"wa:/description\\" data-hveid=\\"CDEQAA\\" role=\\"heading\\"><span class=\\"ILfuVd\\" lang=\\"en\\"><span class=\\"hgKElc\\">The main differences between parakeets and cockatiels are their appearance – with <b>cockatiels having distinctive crests on their head that aren't found on parakeets</b>. In addition, cockatiels are generally larger than parakeets and are most commonly found in grey and yellow while parakeets have a wider variety of colors.</span></span><span class=\\"kX21rb ZYHQ7e\\">Mar 12, 2022</span></div>", "content": "The main differences between parakeets and cockatiels are their appearance – with cockatiels having distinctive crests on their head that aren't found on parakeets. In addition, cockatiels are generally larger than parakeets and are most commonly found in grey and yellow while parakeets have a wider variety of colors.Mar 12, 2022", "highlighted_word": "cockatiels having distinctive crests on their head that aren't found on parakeets"}}, "position": 1, "serp_header": {"title": "Cockatiel vs Parakeet: 5 Key Differences to Decide Which is ...", "displayed_link": "https://a-z-animals.com › Pet Animals › Pet Birds", "displayed_name": "AZ Animals"}, "post_content": null, "block_position": 1, "about_this_result": null}, {"link": "https://lafeber.com/pet-birds/budgie-vs-cockatiel-which-right-for-you/", "title": "Budgie Vs. Cockatiel — Which Is Right For You? – Pet ...", "domain": "lafeber.com", "snippet": {}, "position": 2, "serp_header": {"title": "Budgie Vs. Cockatiel — Which Is Right For You? – Pet ...", "displayed_link": "https://lafeber.com › Home › Posts", "displayed_name": "Lafeber Company"}, "post_content": null, "block_position": 2, "meta_description": {"date": "Jun 13, 2013", "html": "<span>Choose the bird to match your personality: <em>cockatiels are low key and touchy feely</em>, while budgies are high energy and will perch on a finger but ...</span>", "text": "Choose the bird to match your personality: cockatiels are low key and touchy feely, while budgies are high energy and will perch on a finger but ...", "highlighted_words": ["cockatiels are low key and touchy feely"]}, "about_this_result": null}, {"link": "https://earthlife.net/birds/cockatiel-vs-parakeet", "serp": {"footer": "<div class=\\"Z26q7c UK95Uc\\" data-sncf=\\"2\\" data-snf=\\"RlqYWc\\"><div style=\\"max-width:600px\\"><div class=\\"EWpfde\\"><div class=\\"sWISj wHYlTd\\"><g-expandable-container data-anim=\\"\\" data-fcss=\\"\\" data-npd=\\"1\\" data-slct=\\"mnr-c\\" jsaction=\\"C7xow:Z6bwpe;xNpQtd:Nh5q2c;U6VCqe:GsRPff;Ep2Mgc:AgioGc;BDs6B:fW2qAb;ep03Ne:AvkpRc;gvA4Rc:yELBLe\\" jscontroller=\\"QE1bwd\\" jsshadow=\\"\\"><div jsname=\\"gI9xcc\\" jsslot=\\"1\\"><g-accordion data-kno-aco=\\"1\\" jsaction=\\"QRorz:CQwlrf;uwoEDe:Nh5q2c;jnvnaf:jkYXCd;keydown:uYT2Vb;rcuQ6b:npT2md\\" jscontroller=\\"MaEUhd\\" jsshadow=\\"\\"><div class=\\"dEsxWc\\" jsslot=\\"\\"><div class=\\"HYvwY h373nd\\" data-dic=\\"\\" data-g=\\"\\" data-ullb=\\"\\" data-use-legacy-loading-behavior=\\"\\" jsaction=\\"rcuQ6b:npT2md;C0pONd:mhSdVe;A0VnDe:rXa5ib;IKGI6b:VrL1hd\\" jscontroller=\\"aD8OEe\\" jsshadow=\\"\\"><div class=\\"ysxiae iRPzcb\\" jsname=\\"clz4Ic\\"></div><div><div aria-controls=\\"_pm1GZIiSA46iptQP5u-bqAg_31\\" aria-expanded=\\"false\\" class=\\"dnXCYb\\" data-hveid=\\"CA4QAw\\" jsaction=\\"AWEk5c\\" jsname=\\"tJHJj\\" role=\\"button\\" tabindex=\\"0\\"><div class=\\"JlqpRe\\" jsname=\\"lN6iy\\"><span class=\\"JCzEY ZwRhJd\\"><span>Are parakeets or cockatiels more affectionate?</span></span></div><div class=\\"aj35ze\\" jsname=\\"Q8Kwad\\"></div><div class=\\"L3Ezfd\\" data-ved=\\"2ahUKEwiI_eu0usL-AhUOkYkEHeb3BoUQzLECegQIDhAE\\" jsname=\\"pcRaIe\\"></div><div class=\\"ru2Kjc\\" data-ved=\\"2ahUKEwiI_eu0usL-AhUOkYkEHeb3BoUQi7gIegQIDhAF\\" jsname=\\"gwzXIc\\"></div></div></div><div class=\\"bCOlv\\" data-ved=\\"2ahUKEwiI_eu0usL-AhUOkYkEHeb3BoUQkLgIegQIDhAG\\" id=\\"_pm1GZIiSA46iptQP5u-bqAg_31\\" jsname=\\"NRdf4c\\"></div></div><div class=\\"HYvwY h373nd\\" data-dic=\\"\\" data-g=\\"\\" data-ullb=\\"\\" data-use-legacy-loading-behavior=\\"\\" jsaction=\\"rcuQ6b:npT2md;C0pONd:mhSdVe;A0VnDe:rXa5ib;IKGI6b:VrL1hd\\" jscontroller=\\"aD8OEe\\" jsshadow=\\"\\"><div class=\\"ysxiae iRPzcb\\" jsname=\\"clz4Ic\\"></div><div><div aria-controls=\\"_pm1GZIiSA46iptQP5u-bqAg_32\\" aria-expanded=\\"false\\" class=\\"dnXCYb\\" data-hveid=\\"CA4QBw\\" jsaction=\\"AWEk5c\\" jsname=\\"tJHJj\\" role=\\"button\\" tabindex=\\"0\\"><div class=\\"JlqpRe\\" jsname=\\"lN6iy\\"><span class=\\"JCzEY ZwRhJd\\"><span>Do cockatiels like to be held?</span></span></div><div class=\\"aj35ze\\" jsname=\\"Q8Kwad\\"></div><div class=\\"L3Ezfd\\" data-ved=\\"2ahUKEwiI_eu0usL-AhUOkYkEHeb3BoUQzLECegQIDhAI\\" jsname=\\"pcRaIe\\"></div><div class=\\"ru2Kjc\\" data-ved=\\"2ahUKEwiI_eu0usL-AhUOkYkEHeb3BoUQi7gIegQIDhAJ\\" jsname=\\"gwzXIc\\"></div></div></div><div class=\\"bCOlv\\" data-ved=\\"2ahUKEwiI_eu0usL-AhUOkYkEHeb3BoUQkLgIegQIDhAK\\" id=\\"_pm1GZIiSA46iptQP5u-bqAg_32\\" jsname=\\"NRdf4c\\"></div></div><div class=\\"iRPzcb\\"></div></div></g-accordion></div></g-expandable-container></div></div></div></div>"}, "title": "Cockatiel vs Parakeet – Most Important Differences", "domain": "earthlife.net", "snippet": {}, "position": 3, "serp_header": {"title": "Cockatiel vs Parakeet – Most Important Differences", "displayed_link": "https://earthlife.net › birds › cockatiel-vs-parakeet", "displayed_name": "EarthLife.net"}, "post_content": null, "block_position": 3, "meta_description": {"date": "Dec 14, 2022", "html": "<span>Between the two, <em>cockatiels are much more affectionate than parakeets</em>. The latter would sit on your finger, but it would rather not be petted.</span>", "text": "Between the two, cockatiels are much more affectionate than parakeets. The latter would sit on your finger, but it would rather not be petted.", "highlighted_words": ["cockatiels are much more affectionate than parakeets"]}, "about_this_result": null}, {"link": "https://beautyofbirds.com/cockatiel-vs-budgie/", "serp": {"footer": "<div class=\\"Z26q7c UK95Uc\\" data-sncf=\\"2\\" data-snf=\\"RlqYWc\\"><div style=\\"max-width:600px\\"><div class=\\"EWpfde\\"><div class=\\"sWISj wHYlTd\\"><g-expandable-container data-anim=\\"\\" data-fcss=\\"\\" data-npd=\\"1\\" data-slct=\\"mnr-c\\" jsaction=\\"C7xow:Z6bwpe;xNpQtd:Nh5q2c;U6VCqe:GsRPff;Ep2Mgc:AgioGc;BDs6B:fW2qAb;ep03Ne:AvkpRc;gvA4Rc:yELBLe\\" jscontroller=\\"QE1bwd\\" jsshadow=\\"\\"><div jsname=\\"gI9xcc\\" jsslot=\\"1\\"><g-accordion data-kno-aco=\\"1\\" jsaction=\\"QRorz:CQwlrf;uwoEDe:Nh5q2c;jnvnaf:jkYXCd;keydown:uYT2Vb;rcuQ6b:npT2md\\" jscontroller=\\"MaEUhd\\" jsshadow=\\"\\"><div class=\\"dEsxWc\\" jsslot=\\"\\"><div class=\\"HYvwY h373nd\\" data-dic=\\"\\" data-g=\\"\\" data-ullb=\\"\\" data-use-legacy-loading-behavior=\\"\\" jsaction=\\"rcuQ6b:npT2md;C0pONd:mhSdVe;A0VnDe:rXa5ib;IKGI6b:VrL1hd\\" jscontroller=\\"aD8OEe\\" jsshadow=\\"\\"><div class=\\"ysxiae iRPzcb\\" jsname=\\"clz4Ic\\"></div><div><div aria-controls=\\"_pm1GZIiSA46iptQP5u-bqAg_49\\" aria-expanded=\\"false\\" class=\\"dnXCYb\\" data-hveid=\\"CDgQAw\\" jsaction=\\"AWEk5c\\" jsname=\\"tJHJj\\" role=\\"button\\" tabindex=\\"0\\"><div class=\\"JlqpRe\\" jsname=\\"lN6iy\\"><span class=\\"JCzEY ZwRhJd\\"><span>Are cockatiels easier than budgies?</span></span></div><div class=\\"aj35ze\\" jsname=\\"Q8Kwad\\"></div><div class=\\"L3Ezfd\\" data-ved=\\"2ahUKEwiI_eu0usL-AhUOkYkEHeb3BoUQzLECegQIOBAE\\" jsname=\\"pcRaIe\\"></div><div class=\\"ru2Kjc\\" data-ved=\\"2ahUKEwiI_eu0usL-AhUOkYkEHeb3BoUQi7gIegQIOBAF\\" jsname=\\"gwzXIc\\"></div></div></div><div class=\\"bCOlv\\" data-ved=\\"2ahUKEwiI_eu0usL-AhUOkYkEHeb3BoUQkLgIegQIOBAG\\" id=\\"_pm1GZIiSA46iptQP5u-bqAg_49\\" jsname=\\"NRdf4c\\"></div></div><div class=\\"HYvwY h373nd\\" data-dic=\\"\\" data-g=\\"\\" data-ullb=\\"\\" data-use-legacy-loading-behavior=\\"\\" jsaction=\\"rcuQ6b:npT2md;C0pONd:mhSdVe;A0VnDe:rXa5ib;IKGI6b:VrL1hd\\" jscontroller=\\"aD8OEe\\" jsshadow=\\"\\"><div class=\\"ysxiae iRPzcb\\" jsname=\\"clz4Ic\\"></div><div><div aria-controls=\\"_pm1GZIiSA46iptQP5u-bqAg_50\\" aria-expanded=\\"false\\" class=\\"dnXCYb\\" data-hveid=\\"CDgQBw\\" jsaction=\\"AWEk5c\\" jsname=\\"tJHJj\\" role=\\"button\\" tabindex=\\"0\\"><div class=\\"JlqpRe\\" jsname=\\"lN6iy\\"><span class=\\"JCzEY ZwRhJd\\"><span>Do cockatiels talk better than budgies?</span></span></div><div class=\\"aj35ze\\" jsname=\\"Q8Kwad\\"></div><div class=\\"L3Ezfd\\" data-ved=\\"2ahUKEwiI_eu0usL-AhUOkYkEHeb3BoUQzLECegQIOBAI\\" jsname=\\"pcRaIe\\"></div><div class=\\"ru2Kjc\\" data-ved=\\"2ahUKEwiI_eu0usL-AhUOkYkEHeb3BoUQi7gIegQIOBAJ\\" jsname=\\"gwzXIc\\"></div></div></div><div class=\\"bCOlv\\" data-ved=\\"2ahUKEwiI_eu0usL-AhUOkYkEHeb3BoUQkLgIegQIOBAK\\" id=\\"_pm1GZIiSA46iptQP5u-bqAg_50\\" jsname=\\"NRdf4c\\"></div></div><div class=\\"iRPzcb\\"></div></div></g-accordion></div></g-expandable-container></div></div></div></div>"}, "title": "Cockatiel vs Budgie - Most Important Differences", "domain": "beautyofbirds.com", "snippet": {}, "position": 4, "serp_header": {"title": "Cockatiel vs Budgie - Most Important Differences", "displayed_link": "https://beautyofbirds.com › Pet Birds", "displayed_name": "Beauty of Birds"}, "post_content": {"toc": [{"id": null, "name": "About Cockatiels and Budgies", "level": "h2"}, {"id": null, "name": "Cockatiel Vs Budgie: Summary of Key Differences", "level": "h2"}, {"id": null, "name": "Behavioral Differences Between Budgies and Cockatiels", "level": "h2"}, {"id": null, "name": "Which one is easier to care for?", "level": "h3"}, {"id": null, "name": "Which one is more energetic?", "level": "h3"}, {"id": null, "name": "Who talks more?", "level": "h3"}, {"id": null, "name": "Who is more affectionate?", "level": "h3"}, {"id": null, "name": "Which one is noisier?", "level": "h3"}, {"id": null, "name": "Which one is smarter – a cockatiel or a budgie?", "level": "h3"}, {"id": null, "name": "Which one is likely to bite you?", "level": "h3"}, {"id": null, "name": "Who is easier to train?", "level": "h3"}, {"id": null, "name": "Physical Differences", "level": "h2"}, {"id": null, "name": "Budgie or cockatiel – which one is bigger in size?", "level": "h3"}, {"id": null, "name": "Who is more colorful?", "level": "h3"}, {"id": null, "name": "Who needs more physical activity?", "level": "h3"}, {"id": null, "name": "Which bird lives longer?", "level": "h3"}, {"id": null, "name": "What food does each bird take?", "level": "h3"}, {"id": null, "name": "Which Is More Expensive: Cockatiels or Budgies?", "level": "h2"}, {"id": null, "name": "Can You Put Cockatiels and Budgies Together?", "level": "h2"}, {"id": null, "name": "So do cockatiels or budgies make better pets?", "level": "h2"}, {"id": null, "name": "Frequently Asked Questions", "level": "h2"}, {"id": null, "name": "Are cockatiels easier than budgies?", "level": "h3"}, {"id": null, "name": "Do cockatiels talk better than budgies?", "level": "h3"}, {"id": null, "name": "Are cockatiels more affectionate than budgies?", "level": "h3"}, {"id": null, "name": "Are cockatiels smarter than budgies?", "level": "h3"}, {"id": null, "name": "Wrap Up", "level": "h2"}], "link": {"count": 19, "details": [{"link": "https://beautyofbirds.com/conure-vs-cockatiel/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/cockatiel-vs-cockatoo/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/why-do-cockatiels-have-mohawks-crest/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/is-a-cockatiel-a-parrot/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/cockatiel-intelligence/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/raising-caring-for-cockatiels/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/how-big-does-a-cockatiel-get/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/do-cockatiels-talk/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/how-much-attention-do-cockatiels-need/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/cockatiel-cage-size-materials/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://petopedia.petscorner.co.uk/cockatiels-small-parakeets/", "domain": "petopedia.petscorner.co.uk", "is_internal": false}, {"link": "https://kidszoo.org/our-animals/cockatiel/", "domain": "kidszoo.org", "is_internal": false}, {"link": "https://www.bushheritage.org.au/species/budgerigars", "domain": "bushheritage.org.au", "is_internal": false}, {"link": "https://beautyofbirds.com/budgie-mutations/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/cockatiel-mutations/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/how-long-do-cockatiels-live-cockatiel-lifespan-as-pets-wild/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-eat-eggs/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/cockatiel-costs/", "domain": "beautyofbirds.com", "is_internal": true}, {"link": "https://beautyofbirds.com/can-cockatiels-live-with-budgies/", "domain": "beautyofbirds.com", "is_internal": true}], "external": 3, "internal": 16}, "blog_title": "Cockatiel vs Budgie – Most Important Differences", "word_count": 2938, "links_count": 19, "images_count": 18, "headings_count": 27, "paragraphs_count": 114, "frequent_keywords": ["birds budgie cockatiel", "companion birds budgie cockatiel", "budgie cockatiel vs", "budgies possess cockatiels", "key differences birds cockatiels", "cockatiel vs budgie affectionate", "behavioral differences budgies cockatiels", "differences birds cockatiels", "cockatiels budgies appear similar", "birds cockatiels budgies related", "cockatiel vs budgie", "physical differences cockatiels budgies", "cockatiel vs budgie similarity", "cockatiel vs budgie cockatiel", "differences cockatiels budgies appear"], "word_count_without_headings": 2783}, "block_position": 4, "meta_description": {"date": "Dec 12, 2022", "html": "<span><em>The Budgie is a more affectionate bird as compared to the</em> Cockatiel. It's also more gentle than the latter, thus reducing the chances of a bite.</span>", "text": "The Budgie is a more affectionate bird as compared to the Cockatiel. It's also more gentle than the latter, thus reducing the chances of a bite.", "highlighted_words": ["The Budgie is a more affectionate bird as compared to the"]}, "about_this_result": null}, {"link": "https://www.psittacology.com/budgie-vs-cockatiel/", "title": "Budgie vs Cockatiel | Find The Bird For You", "domain": "psittacology.com", "snippet": {}, "position": 5, "serp_header": {"title": "Budgie vs Cockatiel | Find The Bird For You", "displayed_link": "https://www.psittacology.com › budgie-vs-cockatiel", "displayed_name": "Psittacology"}, "post_content": {"toc": [{"id": "budgie-vs-cockatiel-similarities", "name": "Budgie vs cockatiel: Similarities", "level": "h2"}, {"id": "budgie-vs-cockatiel-differences", "name": "Budgie vs cockatiel: Differences", "level": "h2"}, {"id": "who-is-a-budgie-better-for", "name": "Who is a budgie better for?", "level": "h2"}, {"id": "who-is-a-cockatiel-better-for", "name": "Who is a cockatiel better for?", "level": "h2"}, {"id": "conclusion", "name": "Conclusion", "level": "h2"}], "link": {"count": 14, "details": [{"link": "#", "domain": "psittacology.com", "is_internal": true}, {"link": "#Budgie_vs_cockatiel_Similarities", "domain": "psittacology.com", "is_internal": true}, {"link": "#Budgie_vs_cockatiel_Differences", "domain": "psittacology.com", "is_internal": true}, {"link": "#Who_is_a_budgie_better_for", "domain": "psittacology.com", "is_internal": true}, {"link": "#Who_is_a_cockatiel_better_for", "domain": "psittacology.com", "is_internal": true}, {"link": "#Conclusion", "domain": "psittacology.com", "is_internal": true}, {"link": "https://www.psittacology.com/how-to-tame-a-parrot/", "domain": "psittacology.com", "is_internal": true}, {"link": "https://www.psittacology.com/can-cockatiels-talk/", "domain": "psittacology.com", "is_internal": true}, {"link": "https://www.sciencedirect.com/science/article/abs/pii/S1055937X9980022X", "domain": "sciencedirect.com", "is_internal": false}, {"link": "https://www.psittacology.com/are-cockatiels-loud/", "domain": "psittacology.com", "is_internal": true}, {"link": "https://www.psittacology.com/cockatiel-vs-cockatoo/", "domain": "psittacology.com", "is_internal": true}, {"link": "https://www.psittacology.com/how-long-does-a-budgie-live/", "domain": "psittacology.com", "is_internal": true}, {"link": "https://www.psittacology.com/how-long-do-cockatiels-live/", "domain": "psittacology.com", "is_internal": true}, {"link": "https://www.psittacology.com/category/parrot-comparisons/", "domain": "psittacology.com", "is_internal": true}], "external": 1, "internal": 13}, "blog_title": null, "word_count": 1287, "links_count": 14, "images_count": 4, "headings_count": 5, "paragraphs_count": 22, "frequent_keywords": ["similarities cockatiels budgies", "budgie vs cockatiel tiels", "similarities budgies cockatiels", "plenty similarities budgies cockatiels", "cockatiels budgies plenty differences", "budgie vs cockatiel want", "similarities cockatiels budgies plenty", "cockatiel differences budgie better", "differences budgie better cockatiel", "cockatiel differences budgie", "cockatiel similarities budgie", "budgie vs cockatiel know", "budgie vs cockatiel", "vs cockatiel differences budgie", "birds budgie vs cockatiel"], "word_count_without_headings": 1215}, "block_position": 5, "meta_description": {"date": "Mar 6, 2023", "html": "<span><em>Cockatiels are louder than budgies</em>, but budgies tend to spend more time making noise. The stream of budgie chatter is pretty constant, ...</span>", "text": "Cockatiels are louder than budgies, but budgies tend to spend more time making noise. The stream of budgie chatter is pretty constant, ...", "highlighted_words": ["Cockatiels are louder than budgies"]}, "about_this_result": null}, {"link": "https://birdsphere.com/parakeet-vs-cockatiel/", "title": "Parakeet vs Cockatiel — Which Is the Better Pet?", "domain": "birdsphere.com", "snippet": {}, "position": 6, "serp_header": {"title": "Parakeet vs Cockatiel — Which Is the Better Pet?", "displayed_link": "https://birdsphere.com › Bird Tips", "displayed_name": "BirdSphere.com"}, "post_content": {"toc": [{"id": null, "name": "Parakeets and Cockatiels as Pets", "level": "h2"}, {"id": null, "name": "So, What’s Different About Parakeets and Cockatiels?", "level": "h2"}, {"id": null, "name": "Size", "level": "h3"}, {"id": null, "name": "Energy Levels", "level": "h3"}, {"id": null, "name": "Talking", "level": "h3"}, {"id": null, "name": "Cuddliness and Affection", "level": "h3"}, {"id": null, "name": "Demands on Your Time", "level": "h3"}, {"id": null, "name": "Longevity", "level": "h3"}, {"id": null, "name": "Allergies and Respiratory Problems", "level": "h3"}, {"id": null, "name": "Common Origins of Parakeets and Cockatiels", "level": "h2"}, {"id": null, "name": "Frequently Asked Questions About Parakeets and Cockatiels", "level": "h2"}], "link": {"count": 39, "details": [{"link": "#", "domain": "birdsphere.com", "is_internal": true}, {"link": "#Parakeets_and_Cockatiels_as_Pets", "domain": "birdsphere.com", "is_internal": true}, {"link": "#So_What%E2%80%99s_Different_About_Parakeets_and_Cockatiels", "domain": "birdsphere.com", "is_internal": true}, {"link": "#Size", "domain": "birdsphere.com", "is_internal": true}, {"link": "#Energy_Levels", "domain": "birdsphere.com", "is_internal": true}, {"link": "#Talking", "domain": "birdsphere.com", "is_internal": true}, {"link": "#Cuddliness_and_Affection", "domain": "birdsphere.com", "is_internal": true}, {"link": "#Demands_on_Your_Time", "domain": "birdsphere.com", "is_internal": true}, {"link": "#Longevity", "domain": "birdsphere.com", "is_internal": true}, {"link": "#Allergies_and_Respiratory_Problems", "domain": "birdsphere.com", "is_internal": true}, {"link": "#Common_Origins_of_Parakeets_and_Cockatiels", "domain": "birdsphere.com", "is_internal": true}, {"link": "#Frequently_Asked_Questions_About_Parakeets_and_Cockatiels", "domain": "birdsphere.com", "is_internal": true}, {"link": "https://birdsphere.com/parakeet-vs-parrotlet/", "domain": "birdsphere.com", "is_internal": true}, {"link": "https://birdsphere.com/can-parakeets-talk/", "domain": "birdsphere.com", "is_internal": true}, {"link": "https://birdsphere.com/parakeet-vs-conure/", "domain": "birdsphere.com", "is_internal": true}, {"link": "https://www.amazon.com/dp/B07T1GZP37?tag=bsphere-20&linkCode=osi&th=1&psc=1", "domain": "amazon.com", "is_internal": false}, {"link": "https://www.amazon.com/dp/B07T1GZP37?tag=bsphere-20&linkCode=osi&th=1&psc=1", "domain": "amazon.com", "is_internal": false}, {"link": "https://www.amazon.com/dp/B08WV4ZP8X?tag=bsphere-20&linkCode=osi&th=1&psc=1", "domain": "amazon.com", "is_internal": false}, {"link": "https://www.amazon.com/dp/B08WV4ZP8X?tag=bsphere-20&linkCode=osi&th=1&psc=1", "domain": "amazon.com", "is_internal": false}, {"link": "https://www.amazon.com/dp/B07PJRKXDW?tag=bsphere-20&linkCode=osi&th=1&psc=1", "domain": "amazon.com", "is_internal": false}, {"link": "https://www.amazon.com/dp/B07PJRKXDW?tag=bsphere-20&linkCode=osi&th=1&psc=1", "domain": "amazon.com", "is_internal": false}, {"link": "https://www.ncbi.nlm.nih.gov/pmc/articles/PMC1240921/", "domain": "ncbi.nlm.nih.gov", "is_internal": false}, {"link": "https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3944875/", "domain": "ncbi.nlm.nih.gov", "is_internal": false}, {"link": "https://birdsphere.com/can-birds-fly-upside-down/", "domain": "birdsphere.com", "is_internal": true}, {"link": "https://birdsphere.com/parakeet-vs-parrotlet/", "domain": "birdsphere.com", "is_internal": true}, {"link": "https://birdsphere.com/parakeet-vs-conure/", "domain": "birdsphere.com", "is_internal": true}, {"link": "https://birdsphere.com/parakeet-vs-lovebird/", "domain": "birdsphere.com", "is_internal": true}, {"link": "https://birdsphere.com/canary-vs-parakeet/", "domain": "birdsphere.com", "is_internal": true}, {"link": "https://birdsphere.com/difference-between-parrot-and-parakeet/", "domain": "birdsphere.com", "is_internal": true}, {"link": "https://birdsphere.com/best-toys-for-parakeets/", "domain": "birdsphere.com", "is_internal": true}, {"link": "https://birdsphere.com/parakeet-vs-lorikeet/", "domain": "birdsphere.com", "is_internal": true}, {"link": "https://birdsphere.com/cockatoos-as-pets/", "domain": "birdsphere.com", "is_internal": true}, {"link": "https://birdsphere.com/cockatiel-behavior/", "domain": "birdsphere.com", "is_internal": true}, {"link": "https://www.amazon.com/dp/B003HHLDAO?tag=bsphere-20&linkCode=osi&th=1&psc=1", "domain": "amazon.com", "is_internal": false}, {"link": "https://www.amazon.com/dp/B003HHLDAO?tag=bsphere-20&linkCode=osi&th=1&psc=1", "domain": "amazon.com", "is_internal": false}, {"link": "https://www.amazon.com/dp/B0BHRGCGJ2?tag=bsphere-20&linkCode=osi&th=1&psc=1", "domain": "amazon.com", "is_internal": false}, {"link": "https://www.amazon.com/dp/B0BHRGCGJ2?tag=bsphere-20&linkCode=osi&th=1&psc=1", "domain": "amazon.com", "is_internal": false}, {"link": "https://www.amazon.com/dp/B072NY4LYZ?tag=bsphere-20&linkCode=osi&th=1&psc=1", "domain": "amazon.com", "is_internal": false}, {"link": "https://www.amazon.com/dp/B072NY4LYZ?tag=bsphere-20&linkCode=osi&th=1&psc=1", "domain": "amazon.com", "is_internal": false}], "external": 14, "internal": 25}, "blog_title": "Parakeet vs Cockatiel — Which Is the Better Pet?", "word_count": 2395, "links_count": 39, "images_count": 12, "headings_count": 12, "paragraphs_count": 102, "frequent_keywords": ["parakeets cockatiels parakeets", "experience parakeets cockatiels", "experience parakeets cockatiels significant", "parakeets cockatiels pet", "parakeet cockatiel parakeets", "parakeets cockatiels significant differences", "different parakeets cockatiels people", "difference parakeet cockatiel better", "parakeet cockatiel better pet", "difference parakeet cockatiel", "pets parakeets cockatiels", "cockatiels pets parakeets cockatiels", "cockatiels parakeets cockatiels pets", "cockatiels petsso different parakeets", "petsso different parakeets cockatiels"], "word_count_without_headings": 2343}, "block_position": 6, "meta_description": {"date": null, "html": "<span>Both <em>parakeets and cockatiels make good apartment pets</em>. Both kinds of birds like to vocalize, but they are not so noisy that they will disturb the neighbors.</span>", "text": "Both parakeets and cockatiels make good apartment pets. Both kinds of birds like to vocalize, but they are not so noisy that they will disturb the neighbors.", "highlighted_words": ["parakeets and cockatiels make good apartment pets"]}, "about_this_result": null}, {"link": "https://petkeen.com/cockatiel-vs-budgie/", "title": "Cockatiel vs. Budgie: What's the Difference?", "domain": "petkeen.com", "snippet": {}, "position": 7, "serp_header": {"title": "Cockatiel vs. Budgie: What's the Difference?", "displayed_link": "https://petkeen.com › Articles", "displayed_name": "Pet Keen"}, "post_content": {"toc": [{"id": null, "name": "Visual Differences", "level": "h2"}, {"id": null, "name": "At a Glance", "level": "h2"}, {"id": null, "name": "Cockatiel Pet Breed Overview", "level": "h2"}, {"id": null, "name": "Health and Care", "level": "h3"}, {"id": null, "name": "Training", "level": "h3"}, {"id": null, "name": "Suitability", "level": "h3"}, {"id": null, "name": "Budgie Pet Breed Overview", "level": "h2"}, {"id": null, "name": "Exercise", "level": "h3"}, {"id": null, "name": "Training", "level": "h3"}, {"id": null, "name": "Suitability", "level": "h3"}, {"id": null, "name": "Which Breed Is Right for You?", "level": "h2"}], "link": {"count": 8, "details": [{"link": "https://petkeen.com/cockatiel/", "domain": "petkeen.com", "is_internal": true}, {"link": "https://www.youtube.com/watch?v=RBh7HWsUd-U", "domain": "youtube.com", "is_internal": false}, {"link": "https://vcahospitals.com/know-your-pet/chlamydophilosis-in-birds#:~:text=Chlamydophilosis%2C%20also%20called%20%22psittacosis%22,referred%20to%20incorrectly%20as%20parakeets.)", "domain": "vcahospitals.com", "is_internal": false}, {"link": "https://www.amazon.com/dp/B0BXFPLRZB?tag=petkeen-20&linkCode=ogi&th=1&psc=1", "domain": "amazon.com", "is_internal": false}, {"link": "https://petkeen.com/blue-cockatiel/", "domain": "petkeen.com", "is_internal": true}, {"link": "https://petkeen.com/best-budgie-toys/", "domain": "petkeen.com", "is_internal": true}, {"link": "https://petkeen.com/types-of-conure-parrots/", "domain": "petkeen.com", "is_internal": true}, {"link": "https://petkeen.com/cost-to-own-cockatiel/", "domain": "petkeen.com", "is_internal": true}], "external": 3, "internal": 5}, "blog_title": "Cockatiel vs. Budgie: What’s the Difference?", "word_count": 1308, "links_count": 8, "images_count": 11, "headings_count": 12, "paragraphs_count": 24, "frequent_keywords": ["cockatiel budgie similarities size", "cockatiel budgie glance", "budgie breed right cockatiel", "cockatiel budgie glance cockatiel", "cockatiel birds", "budgie cockatiel decision bird", "differences budgie cockatiel decision", "budgie glance cockatiel pet", "blue cockatiel budgie pet", "cockatiel budgie pet breed", "just differences cockatiel budgie", "cockatiels budgies cute", "differences cockatiel budgie similarities", "understanding differences budgie cockatiel", "cockatiels budgies cute birds"], "word_count_without_headings": 1230}, "block_position": 7, "meta_description": {"date": "Mar 20, 2023", "html": "<span>In general, <em>cockatiels are larger and longer than budgies</em>, although both types of birds are on the smaller side in the parrot kingdom.</span>", "text": "In general, cockatiels are larger and longer than budgies, although both types of birds are on the smaller side in the parrot kingdom.", "highlighted_words": ["cockatiels are larger and longer than budgies"]}, "about_this_result": null}, {"link": "https://cockatielreview.com/cockatiel-vs-budgie/", "title": "Cockatiel vs Budgie: What is the Best Pet Bird for Me?", "domain": "cockatielreview.com", "snippet": {}, "position": 8, "serp_header": {"title": "Cockatiel vs Budgie: What is the Best Pet Bird for Me?", "displayed_link": "https://cockatielreview.com › cockatiel-vs-budgie", "displayed_name": "cockatielreview.com"}, "post_content": {"toc": [{"id": null, "name": "Cockatiel vs Budgie: General information", "level": "h2"}, {"id": null, "name": "Communicative skills", "level": "h3"}, {"id": null, "name": "Accommodation", "level": "h3"}, {"id": null, "name": "Companionship", "level": "h3"}, {"id": null, "name": "What are the best birds for kids?", "level": "h3"}, {"id": null, "name": "Video: cockatiel and budgies how they communicate together", "level": "h3"}], "link": {"count": 9, "details": [{"link": "https://en.wikipedia.org/wiki/Budgerigar#Relationship_with_humans", "domain": "en.wikipedia.org", "is_internal": false}, {"link": "https://cockatielreview.com/best-budgie-cage/", "domain": "cockatielreview.com", "is_internal": true}, {"link": "https://en.wikipedia.org/wiki/Cockatiel#Description", "domain": "en.wikipedia.org", "is_internal": false}, {"link": "https://cockatielreview.com/", "domain": "cockatielreview.com", "is_internal": true}, {"link": "https://cockatielreview.com/best-food-cockatiels/", "domain": "cockatielreview.com", "is_internal": true}, {"link": "https://cockatielreview.com/", "domain": "cockatielreview.com", "is_internal": true}, {"link": "https://cockatielreview.com/best-toys-for-cockatiels/", "domain": "cockatielreview.com", "is_internal": true}, {"link": "https://cockatielreview.com/best-budgie-cage/", "domain": "cockatielreview.com", "is_internal": true}, {"link": "https://cockatielreview.com/do-cockatiels-make-good-pets/", "domain": "cockatielreview.com", "is_internal": true}], "external": 2, "internal": 7}, "blog_title": "Cockatiel vs Budgie: What is the Best Pet Bird for Me?", "word_count": 1194, "links_count": 9, "images_count": 10, "headings_count": 7, "paragraphs_count": 20, "frequent_keywords": ["budgies does cockatiel", "cockatiel vs budgie general", "cockatiels budgies usually", "budgie right beginners cockatiel", "cockatiels parakeets", "companionship budgies cockatiels", "going compare cockatiels budgies", "species choose cockatiels parakeets", "cockatiel vs budgie right", "compare cockatiels budgies help", "choose cockatiels parakeets known", "ideal cockatiel vs budgie", "choose cockatiels parakeets", "cockatiels parakeets known budgies", "beginners cockatiel vs budgie"], "word_count_without_headings": 1134}, "block_position": 8, "meta_description": {"date": null, "html": "<span><em>Cockatiels are generally larger than budgies</em>. An average grown-up cockatiel measures 12-13 inches. As a true member of a cockatoo family, the cockatiel has a ...</span>", "text": "Cockatiels are generally larger than budgies. An average grown-up cockatiel measures 12-13 inches. As a true member of a cockatoo family, the cockatiel has a ...", "highlighted_words": ["Cockatiels are generally larger than budgies"]}, "about_this_result": null}]	"[{\\"question\\": \\"Are cockatiels more cuddly than budgies?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Are parakeets or cockatiels louder?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Is it easier to tame a budgie or cockatiel?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 2}, {\\"question\\": \\"Is A cockatiel a good first bird?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"cockatiel vs cockatoo\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 13}, {\\"question\\": \\"cockatiel and budgie hybrid\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 13}, {\\"question\\": \\"cockatiel vs lovebird\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 13}, {\\"question\\": \\"budgie vs parakeet\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 13}, {\\"question\\": \\"cockatiel vs conure\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 13}, {\\"question\\": \\"monk parakeet vs cockatiel\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 13}, {\\"question\\": \\"parakeet and cockatiel food\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 13}, {\\"question\\": \\"parakeet vs parrot\\", \\"type\\": \\"Related\\", \\"visible_in_serps\\": 13}, {\\"question\\": \\"What is the most cuddly pet bird?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Do cockatiels like to snuggle?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Are cockatiels very loud?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What makes a better pet a parakeet or a cockatiel?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Do parakeets or cockatiels talk more?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Are parakeets very loud?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Are cockatiels easier to tame than budgies?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What is the easiest pet bird to tame?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What is the hardest bird to tame?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Are cockatiels good for beginners?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Is it better to have 1 or 2 cockatiels?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What is the disadvantage of cockatiel?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What is the best age to get a cockatiel?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Which is better cockatiel or cockatoo?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Is there a difference between a cockatoo and a cockatiel?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Are cockatoos smarter than cockatiels?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What is the friendliest cockatoo?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Can cockatiels mate with budgies?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Can you mix cockatiel with parakeet?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Can cockatiels be paired with other birds?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Can you breed a love bird with a budgie?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Can I mix birds with budgie?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Is a cockatiel smarter than a lovebird?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What is the difference between a cockatiel and a lovebird?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Can cockatiel and lovebird live together?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Are cockatiels or budgies more friendly?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Is a budgie and a parakeet the same thing?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Can budgies speak?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Why do Americans call budgies parakeet?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Are 2 parakeets better than 1?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Are cockatiels easier than conures?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What is the friendliest conure?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Are green cheek conures louder than cockatiels?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Are green cheek conures smaller than cockatiels?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Are Quakers good beginner birds?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Which is the best cocktail bird?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Why are Monk Parakeets illegal?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Are Monk Parakeets friendly?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Can parakeets eat cockatiel bird food?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What can cockatiels and parakeets eat?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"What food to give budgies and cockatiels?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Can Quaker parrots eat cockatiel food?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Do parrots or parakeets talk?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Are parakeets small parrots?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Do parakeets come from parrots?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}, {\\"question\\": \\"Why are budgies called parakeets?\\", \\"type\\": \\"PPA\\", \\"visible_in_serps\\": 1}]"	2023-04-24 11:54:32.154403+00	df5c9c28-0a0e-4157-b7ba-fb3d5caf2a67
\.


--
-- Data for Name: keywordresearch_suggestion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keywordresearch_suggestion (_id, parent_keyword, search_query, created_at, status, project_id) FROM stdin;
1bc5d219-637a-459f-8e7c-0fc4c0fdfef8	baby cockatiel won't eat	baby cockatiel won't eat	2023-04-19 04:35:22.16329+00	ANALYZED	41fee383-6cac-4790-8828-4a7cdfa5f902
589301a6-98d9-445b-b3c5-977708ad6112	tips for cycling in the rain	tips for road cycling in the rain	2023-04-19 04:05:59.098316+00	ANALYZED	41fee383-6cac-4790-8828-4a7cdfa5f902
8880102b-2871-43a1-9f4d-8381554f9c72	tips for cycling in the rain	tips for cycling in the rain	2023-04-19 04:06:00.569458+00	ANALYZED	41fee383-6cac-4790-8828-4a7cdfa5f902
9bf02150-a4d1-44d7-8696-6dfe58a96829	cockatiel won't	cockatiel won&#39;t stop screaming	2023-04-21 22:04:52.29046+00	ANALYZED	41fee383-6cac-4790-8828-4a7cdfa5f902
4c425af7-44e0-4c83-9e31-b68d802bf8d1	Cockatiel	cockatiel food	2023-04-24 10:56:45.005339+00	ANALYZED	41fee383-6cac-4790-8828-4a7cdfa5f902
df5c9c28-0a0e-4157-b7ba-fb3d5caf2a67	cockatiel vs par	cockatiel vs parakeet	2023-04-24 11:52:19.934447+00	ANALYZED	41fee383-6cac-4790-8828-4a7cdfa5f902
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 76, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 1, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: content_generation_skill_tags_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.content_generation_skill_tags_id_seq', 127, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, true);


--
-- Name: django_celery_results_chordcounter_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_celery_results_chordcounter_id_seq', 1, false);


--
-- Name: django_celery_results_groupresult_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_celery_results_groupresult_id_seq', 1, false);


--
-- Name: django_celery_results_taskresult_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_celery_results_taskresult_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 19, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 45, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: content_generation_document content_generation_document_name_3f4cf897_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_generation_document
    ADD CONSTRAINT content_generation_document_name_3f4cf897_uniq UNIQUE (name);


--
-- Name: content_generation_document content_generation_document_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_generation_document
    ADD CONSTRAINT content_generation_document_pkey PRIMARY KEY (_id);


--
-- Name: content_generation_output content_generation_output_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_generation_output
    ADD CONSTRAINT content_generation_output_pkey PRIMARY KEY (_id);


--
-- Name: content_generation_project content_generation_project_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_generation_project
    ADD CONSTRAINT content_generation_project_name_key UNIQUE (name);


--
-- Name: content_generation_project content_generation_project_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_generation_project
    ADD CONSTRAINT content_generation_project_pkey PRIMARY KEY (_id);


--
-- Name: content_generation_prompt content_generation_prompt_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_generation_prompt
    ADD CONSTRAINT content_generation_prompt_pkey PRIMARY KEY (_id);


--
-- Name: content_generation_prompt content_generation_prompt_skill_id_dd7a9966_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_generation_prompt
    ADD CONSTRAINT content_generation_prompt_skill_id_dd7a9966_uniq UNIQUE (skill_id);


--
-- Name: content_generation_recipe content_generation_recipe_name_7e12e318_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_generation_recipe
    ADD CONSTRAINT content_generation_recipe_name_7e12e318_uniq UNIQUE (name);


--
-- Name: content_generation_recipe content_generation_recipe_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_generation_recipe
    ADD CONSTRAINT content_generation_recipe_pkey PRIMARY KEY (_id);


--
-- Name: content_generation_skill content_generation_skill_name_c6b78988_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_generation_skill
    ADD CONSTRAINT content_generation_skill_name_c6b78988_uniq UNIQUE (name);


--
-- Name: content_generation_skill content_generation_skill_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_generation_skill
    ADD CONSTRAINT content_generation_skill_pkey PRIMARY KEY (_id);


--
-- Name: content_generation_skill_tags content_generation_skill_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_generation_skill_tags
    ADD CONSTRAINT content_generation_skill_tags_pkey PRIMARY KEY (id);


--
-- Name: content_generation_skill_tags content_generation_skill_tags_skill_id_tag_id_3b3aa5af_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_generation_skill_tags
    ADD CONSTRAINT content_generation_skill_tags_skill_id_tag_id_3b3aa5af_uniq UNIQUE (skill_id, tag_id);


--
-- Name: content_generation_tag content_generation_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_generation_tag
    ADD CONSTRAINT content_generation_tag_pkey PRIMARY KEY (_id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_celery_results_chordcounter django_celery_results_chordcounter_group_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_celery_results_chordcounter
    ADD CONSTRAINT django_celery_results_chordcounter_group_id_key UNIQUE (group_id);


--
-- Name: django_celery_results_chordcounter django_celery_results_chordcounter_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_celery_results_chordcounter
    ADD CONSTRAINT django_celery_results_chordcounter_pkey PRIMARY KEY (id);


--
-- Name: django_celery_results_groupresult django_celery_results_groupresult_group_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_celery_results_groupresult
    ADD CONSTRAINT django_celery_results_groupresult_group_id_key UNIQUE (group_id);


--
-- Name: django_celery_results_groupresult django_celery_results_groupresult_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_celery_results_groupresult
    ADD CONSTRAINT django_celery_results_groupresult_pkey PRIMARY KEY (id);


--
-- Name: django_celery_results_taskresult django_celery_results_taskresult_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_celery_results_taskresult
    ADD CONSTRAINT django_celery_results_taskresult_pkey PRIMARY KEY (id);


--
-- Name: django_celery_results_taskresult django_celery_results_taskresult_task_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_celery_results_taskresult
    ADD CONSTRAINT django_celery_results_taskresult_task_id_key UNIQUE (task_id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: keywordresearch_article keywordresearch_article_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keywordresearch_article
    ADD CONSTRAINT keywordresearch_article_pkey PRIMARY KEY (_id);


--
-- Name: keywordresearch_search keywordresearch_search_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keywordresearch_search
    ADD CONSTRAINT keywordresearch_search_pkey PRIMARY KEY (_id);


--
-- Name: keywordresearch_suggestion keywordresearch_suggestion_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keywordresearch_suggestion
    ADD CONSTRAINT keywordresearch_suggestion_pkey PRIMARY KEY (_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: content_generation_document_name_3f4cf897_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX content_generation_document_name_3f4cf897_like ON public.content_generation_document USING btree (name varchar_pattern_ops);


--
-- Name: content_generation_document_project_id_ef6b89ac; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX content_generation_document_project_id_ef6b89ac ON public.content_generation_document USING btree (project_id);


--
-- Name: content_generation_document_suggestion_id_da7e305a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX content_generation_document_suggestion_id_da7e305a ON public.content_generation_document USING btree (suggestion_id);


--
-- Name: content_generation_output_skill_id_id_f642ea64; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX content_generation_output_skill_id_id_f642ea64 ON public.content_generation_output USING btree (skill_id);


--
-- Name: content_generation_project_name_fbc61be2_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX content_generation_project_name_fbc61be2_like ON public.content_generation_project USING btree (name varchar_pattern_ops);


--
-- Name: content_generation_recipe_name_7e12e318_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX content_generation_recipe_name_7e12e318_like ON public.content_generation_recipe USING btree (name text_pattern_ops);


--
-- Name: content_generation_skill_name_c6b78988_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX content_generation_skill_name_c6b78988_like ON public.content_generation_skill USING btree (name varchar_pattern_ops);


--
-- Name: content_generation_skill_tags_skill_id_60b4d98d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX content_generation_skill_tags_skill_id_60b4d98d ON public.content_generation_skill_tags USING btree (skill_id);


--
-- Name: content_generation_skill_tags_tag_id_f4812c8b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX content_generation_skill_tags_tag_id_f4812c8b ON public.content_generation_skill_tags USING btree (tag_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_cele_date_cr_bd6c1d_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_cele_date_cr_bd6c1d_idx ON public.django_celery_results_groupresult USING btree (date_created);


--
-- Name: django_cele_date_cr_f04a50_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_cele_date_cr_f04a50_idx ON public.django_celery_results_taskresult USING btree (date_created);


--
-- Name: django_cele_date_do_caae0e_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_cele_date_do_caae0e_idx ON public.django_celery_results_groupresult USING btree (date_done);


--
-- Name: django_cele_date_do_f59aad_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_cele_date_do_f59aad_idx ON public.django_celery_results_taskresult USING btree (date_done);


--
-- Name: django_cele_status_9b6201_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_cele_status_9b6201_idx ON public.django_celery_results_taskresult USING btree (status);


--
-- Name: django_cele_task_na_08aec9_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_cele_task_na_08aec9_idx ON public.django_celery_results_taskresult USING btree (task_name);


--
-- Name: django_cele_worker_d54dd8_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_cele_worker_d54dd8_idx ON public.django_celery_results_taskresult USING btree (worker);


--
-- Name: django_celery_results_chordcounter_group_id_1f70858c_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_celery_results_chordcounter_group_id_1f70858c_like ON public.django_celery_results_chordcounter USING btree (group_id varchar_pattern_ops);


--
-- Name: django_celery_results_groupresult_group_id_a085f1a9_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_celery_results_groupresult_group_id_a085f1a9_like ON public.django_celery_results_groupresult USING btree (group_id varchar_pattern_ops);


--
-- Name: django_celery_results_taskresult_task_id_de0d95bf_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_celery_results_taskresult_task_id_de0d95bf_like ON public.django_celery_results_taskresult USING btree (task_id varchar_pattern_ops);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: keywordresearch_article_related_search_id_id_de771726; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX keywordresearch_article_related_search_id_id_de771726 ON public.keywordresearch_article USING btree (related_search_id_id);


--
-- Name: keywordresearch_search_related_suggestion_id_id_750b75bd; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX keywordresearch_search_related_suggestion_id_id_750b75bd ON public.keywordresearch_search USING btree (related_suggestion_id_id);


--
-- Name: keywordresearch_suggestion_project_id_3a5b6471; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX keywordresearch_suggestion_project_id_3a5b6471 ON public.keywordresearch_suggestion USING btree (project_id);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: content_generation_document content_generation_d_project_id_ef6b89ac_fk_content_g; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_generation_document
    ADD CONSTRAINT content_generation_d_project_id_ef6b89ac_fk_content_g FOREIGN KEY (project_id) REFERENCES public.content_generation_project(_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: content_generation_document content_generation_d_suggestion_id_da7e305a_fk_keywordre; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_generation_document
    ADD CONSTRAINT content_generation_d_suggestion_id_da7e305a_fk_keywordre FOREIGN KEY (suggestion_id) REFERENCES public.keywordresearch_suggestion(_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: content_generation_output content_generation_o_skill_id_1ec00fc5_fk_content_g; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_generation_output
    ADD CONSTRAINT content_generation_o_skill_id_1ec00fc5_fk_content_g FOREIGN KEY (skill_id) REFERENCES public.content_generation_skill(_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: content_generation_prompt content_generation_p_skill_id_dd7a9966_fk_content_g; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_generation_prompt
    ADD CONSTRAINT content_generation_p_skill_id_dd7a9966_fk_content_g FOREIGN KEY (skill_id) REFERENCES public.content_generation_skill(_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: content_generation_skill_tags content_generation_s_skill_id_60b4d98d_fk_content_g; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_generation_skill_tags
    ADD CONSTRAINT content_generation_s_skill_id_60b4d98d_fk_content_g FOREIGN KEY (skill_id) REFERENCES public.content_generation_skill(_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: content_generation_skill_tags content_generation_s_tag_id_f4812c8b_fk_content_g; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.content_generation_skill_tags
    ADD CONSTRAINT content_generation_s_tag_id_f4812c8b_fk_content_g FOREIGN KEY (tag_id) REFERENCES public.content_generation_tag(_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: keywordresearch_article keywordresearch_arti_related_search_id_id_de771726_fk_keywordre; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keywordresearch_article
    ADD CONSTRAINT keywordresearch_arti_related_search_id_id_de771726_fk_keywordre FOREIGN KEY (related_search_id_id) REFERENCES public.keywordresearch_search(_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: keywordresearch_search keywordresearch_sear_related_suggestion_i_750b75bd_fk_keywordre; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keywordresearch_search
    ADD CONSTRAINT keywordresearch_sear_related_suggestion_i_750b75bd_fk_keywordre FOREIGN KEY (related_suggestion_id_id) REFERENCES public.keywordresearch_suggestion(_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: keywordresearch_suggestion keywordresearch_sugg_project_id_3a5b6471_fk_content_g; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keywordresearch_suggestion
    ADD CONSTRAINT keywordresearch_sugg_project_id_3a5b6471_fk_content_g FOREIGN KEY (project_id) REFERENCES public.content_generation_project(_id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

