--
-- PostgreSQL database dump
--

-- Dumped from database version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)
-- Dumped by pg_dump version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)

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

DROP DATABASE guessing_game;
--
-- Name: guessing_game; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE guessing_game WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE guessing_game OWNER TO freecodecamp;

\connect guessing_game

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
-- Name: players; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.players (
    player_id integer NOT NULL,
    username character varying(22) NOT NULL,
    games_played integer DEFAULT 0 NOT NULL,
    fewest_guesses integer
);


ALTER TABLE public.players OWNER TO freecodecamp;

--
-- Name: players_player_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.players_player_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.players_player_id_seq OWNER TO freecodecamp;

--
-- Name: players_player_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.players_player_id_seq OWNED BY public.players.player_id;


--
-- Name: players player_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.players ALTER COLUMN player_id SET DEFAULT nextval('public.players_player_id_seq'::regclass);


--
-- Data for Name: players; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.players VALUES (2, 'user_1795166796946', 0, NULL);
INSERT INTO public.players VALUES (3, 'user_1795166796945', 0, NULL);
INSERT INTO public.players VALUES (4, 'user_1795166826456', 0, NULL);
INSERT INTO public.players VALUES (5, 'user_1795166826455', 0, NULL);
INSERT INTO public.players VALUES (6, 'user_1795166835359', 0, NULL);
INSERT INTO public.players VALUES (7, 'user_1795166835358', 0, NULL);
INSERT INTO public.players VALUES (8, 'user_1795166857942', 0, NULL);
INSERT INTO public.players VALUES (9, 'user_1795166857941', 0, NULL);
INSERT INTO public.players VALUES (10, 'user_1795166992038', 0, NULL);
INSERT INTO public.players VALUES (11, 'user_1795166992037', 0, NULL);
INSERT INTO public.players VALUES (12, 'user_1795167047086', 0, NULL);
INSERT INTO public.players VALUES (13, 'user_1795167047085', 0, NULL);
INSERT INTO public.players VALUES (15, 'user_1795167082941', 0, NULL);
INSERT INTO public.players VALUES (16, 'user_1795167082940', 0, NULL);
INSERT INTO public.players VALUES (17, 'user_1795167350045', 0, NULL);
INSERT INTO public.players VALUES (18, 'user_1795167350044', 0, NULL);
INSERT INTO public.players VALUES (20, 'user_1795167697875', 0, NULL);
INSERT INTO public.players VALUES (21, 'user_1795167697874', 0, NULL);
INSERT INTO public.players VALUES (22, 'user_1795168183312', 0, NULL);
INSERT INTO public.players VALUES (23, 'user_1795168183311', 0, NULL);
INSERT INTO public.players VALUES (24, 'user_1795168192336', 0, NULL);
INSERT INTO public.players VALUES (25, 'user_1795168192335', 0, NULL);
INSERT INTO public.players VALUES (26, 'user_1795168202998', 0, NULL);
INSERT INTO public.players VALUES (27, 'user_1795168202997', 0, NULL);
INSERT INTO public.players VALUES (28, 'user_1795168482416', 0, NULL);
INSERT INTO public.players VALUES (29, 'user_1795168482415', 0, NULL);
INSERT INTO public.players VALUES (30, '', 0, NULL);
INSERT INTO public.players VALUES (32, 'user_1795169750613', 2, NULL);
INSERT INTO public.players VALUES (31, 'user_1795169750614', 5, NULL);
INSERT INTO public.players VALUES (1, 'Isztvan', 5, 1);
INSERT INTO public.players VALUES (19, 'Isztan', 1, NULL);
INSERT INTO public.players VALUES (33, 'Kuab', 1, NULL);
INSERT INTO public.players VALUES (34, 'Kbua', 1, 4);
INSERT INTO public.players VALUES (14, 'Kuba', 5, 2);
INSERT INTO public.players VALUES (36, 'user_1795170524917', 2, 918);
INSERT INTO public.players VALUES (35, 'user_1795170524918', 5, 996);
INSERT INTO public.players VALUES (38, 'user_1795170603161', 2, 482);
INSERT INTO public.players VALUES (37, 'user_1795170603162', 5, 975);


--
-- Name: players_player_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.players_player_id_seq', 38, true);


--
-- Name: players players_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_pkey PRIMARY KEY (player_id);


--
-- Name: players players_username_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_username_key UNIQUE (username);


--
-- PostgreSQL database dump complete
--

