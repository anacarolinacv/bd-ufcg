--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.24
-- Dumped by pg_dump version 9.5.24

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.venda DROP CONSTRAINT venda_cliente_fk_fkey;
ALTER TABLE ONLY public.venda DROP CONSTRAINT medicamento_fk;
ALTER TABLE ONLY public.farmacia DROP CONSTRAINT gerente_fk;
ALTER TABLE ONLY public.venda DROP CONSTRAINT funcionario_fk;
ALTER TABLE ONLY public.funcionario DROP CONSTRAINT farmacia_fk;
ALTER TABLE ONLY public.entrega DROP CONSTRAINT entrega_endereco_fk_fkey;
ALTER TABLE ONLY public.farmacia DROP CONSTRAINT endereco_fk;
ALTER TABLE ONLY public.endereco_cliente DROP CONSTRAINT endereco_cliente_cliente_fk_fkey;
ALTER TABLE ONLY public.venda DROP CONSTRAINT venda_pkey;
ALTER TABLE ONLY public.farmacia DROP CONSTRAINT sede_unica;
ALTER TABLE ONLY public.medicamento DROP CONSTRAINT medicamento_pkey;
ALTER TABLE ONLY public.funcionario DROP CONSTRAINT funcionario_pk;
ALTER TABLE ONLY public.farmacia DROP CONSTRAINT farmacia_pkey;
ALTER TABLE ONLY public.entrega DROP CONSTRAINT entrega_pkey;
ALTER TABLE ONLY public.endereco DROP CONSTRAINT endereco_pkey;
ALTER TABLE ONLY public.endereco_cliente DROP CONSTRAINT endereco_cliente_pkey;
ALTER TABLE ONLY public.endereco DROP CONSTRAINT endereco_bairro_key;
ALTER TABLE ONLY public.cliente DROP CONSTRAINT cliente_pkey;
ALTER TABLE public.venda ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.medicamento ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.farmacia ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.entrega ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.endereco_cliente ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.endereco ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE public.venda_id_seq;
DROP TABLE public.venda;
DROP SEQUENCE public.medicamento_id_seq;
DROP TABLE public.medicamento;
DROP TABLE public.funcionario;
DROP SEQUENCE public.farmacia_id_seq;
DROP TABLE public.farmacia;
DROP SEQUENCE public.entrega_id_seq;
DROP TABLE public.entrega;
DROP SEQUENCE public.endereco_id_seq;
DROP SEQUENCE public.endereco_cliente_id_seq;
DROP TABLE public.endereco_cliente;
DROP TABLE public.endereco;
DROP TABLE public.cliente;
DROP TYPE public.tipo_funcionario;
DROP TYPE public.tipo_endereco;
DROP TYPE public.estados_nordeste;
DROP EXTENSION btree_gist;
DROP EXTENSION plpgsql;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: btree_gist; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS btree_gist WITH SCHEMA public;


--
-- Name: EXTENSION btree_gist; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION btree_gist IS 'support for indexing common datatypes in GiST';


--
-- Name: estados_nordeste; Type: TYPE; Schema: public; Owner: anaccdv
--

CREATE TYPE public.estados_nordeste AS ENUM (
    'AL',
    'BA',
    'CE',
    'MA',
    'PB',
    'PE',
    'PI',
    'RN',
    'SE'
);


ALTER TYPE public.estados_nordeste OWNER TO anaccdv;

--
-- Name: tipo_endereco; Type: TYPE; Schema: public; Owner: anaccdv
--

CREATE TYPE public.tipo_endereco AS ENUM (
    'Residência',
    'Trabalho',
    'Outro'
);


ALTER TYPE public.tipo_endereco OWNER TO anaccdv;

--
-- Name: tipo_funcionario; Type: TYPE; Schema: public; Owner: anaccdv
--

CREATE TYPE public.tipo_funcionario AS ENUM (
    'Farmaceutico',
    'Vendedor',
    'Entregador',
    'Caixa',
    'Administrador'
);


ALTER TYPE public.tipo_funcionario OWNER TO anaccdv;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: cliente; Type: TABLE; Schema: public; Owner: anaccdv
--

