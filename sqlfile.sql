--
-- PostgreSQL database dump
--

-- Dumped from database version 12.6
-- Dumped by pg_dump version 13.2

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
-- Name: game_images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game_images (
    game_id integer NOT NULL,
    image character varying(255)
);


ALTER TABLE public.game_images OWNER TO postgres;

--
-- Name: game_reward_images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game_reward_images (
    game_reward_id integer NOT NULL,
    image character varying(255)
);


ALTER TABLE public.game_reward_images OWNER TO postgres;

--
-- Name: game_rewards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game_rewards (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    body text,
    available_prices integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.game_rewards OWNER TO postgres;

--
-- Name: game_rewards_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.game_rewards_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.game_rewards_id_seq OWNER TO postgres;

--
-- Name: game_rewards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.game_rewards_id_seq OWNED BY public.game_rewards.id;


--
-- Name: games; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.games (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    body text,
    daily_prices integer DEFAULT 0 NOT NULL,
    winning_chance integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.games OWNER TO postgres;

--
-- Name: games_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.games_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_id_seq OWNER TO postgres;

--
-- Name: games_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.games_id_seq OWNED BY public.games.id;


--
-- Name: games_rewards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.games_rewards (
    game_id integer NOT NULL,
    game_reward_id integer NOT NULL
);


ALTER TABLE public.games_rewards OWNER TO postgres;

--
-- Name: played_games; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.played_games (
    has_won boolean NOT NULL,
    player_id integer NOT NULL,
    game_id integer NOT NULL,
    game_reward_id integer NOT NULL,
    created timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.played_games OWNER TO postgres;

--
-- Name: game_rewards id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_rewards ALTER COLUMN id SET DEFAULT nextval('public.game_rewards_id_seq'::regclass);


--
-- Name: games id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games ALTER COLUMN id SET DEFAULT nextval('public.games_id_seq'::regclass);


--
-- Data for Name: game_images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.game_images (game_id, image) FROM stdin;
1	https://cataas.com/cat
1	https://cataas.com/cat
2	https://cataas.com/cat
2	https://cataas.com/cat
3	https://cataas.com/cat
3	https://cataas.com/cat
\.


--
-- Data for Name: game_reward_images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.game_reward_images (game_reward_id, image) FROM stdin;
1	https://cataas.com/cat
1	https://cataas.com/cat
2	https://cataas.com/cat
3	https://cataas.com/cat
\.


--
-- Data for Name: game_rewards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.game_rewards (id, title, body, available_prices) FROM stdin;
1	prices title	price body text	132
2	prices title	price body text	100
3	prices title	price body text	50
\.


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.games (id, title, body, daily_prices, winning_chance) FROM stdin;
1	8ball	body thingyfdjvcd	100	5
2	8ball	body thingyfdjvcd	100	5
3	8ball	body thingyfdjvcd	100	5
\.


--
-- Data for Name: games_rewards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.games_rewards (game_id, game_reward_id) FROM stdin;
1	1
1	2
1	3
2	3
3	2
\.


--
-- Data for Name: played_games; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.played_games (has_won, player_id, game_id, game_reward_id, created) FROM stdin;
\.


--
-- Name: game_rewards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.game_rewards_id_seq', 3, true);


--
-- Name: games_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.games_id_seq', 3, true);


--
-- Name: game_rewards game_rewards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_rewards
    ADD CONSTRAINT game_rewards_pkey PRIMARY KEY (id);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (id);


--
-- Name: game_images game_images_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_images
    ADD CONSTRAINT game_images_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(id);


--
-- Name: game_reward_images game_reward_images_game_reward_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_reward_images
    ADD CONSTRAINT game_reward_images_game_reward_id_fkey FOREIGN KEY (game_reward_id) REFERENCES public.game_rewards(id);


--
-- Name: games_rewards games_rewards_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_rewards
    ADD CONSTRAINT games_rewards_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(id);


--
-- Name: games_rewards games_rewards_game_reward_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_rewards
    ADD CONSTRAINT games_rewards_game_reward_id_fkey FOREIGN KEY (game_reward_id) REFERENCES public.game_rewards(id);


--
-- Name: played_games played_games_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.played_games
    ADD CONSTRAINT played_games_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(id);


--
-- Name: played_games played_games_game_reward_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.played_games
    ADD CONSTRAINT played_games_game_reward_id_fkey FOREIGN KEY (game_reward_id) REFERENCES public.game_rewards(id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.6
-- Dumped by pg_dump version 13.2

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
-- Name: game_images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game_images (
    game_id integer NOT NULL,
    image character varying(255)
);


ALTER TABLE public.game_images OWNER TO postgres;

--
-- Name: game_reward_images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game_reward_images (
    game_reward_id integer NOT NULL,
    image character varying(255)
);


ALTER TABLE public.game_reward_images OWNER TO postgres;

--
-- Name: game_rewards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game_rewards (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    body text,
    available_prices integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.game_rewards OWNER TO postgres;

--
-- Name: game_rewards_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.game_rewards_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.game_rewards_id_seq OWNER TO postgres;

--
-- Name: game_rewards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.game_rewards_id_seq OWNED BY public.game_rewards.id;


--
-- Name: games; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.games (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    body text,
    daily_prices integer DEFAULT 0 NOT NULL,
    winning_chance integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.games OWNER TO postgres;

--
-- Name: games_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.games_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_id_seq OWNER TO postgres;

--
-- Name: games_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.games_id_seq OWNED BY public.games.id;


--
-- Name: games_rewards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.games_rewards (
    game_id integer NOT NULL,
    game_reward_id integer NOT NULL
);


ALTER TABLE public.games_rewards OWNER TO postgres;

--
-- Name: played_games; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.played_games (
    has_won boolean NOT NULL,
    player_id integer NOT NULL,
    game_id integer NOT NULL,
    game_reward_id integer NOT NULL,
    created timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.played_games OWNER TO postgres;

--
-- Name: game_rewards id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_rewards ALTER COLUMN id SET DEFAULT nextval('public.game_rewards_id_seq'::regclass);


--
-- Name: games id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games ALTER COLUMN id SET DEFAULT nextval('public.games_id_seq'::regclass);


--
-- Data for Name: game_images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.game_images (game_id, image) FROM stdin;
1	https://cataas.com/cat
1	https://cataas.com/cat
2	https://cataas.com/cat
2	https://cataas.com/cat
3	https://cataas.com/cat
3	https://cataas.com/cat
\.


--
-- Data for Name: game_reward_images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.game_reward_images (game_reward_id, image) FROM stdin;
1	https://cataas.com/cat
1	https://cataas.com/cat
2	https://cataas.com/cat
3	https://cataas.com/cat
\.


--
-- Data for Name: game_rewards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.game_rewards (id, title, body, available_prices) FROM stdin;
1	prices title	price body text	132
2	prices title	price body text	100
3	prices title	price body text	50
\.


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.games (id, title, body, daily_prices, winning_chance) FROM stdin;
1	8ball	body thingyfdjvcd	100	5
2	8ball	body thingyfdjvcd	100	5
3	8ball	body thingyfdjvcd	100	5
\.


--
-- Data for Name: games_rewards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.games_rewards (game_id, game_reward_id) FROM stdin;
1	1
1	2
1	3
2	3
3	2
\.


--
-- Data for Name: played_games; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.played_games (has_won, player_id, game_id, game_reward_id, created) FROM stdin;
\.


--
-- Name: game_rewards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.game_rewards_id_seq', 3, true);


--
-- Name: games_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.games_id_seq', 3, true);


--
-- Name: game_rewards game_rewards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_rewards
    ADD CONSTRAINT game_rewards_pkey PRIMARY KEY (id);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (id);


--
-- Name: game_images game_images_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_images
    ADD CONSTRAINT game_images_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(id);


--
-- Name: game_reward_images game_reward_images_game_reward_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_reward_images
    ADD CONSTRAINT game_reward_images_game_reward_id_fkey FOREIGN KEY (game_reward_id) REFERENCES public.game_rewards(id);


--
-- Name: games_rewards games_rewards_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_rewards
    ADD CONSTRAINT games_rewards_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(id);


--
-- Name: games_rewards games_rewards_game_reward_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_rewards
    ADD CONSTRAINT games_rewards_game_reward_id_fkey FOREIGN KEY (game_reward_id) REFERENCES public.game_rewards(id);


--
-- Name: played_games played_games_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.played_games
    ADD CONSTRAINT played_games_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(id);


--
-- Name: played_games played_games_game_reward_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.played_games
    ADD CONSTRAINT played_games_game_reward_id_fkey FOREIGN KEY (game_reward_id) REFERENCES public.game_rewards(id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.6
-- Dumped by pg_dump version 13.2

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
-- Name: game_images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game_images (
    game_id integer NOT NULL,
    image character varying(255)
);


ALTER TABLE public.game_images OWNER TO postgres;

--
-- Name: game_reward_images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game_reward_images (
    game_reward_id integer NOT NULL,
    image character varying(255)
);


ALTER TABLE public.game_reward_images OWNER TO postgres;

--
-- Name: game_rewards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game_rewards (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    body text,
    available_prices integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.game_rewards OWNER TO postgres;

--
-- Name: game_rewards_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.game_rewards_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.game_rewards_id_seq OWNER TO postgres;

--
-- Name: game_rewards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.game_rewards_id_seq OWNED BY public.game_rewards.id;


--
-- Name: games; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.games (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    body text,
    daily_prices integer DEFAULT 0 NOT NULL,
    winning_chance integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.games OWNER TO postgres;

--
-- Name: games_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.games_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_id_seq OWNER TO postgres;

--
-- Name: games_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.games_id_seq OWNED BY public.games.id;


--
-- Name: games_rewards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.games_rewards (
    game_id integer NOT NULL,
    game_reward_id integer NOT NULL
);


ALTER TABLE public.games_rewards OWNER TO postgres;

--
-- Name: played_games; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.played_games (
    has_won boolean NOT NULL,
    player_id integer NOT NULL,
    game_id integer NOT NULL,
    game_reward_id integer NOT NULL,
    created timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.played_games OWNER TO postgres;

--
-- Name: game_rewards id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_rewards ALTER COLUMN id SET DEFAULT nextval('public.game_rewards_id_seq'::regclass);


--
-- Name: games id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games ALTER COLUMN id SET DEFAULT nextval('public.games_id_seq'::regclass);


--
-- Data for Name: game_images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.game_images (game_id, image) FROM stdin;
1	https://cataas.com/cat
1	https://cataas.com/cat
2	https://cataas.com/cat
2	https://cataas.com/cat
3	https://cataas.com/cat
3	https://cataas.com/cat
\.


--
-- Data for Name: game_reward_images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.game_reward_images (game_reward_id, image) FROM stdin;
1	https://cataas.com/cat
1	https://cataas.com/cat
2	https://cataas.com/cat
3	https://cataas.com/cat
\.


--
-- Data for Name: game_rewards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.game_rewards (id, title, body, available_prices) FROM stdin;
2	prices title	price body text	96
1	prices title	price body text	130
3	prices title	price body text	47
\.


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.games (id, title, body, daily_prices, winning_chance) FROM stdin;
1	8ball	body thingyfdjvcd	100	5
2	8ball	body thingyfdjvcd	100	5
3	8ball	body thingyfdjvcd	100	5
\.


--
-- Data for Name: games_rewards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.games_rewards (game_id, game_reward_id) FROM stdin;
3	2
1	1
1	2
1	3
\.


--
-- Data for Name: played_games; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.played_games (has_won, player_id, game_id, game_reward_id, created) FROM stdin;
t	23284323	1	1	2021-02-26 12:32:09.983161
f	23284323	1	2	2021-02-26 12:32:15.127669
t	23284323	1	2	2021-02-26 12:32:17.489225
t	23284323	1	2	2021-02-26 12:32:52.535416
f	23284323	1	3	2021-02-26 12:32:53.837001
t	23284323	1	2	2021-02-26 12:32:55.960352
t	23284323	1	2	2021-02-26 12:32:57.396185
t	23284323	1	1	2021-02-26 12:32:58.514949
f	23284323	1	3	2021-02-26 12:33:00.557303
t	23284323	1	3	2021-02-26 12:33:02.165924
\.


--
-- Name: game_rewards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.game_rewards_id_seq', 3, true);


--
-- Name: games_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.games_id_seq', 3, true);


--
-- Name: game_rewards game_rewards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_rewards
    ADD CONSTRAINT game_rewards_pkey PRIMARY KEY (id);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (id);


--
-- Name: game_images game_images_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_images
    ADD CONSTRAINT game_images_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(id);


--
-- Name: game_reward_images game_reward_images_game_reward_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_reward_images
    ADD CONSTRAINT game_reward_images_game_reward_id_fkey FOREIGN KEY (game_reward_id) REFERENCES public.game_rewards(id);


--
-- Name: games_rewards games_rewards_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_rewards
    ADD CONSTRAINT games_rewards_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(id);


--
-- Name: games_rewards games_rewards_game_reward_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_rewards
    ADD CONSTRAINT games_rewards_game_reward_id_fkey FOREIGN KEY (game_reward_id) REFERENCES public.game_rewards(id);


--
-- Name: played_games played_games_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.played_games
    ADD CONSTRAINT played_games_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(id);


--
-- Name: played_games played_games_game_reward_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.played_games
    ADD CONSTRAINT played_games_game_reward_id_fkey FOREIGN KEY (game_reward_id) REFERENCES public.game_rewards(id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 12.6
-- Dumped by pg_dump version 13.2

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
-- Name: game_images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game_images (
    game_id integer NOT NULL,
    image character varying(255)
);


ALTER TABLE public.game_images OWNER TO postgres;

--
-- Name: game_reward_images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game_reward_images (
    game_reward_id integer NOT NULL,
    image character varying(255)
);


ALTER TABLE public.game_reward_images OWNER TO postgres;

--
-- Name: game_rewards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game_rewards (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    body text,
    available_prices integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.game_rewards OWNER TO postgres;

--
-- Name: game_rewards_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.game_rewards_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.game_rewards_id_seq OWNER TO postgres;

--
-- Name: game_rewards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.game_rewards_id_seq OWNED BY public.game_rewards.id;


--
-- Name: games; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.games (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    body text,
    daily_prices integer DEFAULT 0 NOT NULL,
    winning_chance integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.games OWNER TO postgres;

--
-- Name: games_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.games_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_id_seq OWNER TO postgres;

--
-- Name: games_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.games_id_seq OWNED BY public.games.id;


--
-- Name: games_rewards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.games_rewards (
    game_id integer NOT NULL,
    game_reward_id integer NOT NULL
);


ALTER TABLE public.games_rewards OWNER TO postgres;

--
-- Name: played_games; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.played_games (
    has_won boolean NOT NULL,
    player_id text NOT NULL,
    game_id integer NOT NULL,
    game_reward_id integer NOT NULL,
    created timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.played_games OWNER TO postgres;

--
-- Name: game_rewards id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_rewards ALTER COLUMN id SET DEFAULT nextval('public.game_rewards_id_seq'::regclass);


--
-- Name: games id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games ALTER COLUMN id SET DEFAULT nextval('public.games_id_seq'::regclass);


--
-- Data for Name: game_images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.game_images (game_id, image) FROM stdin;
1	https://cataas.com/cat
1	https://cataas.com/cat
2	https://cataas.com/cat
2	https://cataas.com/cat
3	https://cataas.com/cat
3	https://cataas.com/cat
4	https://cataas.com/cat
4	https://cataas.com/cat
\.


--
-- Data for Name: game_reward_images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.game_reward_images (game_reward_id, image) FROM stdin;
1	https://cataas.com/cat
1	https://cataas.com/cat
2	https://cataas.com/cat
3	https://cataas.com/cat
\.


--
-- Data for Name: game_rewards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.game_rewards (id, title, body, available_prices) FROM stdin;
1	prices title	price body text	54
2	prices title	price body text	25
3	prices title	price body text	0
\.


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.games (id, title, body, daily_prices, winning_chance) FROM stdin;
1	8ball	body thingyfdjvcd	100	5
2	8ball	body thingyfdjvcd	100	5
3	8ball	body thingyfdjvcd	100	5
4	nfjdnf	body thingyfdjvcd	100	5
\.


--
-- Data for Name: games_rewards; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.games_rewards (game_id, game_reward_id) FROM stdin;
3	2
1	1
1	2
1	3
2	3
2	2
2	1
\.


--
-- Data for Name: played_games; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.played_games (has_won, player_id, game_id, game_reward_id, created) FROM stdin;
f	23284323	1	3	2021-03-24 12:46:03.945889
t	23284323	1	2	2021-03-24 12:46:29.24732
f	ecff3d87-1448-419a-b0c3-d5d640bf56bf	1	1	2021-03-24 12:47:42.931403
t	ecff3d87-1448-419a-b0c3-d5d640bf56bf	1	2	2021-03-24 12:47:42.957382
f	84d995b4-6c72-48d5-8adc-6ba9a987e251	1	1	2021-03-24 12:47:53.301074
t	84d995b4-6c72-48d5-8adc-6ba9a987e251	1	1	2021-03-24 12:47:53.329827
t	017fa1b8-09df-40fd-a45f-6d0fc70652a6	1	2	2021-03-24 12:47:54.215637
t	017fa1b8-09df-40fd-a45f-6d0fc70652a6	1	3	2021-03-24 12:47:54.244024
t	0881c64b-df6d-4f27-84ff-c4df1fadee86	1	2	2021-03-24 12:47:54.834905
t	0881c64b-df6d-4f27-84ff-c4df1fadee86	1	2	2021-03-24 12:47:54.864647
f	36d8fd7a-1a01-4e6f-ab9f-61094bf91ae0	1	3	2021-03-24 12:47:55.41503
t	36d8fd7a-1a01-4e6f-ab9f-61094bf91ae0	1	3	2021-03-24 12:47:55.444101
t	b95c6157-13d2-4115-a964-0c6a206d1c0b	1	1	2021-03-24 12:47:55.912701
t	b95c6157-13d2-4115-a964-0c6a206d1c0b	1	3	2021-03-24 12:47:55.942973
f	7d7dd7d8-0f24-4f3c-95af-45aca17868d6	1	3	2021-03-24 12:47:56.471163
t	7d7dd7d8-0f24-4f3c-95af-45aca17868d6	1	2	2021-03-24 12:47:56.501222
f	bc253a25-ff46-4ab7-95b3-069fad2eb81c	1	3	2021-03-24 12:47:56.967242
f	bc253a25-ff46-4ab7-95b3-069fad2eb81c	1	2	2021-03-24 12:47:56.99506
f	7c7acdbc-0a0e-4d23-8a6f-ac4eff8e667c	1	2	2021-03-24 12:47:57.519254
f	7c7acdbc-0a0e-4d23-8a6f-ac4eff8e667c	1	2	2021-03-24 12:47:57.544688
f	2551ba56-dc40-4b84-956b-71437abf267b	1	2	2021-03-24 12:47:57.986309
t	2551ba56-dc40-4b84-956b-71437abf267b	1	3	2021-03-24 12:47:58.025667
f	59ed54b5-c636-400e-b774-90e82816bbae	1	1	2021-03-24 12:47:58.35177
f	59ed54b5-c636-400e-b774-90e82816bbae	1	2	2021-03-24 12:47:58.413124
t	a04f7399-1ce2-40cd-9238-7d5c3ffef0d0	1	1	2021-03-24 12:47:58.569585
t	a04f7399-1ce2-40cd-9238-7d5c3ffef0d0	1	3	2021-03-24 12:47:58.601822
t	01620891-9566-43f1-a423-546c456cb94b	1	3	2021-03-24 12:47:58.7249
f	01620891-9566-43f1-a423-546c456cb94b	1	1	2021-03-24 12:47:58.752169
f	35ed017b-6f1d-4d9f-a798-3c816f3cc0c7	1	3	2021-03-24 12:47:58.99783
t	35ed017b-6f1d-4d9f-a798-3c816f3cc0c7	1	2	2021-03-24 12:47:59.034935
f	953684e6-f0fa-4720-95b9-7385241a23b6	1	1	2021-03-24 12:47:59.138232
f	953684e6-f0fa-4720-95b9-7385241a23b6	1	1	2021-03-24 12:47:59.211125
f	b31a3230-8c08-4d04-a964-cf0bda024ffc	1	2	2021-03-24 12:47:59.257902
f	b31a3230-8c08-4d04-a964-cf0bda024ffc	1	2	2021-03-24 12:47:59.292797
t	cacf1bc5-95bb-4c09-a66f-29977e81063e	1	2	2021-03-24 12:47:59.40414
t	cacf1bc5-95bb-4c09-a66f-29977e81063e	1	1	2021-03-24 12:47:59.435158
t	57885df5-d25d-4dfc-a38b-b6fb327f9db1	1	1	2021-03-24 12:47:59.543699
t	57885df5-d25d-4dfc-a38b-b6fb327f9db1	1	1	2021-03-24 12:47:59.575029
t	f181f00c-5c86-40bb-81f2-61441792af61	1	3	2021-03-24 12:47:59.675928
t	f181f00c-5c86-40bb-81f2-61441792af61	1	3	2021-03-24 12:47:59.70651
t	e9f77fa7-0699-45e1-a20b-369594873939	1	1	2021-03-24 12:47:59.835687
t	e9f77fa7-0699-45e1-a20b-369594873939	1	2	2021-03-24 12:47:59.863747
f	f52038e6-fcc0-49c3-9e6d-5287454b1e45	1	2	2021-03-24 12:47:59.967405
f	f52038e6-fcc0-49c3-9e6d-5287454b1e45	1	1	2021-03-24 12:47:59.993649
f	39915014-ae58-40a0-aaed-16aca61ca2ca	1	2	2021-03-24 12:48:00.126674
t	39915014-ae58-40a0-aaed-16aca61ca2ca	1	3	2021-03-24 12:48:00.158706
t	89b36f8b-72ec-4af8-9109-eaebdc9f2d24	1	3	2021-03-24 12:48:00.266792
f	89b36f8b-72ec-4af8-9109-eaebdc9f2d24	1	2	2021-03-24 12:48:00.296925
t	111a9c1c-2325-4b1f-a4ad-0bd6b92ae040	1	2	2021-03-24 12:48:00.423873
t	111a9c1c-2325-4b1f-a4ad-0bd6b92ae040	1	3	2021-03-24 12:48:00.450314
t	dc0cf882-07e2-4794-9175-59efe7c89b51	1	2	2021-03-24 12:48:00.560428
t	dc0cf882-07e2-4794-9175-59efe7c89b51	1	2	2021-03-24 12:48:00.589415
f	82a3ed70-8048-45fe-a938-5762732679ee	1	2	2021-03-24 12:48:00.713808
t	82a3ed70-8048-45fe-a938-5762732679ee	1	2	2021-03-24 12:48:00.745124
f	a3467ca9-e16e-4332-a83f-c3145ca4f4ea	1	2	2021-03-24 12:48:00.854567
f	a3467ca9-e16e-4332-a83f-c3145ca4f4ea	1	2	2021-03-24 12:48:00.883231
f	35222645-963b-43f1-89cc-4108c4c45a19	1	3	2021-03-24 12:48:01.001158
t	35222645-963b-43f1-89cc-4108c4c45a19	1	3	2021-03-24 12:48:01.03642
f	c96e06c9-efe6-4283-8343-8e8a75bd3144	1	2	2021-03-24 12:48:01.146417
t	c96e06c9-efe6-4283-8343-8e8a75bd3144	1	2	2021-03-24 12:48:01.182705
f	a4f933da-5c08-4e34-bd41-5c6d925c8bd1	1	1	2021-03-24 12:48:01.298064
t	a4f933da-5c08-4e34-bd41-5c6d925c8bd1	1	1	2021-03-24 12:48:01.331674
t	f840f550-5ab7-4348-bde1-c43bce777c7a	1	1	2021-03-24 12:48:01.452366
f	f840f550-5ab7-4348-bde1-c43bce777c7a	1	2	2021-03-24 12:48:01.480162
t	65b1bbab-a443-40e3-9fe3-ce94dc4167d9	1	1	2021-03-24 12:48:01.596478
f	65b1bbab-a443-40e3-9fe3-ce94dc4167d9	1	3	2021-03-24 12:48:01.626127
f	becf29bc-0a4b-4da9-9a4e-f388f106b985	1	2	2021-03-24 12:48:01.730784
f	becf29bc-0a4b-4da9-9a4e-f388f106b985	1	1	2021-03-24 12:48:01.761217
t	b8d3ae6f-2886-44fd-839d-3d5cd2336d59	1	3	2021-03-24 12:48:01.877279
t	b8d3ae6f-2886-44fd-839d-3d5cd2336d59	1	2	2021-03-24 12:48:01.908707
t	64f7098c-4a8d-454a-9b67-9734d7d93987	1	1	2021-03-24 12:48:02.033933
f	64f7098c-4a8d-454a-9b67-9734d7d93987	1	1	2021-03-24 12:48:02.061486
t	c22b7643-10d9-479c-aaa0-048b437e7456	1	2	2021-03-24 12:48:02.161377
f	c22b7643-10d9-479c-aaa0-048b437e7456	1	1	2021-03-24 12:48:02.191713
t	23d35e30-6f49-400d-bba3-41e630c4abfb	1	1	2021-03-24 12:48:02.314128
t	23d35e30-6f49-400d-bba3-41e630c4abfb	1	1	2021-03-24 12:48:02.347475
t	beec09e6-3bc9-41d8-a73d-5c723c6b7ad3	1	2	2021-03-24 12:48:02.463619
f	beec09e6-3bc9-41d8-a73d-5c723c6b7ad3	1	2	2021-03-24 12:48:02.493804
t	d5c277bb-a930-4bb8-b0b5-ff4ed48ae085	1	2	2021-03-24 12:48:02.627073
f	d5c277bb-a930-4bb8-b0b5-ff4ed48ae085	1	1	2021-03-24 12:48:02.669955
f	224e856d-3c2c-47f0-a13e-6a6ab10a0a3f	1	1	2021-03-24 12:48:02.759188
t	224e856d-3c2c-47f0-a13e-6a6ab10a0a3f	1	3	2021-03-24 12:48:02.790545
t	d315be95-5b5e-4aa2-a742-df3ddd20b491	1	2	2021-03-24 12:48:02.910005
t	d315be95-5b5e-4aa2-a742-df3ddd20b491	1	3	2021-03-24 12:48:02.939923
f	18bcff3a-8cc1-4511-9685-93adedbbed0b	1	1	2021-03-24 12:48:03.047936
f	18bcff3a-8cc1-4511-9685-93adedbbed0b	1	3	2021-03-24 12:48:03.103711
t	c37094a1-491e-4a0f-95f6-1f96c8c10cda	1	2	2021-03-24 12:48:03.194202
t	c37094a1-491e-4a0f-95f6-1f96c8c10cda	1	3	2021-03-24 12:48:03.23459
f	8a4970f6-c3c7-43bf-87fc-b522a481c7e1	1	2	2021-03-24 12:48:03.346008
f	8a4970f6-c3c7-43bf-87fc-b522a481c7e1	1	2	2021-03-24 12:48:03.376428
f	19edf6e9-7f6b-46eb-be04-67e740fc11e5	1	1	2021-03-24 12:49:47.518322
t	19edf6e9-7f6b-46eb-be04-67e740fc11e5	1	1	2021-03-24 12:49:47.549257
f	0f8b9ead-2754-4304-8f59-50f2bf6ff267	1	2	2021-03-24 12:49:48.06358
f	0f8b9ead-2754-4304-8f59-50f2bf6ff267	1	1	2021-03-24 12:49:48.09819
t	9f41958e-a8b5-4bba-84b4-6fa86345ba54	1	3	2021-03-24 12:49:48.655207
f	9f41958e-a8b5-4bba-84b4-6fa86345ba54	1	2	2021-03-24 12:49:48.680058
t	37965523-f200-429b-9df4-c21d68fdc826	1	2	2021-03-24 12:49:49.233426
f	37965523-f200-429b-9df4-c21d68fdc826	1	3	2021-03-24 12:49:49.260609
f	08cc03ec-74bd-4cf3-900e-38bf4b86617b	1	2	2021-03-24 12:49:49.594218
f	08cc03ec-74bd-4cf3-900e-38bf4b86617b	1	1	2021-03-24 12:49:49.634504
f	825ca641-8838-4b17-8d8a-72913ea2e626	1	1	2021-03-24 12:49:49.893345
f	825ca641-8838-4b17-8d8a-72913ea2e626	1	1	2021-03-24 12:49:49.9184
f	ea68650f-f28a-4b0b-ad23-fbefd01edcbc	1	2	2021-03-24 12:49:50.123417
t	ea68650f-f28a-4b0b-ad23-fbefd01edcbc	1	2	2021-03-24 12:49:50.155156
t	35f69deb-8299-4582-a7d9-d88f3e044bbc	1	1	2021-03-24 12:49:50.298912
f	35f69deb-8299-4582-a7d9-d88f3e044bbc	1	1	2021-03-24 12:49:50.325216
f	6906adbb-b723-4394-8aab-7e902a3a82c2	1	1	2021-03-24 12:49:50.438841
t	6906adbb-b723-4394-8aab-7e902a3a82c2	1	1	2021-03-24 12:49:50.469344
f	0737ba11-857a-403a-8f4c-12026933dc6f	1	1	2021-03-24 12:49:50.579368
t	0737ba11-857a-403a-8f4c-12026933dc6f	1	1	2021-03-24 12:49:50.609789
f	512baa63-4df1-4923-aa83-ad83bb39c4b5	1	1	2021-03-24 12:49:50.787612
f	512baa63-4df1-4923-aa83-ad83bb39c4b5	1	3	2021-03-24 12:49:50.814307
t	25f57f91-f9cc-4463-aa51-888728bb302e	1	2	2021-03-24 12:49:50.925418
f	25f57f91-f9cc-4463-aa51-888728bb302e	1	3	2021-03-24 12:49:50.951398
t	5dd4ca74-a967-4c32-80b2-549e7e9c52ac	1	1	2021-03-24 12:49:51.069607
t	5dd4ca74-a967-4c32-80b2-549e7e9c52ac	1	1	2021-03-24 12:49:51.098843
t	b2974939-6720-4bd7-916f-4ddfdcea8687	1	2	2021-03-24 12:49:51.212393
t	b2974939-6720-4bd7-916f-4ddfdcea8687	1	3	2021-03-24 12:49:51.238889
t	7d38646a-d9d8-4aa8-b0d5-d99eae62a094	1	1	2021-03-24 12:49:51.35203
t	7d38646a-d9d8-4aa8-b0d5-d99eae62a094	1	1	2021-03-24 12:49:51.38164
f	e36afb82-57c1-4761-b2fe-556b58a8a6e0	1	2	2021-03-24 12:49:51.494993
t	e36afb82-57c1-4761-b2fe-556b58a8a6e0	1	3	2021-03-24 12:49:51.523858
f	40f87702-baca-40f0-b1ad-cdaf125903ea	1	1	2021-03-24 12:49:51.620941
f	40f87702-baca-40f0-b1ad-cdaf125903ea	1	1	2021-03-24 12:49:51.651361
t	4e19389c-bc36-4431-996b-7734ea728409	1	1	2021-03-24 12:49:51.762406
f	4e19389c-bc36-4431-996b-7734ea728409	1	1	2021-03-24 12:49:51.788362
f	45f47b45-451c-4e7d-a84c-f95eed91aa98	1	1	2021-03-24 12:49:51.913729
f	45f47b45-451c-4e7d-a84c-f95eed91aa98	1	2	2021-03-24 12:49:51.938904
t	cd5017e1-ac89-4ae0-b49a-c637fcae09b9	1	3	2021-03-24 12:49:52.059077
f	cd5017e1-ac89-4ae0-b49a-c637fcae09b9	1	1	2021-03-24 12:49:52.083829
f	a7817f28-02f6-427c-a12b-b936dff7f1a1	1	2	2021-03-24 12:49:52.201963
t	a7817f28-02f6-427c-a12b-b936dff7f1a1	1	2	2021-03-24 12:49:52.229671
f	321f90fa-b959-4155-a5c4-1a3bb1edba9d	1	3	2021-03-24 12:49:52.345608
f	321f90fa-b959-4155-a5c4-1a3bb1edba9d	1	2	2021-03-24 12:49:52.373507
f	e6290e70-75ba-44f8-9d08-e331d61ac547	1	3	2021-03-24 12:49:52.493237
t	e6290e70-75ba-44f8-9d08-e331d61ac547	1	3	2021-03-24 12:49:52.52347
f	53b4a08b-e9f5-41aa-b5e6-db4a8c769a34	1	3	2021-03-24 12:49:52.646307
f	53b4a08b-e9f5-41aa-b5e6-db4a8c769a34	1	2	2021-03-24 12:49:52.673278
f	07a98995-da91-4007-a57d-55c7e876e915	1	2	2021-03-24 12:49:52.792806
t	07a98995-da91-4007-a57d-55c7e876e915	1	3	2021-03-24 12:49:52.821053
t	5625ffea-a7e8-4e92-8682-a3f3d6bf4e07	1	3	2021-03-24 12:49:52.945501
f	5625ffea-a7e8-4e92-8682-a3f3d6bf4e07	1	1	2021-03-24 12:49:52.971041
f	58adf078-6c5b-4c72-b3de-975972da6bcf	1	2	2021-03-24 12:49:53.097466
t	58adf078-6c5b-4c72-b3de-975972da6bcf	1	3	2021-03-24 12:49:53.138425
t	e913f138-87b0-4d07-937c-292ab65dd905	1	1	2021-03-24 12:49:53.241119
t	e913f138-87b0-4d07-937c-292ab65dd905	1	2	2021-03-24 12:49:53.281314
t	eb05546c-f0de-4d96-b4f2-5fd48702753d	1	3	2021-03-24 12:49:53.384006
t	eb05546c-f0de-4d96-b4f2-5fd48702753d	1	3	2021-03-24 12:49:53.412978
f	4c4797ba-0eb8-42e7-90a3-09b7bb7588da	1	2	2021-03-24 12:49:53.689247
f	4c4797ba-0eb8-42e7-90a3-09b7bb7588da	1	1	2021-03-24 12:49:53.717009
f	00b0bca6-2990-41f1-9736-6022d4caa27b	1	2	2021-03-24 12:49:53.93142
f	00b0bca6-2990-41f1-9736-6022d4caa27b	1	1	2021-03-24 12:49:53.956097
t	e5f7c5d0-1f39-4d6e-8db8-84c3e57f56c7	1	2	2021-03-24 12:49:54.097616
f	e5f7c5d0-1f39-4d6e-8db8-84c3e57f56c7	1	1	2021-03-24 12:49:54.123727
f	1a20683c-0447-4e28-9e2f-a49f2636c9fa	1	2	2021-03-24 12:49:54.240036
t	1a20683c-0447-4e28-9e2f-a49f2636c9fa	1	3	2021-03-24 12:49:54.267966
t	fb0d91a5-4d95-4f5e-994f-3c933353a231	1	2	2021-03-24 12:49:54.404021
t	fb0d91a5-4d95-4f5e-994f-3c933353a231	1	2	2021-03-24 12:49:54.430593
f	e94fd76f-8fcb-4079-b9fd-b14f8ef9b616	1	1	2021-03-24 12:49:55.56904
f	e94fd76f-8fcb-4079-b9fd-b14f8ef9b616	1	1	2021-03-24 12:49:55.598886
t	7aeb54e5-f38d-4e80-a80e-c104e943e3a1	1	1	2021-03-24 12:49:55.705055
t	7aeb54e5-f38d-4e80-a80e-c104e943e3a1	1	3	2021-03-24 12:49:55.73467
f	b60d2cbd-2bf7-4865-9a67-05ae06806de2	1	3	2021-03-24 12:49:55.85699
t	b60d2cbd-2bf7-4865-9a67-05ae06806de2	1	1	2021-03-24 12:49:55.886416
t	df184505-3e86-4995-b159-9bd316d1ab18	1	3	2021-03-24 12:49:55.996605
f	df184505-3e86-4995-b159-9bd316d1ab18	1	1	2021-03-24 12:49:56.030092
f	114ddd6f-579d-4fb7-a8a8-41acc1a0c507	1	1	2021-03-24 12:49:56.142816
t	114ddd6f-579d-4fb7-a8a8-41acc1a0c507	1	2	2021-03-24 12:49:56.16991
t	8a9da483-5c05-4c2c-b193-fa955f5ac7e8	1	1	2021-03-24 12:49:56.286983
t	8a9da483-5c05-4c2c-b193-fa955f5ac7e8	1	3	2021-03-24 12:49:56.314966
f	180db2e8-903e-4e12-98a1-de4049cbd8e6	1	3	2021-03-24 12:49:56.434457
t	180db2e8-903e-4e12-98a1-de4049cbd8e6	1	2	2021-03-24 12:49:56.463161
t	bf95240b-6515-45bb-b13e-54d8068d39ae	1	3	2021-03-24 12:49:56.579677
f	bf95240b-6515-45bb-b13e-54d8068d39ae	1	3	2021-03-24 12:49:56.606958
t	35a42af0-ad7d-4672-9c5e-9a7a49a55f51	1	1	2021-03-24 12:49:56.720364
t	35a42af0-ad7d-4672-9c5e-9a7a49a55f51	1	1	2021-03-24 12:49:56.747778
f	9e2a674f-7857-466a-bd02-c47dba26ab4c	1	3	2021-03-24 12:49:56.860532
t	9e2a674f-7857-466a-bd02-c47dba26ab4c	1	1	2021-03-24 12:49:56.890076
f	87512c82-1600-4acd-8943-826e400770d2	1	3	2021-03-24 12:49:57.011066
t	87512c82-1600-4acd-8943-826e400770d2	1	2	2021-03-24 12:49:57.040746
t	c7454f09-ba9b-4c50-a46c-0a1ad9a38cce	1	1	2021-03-24 12:49:57.154798
f	c7454f09-ba9b-4c50-a46c-0a1ad9a38cce	1	3	2021-03-24 12:49:57.180071
f	c670f303-e49b-47d0-9110-7f8c9535f0b9	1	3	2021-03-24 12:49:57.289037
f	c670f303-e49b-47d0-9110-7f8c9535f0b9	1	3	2021-03-24 12:49:57.31436
t	9a49b45e-128e-404e-a181-f4433d6e7b7c	1	1	2021-03-24 12:49:57.438516
t	9a49b45e-128e-404e-a181-f4433d6e7b7c	1	2	2021-03-24 12:49:57.46581
t	7ed2084b-5870-4575-82fb-fcf761a23c2b	1	2	2021-03-24 12:49:57.581464
t	7ed2084b-5870-4575-82fb-fcf761a23c2b	1	2	2021-03-24 12:49:57.609583
t	a23418b6-30ce-4c6c-81c2-292a6b352ad8	1	2	2021-03-24 12:49:58.117814
f	a23418b6-30ce-4c6c-81c2-292a6b352ad8	1	1	2021-03-24 12:49:58.149025
t	b3817325-a8a4-4e41-b0ed-e28bfc72779a	1	2	2021-03-24 12:49:58.302821
f	b3817325-a8a4-4e41-b0ed-e28bfc72779a	1	1	2021-03-24 12:49:58.332014
f	e80b7fa8-24f8-4087-9c4a-0a952ce43994	1	3	2021-03-24 12:49:58.584159
f	e80b7fa8-24f8-4087-9c4a-0a952ce43994	1	3	2021-03-24 12:49:58.612803
t	409942e9-739b-4c69-9e26-a8907cb78502	1	2	2021-03-24 13:25:56.448013
f	409942e9-739b-4c69-9e26-a8907cb78502	1	3	2021-03-24 13:25:56.480381
t	374599b6-3f46-4d5c-b631-3d07daa730bf	1	2	2021-03-24 13:25:57.564691
t	374599b6-3f46-4d5c-b631-3d07daa730bf	1	1	2021-03-24 13:25:57.608163
f	4a96e419-f817-436c-bf36-90f9929300d4	1	3	2021-03-24 13:25:57.843763
t	4a96e419-f817-436c-bf36-90f9929300d4	1	2	2021-03-24 13:25:57.912182
t	6505ac6b-decb-42e5-8266-5c933f917912	1	1	2021-03-24 13:25:58.154186
f	6505ac6b-decb-42e5-8266-5c933f917912	1	3	2021-03-24 13:25:58.183314
f	c07dae0b-9ad4-4a07-82e3-4b090829193f	1	1	2021-03-24 13:25:58.401536
f	c07dae0b-9ad4-4a07-82e3-4b090829193f	1	1	2021-03-24 13:25:58.437057
t	9746cb9b-baed-40fe-a8ea-be99f659273a	1	2	2021-03-24 13:31:58.65844
f	9746cb9b-baed-40fe-a8ea-be99f659273a	1	1	2021-03-24 13:31:58.689177
f	57e88e1c-a7f8-48f8-a907-4d2b94453808	1	3	2021-03-24 13:31:59.704796
f	57e88e1c-a7f8-48f8-a907-4d2b94453808	1	3	2021-03-24 13:31:59.731185
f	63db76c3-5665-4af6-85cf-14f4d02b064d	1	2	2021-03-24 13:32:00.402891
f	63db76c3-5665-4af6-85cf-14f4d02b064d	1	2	2021-03-24 13:32:00.430032
f	88531bed-d0ad-48cd-a409-e8490e00f8d2	1	2	2021-03-24 13:32:00.578549
f	88531bed-d0ad-48cd-a409-e8490e00f8d2	1	2	2021-03-24 13:32:00.605313
t	b093023f-3ff5-4add-8e2b-31907c7259a0	1	1	2021-03-24 13:32:00.744208
f	b093023f-3ff5-4add-8e2b-31907c7259a0	1	3	2021-03-24 13:32:00.770589
f	296f55c2-f7fa-4648-b544-abc67813976d	1	3	2021-03-24 13:32:02.302185
t	296f55c2-f7fa-4648-b544-abc67813976d	1	1	2021-03-24 13:32:02.334723
t	9b3f3ca2-88e6-4bc9-b138-379f4eb9a2d7	1	1	2021-03-24 13:32:02.541317
t	9b3f3ca2-88e6-4bc9-b138-379f4eb9a2d7	1	2	2021-03-24 13:32:02.574099
t	a4e6c103-7a1d-4bf5-8b33-fa5bec5ad036	1	1	2021-03-24 13:32:02.701543
f	a4e6c103-7a1d-4bf5-8b33-fa5bec5ad036	1	3	2021-03-24 13:32:02.731104
f	295a01ec-70c4-4a71-9d4b-39b176d60494	1	1	2021-03-24 13:32:03.249076
f	295a01ec-70c4-4a71-9d4b-39b176d60494	1	3	2021-03-24 13:32:03.275294
f	05c5dc60-aeb1-4abc-ba0a-9ac5a00b8667	1	3	2021-03-24 13:32:04.036057
f	05c5dc60-aeb1-4abc-ba0a-9ac5a00b8667	1	3	2021-03-24 13:32:04.060375
t	c35cd2d1-f320-442a-9f8e-92bc843c8b18	1	2	2021-03-24 13:32:04.471939
f	c35cd2d1-f320-442a-9f8e-92bc843c8b18	1	1	2021-03-24 13:32:04.499195
f	a1d01675-822a-437d-862b-6ba97035e1d7	1	2	2021-03-24 13:32:04.660143
f	a1d01675-822a-437d-862b-6ba97035e1d7	1	3	2021-03-24 13:32:04.689624
f	61922f89-9177-40a0-9585-ad8e5807241c	1	3	2021-03-24 13:32:04.809152
t	61922f89-9177-40a0-9585-ad8e5807241c	1	2	2021-03-24 13:32:04.843924
f	9685c657-50df-4067-a513-566d81c2705b	1	1	2021-03-24 13:32:05.154829
f	9685c657-50df-4067-a513-566d81c2705b	1	1	2021-03-24 13:32:05.184501
t	3cb99ce7-1421-41c0-b631-479fb5d54ba8	1	1	2021-03-24 13:40:44.044559
t	3cb99ce7-1421-41c0-b631-479fb5d54ba8	1	1	2021-03-24 13:40:44.079049
t	bce9813c-539f-4233-ba8e-26d8e1efd6c9	1	2	2021-03-24 13:40:45.058084
t	bce9813c-539f-4233-ba8e-26d8e1efd6c9	1	2	2021-03-24 13:40:45.095476
t	fd814f2c-ebed-44f6-ba51-b7e33652084c	1	2	2021-03-24 13:40:46.036415
f	fd814f2c-ebed-44f6-ba51-b7e33652084c	1	3	2021-03-24 13:40:46.071041
f	47c573f9-94d5-4669-be94-c62f291042c4	1	3	2021-03-24 13:41:20.350447
t	47c573f9-94d5-4669-be94-c62f291042c4	1	2	2021-03-24 13:41:20.399281
f	80f43b99-178a-4e1d-8814-026eeaeb0f9d	1	3	2021-03-24 13:49:00.290283
t	80f43b99-178a-4e1d-8814-026eeaeb0f9d	1	1	2021-03-24 13:49:00.335989
f	86c32628-6397-41e3-b296-1ed2e9c44816	1	3	2021-03-24 13:49:40.757517
t	86c32628-6397-41e3-b296-1ed2e9c44816	1	1	2021-03-24 13:49:40.810656
f	c31ba3b6-3f72-475d-8b5d-448ca39de18b	1	3	2021-03-24 13:49:41.715193
t	c31ba3b6-3f72-475d-8b5d-448ca39de18b	1	2	2021-03-24 13:49:41.759373
t	07bb32fe-8672-4b27-ac20-278f83246720	1	2	2021-03-24 13:49:42.703864
f	07bb32fe-8672-4b27-ac20-278f83246720	1	3	2021-03-24 13:49:42.746476
t	01adc240-3fb9-402e-9640-b44d0e94be69	1	1	2021-03-24 13:49:43.237764
t	01adc240-3fb9-402e-9640-b44d0e94be69	1	1	2021-03-24 13:49:43.303777
f	e8dcc033-42a5-4245-ba97-a6f4dc7c8c14	1	3	2021-03-24 13:49:43.41837
t	e8dcc033-42a5-4245-ba97-a6f4dc7c8c14	1	1	2021-03-24 13:49:43.474945
t	78be4f75-37c5-4095-9650-f14fc5bc8161	1	1	2021-03-24 13:49:43.561266
t	78be4f75-37c5-4095-9650-f14fc5bc8161	1	2	2021-03-24 13:49:43.60401
t	359c4164-ef0f-42cb-90ce-de45fa4cb0e6	1	1	2021-03-24 13:49:44.247638
t	359c4164-ef0f-42cb-90ce-de45fa4cb0e6	1	1	2021-03-24 13:49:44.30048
t	ec5dca5d-ad54-4cc3-97b1-1ea21a7f879e	1	1	2021-03-24 13:49:44.484869
f	ec5dca5d-ad54-4cc3-97b1-1ea21a7f879e	1	2	2021-03-24 13:49:44.524721
f	6b58362a-d9d3-4dc6-af57-06a3f3c94240	1	3	2021-03-24 13:49:44.706199
f	6b58362a-d9d3-4dc6-af57-06a3f3c94240	1	3	2021-03-24 13:49:44.746369
f	1d002864-a33e-4243-aa21-2bec76a573f3	1	3	2021-03-24 13:50:30.655472
f	1d002864-a33e-4243-aa21-2bec76a573f3	1	2	2021-03-24 13:50:30.706726
t	9b4365a1-ac35-410c-9f0d-ebbb30305cf9	1	1	2021-03-24 13:50:41.955363
t	9b4365a1-ac35-410c-9f0d-ebbb30305cf9	1	1	2021-03-24 13:50:42.006065
f	6128fb03-df90-4d8c-8a9b-fb1c925ac80c	1	3	2021-03-24 13:50:49.42799
t	6128fb03-df90-4d8c-8a9b-fb1c925ac80c	1	2	2021-03-24 13:50:49.460827
f	ee7c32a7-19f8-42c9-a6a9-987488edd3c6	1	3	2021-03-24 13:50:50.13653
t	ee7c32a7-19f8-42c9-a6a9-987488edd3c6	1	1	2021-03-24 13:50:50.174015
f	9383cb61-b125-477d-8185-cc94595f7150	1	3	2021-03-24 13:51:41.087399
f	c12abe84-afd7-4a9a-952f-0dd5ee81959a	1	1	2021-03-24 13:51:41.883845
f	1ed11568-e25b-412f-8b3f-8548cb6c46e6	1	2	2021-03-24 13:51:42.954056
f	81b7d087-6000-4608-a11f-45708902079e	1	2	2021-03-24 13:51:54.511996
f	f1f19b1b-bc68-436a-9449-add05c46dd9a	1	3	2021-03-24 13:51:59.439559
f	345bd4cb-b5d8-43fd-84d8-9d5d0ea2924f	1	2	2021-03-24 13:51:59.867894
f	65b268e3-8fec-44d0-8311-8e1b8486d467	1	2	2021-03-24 13:52:00.91683
t	6da61f92-9db1-4751-bd7a-4eb040e8da45	1	2	2021-03-24 13:52:01.731753
f	ade8974b-441b-493d-bd49-2abc62bfcfbf	1	1	2021-03-24 13:52:06.409188
f	fd2b6391-5cc3-4d99-9fff-c21b4418deea	1	3	2021-03-24 13:52:06.654437
f	4cd6be53-aa88-4d8e-afda-4855810625d8	1	2	2021-03-24 13:52:06.876537
f	ab309418-e16f-4d3c-882a-7c6fddd09f6c	1	3	2021-03-24 13:52:07.096706
f	a9af6d4d-0749-419e-85bd-760f62ead870	1	1	2021-03-24 13:52:07.635422
t	a1a7055f-4b0a-42ef-b62c-31b52b862054	1	2	2021-03-24 13:52:08.134741
f	4fdf4987-9961-4c0e-adc6-f8b549af5fe2	1	1	2021-03-24 13:52:08.531876
t	5effff0d-f92e-4d56-a33c-688f552ffcf4	1	2	2021-03-24 13:52:09.04358
\.


--
-- Name: game_rewards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.game_rewards_id_seq', 3, true);


--
-- Name: games_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.games_id_seq', 4, true);


--
-- Name: game_rewards game_rewards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_rewards
    ADD CONSTRAINT game_rewards_pkey PRIMARY KEY (id);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (id);


--
-- Name: game_images game_images_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_images
    ADD CONSTRAINT game_images_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(id);


--
-- Name: game_reward_images game_reward_images_game_reward_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_reward_images
    ADD CONSTRAINT game_reward_images_game_reward_id_fkey FOREIGN KEY (game_reward_id) REFERENCES public.game_rewards(id);


--
-- Name: games_rewards games_rewards_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_rewards
    ADD CONSTRAINT games_rewards_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(id);


--
-- Name: games_rewards games_rewards_game_reward_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games_rewards
    ADD CONSTRAINT games_rewards_game_reward_id_fkey FOREIGN KEY (game_reward_id) REFERENCES public.game_rewards(id);


--
-- Name: played_games played_games_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.played_games
    ADD CONSTRAINT played_games_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.games(id);


--
-- Name: played_games played_games_game_reward_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.played_games
    ADD CONSTRAINT played_games_game_reward_id_fkey FOREIGN KEY (game_reward_id) REFERENCES public.game_rewards(id);


--
-- PostgreSQL database dump complete
--

