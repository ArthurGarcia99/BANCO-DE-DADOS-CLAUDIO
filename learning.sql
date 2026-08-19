CREATE DATABASE hospital

USE hospital

CREATE TABLE especialidades (
	codEsp INT PRIMARY KEY IDENTITY(10, 10),
	nome varchar(40),
)

CREATE TABLE medicos (
	codMed INT PRIMARY KEY IDENTITY (1,1),
	nome VARCHAR(80),
	idade int,
	salario MONEY,
	codEsp INT FOREIGN KEY REFERENCES especialidades(codEsp),
)

SELECT * FROM medicos
SELECT * FROM especialidades

-- CADASTRO ESPECIALIDADES
INSERT INTO especialidades (nome)
VALUES 
	('OTORRINO'),
	('OBSTETRA'),
	('PEDIATRA'),
	('CARDIOLOGISTA'),
	('DERMATOLOGISTA'),
	('ORTOPEDISTA')


-- CADASTRO MÉDICOS
INSERT INTO medicos
VALUES
	('JOÃO', 48, 800, 10),
	('JOSÉ', 35, 1200, 10),
	('ANA', 47, 1400, 30),
	('IVO', 51, 750, NULL),
	('SILVIO', NULL, 2550, 20),
	('ADÃO', 62, 1950, 50),
	('EVA', 42, 800, NULL),
	('JOANA', 39, 1200, 10),
	('AFONSO', NULL, 800, 30)

-- CADASTRO DE MEDICOS PREENCHENDO APENAS ALGUNS CAMPOS(MAIS USADO):
INSERT INTO medicos (nome, idade, salario)
VALUES
	('MARINA', 40, 750),
	('MARIA', 41, 1950)


INSERT INTO medicos (nome, salario)
VALUES
	('RODOLFO', 1330)

CREATE TABLE pacientes(
	codPac INT PRIMARY KEY IDENTITY (1,1),
	nome varchar(40),
	fone varchar(30)
)

CREATE TABLE consulta (
	codCons INT PRIMARY KEY IDENTITY (1,1), -- PK COM AUTONUMERAÇÃO
	data date,
	codMed INT FOREIGN KEY REFERENCES medicos(codMed) NOT NULL, -- CAMPO OBRIGATORIO
	codPac INT FOREIGN KEY REFERENCES pacientes(codPac) NOT NULL -- CAMPO OBRIGATORIO
)

SELECT * FROM medicos AS M INNER JOIN consulta AS C
							ON M.codMed = C.codMed
							INNER JOIN pacientes AS P
							ON P.codPac = C.codPac
							INNER JOIN especialidades AS E
							ON E.codEsp = M.codEsp
WHERE
	C.data >- '2026/05/01' AND C.data < '2026/05/31'
	AND
	E.nome = 'PEDIATRA'

--INSERIR NA TABELA CLIENTES
INSERT INTO clientes
VALUES
	('Lucas Ferreira', '84729156320'),
	('Mariana Souza', '39184752604'),
	('Carlos Mendes', '62591837450'),
	('Ana Oliveira', '91827463501'),
	('Pedro Santos', '57381926408');

--INSERIR NA TABELA CONSULTAS
INSERT INTO consultas 
VALUES
	('2026-06-10 08:00:00', 'Consultório Central', 1, 1),
	('2026-06-10 09:00:00', 'Clínica Vida', 2, 2),
	('2026-06-10 10:00:00', 'Consultório Central', 3, 3),
	('2026-06-11 08:30:00', 'Centro Médico São Lucas', 1, 4),
	('2026-06-11 09:30:00', 'Clínica Vida', 2, 5),
	('2026-06-11 11:00:00', 'Consultório Central', 3, 1),
	('2026-06-12 08:00:00', 'Centro Médico São Lucas', 1, 2),
	('2026-06-12 09:00:00', 'Clínica Bem Estar', 2, 3),
	('2026-06-12 10:30:00', 'Consultório Central', 3, 4),
	('2026-06-13 14:00:00', 'Clínica Bem Estar', 1, 5);

--ATUALIZAR UM NOME DO MEDICO
UPDATE medicos set nome = 'JOAO DA SILVA'
WHERE nome = 'JOAO'

--ATUALIZAR DATA DA CONSULTA
UPDATE consultas SET data = '15/10/2026'
WHERE codCons = 3

--APAGAR A PRIMEIRA CONSULTA
DELETE consultas
WHERE codCons = 1

--LISTA OS NOMES DOS MEDICOS E A ESPECIALIDADE DE CADA UM
SELECT a.nome, E.nome AS espMedica
FROM medicos AS M INNER JOIN especialidades AS E
				ON M.codEsp = E.codEsp

--LISTA OS MEDICOS QUE NAO TEM ESPECIALIDADES
SELECT *
FROM medicos
WHERE codEsp IS NULL

--LISTA AS CONSULTAS FEITAS PELO CONVENIO UNIMED NO MES DE ABRIL
SELECT *
FROM consultas
WHERE convenio = 'UNIMED'
	  AND
	  data >= '2026/01/04'
	  AND
	  data <= '2026/30/04'

--ADICIONAR COLUNA NA TABELA CONSULTAS
ALTER TABLE consultas
ADD convenio varchar(30)

--LISTA OS NOMES DOS PACIENTES E OS CONVENIOS QUE USARAM NAS SUAS CONSULTAS
SELECT P.nome, C.convenio
FROM pacientes AS P INNER JOIN consultas AS C
					ON P.codPac = C.codPac

--LISTA OS TELEFONES DOS PACIENTES QUE NUNCA CONSULTARAM
SELECT P.nome, P.fone, C.data
FROM pacientes AS P LEFT JOIN consultas AS C
					ON P.codPac = C.codPac
					WHERE C.codPac IS NULL

--LISTA OS CONVENIOS DAS CONSULTAS FEITAS POR ORTOPEDISTAS
SELECT C.convenio, M.nome, E.nome AS espMedica
FROM consultas AS C INNER JOIN medicos AS M
					ON C.codMed = M.codMed
					INNER JOIN especialidades AS E
					ON M.codEsp = E.codEsp
WHERE E.nome = 'ORTOPEDISTA'

--LISTA OS NOMES e FONES DOS pacientes atendidos por pediatras em abril/2026