CREATE TABLE public.cliente (
    nome character varying(40) NOT NULL,
    cpf character(11) NOT NULL,
    data_nascimento date,
    CONSTRAINT checa_maioridade CHECK ((age((data_nascimento)::timestamp with time zone) > '18 years'::interval))
);


ALTER TABLE public.cliente OWNER TO anaccdv;

--
-- Name: endereco; Type: TABLE; Schema: public; Owner: anaccdv
--

CREATE TABLE public.endereco (
    id integer NOT NULL,
    estado public.estados_nordeste NOT NULL,
    cidade text NOT NULL,
    bairro text NOT NULL
);


ALTER TABLE public.endereco OWNER TO anaccdv;

--
-- Name: endereco_cliente; Type: TABLE; Schema: public; Owner: anaccdv
--

CREATE TABLE public.endereco_cliente (
    id integer NOT NULL,
    cliente_fk character(11) NOT NULL,
    numero integer,
    cep bigint NOT NULL,
    tipo public.tipo_endereco NOT NULL
);


ALTER TABLE public.endereco_cliente OWNER TO anaccdv;

--
-- Name: endereco_cliente_id_seq; Type: SEQUENCE; Schema: public; Owner: anaccdv
--

CREATE SEQUENCE public.endereco_cliente_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.endereco_cliente_id_seq OWNER TO anaccdv;

--
-- Name: endereco_cliente_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: anaccdv
--

ALTER SEQUENCE public.endereco_cliente_id_seq OWNED BY public.endereco_cliente.id;


--
-- Name: endereco_id_seq; Type: SEQUENCE; Schema: public; Owner: anaccdv
--

CREATE SEQUENCE public.endereco_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.endereco_id_seq OWNER TO anaccdv;

--
-- Name: endereco_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: anaccdv
--

ALTER SEQUENCE public.endereco_id_seq OWNED BY public.endereco.id;


--
-- Name: entrega; Type: TABLE; Schema: public; Owner: anaccdv
--

CREATE TABLE public.entrega (
    id integer NOT NULL,
    cpf_cliente character(11) NOT NULL,
    endereco_fk integer NOT NULL
);


ALTER TABLE public.entrega OWNER TO anaccdv;

--
-- Name: entrega_id_seq; Type: SEQUENCE; Schema: public; Owner: anaccdv
--

CREATE SEQUENCE public.entrega_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.entrega_id_seq OWNER TO anaccdv;

--
-- Name: entrega_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: anaccdv
--

ALTER SEQUENCE public.entrega_id_seq OWNED BY public.entrega.id;


--
-- Name: farmacia; Type: TABLE; Schema: public; Owner: anaccdv
--

CREATE TABLE public.farmacia (
    id integer NOT NULL,
    endereco_fk integer,
    nome character varying(20) NOT NULL,
    tipo character varying(6) NOT NULL,
    gerente_fk character(11),
    tipo_fun public.tipo_funcionario,
    CONSTRAINT checa_tipo CHECK ((((tipo)::text = 'SEDE'::text) OR ((tipo)::text = 'FILIAL'::text))),
    CONSTRAINT tipo_gerente CHECK ((tipo_fun = ANY (ARRAY['Administrador'::public.tipo_funcionario, 'Farmaceutico'::public.tipo_funcionario])))
);


ALTER TABLE public.farmacia OWNER TO anaccdv;

--
-- Name: farmacia_id_seq; Type: SEQUENCE; Schema: public; Owner: anaccdv
--

CREATE SEQUENCE public.farmacia_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.farmacia_id_seq OWNER TO anaccdv;

--
-- Name: farmacia_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: anaccdv
--

ALTER SEQUENCE public.farmacia_id_seq OWNED BY public.farmacia.id;


--
-- Name: funcionario; Type: TABLE; Schema: public; Owner: anaccdv
--

CREATE TABLE public.funcionario (
    cpf character(11) NOT NULL,
    nome character varying(50) NOT NULL,
    started_at date NOT NULL,
    tipo public.tipo_funcionario NOT NULL,
    farmarcia_fk integer
);


