CREATE DATABASE REVISAO2026
GO
USE REVISAO2026

--cadastre a tabela categoria e a tabela produto, sendo que a tabela produto deve ter uma chave estrangeira para a tabela categoria
CREATE TABLE categoria(
    codCat INT PRIMARY KEY IDENTITY(1,1),
    nomeCat VARCHAR(50)
)

CREATE TABLE produto(
    codPro INT PRIMARY KEY IDENTITY(1,1),
    descricao VARCHAR(100),
    codBarras VARCHAR(30),
    estoque INT,
    codCat INT FOREIGN KEY REFERENCES categoria(codCat)
)

--cadastre 5 categorias e 8 produtos, preenchendo todos os campos das tabelas
INSERT INTO categoria VALUES 
('Bebidas'),
('Alimentos'),
('Higiene'),
('Limpeza'),
('Eletrônicos')

INSERT INTO produto VALUES 
('Coca-Cola 2L', '1234567890123', 50, 1),
('Pepsi 2L', '1234567890124', 30, 1),
('Arroz 5kg', '1234567890125', 100, 2),
('Sabão em pó 1kg', '1234567890126', 40, 4),
('Shampoo 500ml', '1234567890127', 25, 3),
('Detergente 500ml', '1234567890128', 60, 4),
('Televisão 32"', '1234567890129', 10, 5),
('Notebook i5', '1234567890130', 5, 5)

--altere o estoque do produto de codigo 4 o estoque deve ser 350

UPDATE produto 
SET estoque = 350 
WHERE codPro = 4

--liste a descrição, codigo de barras e estoque dos produtos que possuem estoque maior que 500

SELECT descricao, codBarras, estoque 
FROM produto 
WHERE estoque > 500

--exclua os produtos da categoria de codigo 3

DELETE FROM produto 
WHERE codCat = 3

--cadastre um novo produto sem preencher o codigo de barras

INSERT INTO produto (descricao, estoque, codCat) 
VALUES ('celular', 100, 5)

--exclua a coluna codBarras 

ALTER TABLE produto
DROP COLUMN codBarras

--liste a descrição e os estoques dos produtos em ordem decrescente de estoque

SELECT descricao, estoque 
FROM produto 
ORDER BY estoque DESC

--crie uma nova coluna para guardar o preço unitario dos produtos

ALTER TABLE produto
ADD preco MONEY

--exclua os produtos cujas categorias sejam dos codigos 1, 3 ou 5

DELETE FROM produto
WHERE codCat IN (1, 3, 5)

--atualize cada preço unitario dos produtos (não deixe todos com o mesmo preço)

UPDATE produto SET preco = 1.99 WHERE codPro = 1
UPDATE produto SET preco = 2.49 WHERE codPro = 2
UPDATE produto SET preco = 3.99 WHERE codPro = 3
UPDATE produto SET preco = 4.99 WHERE codPro = 4
UPDATE produto SET preco = 5.99 WHERE codPro = 5

--liste a descrição dos produtos e os nomes das categorias que eles pertencem, faça um inner join entre as tabelas produto e categoria

SELECT P.descricao, C.nomeCat
FROM produto AS P INNER JOIN categoria AS C ON P.codCat = C.codCat

--liste as categorias que não possuem produtos vinculados a ele

SELECT *
FROM categoria AS c
LEFT JOIN produto AS p
    ON p.codCat = c.codCat
WHERE p.codCat IS NULL;

--Reajustar o preço unitário dos produtos com estoque menor que 400
UPDATE produto
SET preco = preco + preco * 0.05
WHERE estoque < 400

-- FUNÇÕES DE AGREGAÇÃO
SELECT MAX(estoque) AS maiorEstoque
FROM produto

SELECT MIN(estoque) AS menorEstoque
FROM produto

SELECT MIN(estoque) AS menorEstoque, MAX(estoque) AS maiorEstoque
FROM produto

--SUM = retorna a soma
SELECT SUM(preco) AS precoTotal
FROM produto

SELECT descricao, estoque, preco, estoque * preco AS valorEstoque
FROM produto

SELECT SUM(estoque * preco) AS ValorTotalEstoque
FROM produto

-- AVG = calcula a media
SELECT AVG(preco) AS PrecoMedio
FROM produtos

--ROUND = função para arredondamentos
SELECT ROUND(12345.6789, 2)

SELECT ROUND(AVG(preco), 2) AS precoMedio
FROM produto

-- COUNT = contao núnmero de ocorrências
SELECT COUNT(descricao)
FROM produto
