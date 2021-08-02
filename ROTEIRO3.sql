--
-- COMANDOS ADICIONAIS
--

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

