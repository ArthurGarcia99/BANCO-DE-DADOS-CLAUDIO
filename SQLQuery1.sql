USE hospital;

SELECT * FROM consulta;
SELECT * FROM especialidades;
SELECT * FROM medicos;
SELECT * FROM pacientes;

UPDATE medicos
SET codEsp = 30
WHERE codEsp = 20;

INSERT INTO pacientes (nome, fone)
VALUES ('João Silva', '11987654321'),
	   ('Maria Oliveira', '11912345678'),
	   ('Carlos Souza', '11987654322'),
	   ('Ana Santos', '11912345679'),
	   ('Pedro Lima', '11987654323'),
	   ('Luisa Costa', '11912345680');

INSERT INTO consulta (data, codMed, codPac)
VALUES ('2024-07-01', 1, 1),
	   ('2024-07-02', 2, 2),
	   ('2024-07-03', 3, 3),
	   ('2024-07-04', 4, 4),
	   ('2024-07-05', 5, 5),
	   ('2024-07-06', 6, 6),
	   ('2024-07-07', 7, 1),
	   ('2024-07-08', 8, 2),
	   ('2024-07-09', 9, 3),
	   ('2024-07-10', 10, 4),
	   ('2024-07-11', 11, 5),
	   ('2024-07-12', 12, 6);

ALTER TABLE consulta
ADD convenio VARCHAR(50);

DELETE FROM consulta;

UPDATE medicos
SET nome = 'JOÃO DA SILVA'
WHERE codMed = 1;

UPDATE consulta
SET data = '2026-5-15'
WHERE codCons = 3;

DELETE FROM consulta
WHERE codCons = 1;

SELECT m.nome, e.nome FROM medicos AS m
				INNER JOIN especialidades AS e
				ON m.codEsp = e.codEsp

SELECT * FROM medicos 
WHERE codEsp IS NULL;

INSERT INTO consulta
VALUES
    ('2026-06-10 08:00:00', 1, 1, 'UNIMED'),
    ('2026-06-10 09:00:00', 2, 2, 'Bradesco Saúde'),
    ('2026-06-10 10:00:00', 3, 3, 'SulAmérica'),
    ('2026-06-11 08:30:00', 1, 4, 'Amil'),
    ('2026-06-11 09:30:00', 2, 5, 'UNIMED'),
    ('2026-06-11 11:00:00', 3, 1, 'Porto Saúde'),
    ('2026-06-12 08:00:00', 1, 2, 'Bradesco Saúde'),
    ('2026-06-12 09:00:00', 2, 3, 'SulAmérica'),
    ('2026-06-12 10:30:00', 3, 4, 'Amil'),
    ('2026-06-13 14:00:00', 1, 5, 'UNIMED');


SELECT * FROM consulta
WHERE convenio = 'UNIMED' AND data >= '2026-06-01' AND data <= '2026-06-30';


SELECT p.nome, c.convenio FROM pacientes AS p
				INNER JOIN consulta AS c
				ON p.codPac = c.codPac;

SELECT p.fone FROM pacientes AS p
			LEFT JOIN consulta AS c
			ON p.codPac = c.codPac
WHERE c.codPac IS NULL;

SELECT c.convenio FROM consulta AS c
			LEFT JOIN medicos AS m
			ON c.codMed = m.codMed
WHERE m.codEsp = 60;

SELECT p.nome, p.fone FROM pacientes AS p
			INNER JOIN consulta AS c
			ON p.codPac = c.codPac
			INNER JOIN medicos AS m
			ON c.codMed = m.codMed
WHERE m.codEsp = 50 OR m.codEsp = 30 AND c.data >= '2026-06-01' AND c.data <= '2026-06-30';

INSERT INTO especialidades
VALUES ('NEUROLOGISTA')

UPDATE medicos
SET codEsp = 70
WHERE codMed = 11 OR codMed = 12;

INSERT INTO consulta
VALUES	('2026-05-10 08:00:00', 4, 2, 'UNIMED'),
		('2026-05-11 09:00:00', 5, 3, 'Bradesco Saúde'),
	    ('2026-05-12 10:00:00', 3, 4, 'SulAmérica');



UPDATE c
SET c.convenio = 'SUS'
FROM consulta AS c
INNER JOIN medicos AS m
	ON c.codMed = m.codMed
WHERE m.codEsp = 30	
	AND data >= '2026-06-01' 
	AND data <= '2026-06-30';

SELECT * FROM consulta AS c
		      FULL OUTER JOIN medicos AS m
			  ON c.codMed = m.codMed;