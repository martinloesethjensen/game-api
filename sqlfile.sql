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

--
-- Name: diesel_manage_updated_at(regclass); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.diesel_manage_updated_at(_tbl regclass) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    EXECUTE format('CREATE TRIGGER set_updated_at BEFORE UPDATE ON %s
                    FOR EACH ROW EXECUTE PROCEDURE diesel_set_updated_at()', _tbl);
END;
$$;


ALTER FUNCTION public.diesel_manage_updated_at(_tbl regclass) OWNER TO postgres;

--
-- Name: diesel_set_updated_at(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.diesel_set_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF (
        NEW IS DISTINCT FROM OLD AND
        NEW.updated_at IS NOT DISTINCT FROM OLD.updated_at
    ) THEN
        NEW.updated_at := current_timestamp;
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.diesel_set_updated_at() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: __diesel_schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.__diesel_schema_migrations (
    version character varying(50) NOT NULL,
    run_on timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.__diesel_schema_migrations OWNER TO postgres;

--
-- Name: game_images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game_images (
    game_id integer NOT NULL,
    image character varying(255)
);


ALTER TABLE public.game_images OWNER TO postgres;

--
-- Name: game_price_images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game_price_images (
    game_price_id integer NOT NULL,
    image character varying(255)
);


ALTER TABLE public.game_price_images OWNER TO postgres;

--
-- Name: game_prices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game_prices (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    body text,
    available_prices integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.game_prices OWNER TO postgres;

--
-- Name: game_prices_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.game_prices_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.game_prices_id_seq OWNER TO postgres;

--
-- Name: game_prices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.game_prices_id_seq OWNED BY public.game_prices.id;


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
-- Name: game_prices id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_prices ALTER COLUMN id SET DEFAULT nextval('public.game_prices_id_seq'::regclass);


--
-- Name: games id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games ALTER COLUMN id SET DEFAULT nextval('public.games_id_seq'::regclass);


--
-- Data for Name: __diesel_schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.__diesel_schema_migrations (version, run_on) FROM stdin;
00000000000000	2021-02-19 12:04:57.817636
20210219120511	2021-02-19 12:06:30.233441
\.


--
-- Data for Name: game_images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.game_images (game_id, image) FROM stdin;
5	https://cataas.com/cat
5	https://cataas.com/cat
5	https://cataas.com/cat
5	https://cataas.com/cat
5	https://cataas.com/cat
6	https://cataas.com/cat
6	https://cataas.com/cat
6	https://cataas.com/cat
6	https://cataas.com/cat
6	https://cataas.com/cat
7	https://cataas.com/cat
7	https://cataas.com/cat
7	https://cataas.com/cat
7	https://cataas.com/cat
7	https://cataas.com/cat
8	https://cataas.com/cat
8	https://cataas.com/cat
8	https://cataas.com/cat
8	https://cataas.com/cat
8	https://cataas.com/cat
9	https://cataas.com/cat
\.


--
-- Data for Name: game_price_images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.game_price_images (game_price_id, image) FROM stdin;
\.


--
-- Data for Name: game_prices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.game_prices (id, title, body, available_prices) FROM stdin;
\.


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.games (id, title, body, daily_prices, winning_chance) FROM stdin;
5	hey	body efjdnhsfdbhfdsf	100	5
6	hey	body efjdnhsfdbhfdsf	100	5
7	hey	body efjdnhsfdbhfdsf	100	5
8	hey	body efjdnhsfdbhfdsf	100	5
9	8ball	body thingyfdjvcd	100	5
\.


--
-- Name: game_prices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.game_prices_id_seq', 1, false);


--
-- Name: games_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.games_id_seq', 9, true);


--
-- Name: __diesel_schema_migrations __diesel_schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.__diesel_schema_migrations
    ADD CONSTRAINT __diesel_schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: game_prices game_prices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_prices
    ADD CONSTRAINT game_prices_pkey PRIMARY KEY (id);


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
-- Name: game_price_images game_price_images_game_price_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_price_images
    ADD CONSTRAINT game_price_images_game_price_id_fkey FOREIGN KEY (game_price_id) REFERENCES public.game_prices(id);


--
-- PostgreSQL database dump complete
--

