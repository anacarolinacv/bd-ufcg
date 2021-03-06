-- ROTEIRO 1 - BD UFCG 
-- ANA CAROLINA CHAVES DE VASCONCELOS -- 118110388

--- OBS: PODE NOTAR QUE EU COLOQUEI MUITAS COISAS COMO PROIBIDOS SEREM NULL, MAS ISSO FOI MAIS EM QUESTAO DO CONTEXTO MESMO. ESSES TIPOS DE SITUACOES CADA INFORMACAO TENDE A SER IMPORTANTE E ESSENCIAL. 
-- obs: em dados que nao tem tamanho padrao, eu coloquei um tamanho alto para nao ter perigo de nao dar (nao sei se isso eh uma boa pratica)
-- CRIACAO TABELA AUTOMOVEL

CREATE TABLE AUTOMOVEL(
MODELO VARCHAR(30) NOTNULL,
MARCA VARCHAR(30) NOTNULL,
PLACA CHAR(7) NOTNULL,
COR VARCHAR(20) NOTNULL,
RENAVAM INTEGER NOTNULL
);

-- CRIACAO TABELA SEGURO - CASO A COBERTURA FOR NULL SERA CONSIDERADA COMO ILIMITADA

CREATE TABLE SEGURO(
APOLICE_SEGURO VARCHAR(50) NOTNULL,
VALOR_SEGURO NUMERIC NOT NULL,
CPF_SEGURADO CHAR(11) NOT NULL,
INICIO_CONTRATO DATE NOTNULL,
VENCIMENTO DATE NOT NULL,
PLACA_AUTOMOVEL CHAR(7) NOTNULL,
COBERTURA TEXT SET NULL
);

-- CRIACAO DA TABELA SEGURADO

CREATE TABLE SEGURADO(
NOME VARCHAR(40) NOTNULL,
DATA_NASC DATE NOTNULL,
CPF CHAR(11) NOTNULL,
RG VARCHAR(15) NOTNULL,
TELEFONE VARCHAR(15) NOTNULL,
EMAIL VARCHAR(100) NOTNULL,
ENDERECO VARCHAR(100) NOTNULL,
);

-- CRIACAO DA TABELA SINISTRO

CREATE TABLE SINISTRO(
NUMERO_OCORRENCIA SERIAL NOTNULL,
TIPO_OCORRENCIA TEXT NOTNULL,
DATA_OCORRIDO TIMESTAMP NOTNULL,
APOLICE_SEGURO VARCHAR(30) NOTNULL

);

-- CRIACAO DA TABELA PERITO

CREATE TABLE PERITO(
NOME VARCHAR(40) NOTNULL,
DATA_NASC DATE NOTNULL,
CPF CHAR(11) NOTNULL,
RG VARCHAR(15) NOTNULL,
EMAIL VARCHAR(100)
);

-- CRIACAO DA TABELA PERICIA

CREATE TABLE PERICIA(
DESCRICAO_DANOS TEXT NOTNULL,
PLACA_AUTOMOVEL CHAR(7) NOTNULL,
CPF_PERITO CHAR(11) NOTNULL
);

-- CRIACAO DA TABELA REPARO 

CREATE TABLE REPARO(
PLACA_AUTOMOVEL CHAR(7) NOTNULL,
RELATO_OCORRIDO TEXT NOTNULL,
VALOR_CONSERTO NUMERIC NOTNULL,
CNPJ_OFICINA CHAR(14) NOT NULL,
PERDA_TOTAL BOOLEAN
);

-- CRIACAO DA TABELA DE OFICINA 

