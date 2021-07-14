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

ALTER TABLE ONLY public.funcionario DROP CONSTRAINT fk_funcionario;
ALTER TABLE ONLY public.tarefas DROP CONSTRAINT fk_func;
ALTER TABLE ONLY public.tarefas DROP CONSTRAINT pk_tarefas;
ALTER TABLE ONLY public.funcionario DROP CONSTRAINT funcionario_pkey;
DROP TABLE public.tarefas;
DROP TABLE public.funcionario;
SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: funcionario; Type: TABLE; Schema: public; Owner: anaccdv
--

CREATE TABLE public.funcionario (
    cpf character(11) NOT NULL,
    data_nasc date NOT NULL,
    nome text NOT NULL,
    funcao character varying(11) NOT NULL,
    nivel character(1) NOT NULL,
    superior_cpf character varying(11),
    CONSTRAINT check_func CHECK ((((funcao)::text = 'LIMPEZA'::text) OR ((funcao)::text = 'SUP_LIMPEZA'::text))),
    CONSTRAINT check_rol CHECK (((nivel = 'J'::bpchar) OR (nivel = 'P'::bpchar) OR (nivel = 'S'::bpchar))),
    CONSTRAINT check_sup CHECK (((((funcao)::text = 'LIMPEZA'::text) AND (superior_cpf IS NOT NULL)) OR (((funcao)::text = 'SUP_LIMPEZA'::text) AND (superior_cpf IS NULL))))
);


ALTER TABLE public.funcionario OWNER TO anaccdv;

--
-- Name: tarefas; Type: TABLE; Schema: public; Owner: anaccdv
--

CREATE TABLE public.tarefas (
    id bigint NOT NULL,
    descricao text NOT NULL,
    func_resp_cpf character(11),
    prioridade smallint NOT NULL,
    status character(1) NOT NULL,
    CONSTRAINT check_prioridade CHECK (((prioridade >= 0) AND (prioridade <= 5))),
    CONSTRAINT func_idnull CHECK (((((status = 'C'::bpchar) OR (status = 'E'::bpchar)) AND (func_resp_cpf IS NOT NULL)) OR (status = 'P'::bpchar)))
);


ALTER TABLE public.tarefas OWNER TO anaccdv;

--
-- Data for Name: funcionario; Type: TABLE DATA; Schema: public; Owner: anaccdv
--

INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678911', '1980-05-07', 'Pedro da Silva', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('12345678912', '1980-03-08', 'Jose da Silva', 'LIMPEZA', 'J', '12345678911');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('07393368005', '1999-05-19', 'ANA CAROLINA', 'SUP_LIMPEZA', 'P', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('07393368010', '1999-05-19', 'CAROL HIHI', 'SUP_LIMPEZA', 'P', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('56221089080', '2005-03-21', 'LULU ETC', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('56221089090', '2005-03-21', 'TAINARA', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('25654948950', '1999-07-19', 'GABRIELA', 'LIMPEZA', 'J', '07393368005');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('25654948940', '1999-07-19', 'GABRI', 'LIMPEZA', 'J', '07393368005');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('25654948943', '1999-07-19', 'alice', 'LIMPEZA', 'J', '07393368005');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('25654948946', '1999-07-19', 'fernanda', 'LIMPEZA', 'J', '07393368005');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('25654948947', '1999-07-19', 'jennifer', 'LIMPEZA', 'J', '07393368005');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('25654948941', '1999-07-19', 'mateus', 'LIMPEZA', 'J', '07393368005');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('32323232954', '1993-01-11', 'FREDERICA', 'LIMPEZA', 'J', '25654948941');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('32323232980', '1993-01-11', 'FERNADO', 'LIMPEZA', 'J', '25654948941');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('98765432122', '1988-08-01', 'LUIGI', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('98765432111', '1988-08-09', 'MARIO', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('32323232911', '1999-07-19', 'mateus', 'LIMPEZA', 'J', '07393368005');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('3232911    ', '1988-08-09', 'MARIO', 'SUP_LIMPEZA', 'S', NULL);
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('26216065041', '1993-01-11', 'ihu', 'LIMPEZA', 'J', '26216065041');
INSERT INTO public.funcionario (cpf, data_nasc, nome, funcao, nivel, superior_cpf) VALUES ('11111111111', '1975-04-12', 'alguem aleatorio', 'SUP_LIMPEZA', 'S', NULL);


--
-- Data for Name: tarefas; Type: TABLE DATA; Schema: public; Owner: anaccdv
--

INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483653, 'limpar portas do 1o andar', '32323232911', 2, 'P');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483640, 'aparar gramas da área frontal', '3232911    ', 3, 'P');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483646, 'limpar chao do corredor central', '98765432111', 0, 'C');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483647, 'limpar janelas da sala 203', '98765432122', 1, 'C');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483651, 'limpar portas do 1o andar', '32323232911', 5, 'P');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (2147483652, 'limpar portas do 2o andar', '32323232911', 5, 'P');
INSERT INTO public.tarefas (id, descricao, func_resp_cpf, prioridade, status) VALUES (126546547, 'trancar portas 3o andar', '11111111111', 0, 'E');


--
-- Name: funcionario_pkey; Type: CONSTRAINT; Schema: public; Owner: anaccdv
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT funcionario_pkey PRIMARY KEY (cpf);


--
-- Name: pk_tarefas; Type: CONSTRAINT; Schema: public; Owner: anaccdv
--

ALTER TABLE ONLY public.tarefas
    ADD CONSTRAINT pk_tarefas PRIMARY KEY (id);


--
-- Name: fk_func; Type: FK CONSTRAINT; Schema: public; Owner: anaccdv
--

ALTER TABLE ONLY public.tarefas
    ADD CONSTRAINT fk_func FOREIGN KEY (func_resp_cpf) REFERENCES public.funcionario(cpf) ON DELETE SET NULL;


--
-- Name: fk_funcionario; Type: FK CONSTRAINT; Schema: public; Owner: anaccdv
--

ALTER TABLE ONLY public.funcionario
    ADD CONSTRAINT fk_funcionario FOREIGN KEY (superior_cpf) REFERENCES public.funcionario(cpf);


--
-- PostgreSQL database dump complete
--