ALTER TABLE public.funcionario OWNER TO anaccdv;

--
-- Name: medicamento; Type: TABLE; Schema: public; Owner: anaccdv
--

CREATE TABLE public.medicamento (
    id integer NOT NULL,
    nome character varying(50) NOT NULL,
    tem_receita boolean NOT NULL,
    preco numeric NOT NULL,
    bula text
);


ALTER TABLE public.medicamento OWNER TO anaccdv;

--
-- Name: medicamento_id_seq; Type: SEQUENCE; Schema: public; Owner: anaccdv
--

CREATE SEQUENCE public.medicamento_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.medicamento_id_seq OWNER TO anaccdv;

--
-- Name: medicamento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: anaccdv
--

ALTER SEQUENCE public.medicamento_id_seq OWNED BY public.medicamento.id;


--
-- Name: venda; Type: TABLE; Schema: public; Owner: anaccdv
--

CREATE TABLE public.venda (
    id integer NOT NULL,
    cliente_fk character(11),
    medicamento_fk integer NOT NULL,
    funcionario_fk character(11) NOT NULL,
    tipo_fun public.tipo_funcionario NOT NULL,
    tem_receita boolean NOT NULL,
    CONSTRAINT checa_venda_receitada CHECK ((((tem_receita = true) AND (funcionario_fk IS NOT NULL)) OR (tem_receita = false))),
    CONSTRAINT feita_vendedor CHECK ((tipo_fun = 'Vendedor'::public.tipo_funcionario))
);


ALTER TABLE public.venda OWNER TO anaccdv;

--
-- Name: venda_id_seq; Type: SEQUENCE; Schema: public; Owner: anaccdv
--

CREATE SEQUENCE public.venda_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.venda_id_seq OWNER TO anaccdv;

--
-- Name: venda_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: anaccdv
--

ALTER SEQUENCE public.venda_id_seq OWNED BY public.venda.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: anaccdv
--

