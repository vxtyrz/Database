CREATE TABLE inscricao (
    codigo INTEGER not null,
    datainicio DATE NOT NULL,
    local VARCHAR(50) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    codmodalidade INTEGER NOT NULL,
    codatleta INTEGER NOT NULL,
    valor NUMERIC(8,2) NOT NULL,
    primary key (codigo),
    foreign key (codmodalidade) references modalidade (codigo),
    foreign key (codatleta) references atleta (codigo)
);


INSERT INTO inscricao (codigo, datainicio, local, pais, codmodalidade, codatleta, valor)
VALUES 
(1, '2025-01-15', 'São Paulo', 'Brasil', 1, 1, 150.00),
(2, '2025-02-10', 'Lisboa', 'Portugal', 2, 2, 120.00),
(3, '2025-03-05', 'Buenos Aires', 'Argentina', 3, 3, 180.00),
(4, '2025-04-20', 'Paris', 'França', 1, 4, 200.00),
(5, '2025-05-12', 'Nova York', 'EUA', 2, 5, 250.00),
(6, '2025-06-18', 'Tóquio', 'Japão', 3, 6, 300.00),
(7, '2025-07-08', 'Berlim', 'Alemanha', 1, 1, 170.00),
(8, '2025-08-25', 'Cidade do Cabo', 'África do Sul', 2, 2, 190.00),
(9, '2025-09-14', 'Toronto', 'Canadá', 3, 3, 160.00),
(10, '2025-10-02', 'Sydney', 'Austrália', 1, 4, 210.00);
SELECT * FROM inscricao;


--------------------------------------------------
/* PROVA */
/* 1) inserir 2 novos treinadores */
INSERT INTO treinador (codigo, nome, telefone)
VALUES (10, 'Enzo Maresca', 666),
(11, 'Alex Ferguson', 999);

SELECT * FROM treinador;


/* 2) 2 novas modalidades associadas aos novos treinadores */
INSERT INTO modalidade (codigo, nome, codtreinador)
VALUES (10, 'KUNG FU', 10),
(11, 'MUAY THAI', 11);

SELECT * FROM modalidade;


/* 3) novo atleta em cada nova modalidade */
INSERT INTO atleta (codigo, nome, endereco, cidade, estado, datanascimento, peso, altura, codmodalidade, telefone)
VALUES (7, 'Fabrício Bruno', 'Barra da Tijuca', 'Rio de Janeiro', 'RJ', '06/02/1981', 96.00, '1.92', 10, '999999'),
(8, 'Anderson Farias', 'Rua Bandeirantes', 'Criciúma', 'SC', '14/05/1971', 63.00, '1.63', 11, '88888888');

SELECT * FROM atleta;

/* 4) inserir campo pais_origem na tabela treinador e preencher com Brasil */
ALTER TABLE treinador
ADD COLUMN pais_origem VARCHAR(50);
SELECT * FROM treinador;

UPDATE treinador 
SET pais_origem = 'Brasil';
SELECT * FROM treinador;

/* 5) novo atleta tabela campeonato para 'Rafaela Silva' */
INSERT INTO atleta (codigo, nome, endereco, cidade, estado, datanascimento, peso, altura, codmodalidade, telefone)
VALUES (9, 'Rafaela Silva', 'Rua dos Coqueiros', 'Ribeirão Preto', 'SP', '25/11/1994', 52.00, '1.58', 3, '99966669');

INSERT INTO campeonato (codigo, datainscricao, valor, codatleta, codmodalidade, patrocinador, premiacao)
VALUES (6, '03/10/2025', 600.00, 9, 3, 'Nike', 5500.00);
SELECT * FROM campeonato;
SELECT * FROM atleta;


/* 6) valor inscrição campeonato codigo 10 para 600 */
INSERT INTO campeonato (codigo, datainscricao, valor, codatleta, codmodalidade, patrocinador, premiacao)
VALUES (10, '06/10/2025', 550.00, 8, 7, 'SATC', 6600.00);
SELECT * FROM campeonato;

UPDATE campeonato
SET valor = 600.00
WHERE codigo = 10;


/* 7) local campeonato codigo 11 para paris */
ALTER TABLE campeonato
ADD COLUMN local VARCHAR(50);
SELECT * FROM campeonato;

INSERT INTO atleta (codigo, nome, endereco, cidade, estado, datanascimento, peso, altura, codmodalidade, telefone)
VALUES (10, 'Ramon Dino', 'Rua da Samambaia', 'Ribeirão Preto', 'SP', '30/12/1987', 102.00, '1.70', 11, '333366669');
SELECT * FROM atleta;

UPDATE campeonato
SET local = 'Paris'
WHERE codigo = 10;

SELECT * FROM campeonato;


/* 8) adicionar campo tempo_prova na tabela inscricao e atualizar o valor para o atleta 10 */
INSERT INTO inscricao (codigo, datainicio, local, pais, codmodalidade, codatleta, valor)
VALUES (11, '01/01/2025', 'Los Angeles', 'EUA', 11, 10, 77000.00);

ALTER TABLE inscricao
ADD COLUMN tempo_prova VARCHAR(50);

UPDATE inscricao
SET tempo_prova = '3 Horas'
WHERE codigo = 11

SELECT * FROM inscricao;


/* 9) modalidade codigo 11 -> handebol */
UPDATE modalidade
SET nome = 'Handebol'
WHERE codigo = 11;

SELECT * FROM modalidade;


