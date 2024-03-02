CREATE TABLE autor (
autorID INT PRIMARY KEY,
 nomeAutor VARCHAR(100),
 nacionalidadeAutor VARCHAR(100)
);

CREATE TABLE categoria (
categoriaID INT PRIMARY KEY,
 generoCategoria VARCHAR(50),
 nacionalidade VARCHAR(50)
);

CREATE TABLE livro (
 livroID INT PRIMARY KEY,
 ISBN INT,
 exemplaresDisponiveis INT,
 idioma VARCHAR(50),
 titulo VARCHAR(100),
 editora VARCHAR(100),
 autorID INT,
 categoriaID INT,
 publicacao DATETIME NULL,
 FOREIGN KEY (autorID)
REFERENCES autor(autorID),
FOREIGN KEY (categoriaID)
REFERENCES categoria(categoriaID)
);

CREATE TABLE membro (
membroID INT PRIMARY KEY AUTO_INCREMENT,
 nomeMembro VARCHAR(100),
 emailMembro VARCHAR(100),
 telefoneMembro VARCHAR(15),
 cidadeEndereco VARCHAR(50),
 ruaEndereco VARCHAR(50),
 CEPEndereco VARCHAR(15),
 estadoEndereco VARCHAR(20),
 numeroEndereco INT
);

CREATE TABLE emprestimo (
emprestimoID INT PRIMARY KEY AUTO_INCREMENT,
 dataDevolucaoPrevista DATETIME NOT NULL,
 dataDevolucaoReal DATETIME NOT NULL,
 dataEmprestimo DATETIME NOT NULL,
 membroID INT,
 livroID INT,
 FOREIGN KEY (membroID)
REFERENCES membro(membroID),
FOREIGN KEY (livroID)
REFERENCES livro(livroID)
);

INSERT INTO autor (autorID, nomeAutor, nacionalidadeAutor)
 VALUES
 (1, 'Clarice Lispector', 'Brasileira'),
 (2, 'Fernando Pessoa', 'Portugues'),
 (3, 'Haruki Murakami', 'Japones'),
 (4, 'Sylvia Plath', 'Estadunidense'),
 (5, 'Florbela Espanca', 'Portugues');

 INSERT INTO categoria (categoriaID, generoCategoria,
nacionalidade)
 VALUES
 (1, 'Romance', 'Ingles'),
 (2, 'Realismo Magico', 'Columbiano'),
 (3, 'Terror', 'Estadunidense'),
 (4, 'Gotico', 'Brasileiro'),
 (5, 'Filosofia', 'Alema');

INSERT INTO livro (livroID, ISBN, exemplaresDisponiveis, idioma, titulo, editora, autorID, categoriaID)
VALUES
  (1, 2, 10, 'Português', 'Querida Sputnik', 'Nova Editora', 3, 2),
  (2, 1, 8, 'Alemão', 'Os Sofrimentos do Jovem Werther', 'Cassenote', 1, 5),
  (3, 3, 5, 'Japonês', 'A Hora da Estrela', 'Francisco Alves', 2, 1),
  (4, 5, 12, 'Coreano', 'Amendoas', 'Super Herói', 4, 3),
  (5, 4, 7, 'Inglês', 'Perto do Coração Selvagem', 'Amigo do Campo', 5, 4);

INSERT INTO membro (nomeMembro, emailMembro, telefoneMembro, cidadeEndereco, ruaEndereco, CEPEndereco, estadoEndereco, numeroEndereco)
VALUES
("Ana Paula Endler", "anapaulaendler@gmail.com", "123456789", "Mafra", "Engenheiro Agrimensor Marcio Lalaland", "12345678", "SC", 513),
("Roberto Carlos", "robertinho@gmail.com", "66666666666", "Janeiro", "Iupis Coronel", "55555555", "RJ", 111),
("Getulio Vargas", "gege@gmail.com", "88888888888", "Macondo", "Amigos da Vila Sesamo", "12345678", "PR", 444),
("Zumbi Zumbidos", "zzz@gmail.com", "77777777777", "Palma Doce", "Zimzalabim da Silva", "12345678", "AC", 8),
("Ricardo Felipe", "ricardineceo@gmail.com", "11111111111", "Ririri", "Patati Sorriso", "12345678", "RS", 666);

