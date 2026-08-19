-- Criar um novo BD para o Exercicio:
CREATE DATABASE vet2026
GO

USE vet2026

-- Criar Tabelas
CREATE TABLE veterinario(
    codVet INT PRIMARY KEY IDENTITY (1,1),
    nome VARCHAR (100),
    dataNasc date
)

CREATE TABLE consulta(
    codCon INT PRIMARY KEY IDENTITY (1,1),
    dataCon datetime,
    valor money,
    codVet INT FOREIGN KEY REFERENCES veterinario (codVet)
)

CREATE TABLE animal(
    codAni INT PRIMARY KEY IDENTITY (1,1),
    nome VARCHAR (100),
    especie VARCHAR (50)
)

-- Criar Chave Estrangeira em Tabela que já existe:
ALTER TABLE consulta
    ADD codAni INT FOREIGN KEY REFERENCES animal (codAni)

--Inserir valores nas tabelas
INSERT INTO veterinario
VALUES
 ('JOÃO','1985/05/12'),
 ('MARIA','1990/07/20'),
 ('PEDRO','2000/03/19'),
 ('RAFAELA','1999/10/25'),
 ('ANA','2001/07/28')

 INSERT INTO animal
 VALUES
 ('REX','CACHORRO'),('PLUTO','CACHORRO'),('MAX','CACHORRO'),
 ('MIAU','GATO'),('BOLINHA','GATO'),('LUNA','GATO'),
 ('TEWWTY','PAPAGAIO'),('THOR','CACHORRO'),('SIMBA','GATO'),
 ('POLI','PAPAGAIO')

 INSERT INTO consulta
 VALUES
 ('2026/03/11',180,3,7),('2026/04/05',250,1,8),
 ('2026/04/15',90,5,7),('2026/03/01',480,3,9),
 ('2026/09/01',222,4,3),('2026/12/15',202,2,3),
 ('2026/01/10',220,5,4),('2026/11/22',300,2,1),
 ('2026/02/28',300,2,6),('2026/01/13',220,2,3)

-- Select na media, valor maximo e minimo da tabela consulta
 SELECT
    AVG(valor) AS valorMedio,
    MAX(valor) AS ValorMaximo,
    MIN(valor) AS ValorMinimo
   FROM consulta
   WHERE dataCon >= '2026/06/01' AND
         dataCon <= '2026/10/01'

-- UPDATE do nome do veterinario de codigo 3
UPDATE veterinario SET nome = 'KAIQUE'
WHERE codVet = 3

--SELECT DISTINCT nas especies da tabela animal
SELECT DISTINCT Especie
  FROM animal

--SELECT COUNT na tabela consulta, quantidade de consultas que foram feitas
SELECT COUNT(*) AS qtdeConsultas
  FROM consulta
  WHERE codVet = 3

-- SELECT COUNT na tabela consulta, quantiade de consultas que foram feitas
SELECT COUNT(*) AS qtdeConsultas
  FROM consulta

-- SELECT DISTINCT da tabela animal, seleciona todos os animais sem repetir
SELECT DISTINCT especie
  FROM animal

-- SELECT da tabela animal, ordena os nomes por ordem alfabetica
SELECT DISTINCT nome
  FROM animal
  ORDER BY nome

SELECT DISTINCT especie,
       nome
  FROM animal
  ORDER BY especie, nome -- ORDENAÇÂO POR MAIS DE UM CAMPO

SELECT SUM(valor) AS 'Valor Total'
  FROM consulta
  WHERE codVet = 3

SELECT COUNT(*) AS qtdeVet
  FROM veterinario

SELECT valor * 1.1 as valorAumento
  FROM consulta
  WHERE codVet = 3

SELECT COUNT(*) AS contagemConsultas
  FROM consulta
  WHERE codVet = 3
     AND dataCon >= '2026/01/01' AND dataCon <= '2026/03/31'