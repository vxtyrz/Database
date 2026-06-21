


/* 1- criar as tabelas */

CREATE TABLE cliente (
idcliente SERIAL PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
email VARCHAR(100) NOT NULL,
telefone VARCHAR(20));

CREATE TABLE produto (
idproduto SERIAL PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
preco NUMERIC(6,2) NOT NULL,
estoque INT);

CREATE TABLE pedido (
idpedido SERIAL PRIMARY KEY,
idcliente INT NOT NULL,
data  DATE,
status VARCHAR(50),
FOREIGN KEY (idcliente) REFERENCES cliente (idcliente));

CREATE TABLE itenspedido (
iditem SERIAL PRIMARY KEY,
idpedido INT NOT NULL,
idproduto INT NOT NULL,
quantidade INT NOT NULL,
preco NUMERIC(6,2) NOT NULL,
FOREIGN KEY (idpedido) REFERENCES pedido (idpedido),
FOREIGN KEY (idproduto) REFERENCES produto (idproduto));


/* 2- popular as tabelas */

INSERT INTO cliente (idcliente, nome, email, telefone) VALUES
(1, 'João Silva', 'joao@email.com', '48999990001'),
(2, 'Maria Souza', 'maria@email.com', '48999990002'),
(3, 'Carlos Lima', 'carlos@email.com', '48999990003'),
(4, 'Ana Costa', 'ana@email.com', '48999990004'),
(5, 'Pedro Alves', 'pedro@email.com', '48999990005');

INSERT INTO produto (idproduto, nome, preco, estoque) VALUES
(1,  'Notebook Dell', 3500.00, 10),
(2,  'Mouse sem fio', 80.00, 50),
(3,  'Teclado mecânico', 250.00, 30),
(4,  'Monitor 24 polegadas', 900.00, 20),
(5,  'Webcam Full HD', 150.00, 15);

INSERT INTO pedido (idpedido, idcliente, data, status) VALUES
(1, 1, '2025-01-10', 'PENDENTE'),
(2, 2, '2025-01-15', 'PAGO'),
(3, 3, '2025-02-05', 'ENVIADO'),
(4, 1, '2025-02-20', 'CANCELADO'),
(5, 4, '2025-03-01', 'PAGO'),
(6, 2, '2025-03-10', 'ENVIADO'),
(7, 3, '2025-04-05', 'PENDENTE'),
(8, 1, '2025-04-18', 'PAGO'),
(9, 4, '2025-05-02', 'ENVIADO'),
(10, 2, '2025-05-20', 'CANCELADO');

INSERT INTO itenspedido (iditem, idpedido, idproduto, quantidade, preco) VALUES
(1, 1, 1, 1, 3500.00),
(2, 2, 2, 2, 80.00),
(3, 3, 3, 1, 250.00),
(4, 4, 1, 1, 3500.00),
(5, 5, 4, 2, 900.00),
(6, 6, 2, 1, 80.00),
(7, 7, 3, 3, 250.00),
(8, 8, 4, 1, 900.00),
(9, 9, 1, 1, 3500.00),
(10, 10, 2, 2, 80.00);


/*3- alterar informações */

/*a- telefone do cliente id = 1 para '48988887777' */

UPDATE cliente
SET telefone = '48988887777'
WHERE idcliente = 1;

SELECT * FROM cliente
WHERE idcliente = 1;

/*b- email do cliente id = 2 para novoemail@empresa.com */

UPDATE cliente
SET email = 'novoemail@empresa.com'
WHERE idcliente = 2;

SELECT * FROM cliente
WHERE idcliente = 2;

/*c- altere preco produto id = 1 para 3700 */

UPDATE produto
SET preco = 3700.00
WHERE idproduto = 1;

SELECT * FROM produto
WHERE idproduto = 1;

/*d- atualize o estoque do produto id = 2 para 100 */

UPDATE produto
SET estoque = 100
WHERE idproduto = 2;

SELECT * FROM produto
WHERE idproduto = 2;


/* 4- pesquisas simples */

/*a- pesquisa joao silva */

SELECT * FROM cliente
WHERE nome = 'João Silva';

/*b- liste clientes cadastrados após 2025-01-01 */

SELECT * FROM pedido
WHERE DATA > '2025-01-01';

/*c- liste todos os produtos com preço acima de 500 */

SELECT * FROM produto
WHERE preco > 500.00;

/*d- produtos com estoque menor que 20 */

SELECT * FROM produto
WHERE estoque < 20;

/*e- liste pedidos com status "pago" */

SELECT * FROM pedido
WHERE status = 'PAGO'


/*6- pesquisas multiplas tabelas */

