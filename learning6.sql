CREATE DATABASE exeConstraint
GO
USE exeConstraint

--1. Tabela de Funcionarios
--   A FK para Departamento nao entra aqui: e criada no item 5.
CREATE TABLE Funcionario(
    CodFun INT CONSTRAINT PK_Funcionario PRIMARY KEY IDENTITY(1,1),
    Nome VARCHAR(80) NOT NULL,
    CPF NUMERIC(11) CONSTRAINT UN_Func_CPF UNIQUE,
    RG NUMERIC(12) CONSTRAINT UN_Func_RG UNIQUE,
    Sexo CHAR(1) CONSTRAINT CK_Func_sexo CHECK(Sexo IN ('M','F')),
    Categoria VARCHAR(15) CONSTRAINT CK_Func_categoria
        CHECK(Categoria IN ('Auxiliar','Supervisor','Terceirizado','Contratado','Coordenador')),
    Idade INT CONSTRAINT CK_Func_idade CHECK(Idade BETWEEN 16 AND 65),
    CodDepto INT
)

--2. Tabela de Departamentos
CREATE TABLE Departamento(
    CodDepto INT CONSTRAINT PK_Departamento PRIMARY KEY IDENTITY(1,1),
    Nome VARCHAR(50) NOT NULL,
    Descricao VARCHAR(100),
    CodGerente INT CONSTRAINT FK_Depto_gerente FOREIGN KEY REFERENCES Funcionario(CodFun)
)

--3. Tabela de Projetos (numeracao automatica a partir de 100)
CREATE TABLE Projeto(
    CodProj INT CONSTRAINT PK_Projeto PRIMARY KEY IDENTITY(100,1),
    Nome VARCHAR(50) NOT NULL,
    Descricao VARCHAR(100)
)

--4. Participacao dos funcionarios nos projetos
CREATE TABLE Participacao(
    CodFun INT NOT NULL CONSTRAINT FK_Part_func FOREIGN KEY REFERENCES Funcionario(CodFun),
    CodProj INT NOT NULL CONSTRAINT FK_Part_proj FOREIGN KEY REFERENCES Projeto(CodProj),
    DtInicio DATE,
    DtFim DATE,
    CONSTRAINT CK_Part_datas CHECK(DtInicio < DtFim)
)

--5. Ligacao entre Funcionario e Departamento
ALTER TABLE Funcionario
    ADD CONSTRAINT FK_Func_depto FOREIGN KEY (CodDepto) REFERENCES Departamento(CodDepto)


--6. Chave primaria composta em Participacao
ALTER TABLE Participacao
    ADD CONSTRAINT PK_Participacao PRIMARY KEY (CodFun, CodProj)

--7. Departamentos
INSERT INTO Departamento(Nome) VALUES
    ('CONTAS A PAGAR'),
    ('CONTAS A RECEBER'),
    ('FATURAMENTO'),
    ('VENDAS'),
    ('COMPRAS')

--8. Projetos (recebem os codigos 100 a 104)
INSERT INTO Projeto(Nome, Descricao) VALUES
    ('Portal do Cliente', 'Site de autoatendimento'),
    ('Troca de ERP', 'Migracao do sistema de gestao'),
    ('Loja Online', 'E-commerce proprio'),
    ('Automacao Fiscal', 'Emissao automatica de notas'),
    ('App de Vendas', 'Aplicativo para os vendedores')

--9. Funcionarios (recebem os codigos 1 a 10)
INSERT INTO Funcionario(Nome, CPF, RG, Sexo, Categoria, Idade, CodDepto) VALUES
    ('Ana Souza',        11111111111, 100000001, 'F', 'Coordenador',  42, 1),
    ('Bruno Lima',       22222222222, 100000002, 'M', 'Auxiliar',     23, 1),
    ('Carla Dias',       33333333333, 100000003, 'F', 'Supervisor',   35, 2),
    ('Diego Alves',      44444444444, 100000004, 'M', 'Contratado',   28, 2),
    ('Elaine Rocha',     55555555555, 100000005, 'F', 'Coordenador',  47, 3),
    ('Fabio Nunes',      66666666666, 100000006, 'M', 'Terceirizado', 31, 3),
    ('Gisele Prado',     77777777777, 100000007, 'F', 'Supervisor',   38, 4),
    ('Heitor Campos',    88888888888, 100000008, 'M', 'Auxiliar',     19, 4),
    ('Ivone Martins',    99999999999, 100000009, 'F', 'Coordenador',  55, 5),
    ('Joao Pereira',     12345678901, 100000010, 'M', 'Contratado',   26, 5)