ALTER TABLE ONLY public.endereco ALTER COLUMN id SET DEFAULT nextval('public.endereco_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: anaccdv
--

ALTER TABLE ONLY public.endereco_cliente ALTER COLUMN id SET DEFAULT nextval('public.endereco_cliente_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: anaccdv
--

ALTER TABLE ONLY public.entrega ALTER COLUMN id SET DEFAULT nextval('public.entrega_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: anaccdv
--

ALTER TABLE ONLY public.farmacia ALTER COLUMN id SET DEFAULT nextval('public.farmacia_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: anaccdv
--

ALTER TABLE ONLY public.medicamento ALTER COLUMN id SET DEFAULT nextval('public.medicamento_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: anaccdv
--

ALTER TABLE ONLY public.venda ALTER COLUMN id SET DEFAULT nextval('public.venda_id_seq'::regclass);


--
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: anaccdv
--



--
-- Data for Name: endereco; Type: TABLE DATA; Schema: public; Owner: anaccdv
--



--
-- Data for Name: endereco_cliente; Type: TABLE DATA; Schema: public; Owner: anaccdv
--



--
-- Name: endereco_cliente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anaccdv
--

SELECT pg_catalog.setval('public.endereco_cliente_id_seq', 1, false);


--
-- Name: endereco_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anaccdv
--

SELECT pg_catalog.setval('public.endereco_id_seq', 1, false);


--
-- Data for Name: entrega; Type: TABLE DATA; Schema: public; Owner: anaccdv
--



--
-- Name: entrega_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anaccdv
--

SELECT pg_catalog.setval('public.entrega_id_seq', 1, false);


--
-- Data for Name: farmacia; Type: TABLE DATA; Schema: public; Owner: anaccdv
--



--
-- Name: farmacia_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anaccdv
--

SELECT pg_catalog.setval('public.farmacia_id_seq', 1, false);


--
-- Data for Name: funcionario; Type: TABLE DATA; Schema: public; Owner: anaccdv
--



--
-- Data for Name: medicamento; Type: TABLE DATA; Schema: public; Owner: anaccdv
--



--
-- Name: medicamento_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anaccdv
--

SELECT pg_catalog.setval('public.medicamento_id_seq', 1, false);


--
-- Data for Name: venda; Type: TABLE DATA; Schema: public; Owner: anaccdv
--



--
-- Name: venda_id_seq; Type: SEQUENCE SET; Schema: public; Owner: anaccdv
--

SELECT pg_catalog.setval('public.venda_id_seq', 1, false);


--
-- Name: cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: anaccdv
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (cpf);


--
-- Name: endereco_bairro_key; Type: CONSTRAINT; Schema: public; Owner: anaccdv
--

ALTER TABLE ONLY public.endereco
    ADD CONSTRAINT endereco_bairro_key UNIQUE (bairro);


--
-- Name: endereco_cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: anaccdv
--

ALTER TABLE ONLY public.endereco_cliente
    ADD CONSTRAINT endereco_cliente_pkey PRIMARY KEY (id, cliente_fk);


--
-- Name: endereco_pkey; Type: CONSTRAINT; Schema: public; Owner: anaccdv
--

ALTER TABLE ONLY public.endereco
    ADD CONSTRAINT endereco_pkey PRIMARY KEY (id);


--
-- Name: entrega_pkey; Type: CONSTRAINT; Schema: public; Owner: anaccdv
--

ALTER TABLE ONLY public.entrega
    ADD CONSTRAINT entrega_pkey PRIMARY KEY (id);


--
-- Name: farmacia_pkey; Type: CONSTRAINT; Schema: public; Owner: anaccdv
--

ALTER TABLE ONLY public.farmacia
    ADD CONSTRAINT farmacia_pkey PRIMARY KEY (id);


--
-- Name: funcionario_pk; Type: CONSTRAINT; Schema: public; Owner: anaccdv
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_pk PRIMARY KEY (cpf, tipo);


--
-- Name: medicamento_pkey; Type: CONSTRAINT; Schema: public; Owner: anaccdv
--

ALTER TABLE ONLY public.medicamento
    ADD CONSTRAINT medicamento_pkey PRIMARY KEY (id, tem_receita);


--
-- Name: sede_unica; Type: CONSTRAINT; Schema: public; Owner: anaccdv
--

ALTER TABLE ONLY public.farmacia
    ADD CONSTRAINT sede_unica EXCLUDE USING gist (tipo WITH =) WHERE (((tipo)::text = 'SEDE'::text));


--
-- Name: venda_pkey; Type: CONSTRAINT; Schema: public; Owner: anaccdv
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT venda_pkey PRIMARY KEY (id);


--
-- Name: endereco_cliente_cliente_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: anaccdv
--

ALTER TABLE ONLY public.endereco_cliente
    ADD CONSTRAINT endereco_cliente_cliente_fk_fkey FOREIGN KEY (cliente_fk) REFERENCES public.cliente(cpf);


--
-- Name: endereco_fk; Type: FK CONSTRAINT; Schema: public; Owner: anaccdv
--

ALTER TABLE ONLY public.farmacia
    ADD CONSTRAINT endereco_fk FOREIGN KEY (endereco_fk) REFERENCES public.endereco(id);


--
-- Name: entrega_endereco_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: anaccdv
--

ALTER TABLE ONLY public.entrega
    ADD CONSTRAINT entrega_endereco_fk_fkey FOREIGN KEY (endereco_fk, cpf_cliente) REFERENCES public.endereco_cliente(id, cliente_fk);


--
-- Name: farmacia_fk; Type: FK CONSTRAINT; Schema: public; Owner: anaccdv
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT farmacia_fk FOREIGN KEY (farmarcia_fk) REFERENCES public.farmacia(id);


--
-- Name: funcionario_fk; Type: FK CONSTRAINT; Schema: public; Owner: anaccdv
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT funcionario_fk FOREIGN KEY (funcionario_fk, tipo_fun) REFERENCES public.funcionario(cpf, tipo) ON DELETE RESTRICT;


--
-- Name: gerente_fk; Type: FK CONSTRAINT; Schema: public; Owner: anaccdv
--

ALTER TABLE ONLY public.farmacia
    ADD CONSTRAINT gerente_fk FOREIGN KEY (gerente_fk, tipo_fun) REFERENCES public.funcionario(cpf, tipo) ON DELETE RESTRICT;


--
-- Name: medicamento_fk; Type: FK CONSTRAINT; Schema: public; Owner: anaccdv
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT medicamento_fk FOREIGN KEY (medicamento_fk, tem_receita) REFERENCES public.medicamento(id, tem_receita);


--
-- Name: venda_cliente_fk_fkey; Type: FK CONSTRAINT; Schema: public; Owner: anaccdv
--

ALTER TABLE ONLY public.venda
    ADD CONSTRAINT venda_cliente_fk_fkey FOREIGN KEY (cliente_fk) REFERENCES public.cliente(cpf);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--


--
-- COMANDOS ADICIONAIS
-- 
-- ALUNA: ANA CAROLINA CHAVES DE VASCONCELOS

-----------------------------------DEVEM FUNCIONAR------------------------------------------------------

INSERT INTO endereco(id, estado, cidade, bairro) VALUES(1,'PB', 'Campina Grande', 'Castelo Branco'), (2,'PB', 'Joao Pessoa', 'Cabo Branco');

--- OBS: Farmacia pode iniciar sem um gerente || Adicionando uma farmacia

INSERT INTO farmacia(id, endereco_fk, nome, tipo) VALUES(1, 1, 'rede pharma', 'SEDE');

--- Adicionando funcionarios na farmacia ja cadastrada

INSERT INTO funcionario(cpf, nome, tipo, farmacia_fk) VALUES ('12345678901', 'ANA CAROLINA', 'Vendedor',1), ('12345678902', 'EDUARDO', 'Entregador',1),
('12345678903', 'LUCIANO', 'Administrador',1), ('12345678904', 'LEANDRA', 'Farmaceutico',1);

--- Alocando o gerente responsavel da farmacia cadastrada

UPDATE farmacia SET gerente_fk = '12345678903', tipo_fun = 'Administrador' WHERE id=1;

--- Adicionando um cliente ( tem que ser maior de 18 anos)

INSERT INTO cliente(nome, cpf, data_nascimento) VALUES('VANESSA', '12345678905', '2002-01-01');

--- Adicionando um medicamento ( so a bula que pode vir vazia)

INSERT INTO medicamento(id, nome, receitado, preco, bula) VALUES(1, 'DORFLEX', FALSE, 3.50, 'A BULA AQUI OK');

--- Adicionando uma venda 

INSERT INTO venda(id, cliente_fk, medicamento_fk, funcionario_fk, tipo_fun, receitado) VALUES(1,NULL, 1, '12345678901','Vendedor', FALSE);

----------------------------------NÃO DEVEM FUNCIONAR----------------------------------------------------

--- MEDICAMENTO COM NOME VAZIO

INSERT INTO medicamento(id, nome, receitado, preco, bula) VALUES(2, null , FALSE, 7.50, 'A BULA AQUI OK');

-- JA FOI CADASTRADA UMA SEDE

INSERT INTO farmacia VALUES(2, 2, 'PAGUEMENOS', 'SEDE', '12345678904', 'Farmaceutico');

-- CLIENTE TEM QUE SER MAIOR QUE 18 ANOS

INSERT INTO cliente VALUES('FERNANDO', '12345678905', '2006-06-01');

-- SP NAO FAZ PARTE DO NORDESTE( E AINDA BEM) 

INSERT INTO endereco VALUES(2, 'SP', 'nao sei', 'vuvuvuvu');

-- VENDA NAO PODE SER FEITA POR FUNCIONANDO COM FUNCAO CAIXA

INSERT INTO venda(id, cliente_fk, medicamento_fk, funcionario_fk, tipo_fun, receitado) VALUES(2,NULL, 1, '12345678902','Caixa', FALSE);

-- GERENTE SO PODE SER ADM

UPDATE farmacia SET gerente_fk = '12345678901', tipo_fun = 'Vendedor' WHERE id=1;

-- NAO PODE DELETAR UM FUNCIONARIO QUE ESTEJA VINCULADO A UMA VENDA

DELETE FROM funcionario WHERE cpf = '12345678901';



