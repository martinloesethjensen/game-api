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