/* 10) reduzir em 15% o valor da inscrição para atletas da modalidade 1 */
UPDATE inscricao
SET valor = valor * 0.15
WHERE codmodalidade = 1;

SELECT * FROM inscricao;


/* 11) listar todos atletas inscritos no FUTEBOL */
SELECT atleta.nome, modalidade.nome FROM atleta, modalidade WHERE modalidade.codigo = atleta.codmodalidade AND modalidade.codigo = 1;

SELECT * FROM atleta;


/* 12) exibir nome atletas, data, e avlor da inscricao com a modalidade Handebol */
UPDATE inscricao
SET codatleta = 8
WHERE CODIGO = 7;

UPDATE inscricao
SET codmodalidade = 11
WHERE CODIGO = 7;

SELECT atleta.nome, inscricao.datainicio, inscricao.valor FROM atleta, inscricao WHERE atleta.codigo = inscricao.codatleta AND atleta.codmodalidade = 11;
SELECT * FROM atleta;
SELECT * FROM inscricao;


/* 13) total arrecadado por cada modalidade nos campeonatos */
UPDATE campeonato
SET premiacao = 1500.00
WHERE codigo = 1;

UPDATE campeonato
SET premiacao = 1800.00
WHERE codigo = 2;

UPDATE campeonato
SET premiacao = 3000.00
WHERE codigo = 3;

UPDATE campeonato
SET premiacao = 8000.00
WHERE codigo = 4;

SELECT modalidade.nome, SUM(campeonato.premiacao) FROM modalidade, campeonato WHERE modalidade.codigo = campeonato.codmodalidade GROUP BY modalidade.nome;
SELECT * FROM campeonato;


/* 14) exibir cidades onde ocorreram campeonatos com o atleta Neymar JR */
UPDATE campeonato
SET local = 'Kiev'
WHERE codigo = 5;

SELECT campeonato.local, atleta.nome FROM campeonato, atleta WHERE atleta.codigo = campeonato.codatleta AND campeonato.codatleta = 5;
SELECT * FROM atleta;


/* 15) listar atletas e suas modalidades */
SELECT atleta.nome, modalidade.nome FROM atleta, modalidade WHERE modalidade.codigo = atleta.codmodalidade;
SELECT * FROM modalidade;
SELECT * FROM atleta;


/* 16) campeonatos realizados entre 2025-10-01 e 2025-10-07 */
SELECT campeonato.codigo AS codigo_campeonato, campeonato.datainscricao FROM campeonato WHERE campeonato.datainscricao BETWEEN '01/10/2025' AND '07/10/2025';
SELECT * FROM campeonato;

/* 17) atletas com premiação acima de RS 400 */
SELECT atleta.nome, campeonato.premiacao FROM atleta, campeonato WHERE atleta.codigo = campeonato.codatleta AND premiacao >= 400.00;
SELECT * FROM campeonato;
SELECT * FROM atleta;


/* 18) Calcular valor médio de inscrição por modalidade */
SELECT modalidade.nome, AVG(inscricao.valor) FROM modalidade, inscricao WHERE modalidade.codigo = inscricao.codmodalidade GROUP BY modalidade.nome;
SELECT * FROM inscricao;
SELECT * FROM modalidade;


/* 19) maior e menor inscrição por atleta */
SELECT atleta.nome, MAX(inscricao.valor), MIN(inscricao.valor) FROM atleta, inscricao WHERE atleta.codigo = inscricao.codatleta GROUP BY atleta.nome;


/* 20) listar atletas e quantos campeonatos participaram */
SELECT atleta.nome, COUNT(campeonato.codigo) AS campeonato_atleta FROM atleta, campeonato WHERE atleta.codigo = campeonato.codatleta GROUP BY atleta.nome;
SELECT * FROM atleta;
SELECT * FROM campeonato;


/* 21) listar nome atletas, modalidade que praticam e os campeonatos que estão inscritos ordenados por nome atleta */
SELECT atleta.nome, modalidade.nome, campeonato.codigo FROM atleta, modalidade, campeonato WHERE modalidade.codigo = atleta.codmodalidade AND atleta.codigo = campeonato.codatleta AND modalidade.codigo = campeonato.codmodalidade GROUP BY atleta.nome, modalidade.nome, campeonato.codigo;
SELECT * FROM modalidade

/* 22) nomes dos atletas, datas de inscrição e o valor pago por campeonato */
SELECT atleta.nome, inscricao.datainicio, campeonato.premiacao FROM atleta, inscricao, campeonato WHERE atleta.codigo = inscricao.codatleta AND atleta.codigo = campeonato.codatleta;
SELECT * FROM atleta;
SELECT * FROM inscricao;
SELECT * FROM campeonato;


/* 23) listar atletas que participam de campeonatos fora da sua cidade */
/*oops*/

/* 24) nome atleta e quantos campeonatos cada um participou por modalidade */
SELECT atleta.nome, COUNT(campeonato.codigo), modalidade.nome FROM atleta, campeonato, modalidade WHERE atleta.codigo = campeonato.codatleta AND modalidade.codigo = campeonato.codmodalidade AND modalidade.codigo = atleta.codmodalidade GROUP BY atleta.nome, modalidade.nome;

/* 25) listar atletas, modalidades em campeonatos com valor acima de R$ 500 */
SELECT atleta.nome, modalidade.nome, campeonato.valor FROM atleta, modalidade, campeonato WHERE atleta.codigo = campeonato.codatleta AND modalidade.codigo = campeonato.codmodalidade AND modalidade.codigo = atleta.codmodalidade AND campeonato.valor >= 500.00;