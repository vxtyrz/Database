CREATE TABLE produtos (
codigo SERIAL PRIMARY KEY,
nome TEXT,
preco NUMERIC,
estoque INT,
status  varchar(50));

CREATE TABLE pedidos (
codpedido SERIAL PRIMARY KEY,
datapedido date,
codproduto INT,
quantidade INT,
total NUMERIC,
status  varchar(50),
Foreign Key (codproduto) references produtos (codigo));

INSERT INTO produtos (nome, preco, estoque, status) VALUES
('Notebook', 3500.00, 15, 'ativo'),
('Mouse', 80.00, 50, 'ativo'),
('Teclado', 150.00, 30, 'ativo'),
('Monitor', 900.00, 20, 'ativo'),
('Headset', 200.00, 25, 'ativo');

INSERT INTO pedidos (datapedido, codproduto, quantidade, total, status) VALUES
('2026-04-01', 1, 1, 3500.00, 'finalizado'),
('2026-04-02', 2, 2, 160.00, 'finalizado'),
('2026-04-03', 3, 1, 150.00, 'finalizado'),
('2026-04-04', 4, 1, 900.00, 'cancelado'),
('2026-04-05', 5, 2, 400.00, 'finalizado'),
('2026-04-06', 1, 1, 3500.00, 'cancelado'),
('2026-04-07', 2, 3, 240.00, 'finalizado'),
('2026-04-08', 3, 2, 300.00, 'cancelado'),
('2026-04-09', 4, 1, 900.00, 'finalizado'),
('2026-04-10', 5, 1, 200.00, 'finalizado');

CREATE TABLE vendas (
codvenda SERIAL PRIMARY KEY,
datavenda DATE,
codpedido INT,
codproduto INT,
quantidade INT,
valorunitario NUMERIC,
status VARCHAR(20),
FOREIGN KEY (codpedido) REFERENCES pedidos(codpedido),
FOREIGN KEY (codproduto) REFERENCES produtos(codigo));

INSERT INTO vendas (datavenda, codpedido, codproduto, quantidade, valorunitario, status) VALUES
('2026-04-01', 1, 1, 1, 3500.00, 'ativa'),
('2026-04-02', 2, 2, 2, 80.00, 'ativa'),
('2026-04-03', 3, 3, 1, 150.00, 'ativa'),
('2026-04-04', 4, 4, 1, 900.00, 'ativa'),
('2026-04-05', 5, 5, 2, 200.00, 'ativa'),
('2026-04-06', 6, 1, 1, 3500.00, 'cancelada'),
('2026-04-07', 7, 2, 3, 80.00, 'ativa'),
('2026-04-08', 8, 3, 2, 150.00, 'ativa'),
('2026-04-09', 9, 4, 1, 900.00, 'ativa'),
('2026-04-10', 10, 5, 1, 200.00, 'ativa');

/* EXERCÍCIOS PROCEDURE */
/* 1*/
CREATE PROCEDURE inserir_produto(pro_nome VARCHAR, pro_preco NUMERIC, pro_estoque INT) AS $$
	BEGIN
		INSERT INTO produtos(nome, preco, estoque, status)
		VALUES (pro_nome, pro_preco, pro_estoque, 'ativo');
	END;
$$ LANGUAGE plpgsql;

CALL inserir_produto ('caneta azul', 3.50, 50)


/* 2*/
CREATE PROCEDURE atualizar_preco(pro_codigo INT, pro_novo_preco NUMERIC) AS $$
	BEGIN
		UPDATE produtos SET preco = pro_novo_preco
		WHERE codigo = pro_codigo;
	END;
$$ LANGUAGE plpgsql;

CALL atualizar_preco(3, 200.00);
SELECT * FROM produtos;

/* 3*/
CREATE PROCEDURE baixar_estoque(pro_codigo INT, pro_estoque INT, pro_quantidade NUMERIC) AS $$
	BEGIN
		UPDATE produtos SET estoque = pro_estoque - pro_quantidade
		WHERE codigo = pro_codigo;
	END;
$$ LANGUAGE plpgsql;

CALL baixar_estoque(4, 20, 10);
SELECT * FROM produtos;

/* 4*/
CREATE PROCEDURE repor_estoque(pro_codigo INT, pro_estoque INT, pro_quantidade NUMERIC) AS $$
	BEGIN
		UPDATE produtos SET estoque = pro_estoque + pro_quantidade
		WHERE codigo = pro_codigo;
	END;
$$ LANGUAGE plpgsql;

CALL repor_estoque(1, 15, 75)

/* 5*/
SELECT * FROM vendas;
CREATE PROCEDURE calcular_total_pedido(v_codpedido INT, INOUT v_total NUMERIC) AS $$
	BEGIN
    	SELECT COALESCE(SUM(valorunitario * quantidade), 0) INTO v_total
    	FROM vendas
    	WHERE codpedido = v_codpedido;
	END;	
$$ LANGUAGE plpgsql;

DROP PROCEDURE calcular_total_pedido(v_codpedido INT, INOUT v_total NUMERIC)

CALL calcular_total_pedido(7, NULL)

/*6 */
SELECT * FROM produtos;
SELECT * FROM pedidos;
CREATE PROCEDURE inserir_pedido(p_codigo INT, p_quantidade INT) AS $$
	DECLARE 
		v_preco NUMERIC;
		v_total NUMERIC;
	BEGIN
		SELECT preco INTO v_preco FROM produtos WHERE codigo = p.codigo;
		v_total = v_preco * p_quantidade;

		INSERT INTO pedidos (datapedido, codproduto, quantidade, total, status)
		VALUES (CURRENT_DATE, p_codproduto, p_quantidade, v_total, 'finalizado');
	END;
$$ LANGUAGE plpgsql;















/* 1- retornar o dobro de um numero */

/*plpgsql*/
CREATE OR REPLACE FUNCTION dobro(x INT) RETURNS INT AS '
	BEGIN
		RETURN x * 2;
	END;
' LANGUAGE plpgsql;

/*sql*/
CREATE OR REPLACE FUNCTION dobro2(x INT) RETURNS INT AS '
		SELECT x * 2;
' LANGUAGE sql;

SELECT dobro2(6)


/* 2- função para verificar se o número é par */

/*plpgsql*/
CREATE OR REPLACE FUNCTION par(n INT) RETURNS BOOLEAN AS '
	BEGIN
		return (n % 2 = 0);
	END;
' LANGUAGE plpgsql;

SELECT par(16)

/*sql*/
CREATE OR REPLACE FUNCTION par2(n INT) RETURNS BOOLEAN AS '
	SELECT n % 2 = 0;
' LANGUAGE SQL;

SELECT par2(19)


/* 3- função para receber preço e %desconto e retornar resultado */

/*plpgsql*/
CREATE OR REPLACE FUNCTION calcular