CREATE TABLE OFICINA(
NOME VARCHAR(40) NOTNULL,
LOCALIDADE VARCHAR(50) NOTNULL,
CNPJ CHAR(14) NOTNULL

-- TERCEIRA QUESTAO - DEFINIR AS CHAVES PRIMARIAS

ALTER TABLE AUTOMOVEL ADD PRIMARY KEY (PLACA);
ALTER TABLE SEGURO ADD PRIMARY KEY (APOLICE_SEGURO);
ALTER TABLE SEGURADO ADD PRIMARY KEY (CPF);
ALTER TABLE SINISTRO ADD PRIMARY KEY (NUMERO_OCORRENCIA);
ALTER TABLE PERITO ADD PRIMARY KEY (CPF);
ALTER TABLE PERICIA ADD PRIMARY KEY (PLACA_AUTOMOVEL);
ALTER TABLE REPARO ADD PRIMARY KEY (PLACA_AUTOMOVEL);
ALTER TABLE OFICINA ADD PRIMARY KEY (CNPJ);

-- QUARTA QUESTAO - DEFINIR AS CHAVES ESTRANGEIRAS

ALTER TABLE SEGURO ADD CONSTRAINT seguro_placa_automovel_fkey FOREIGN KEY (PLACA_AUTOMOVEL) REFERENCES AUTOMOVEL (PLACA);

ALTER TABLE SEGURO ADD CONSTRAINT seguro_cpf_segurado_fkey FOREIGN KEY (CPF_SEGURADO) REFERENCES SEGURADO (CPF);

ALTER TABLE SINISTRO ADD CONSTRAINT sinistro_apolice_seguro_fkey FOREIGN KEY (APOLICE_SEGURO) REFERENCES SEGURO (APOLICE_SEGURO);

ALTER TABLE PERICIA ADD CONSTRAINT pericia_placa_automovel_fkey FOREIGN KEY (PLACA_AUTOMOVEL) REFERENCES AUTOMOVEL (PLACA);

ALTER TABLE PERICIA ADD CONSTRAINT pericia_cpf_perito_fkey FOREIGN KEY (CPF_PERITO) REFERENCES PERITO (CPF);

ALTER TABLE REPARO ADD CONSTRAINT reparo_placa_automovel_observacoes_perito_fkey FOREIGN KEY (PLACA_AUTOMOVEL, RELATO_OCORRIDO) REFERENCES PERICIA (PLACA_AUTOMOVEL, DESCRICAO_DANOS);

ALTER TABLE REPARO ADD CONSTRAINT reparo_cnpj_oficina_fkey FOREIGN KEY (CNPJ_OFICINA) REFERENCES OFICINA (CNPJ);

-- QUINTA QUESTAO 

/*
Boa parte dos atributos que coloquei julgo serem bastante importantes para a situacao envolvida como um todo, mas principalmente para questao de historico do carro para outras situacoes, como venda
*/

-- SEXTA QUESTAO - REMOVER AS TABELAS

DROP TABLE REPARO CASCADE;
DROP TABLE OFICINA;
DROP TABLE PERICIA CASCADE;
DROP TABLE PERITO;
DROP TABLE SEGURO CASCADE;
DROP TABLE SEGURADO;
DROP TABLE SINISTRO CASCADE;
DROP TABLE AUTOMOVEL;

-- SETIMA/OITAVA QUESTOES RELACIONADAS A CRIACAO DAS TABELAS A PARTIR DAS CONSTRAINTS OBSERVADAS. 

-- CRIACAO TABELA AUTOMOVEL

CREATE TABLE AUTOMOVEL(
NUMERO_CHASSI CHAR(17) NOT NULL, 
MODELO VARCHAR(30),
MARCA VARCHAR(30),
PLACA CHAR(7) NOT NULL,
COR VARCHAR(20),
ANO_FABRICACAO DATE NOT NULL, 
RENAVAM INTEGER NOT NULL,
PRIMARY KEY(PLACA)
);

-- CRIACAO DA TABELA SEGURADO

CREATE TABLE SEGURADO(
NOME VARCHAR(40) NOT NULL,
DATA_NASC DATE NOT NULL,
CPF CHAR(11) NOT NULL,
RG VARCHAR(15) NOT NULL,
TELEFONE VARCHAR(15) NOT NULL,
EMAIL VARCHAR(100) NOT NULL,
ENDERECO VARCHAR(100) NOT NULL,
PRIMARY KEY(CPF)
);

-- CRIACAO DA TABELA PERITO

CREATE TABLE PERITO(
NOME VARCHAR(40) NOT NULL,
DATA_NASC DATE NOT NULL,
CPF CHAR(11) NOT NULL,
RG VARCHAR(15) NOT NULL,
EMAIL VARCHAR(100),
PRIMARY KEY(CPF)
);

-- CRIACAO TABELA SEGURO - CASO A COBERTURA FOR NULL SERA CONSIDERADA COMO ILIMITADA

CREATE TABLE SEGURO(
APOLICE_SEGURO VARCHAR(50) CONSTRAINT seguro_pkey PRIMARY KEY,
VALOR_SEGURO NUMERIC NOT NULL,
CPF_SEGURADO CHAR(11) NOT NULL,
INICIO_CONTRATO DATE NOT NULL,
VENCIMENTO DATE NOT NULL,
PLACA_AUTOMOVEL CHAR(7) NOT NULL,
COBERTURA TEXT,
CONSTRAINT seguro_placa_automovel_fkey FOREIGN KEY (PLACA_AUTOMOVEL) 
REFERENCES AUTOMOVEL(PLACA),
CONSTRAINT seguro_cpf_segurado_fkey FOREIGN KEY (CPF_SEGURADO)
REFERENCES SEGURADO (CPF)
);

-- CRIACAO DA TABELA SINISTRO

CREATE TABLE SINISTRO(
NUMERO_OCORRENCIA SERIAL NOT NULL,
TIPO_OCORRENCIA TEXT NOT NULL,
DATA_OCORRIDO TIMESTAMP NOT NULL,
APOLICE_SEGURO VARCHAR(30) NOT NULL,
LOCALIZACAO VARCHAR(50) NOT NULL,
PRIMARY KEY(NUMERO_OCORRENCIA),
CONSTRAINT sinistro_apolice_seguro_fkey FOREIGN KEY (APOLICE_SEGURO) REFERENCES SEGURO (APOLICE_SEGURO)

);

-- CRIACAO DA TABELA PERICIA

CREATE TABLE PERICIA(
DESCRICAO_DANOS TEXT NOT NULL,
PLACA_AUTOMOVEL CHAR(7) NOT NULL,
CPF_PERITO CHAR(11) NOT NULL,
PRIMARY KEY(PLACA_AUTOMOVEL),
CONSTRAINT pericia_placa_automovel_fkey FOREIGN KEY (PLACA_AUTOMOVEL) REFERENCES AUTOMOVEL (PLACA),
CONSTRAINT pericia_cpf_perito_fkey FOREIGN KEY (CPF_PERITO) REFERENCES PERITO (CPF)

);

-- CRIACAO DA TABELA DE OFICINA 

CREATE TABLE OFICINA(
NOME VARCHAR(40) NOT NULL,
LOCALIDADE VARCHAR(50) NOT NULL,
CNPJ CHAR(14) NOT NULL,
DONO VARCHAR(50),
PRIMARY KEY(CNPJ)
);

-- CRIACAO DA TABELA REPARO 

CREATE TABLE REPARO(
PLACA_AUTOMOVEL CHAR(7) NOTNULL,
RELATO_OCORRIDO TEXT NOTNULL,
VALOR_CONSERTO NUMERIC NOTNULL,
CNPJ_OFICINA CHAR(14) NOT NULL,
PERDA_TOTAL BOOLEAN,
HORARIO_FINALIZADO TIMESTAMP,
PRIMARY KEY(PLACA_AUTOMOVEL),
CONSTRAINT reparo_placa_automovel_observacoes_perito_fkey FOREIGN KEY (PLACA_AUTOMOVEL, RELATO_OCORRIDO) REFERENCES PERICIA (PLACA_AUTOMOVEL, DESCRICAO_DANOS),
CONSTRAINT reparo_cnpj_oficina_fkey FOREIGN KEY (CNPJ_OFICINA) REFERENCES OFICINA (CNPJ);

);

-- obs: levar em consideracao que a ordem de drop eh importante por causa das FK
-- NONA QUESTAO -- DROP BANCO
-- COLOQUEI CASCADE NAS TABELAS PARA DELETAR AS REFERENCIAS EM OUTRAS TABELAS

DROP TABLE REPARO CASCADE;
DROP TABLE OFICINA;
DROP TABLE PERICIA CASCADE;
DROP TABLE PERITO;
DROP TABLE SEGURO CASCADE;
DROP TABLE SEGURADO;
DROP TABLE SINISTRO CASCADE;
DROP TABLE AUTOMOVEL;