/*a- liste o id do pedido, nome do cliente data e status de todos os pedidos */

SELECT p.idpedido, c.nome, p.data, p.status 
FROM pedido p 
INNER JOIN cliente c 
ON p.idcliente = c.idcliente;

/*b- pedidos realizados entre 01/02/2025 e 31/03/2025 com nome cliente e data */

SELECT p.idpedido, c.nome, p.data
FROM pedido p 
INNER JOIN cliente c
ON p.idcliente = c.idcliente
WHERE p.data BETWEEN '2025/02/01' AND '2025/03/31';

/*c- liste os itens dos pedidos onde valr total (quant x preço) > 1000 */

SELECT * FROM itenspedido
WHERE (quantidade * preco) > 1000;

/*d- liste clientes que nao possuem pedidos */

SELECT c.nome
FROM cliente c
LEFT JOIN pedido p 
ON c.idcliente = p.idcliente
WHERE p.idpedido IS NULL;

/*e- liste produtos que nunca foram vendidos */

SELECT * FROM itenspedido;

SELECT p.nome 
FROM produto p
LEFT JOIN itenspedido i ON p.idproduto = i.idproduto
WHERE i.iditem IS NULL;

/*f- todos os pedidos com o nome do cliente e status mesmo que esteja ausente */

SELECT p.idpedido, c.nome, p.status
FROM pedido p
LEFT JOIN cliente c ON p.idcliente = c.idcliente


/* CRIAR USUÁRIOS E GRUPOS */

CREATE ROLE vendedor;
CREATE ROLE gerente;

-- b) Criar dois usuários e associá-los aos grupos
CREATE USER ana WITH PASSWORD 'senha123';
GRANT vendedor TO ana;

CREATE USER joao WITH PASSWORD 'senha123';
GRANT gerente TO joao;

-- c) Dar permissões de acesso
-- Acesso total para o GERENTE
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO gerente;

-- Somente INSERT e SELECT tabela pedidos e itens para o VENDEDOR
GRANT SELECT, INSERT ON pedido, itenspedido TO vendedor;

/* NOVO INDICIE DE PESQUISA */
CREATE INDEX idx_data_pedido ON pedido(data);


UPDATE cliente
SET telefone = '111111111111'
WHERE idcliente = 1;

UPDATE cliente
SET email = 'xxxxxxxxxxxxxxxxxx'
WHERE idcliente = 2;

SELECT * FROM cliente
WHERE nome = 'João Silva';

X
SELECT p.data, c.nome
FROM pedido p
INNER JOIN cliente c ON p.idcliente = c.idcliente
WHERE p.data > '2025-01-01';

SELECT DISTINCT c.nome
FROM cliente c
INNER JOIN pedido p ON c.idcliente = p.idcliente
WHERE p.data > '2025-01-01';
X

SELECT * FROM cliente;
SELECT * FROM itenspedido;
SELECT * FROM pedido;
SELECT * FROM produto;

SELECT p.idpedido, c.nome, p.status
FROM pedido p
JOIN cliente c ON c.idcliente = p.idcliente;

SELECT c.nome, p.data
FROM cliente c
JOIN pedido p ON p.idcliente = c.idcliente
WHERE p.data BETWEEN '2025-02-01' AND '2025-03-31';

SELECT * FROM itenspedido
WHERE (quantidade * preco) > 1000;

SELECT c.nome
FROM cliente c
LEFT JOIN pedido p ON p.idcliente = c.idcliente
WHERE p.idpedido IS NULL;

SELECT p.nome
FROM produto p
LEFT JOIN itenspedido i ON i.idproduto = p.idproduto
WHERE i.iditem IS NULL;

SELECT p.idpedido, c.nome, p.status
FROM cliente c
FULL JOIN pedido p ON c.idcliente = p.idpedido;

SELECT idpedido, SUM(quantidade * preco) AS valor_total
FROM itenspedido 
GROUP BY idpedido
HAVING SUM(preco) > 500.00;

SELECT idpedido, AVG(preco) AS media_vendidos
FROM itenspedido 
GROUP BY idpedido;

SELECT p.idcliente, c.nome, SUM(i.quantidade * i.preco) AS total_gasto
FROM pedido p
JOIN itenspedido i ON p.idpedido = i.idpedido
JOIN cliente c ON p.idcliente = c.idcliente
GROUP BY p.idcliente, c.nome
HAVING SUM(quantidade * preco) > 1000.00;

CREATE ROLE niggas;
CREATE ROLE holychopped;

CREATE USER nigga1 WITH PASSWORD 'nigga1';
GRANT niggas TO nigga1;

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA PUBLIC TO niggas;

CREATE INDEX idx_data_pedido ON pedido(data);

