/*- ALTERAR INFORMAÇÕES*/

SELECT * FROM cliente
SELECT * FROM pedido
SELECT * FROM itenspedido
SELECT * FROM produto
/* telefone cliente 1 para '48991192912' */

UPDATE cliente
SET TELEFONE = '48991192912'
WHERE idcliente = 1;

/* email cliente 2 para vitaocibr@gmail.com */

UPDATE cliente
SET email = 'vitaocribr@gmail.com'
WHERE idcliente = 2;

/* preço produto produto 1 para 4000 */

UPDATE produto 
SET preco = 4000.00
WHERE idproduto = 1;

/* estoque poduto 2 para 200 */

UPDATE produto
SET estoque = 200
WHERE idproduto = 2;


/* PESQUISAS SIMPLES */

/* dados cliente joao silva */

SELECT * FROM cliente
WHERE idcliente = 1;

/* liste clientes cadastrados apos 2025-01-01 */

SELECT * FROM pedido
WHERE data > '2025-02-01';

/* produtos com preço acima de 500 */

SELECT * FROM produto
WHERE preco > 500.00;

/* produtos com estoque menor que 20 */

SELECT * FROM produto
WHERE estoque < 20;

/* PESQUISAS MÚLTIPLAS */
/* id pedido nome do cliente data e status de todos os pedidos */

SELECT * FROM cliente
SELECT * FROM itenspedido 
SELECT * FROM pedido
SELECT * FROM produto

SELECT p.idpedido, c.nome, p.data, p.status
FROM pedido p
INNER JOIN cliente c ON p.idcliente = c.idcliente;

/* todos os pedidos realizads entre 01/02 e 31/03 com nome do cliente e data */

SELECT p.idpedido, p.data, c.nome
FROM pedido p
INNER JOIN cliente c ON p.idcliente = c.idcliente
WHERE p.data BETWEEN '2025-02-01' AND '2025-03-31'

/* todos os itens onde o valor total *quantidade x preço* seja mais que 100 */

SELECT * FROM itenspedido
WHERE quantidade * preco > 1000;

/* clientes que não possuem pedidos */

SELECT p.idcliente, c.nome, p.idpedido
FROM pedido p
LEFT JOIN cliente c ON p.idcliente = c.idcliente
WHERE p.idpedido IS NULL

/* produtos que nunca foram vendidos */

SELECT pr.nome
FROM produto pr
LEFT JOIN itenspedido i ON pr.idproduto = i.idproduto
WHERE i.iditem IS NULL;

/* todos os pedidos com nome do cliente e status */

SELECT p.idpedido, c.nome, p.status
FROM pedido p
LEFT JOIN cliente c ON p.idcliente = c.idcliente;

/* valor total de cade pedido, apenas pedidos com total maior que 500 */

SELECT p.idpedido, i.preco, i.quantidade
FROM pedido p 
LEFT JOIN itenspedido i ON p.idpedido = i.idpedido
WHERE preco * quantidade > 500;

SELECT idpedido, SUM(quantidade * preco) AS valor_total
FROM itenspedido
GROUP BY idpedido
HAVING SUM(quantidade * preco) > 500;

/* média de preço dos produtos vendidos */

SELECT AVG(preco) AS media_preco
FROM itenspedido;

/* CRIAR USUÁRIOS E GRUPOS */

CREATE GROUP vendedores;
CREATE GROUP gerente;

CREATE USER Vitor WITH PASSWORD '123';
GRANT vendedores to Vitor;

CREATE USER Joao WITH PASSWORD '256';
GRANT gerente to Joao;

/* permissões */

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA PUBLIC TO gerente;

GRANT SELECT, INSERT ON pedido, itenspedido to vendedor;

/* novo indice */

CREATE INDEX idx_data_pedido ON pedido(data);