--10. Tres funcionarios para cada projeto
INSERT INTO Participacao(CodFun, CodProj, DtInicio, DtFim) VALUES
    (1, 100, '2025-01-06', '2025-06-30'),
    (2, 100, '2025-01-06', '2025-06-30'),
    (3, 100, '2025-02-03', '2025-06-30'),
    (4, 101, '2025-01-13', '2025-08-29'),
    (5, 101, '2025-01-13', '2025-08-29'),
    (6, 101, '2025-03-03', '2025-08-29'),
    (7, 102, '2025-02-03', '2025-09-30'),
    (8, 102, '2025-02-03', '2025-09-30'),
    (9, 102, '2025-04-01', '2025-09-30'),
    (10, 103, '2025-03-03', '2025-10-31'),
    (1, 103, '2025-03-03', '2025-10-31'),
    (5, 103, '2025-05-05', '2025-10-31'),
    (2, 104, '2025-04-01', '2025-11-28'),
    (7, 104, '2025-04-01', '2025-11-28'),
    (9, 104, '2025-06-02', '2025-11-28')

--11. Chefes dos departamentos
UPDATE Departamento SET CodGerente = 1 WHERE Nome = 'CONTAS A PAGAR'
UPDATE Departamento SET CodGerente = 3 WHERE Nome = 'CONTAS A RECEBER'
UPDATE Departamento SET CodGerente = 5 WHERE Nome = 'FATURAMENTO'
UPDATE Departamento SET CodGerente = 7 WHERE Nome = 'VENDAS'
UPDATE Departamento SET CodGerente = 9 WHERE Nome = 'COMPRAS'

--12. Cidade do funcionario com valor padrao 'Franca'
--    WITH VALUES preenche tambem as linhas ja cadastradas.
ALTER TABLE Funcionario
    ADD Cidade VARCHAR(50) CONSTRAINT DF_Func_cidade DEFAULT 'Franca' WITH VALUES


--13. Funcionario novo sem cidade: deve gravar 'Franca'
INSERT INTO Funcionario(Nome, CPF, RG, Sexo, Categoria, Idade) VALUES
    ('Karina Melo', 10987654321, 100000011, 'F', 'Auxiliar', 22)

SELECT Nome, Cidade FROM Funcionario WHERE Nome = 'Karina Melo'

--14. Projeto novo (codigo 105) com 5 funcionarios
INSERT INTO Projeto(Nome, Descricao) VALUES ('Novo CRM', 'Gestao de relacionamento')

INSERT INTO Participacao(CodFun, CodProj, DtInicio, DtFim) VALUES
    (1, 105, '2025-07-01', '2026-01-30'),
    (3, 105, '2025-07-01', '2026-01-30'),
    (5, 105, '2025-07-01', '2026-01-30'),
    (8, 105, '2025-08-01', '2026-01-30'),
    (10, 105, '2025-08-01', '2026-01-30')

--15. Funcionarios sem departamento
SELECT CodFun, Nome FROM Funcionario WHERE CodDepto IS NULL

UPDATE Funcionario SET CodDepto = 4 WHERE CodDepto IS NULL

--16. Valor padrao para os campos Descricao
ALTER TABLE Departamento
    ADD CONSTRAINT DF_Depto_descricao DEFAULT 'Sem descricao' FOR Descricao
ALTER TABLE Projeto
    ADD CONSTRAINT DF_Proj_descricao DEFAULT 'Sem descricao' FOR Descricao

--17. Exclusao das tabelas
--    As FKs entre Funcionario e Departamento sao circulares, entao uma delas
--    precisa cair antes dos DROPs.
ALTER TABLE Departamento DROP CONSTRAINT FK_Depto_gerente
GO
DROP TABLE Participacao
DROP TABLE Projeto
DROP TABLE Funcionario
DROP TABLE Departamento

SELECT Nome, CPF
FROM Funcionario AS f
INNER JOIN Departamento AS d
ON f.codDepto = d.codDepto;

SELECT nome
FROM Funcionario AS f
INNER JOIN Departamento AS d
ON f.codDepto = d.codDepto
WHERE f.codDepto IS NULL;

SELECT count(*) AS qtdeFuncionarios
FROM Funcionario AS f
INNER JOIN Departamento AS d
ON f.codDepto = d.codDepto
WHERE f.categoria = 'Auxíliar' && d.nomeDepto = 'Compras';

SELECT nome, CPF
FROM Funcionario AS f
INNER JOIN Projetos AS p
ON f.codFun = p.codFun
WHERE p.DataInicio BETWEEN '2025-07-01' AND '2025-07-31';

SELECT d.Nome, f.Nome
FROM Funcionario AS f
INNER JOIN Departamento AS d
ON f.codFun = d.codGerente;

SELECT 
    MAX(idade) AS maior_idade, 
    AVG(idade) AS idade_media
FROM 
    Funcionario
WHERE 
    Departamento IN ('Faturamento', 'Vendas', 'Compras');

SELECT f.Nome, p.Nome, p.Descricao
FROM Funcionario AS f
INNER JOIN Participacao AS pa
ON f.codFun = pa.codFun
INNER JOIN Projeto AS p
ON pa.codProj = p.codProj;

SELECT f.Nome, d.Nome, g.Nome
FROM Funcionario AS f
INNER JOIN Departamento AS d
ON f.codDepto = d.codDepto
INNER JOIN Funcionario AS g
ON d.codGerente = g.codFun
ORDER BY d.Nome ASC, f.Nome ASC;