INSERT INTO emprestimo (dataDevolucaoPrevista, dataDevolucaoReal, dataEmprestimo, membroID, livroID)
VALUES
('2023-10-23 14:30:00', '2023-10-15 10:00:00', '2023-10-03 00:00:00', 1, 1),
('2023-10-25 14:45:00', '2023-10-17 10:15:00', '2023-10-05 00:00:00', 2, 2),
('2023-10-27 15:00:00', '2023-10-19 10:30:00', '2023-10-07 00:00:00', 3, 3),
('2023-10-29 21:00:00', '2023-10-21 15:00:00', '2023-10-03 00:00:00', 4, 4),
('2023-10-31 14:30:00', '2023-10-23 10:00:00', '2023-10-03 00:00:00', 5, 5);

SELECT nomeAutor FROM autor
WHERE nomeAutor LIKE 'A%';

SELECT titulo FROM livro
WHERE titulo LIKE '%Sistema%';

SELECT livroID, titulo FROM livro
WHERE publicacao > DATE_SUB(NOW(), INTERVAL 5 YEAR);

SELECT titulo FROM livro
WHERE exemplaresDisponiveis < 5
ORDER BY titulo;

SELECT livroID FROM emprestimo
WHERE emprestimoID IS NULL;

UPDATE emprestimo
SET dataDevolucaoReal = NOW();

UPDATE emprestimo
SET dataDevolucaoPrevista = DATE_ADD(dataDevolucaoPrevista, INTERVAL
30 DAY);

DELETE FROM membro
WHERE membroID NOT IN (SELECT DISTINCT membroID FROM emprestimo);

DELETE FROM categoria
WHERE categoriaID NOT IN (SELECT DISTINCT categoriaID FROM livro);

-- 1) Listar o título do livro e o nome do autor para todos os livros cadastrados na base.

SELECT livro.titulo, autor.nomeAutor
FROM livro
INNER JOIN autor
ON autor.autorID = livro.autorID;

-- 3) Listar o nome da categoria e o título do livro de todos os livros cadastrados na base.

SELECT categoria.generoCategoria, livro.titulo
FROM livro
INNER JOIN categoria
ON categoria.categoriaID = livro.categoriaID;

-- 5) Listar a data de empréstimo, data da devolução real, nome do membro que emprestou, título do livro, nome da categoria e nome do autor (ou autores) de todos os empréstimos realizados.

SELECT emprestimo.dataEmprestimo, emprestimo.dataDevolucaoReal, membro.nomeMembro, livro.titulo, categoria.generoCategoria, autor.nomeAutor
FROM emprestimo
INNER JOIN membro
ON emprestimo.membroID = membro.membroID
INNER JOIN livro
ON livro.livroID = emprestimo.livroID
INNER JOIN categoria
ON categoria.categoriaID = livro.categoriaID
INNER JOIN autor
ON livro.autorID = autor.autorID;

-- 7) Contar quantos empréstimos foram feitos no ano passado.

SELECT COUNT(*) FROM emprestimo
WHERE YEAR(dataEmprestimo) = YEAR(CURDATE()) - 1;

-- 9) Listar o título do livro e o nome do membro de todos os livros emprestados na semana corrente, agrupados e ordenados por data de empréstimo.

SELECT livro.titulo, membro.nomeMembro 
FROM emprestimo
INNER JOIN livro ON emprestimo.livroID = livro.livroID
INNER JOIN membro ON emprestimo.membroID = membro.membroID
WHERE YEARWEEK(emprestimo.dataEmprestimo, 1) = YEARWEEK(NOW(), 1)
ORDER BY emprestimo.dataEmprestimo;