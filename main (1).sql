    CREATE TABLE CLIENTE (
          	IdCliente INTEGER PRIMARY KEY AUTOINCREMENT,
          	Nome VARCHAR(100),
          	Sexo VARCHAR(1),
            Pais VARCHAR(15) Default 'Brasil',
          	DtaNasc DATETIME NOT NULL
      	);
      
    CREATE TABLE CLIENTEESTRANGEIRO (
            Passaporte VARCHAR(10),
            IdCliente INTEGER PRIMARY KEY AUTOINCREMENT,
            FOREIGN KEY (IdCliente) REFERENCES CLIENTE(IdCliente)
        );

    CREATE TABLE CLIENTEBR (
            CPF NUMERIC(11) UNIQUE,
            Cidade VARCHAR(20) NULL,
            UF VARCHAR(2) NULL,
            RG NUMERIC(10) UNIQUE,
            CEP NUMERIC(8) NOT NULL,
            Rua VARCHAR(100) NULL,
            Numero NUMERIC(15) NULL,
            IdCliente INTEGER PRIMARY KEY AUTOINCREMENT,
            FOREIGN KEY (IdCliente) REFERENCES CLIENTE(IdCliente)
    );

    CREATE TABLE QUARTO (
            NroQuarto INTEGER PRIMARY KEY,
            Andar INTEGER,
            Tipo VARCHAR(50) NULL,
            Descricao VARCHAR(300) NULL,
            VlrDiaria INTEGER
    );

    CREATE TABLE RESERVA (
            NroReserva INTEGER PRIMARY KEY AUTOINCREMENT,
            Entrada DATETIME NOT NULL,
            Periodo INTEGER,
            IdCliente INTEGER,
            NroQuarto INTEGER,
            FOREIGN KEY (IdCliente) REFERENCES CLIENTE(IdCliente),
            FOREIGN KEY (NroQuarto) REFERENCES QUARTO(NroQuarto)
        );

    CREATE TABLE GERENTE (
            MatriculaGerente INTEGER PRIMARY KEY,
            NomeGerente VARCHAR(100)
    );

    CREATE TABLE APROVACAO (
            NroQuarto INTEGER PRIMARY KEY,
            MatriculaGerente INTEGER,
            DataHora DATETIME NOT NULL,
            FOREIGN KEY (NroQuarto) REFERENCES QUARTO(NroQuarto),
            FOREIGN KEY (MatriculaGerente) REFERENCES GERENTE(MatriculaGerente)
    );

    CREATE TABLE OCUPACAO (
            NroReserva INTEGER PRIMARY KEY,
            NroQuarto INTEGER,
            Entrada DATETIME NOT NULL,
            Saida DATETIME NOT NULL,
            FOREIGN KEY (NroReserva, Entrada) REFERENCES RESERVA(NroReserva, Entrada),
            FOREIGN KEY (NroQuarto) REFERENCES QUARTO(NroQuarto)    
    );

    CREATE TABLE RESTAURANTE (
            IdRestaurante INTEGER PRIMARY KEY,
            Prato VARCHAR(50),
            Preco INTEGER
    );

    CREATE TABLE OCUPACAORESTAURANTE (
            IdOcupacaoRestaurante INTEGER PRIMARY KEY AUTOINCREMENT,
            DataHora DATETIME NOT NULL,
            NroReserva INTEGER,
            IdRestaurante INTEGER,
            QUANTIDADE INTEGER,
            FOREIGN KEY (NroReserva) REFERENCES RESERVA(NroReserva),
            FOREIGN KEY (IdRestaurante) REFERENCES RESTAURANTE(IdRestaurante)
    );

    CREATE TABLE FRIGOBAR (
            IdFrigobar INTEGER PRIMARY KEY,
            Item VARCHAR(100),
            Preco INTEGER
    );

    CREATE TABLE OCUPACAOFRIGOBAR (
            DataHora DATETIME NOT NULL PRIMARY KEY,
            NroReserva INTEGER,
            IdFrigobar INTEGER,
            Quantidade INTEGER,
            FOREIGN KEY (NroReserva) REFERENCES RESERVA(NroReserva),
            FOREIGN KEY (IdFrigobar) REFERENCES FRIGOBAR(IdFrigobar)
    );

    CREATE TABLE MASSAGEM (
            IdMassagem INTEGER PRIMARY KEY,
            Tipo VARCHAR(50),
            Preco INTEGER
    );

    CREATE TABLE OCUPACAOMASSAGEM (
            DataHora DATATIME PRIMARY KEY,
            NroReserva INTEGER,
            IdMassagem INTEGER,
            Produtos VARCHAR(100),
            FOREIGN KEY (NroReserva) REFERENCES RESERVA(NroReserva),
            FOREIGN KEY (IdMassagem) REFERENCES MASSAGEM(IdMassagem)
    );

    CREATE TABLE TIPOPAGAMENTO (
            IdTipoPagamento INTEGER PRIMARY KEY,
            Descricao VARCHAR(200)
    );

    CREATE TABLE PAGAMENTO (
            NroReserva INTEGER PRIMARY KEY,
            IdTipoPagamento INTEGER,
            DataHora DATETIME NOT NULL,
            ValorTotal INTEGER,
            FOREIGN KEY (NroReserva) REFERENCES RESERVA(NroReserva),
            FOREIGN KEY (IdTipoPagamento) REFERENCES TIPOPAGAMENTO(IdTipoPagamento)
    );

        INSERT INTO CLIENTE (Nome, Sexo, DtaNasc)
        VALUES ('Cliente1', 'M', '1990-01-15'),
               ('Cliente2', 'F', '1985-05-20'),
               ('Cliente3', 'M', '1982-11-10'),
               ('Cliente4', 'F', '1995-07-30'),
               ('Cliente5', 'M', '1988-03-25');
        
        INSERT INTO CLIENTEESTRANGEIRO (Passaporte, IdCliente)
        VALUES ('P12345', 1),
               ('P54321', 2),
               ('P98765', 3),
               ('P24680', 4),
               ('P13579', 5);
        
        INSERT INTO CLIENTEBR (CPF, Cidade, UF, RG, CEP, Rua, Numero, IdCliente)
        VALUES (12345678901, 'São Paulo', 'SP', 987654321, 12345678, 'Rua A', 101, 1),
               (98765432109, 'Rio de Janeiro', 'RJ', 543210987, 87654321, 'Rua B', 202, 2),
               (45678901234, 'Belo Horizonte', 'MG', 321098765, 98765432, 'Rua C', 303, 3),
               (23456789012, 'Porto Alegre', 'RS', 210987654, 87654323, 'Rua D', 404, 4),
               (34567890123, 'Brasília', 'DF', 109876543, 76543210, 'Rua E', 505, 5);
        
        INSERT INTO QUARTO (NroQuarto, Andar, Tipo, Descricao, VlrDiaria)
        VALUES (101, 1, 'Standard', 'Quarto padrão com cama de casal', 150),
               (102, 1, 'Suite', 'Suíte luxuosa com vista para o mar', 300),
               (201, 2, 'Standard', 'Quarto padrão com duas camas de solteiro', 160),
               (202, 2, 'Suite', 'Suíte executiva com sala de estar', 350),
               (301, 3, 'Standard', 'Quarto padrão com varanda', 180);
        
        INSERT INTO RESERVA (Entrada, Periodo, IdCliente, NroQuarto)
        VALUES ('2023-11-01', 3, 1, 101),
               ('2023-12-05', 5, 2, 201),
               ('2023-10-15', 2, 3, 102),
               ('2023-11-20', 4, 4, 202),
               ('2023-12-10', 6, 5, 301);
        
        INSERT INTO GERENTE (MatriculaGerente, NomeGerente)
        VALUES (1001, 'Gerente1'),
               (1002, 'Gerente2'),
               (1003, 'Gerente3'),
               (1004, 'Gerente4'),
               (1005, 'Gerente5');
        
        INSERT INTO APROVACAO (NroQuarto, MatriculaGerente, DataHora)
        VALUES (101, 1001, '2023-11-01 08:00:00'),
               (201, 1002, '2023-12-05 10:15:00'),
               (102, 1003, '2023-10-15 14:30:00'),
               (202, 1004, '2023-11-20 11:45:00'),
               (301, 1005, '2023-12-10 16:20:00');
        
        INSERT INTO RESTAURANTE (Prato, Preco)
        VALUES ('Prato1', 25),
               ('Prato2', 30),
               ('Prato3', 15),
               ('Prato4', 40),
               ('Prato5', 20);
        
        INSERT INTO FRIGOBAR (Item, Preco)
        VALUES ('Item1', 5),
               ('Item2', 4),
               ('Item3', 6),
               ('Item4', 3),
               ('Item5', 7);
        
        INSERT INTO MASSAGEM (Tipo, Preco)
        VALUES ('Massagem Relaxante', 50),
               ('Massagem Terapêutica', 60),
               ('Massagem Esportiva', 55),
               ('Massagem de Pedras Quentes', 70),
               ('Massagem Aromaterapia', 65);
        
        
        INSERT INTO TIPOPAGAMENTO (Descricao)
        VALUES ('Cartão de Crédito'),
               ('Dinheiro'),
               ('Cheque'),
               ('Transferência Bancária'),
               ('Pix');
        
        SELECT Sexo FROM CLIENTE ORDER BY Nome;
        SELECT CPF, CEP FROM CLIENTEBR WHERE Cidade = 'Curitiba';
        SELECT NroQuarto FROM QUARTO ORDER BY VlrDiaria, Andar DESC;
        SELECT NroQuarto FROM QUARTO WHERE VlrDiaria >= 100 AND VlrDiaria <= 150;
        SELECT NroReserva FROM RESERVA WHERE IdCliente = 3;
        SELECT DISTINCT NroQuarto FROM RESERVA;
        SELECT DISTINCT NroQuarto FROM APROVACAO;
        SELECT DISTINCT NroReserva FROM OCUPACAORESTAURANTE;
        SELECT DISTINCT NroReserva FROM PAGAMENTO WHERE IdTipoPagamento = 'Dinheiro';


        UPDATE RESERVA SET Entrada = CURRENT_TIMESTAMP;
        UPDATE RESERVA SET Entrada = Entrada + 30;
        UPDATE CLIENTEBR SET Cidade = 'Curitiba';
        UPDATE CLIENTEBR SET UF = 'PR' WHERE Cidade = 'Curitiba';
        UPDATE CLIENTEBR SET UF = 'ND' WHERE UF = NULL;
        UPDATE QUARTO SET VlrDiaria = VlrDiaria * 1.3 WHERE Andar > 3;
        UPDATE QUARTO SET VlrDiaria = VlrDiaria * 0.6 WHERE NroQuarto IN (
            SELECT NroQuarto 
            FROM OCUPACAO 
            WHERE Saida < DATE('now', '-2 years')
            );
        UPDATE OCUPACAO SET Saida = CURRENT_TIMESTAMP;
        DELETE FROM RESERVA WHERE NroReserva NOT IN (
            SELECT NroReserva
            FROM OCUPACAO
        );
        DELETE FROM QUARTO WHERE NroQuarto NOT IN (
            SELECT NroQuarto
            FROM OCUPACAO
        );
        DELETE FROM OCUPACAORESTAURANTE WHERE DataHora < '2015-01-01';
        DELETE FROM OCUPACAOFRIGOBAR WHERE DataHora < '2015-01-01';
        DELETE FROM OCUPACAOMASSAGEM WHERE DataHora < '2015-01-01';

    SELECT CLIENTE.Nome, RESERVA.Entrada
    FROM CLIENTE
    INNER JOIN RESERVA 
    ON CLIENTE.IdCliente = RESERVA.IdCliente
    ORDER BY CLIENTE.Nome;

    SELECT CLIENTE.Nome, CLIENTEBR.CPF
    FROM CLIENTE
    INNER JOIN CLIENTEBR
    ON CLIENTE.IdCliente = CLIENTEBR.IdCliente;

    SELECT CLIENTE.Nome, CLIENTEESTRANGEIRO.Passaporte
    FROM CLIENTE
    INNER JOIN CLIENTEESTRANGEIRO
    ON CLIENTE.IdCliente = CLIENTEESTRANGEIRO.IdCliente;

    SELECT RESERVA.NroReserva, GERENTE.NomeGerente
    FROM RESERVA
    INNER JOIN APROVACAO
    ON APROVACAO.NroQuarto = RESERVA.NroQuarto
    INNER JOIN GERENTE
    ON GERENTE.MatriculaGerente = APROVACAO.MatriculaGerente;

    SELECT OCUPACAO.NroReserva, QUARTO.Descricao, RESTAURANTE.Preco
    FROM OCUPACAO
    INNER JOIN QUARTO
    ON OCUPACAO.NroQuarto = QUARTO.NroQuarto
    INNER JOIN OCUPACAORESTAURANTE
    ON OCUPACAORESTAURANTE.NroReserva = OCUPACAO.NroReserva
    INNER JOIN RESTAURANTE
    ON OCUPACAORESTAURANTE.IdRestaurante = RESTAURANTE.IdRestaurante;

    SELECT CLIENTE.Nome, PAGAMENTO.IdTipoPagamento
    FROM CLIENTE
    INNER JOIN RESERVA
    ON RESERVA.IdCliente = CLIENTE.IdCliente
    INNER JOIN OCUPACAO
    ON RESERVA.NroReserva = OCUPACAO.NroReserva
    INNER JOIN PAGAMENTO
    ON PAGAMENTO.NroReserva = OCUPACAO.NroReserva;

    SELECT CLIENTE.Nome, OCUPACAOMASSAGEM.Produtos
    FROM CLIENTE
    INNER JOIN RESERVA
    ON RESERVA.IdCliente = CLIENTE.IdCliente
    INNER JOIN OCUPACAOMASSAGEM
    ON OCUPACAOMASSAGEM.NroReserva = RESERVA.NroReserva
    INNER JOIN OCUPACAO
    ON OCUPACAO.NroReserva = RESERVA.NroReserva
    WHERE OCUPACAO.Entrada > DATE('now', '-1 years');

    SELECT CLIENTE.Nome, CLIENTE.DtaNasc, QUARTO.Andar
    FROM CLIENTE
    INNER JOIN RESERVA
    ON RESERVA.IdCliente = CLIENTE.IdCliente
    INNER JOIN OCUPACAO
    ON OCUPACAO.NroReserva = RESERVA.NroReserva
    INNER JOIN QUARTO
    ON QUARTO.NroQuarto = OCUPACAO.NroQuarto
    WHERE OCUPACAO.Entrada > DATE('now', '-3 months');

    SELECT CLIENTE.Nome, CLIENTEBR.Cidade, CLIENTEBR.UF
    FROM CLIENTE
    INNER JOIN CLIENTEBR
    ON CLIENTEBR.IdCliente = CLIENTE.IdCliente
    INNER JOIN RESERVA
    ON RESERVA.IdCliente = CLIENTE.IdCliente
    INNER JOIN OCUPACAO
    ON OCUPACAO.NroReserva = RESERVA.NroReserva
    WHERE OCUPACAO.Entrada > DATE('now', '-5 years');

    SELECT CLIENTE.Nome, RESERVA.Entrada, OCUPACAO.Entrada, OCUPACAO.Saida, QUARTO.Andar, OCUPACAO.NroQuarto
    FROM CLIENTE
    INNER JOIN RESERVA
    ON RESERVA.IdCliente = CLIENTE.IdCliente
    INNER JOIN OCUPACAO
    ON OCUPACAO.NroReserva = RESERVA.NroReserva
    INNER JOIN QUARTO
    ON OCUPACAO.NroQuarto = QUARTO.NroQuarto
    WHERE strftime('%Y', OCUPACAO.Entrada) = strftime('%Y', 'now');



    SELECT COUNT(IdCliente) QntClientes
    FROM CLIENTE;

    SELECT *, COUNT(Numero) FROM CLIENTEBR GROUP BY IdCliente;

    SELECT Cidade, UF, COUNT(IdCliente) FROM CLIENTEBR GROUP BY Cidade;

    SELECT Andar, COUNT(NroQuarto) FROM QUARTO GROUP BY Andar; 

    SELECT AVG(ValorTotal) FROM PAGAMENTO;

    SELECT AVG(ValorTotal), QUARTO.Andar
    FROM PAGAMENTO
    INNER JOIN RESERVA
    ON RESERVA.NroReserva = PAGAMENTO.NroReserva
    INNER JOIN QUARTO
    ON RESERVA.NroQuarto = QUARTO.NroQuarto
    GROUP BY QUARTO.Andar;

    SELECT COUNT(NroQuarto), Tipo FROM QUARTO GROUP BY Tipo;

    SELECT AVG(ValorTotal), QUARTO.Tipo
    FROM PAGAMENTO
    INNER JOIN RESERVA
    ON RESERVA.NroReserva = PAGAMENTO.NroReserva
    INNER JOIN QUARTO
    ON QUARTO.NroQuarto = RESERVA.NroQuarto
    GROUP BY Tipo;

    SELECT COUNT(NroReserva) FROM RESERVA
    WHERE RESERVA.Entrada > DATE('now', '-1 years');

    SELECT RESERVA.Entrada, COUNT(NroReserva) FROM RESERVA
    WHERE RESERVA.Entrada > DATE('now', '-1 years')
    GROUP BY RESERVA.Entrada;

    SELECT OCUPACAO.Saida, PAGAMENTO.ValorTotal
    FROM OCUPACAO
    INNER JOIN RESERVA
    ON RESERVA.NroQuarto = OCUPACAO.NroQuarto
    INNER JOIN PAGAMENTO
    ON PAGAMENTO.NroReserva = RESERVA.NroReserva
    GROUP BY Saida;

    SELECT AVG(Preco) FROM RESTAURANTE;

    SELECT SUM(ValorTotal), OCUPACAO.Entrada FROM PAGAMENTO
    INNER JOIN OCUPACAO
    ON OCUPACAO.NroReserva = PAGAMENTO.NroReserva
    WHERE strftime('%Y', OCUPACAO.Entrada) = strftime('%Y', 'now');

    SELECT RESERVA.NroReserva, SUM(RESTAURANTE.Preco) FROM RESERVA
    INNER JOIN OCUPACAORESTAURANTE
    ON OCUPACAORESTAURANTE.NroReserva = RESERVA.NroReserva
    INNER JOIN RESTAURANTE
    ON OCUPACAORESTAURANTE.IdRestaurante = RESTAURANTE.IdRestaurante
    GROUP BY RESERVA.NroReserva;

    SELECT *, SUM(ValorTotal) FROM PAGAMENTO
    GROUP BY PAGAMENTO.IdTipoPagamento;

    SELECT PAGAMENTO.IdTipoPagamento, COUNT(PAGAMENTO.NroReserva) FROM PAGAMENTO
    INNER JOIN OCUPACAO
    ON PAGAMENTO.NroReserva = OCUPACAO.NroReserva
    WHERE strftime('%Y-%m', OCUPACAO.Entrada) = strftime('%Y-%m', 'now')
    GROUP BY PAGAMENTO.IdTipoPagamento;

    SELECT MIN(ValorTotal) FROM PAGAMENTO
    INNER JOIN OCUPACAO
    ON PAGAMENTO.NroReserva = OCUPACAO.NroReserva
    WHERE strftime('%Y-%m', OCUPACAO.Entrada) = strftime('%Y-%m', 'now', '-1 months');

    SELECT MAX(ValorTotal) FROM PAGAMENTO
    INNER JOIN OCUPACAO
    ON PAGAMENTO.NroReserva = OCUPACAO.NroReserva
    WHERE strftime('%Y', OCUPACAO.Entrada) = strftime('%Y', 'now');

    SELECT CLIENTE.Nome, CLIENTEBR.CPF
    FROM CLIENTE
    INNER JOIN CLIENTEBR
    ON CLIENTE.IdCliente = CLIENTEBR.IdCliente
    UNION ALL
    SELECT CLIENTE.Nome, CLIENTEESTRANGEIRO.Passaporte
    FROM CLIENTE
    INNER JOIN CLIENTEESTRANGEIRO
    ON CLIENTE.IdCliente = CLIENTEESTRANGEIRO.IdCliente;

    SELECT CLIENTE.Nome, CLIENTE.DtaNasc, CLIENTEBR.RG
    FROM CLIENTE
    INNER JOIN CLIENTEBR
    ON CLIENTE.IdCliente = CLIENTEBR.IdCliente
    UNION
    SELECT CLIENTE.Nome, CLIENTE.DtaNasc, CLIENTEESTRANGEIRO.Passaporte
    FROM CLIENTE
    INNER JOIN CLIENTEESTRANGEIRO
    ON CLIENTE.IdCliente = CLIENTEESTRANGEIRO.IdCliente;

    SELECT RESTAURANTE.Prato, RESTAURANTE.Preco
    FROM RESTAURANTE
    UNION
    SELECT FRIGOBAR.Item, FRIGOBAR.Preco
    FROM FRIGOBAR
    UNION
    SELECT MASSAGEM.Tipo, MASSAGEM.Preco
    FROM MASSAGEM;

    CREATE VIEW VBRASIL AS
    SELECT CLIENTE.IdCliente, CLIENTE.Nome, CLIENTEBR.CPF Documento
    FROM CLIENTE
    INNER JOIN CLIENTEBR
    ON CLIENTE.IdCliente = CLIENTEBR.IdCliente;

    CREATE VIEW VESTRANGEIROS AS
    SELECT CLIENTE.IdCliente, CLIENTE.Nome, CLIENTEESTRANGEIRO.Passaporte Documento
    FROM CLIENTE
    INNER JOIN CLIENTEESTRANGEIRO
    ON CLIENTE.IdCliente = CLIENTEESTRANGEIRO.IdCliente;

    CREATE VIEW VRESERVAS AS
    SELECT R.NroReserva, C.IdCliente, C.Nome, R.NroQuarto, R.Entrada
    FROM CLIENTE C
    INNER JOIN RESERVA R
    ON R.IdCliente = C.IdCliente
    INNER JOIN QUARTO Q
    ON R.NroQuarto = Q.NroQuarto;

    CREATE VIEW VCONSUMOS AS
    SELECT CLIENTE.IdCliente, RESTAURANTE.Prato Consumo, RESTAURANTE.Preco Valor
    FROM CLIENTE, RESTAURANTE
    UNION
    SELECT CLIENTE.IdCliente, FRIGOBAR.Item Consumo, FRIGOBAR.Preco Valor
    FROM CLIENTE, FRIGOBAR
    UNION
    SELECT CLIENTE.IdCliente, MASSAGEM.Tipo Consumo, MASSAGEM.Preco Valor
    FROM CLIENTE, MASSAGEM;

    SELECT COUNT(*) FROM VESTRANGEIROS;

    SELECT VRESERVAS.Nome
    FROM VRESERVAS
    WHERE VRESERVAS.Entrada = CURRENT_DATE
    ORDER BY VRESERVAS.Nome;

    SELECT VBRASIL.Nome, COUNT(VCONSUMOS.Valor) FROM VBRASIL
    INNER JOIN VCONSUMOS
    ON VBRASIL.IdCliente = VCONSUMOS.IdCliente
    GROUP BY VBRASIL.Nome;