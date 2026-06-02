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
