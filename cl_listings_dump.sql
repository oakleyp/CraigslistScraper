--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.3
-- Dumped by pg_dump version 9.6.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: oakley
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE ar_internal_metadata OWNER TO oakley;

--
-- Name: listings; Type: TABLE; Schema: public; Owner: oakley
--

CREATE TABLE listings (
    id bigint NOT NULL,
    title character varying,
    price double precision,
    issue_date timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE listings OWNER TO oakley;

--
-- Name: listings_id_seq; Type: SEQUENCE; Schema: public; Owner: oakley
--

CREATE SEQUENCE listings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE listings_id_seq OWNER TO oakley;

--
-- Name: listings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: oakley
--

ALTER SEQUENCE listings_id_seq OWNED BY listings.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: oakley
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE schema_migrations OWNER TO oakley;

--
-- Name: listings id; Type: DEFAULT; Schema: public; Owner: oakley
--

ALTER TABLE ONLY listings ALTER COLUMN id SET DEFAULT nextval('listings_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: oakley
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: listings listings_pkey; Type: CONSTRAINT; Schema: public; Owner: oakley
--

ALTER TABLE ONLY listings
    ADD CONSTRAINT listings_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: oakley
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- PostgreSQL database dump complete
--

