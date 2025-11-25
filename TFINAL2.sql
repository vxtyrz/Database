/*criação tabelas*/
CREATE TABLE funcionario (
    id_funcionario INT PRIMARY KEY,
    cpf            VARCHAR(11) UNIQUE NOT NULL,
    matricula      INT UNIQUE NOT NULL
);

CREATE TABLE cliente (
    id_cliente     INT PRIMARY KEY,
    cpf_cnpj       VARCHAR(14) UNIQUE NOT NULL,
    telefone       VARCHAR(11) NOT NULL,
    nome           VARCHAR(50) NOT NULL,
    endereco       VARCHAR(50) NOT NULL
);

CREATE TABLE produto (
    id_produto     INT PRIMARY KEY,
    nome           VARCHAR(50) UNIQUE NOT NULL,
    estoque        INT NOT NULL,
    preco          NUMERIC(10,2) NOT NULL 
);

CREATE TABLE fornecedor (
    id_fornecedor  INT PRIMARY KEY,
    nome           VARCHAR(50) NOT NULL,
    cnpj           VARCHAR(14) UNIQUE NOT NULL,
    email          VARCHAR(30) UNIQUE,
    telefone       VARCHAR(11) UNIQUE
);

CREATE TABLE devolucao (
    id_devolucao   INT PRIMARY KEY,
    motivo         VARCHAR(100) NOT NULL, 
    data_reemb     DATE NOT NULL,
    valor          NUMERIC(10,2) NOT NULL
);


CREATE TABLE atendimento (
    id_atendimento INT PRIMARY KEY,
    data_atend     DATE NOT NULL,
    id_funcionario INT NOT NULL,
    id_cliente     INT NOT NULL,
    CONSTRAINT fk_atend_func FOREIGN KEY (id_funcionario) REFERENCES funcionario (id_funcionario),
    CONSTRAINT fk_atend_cli  FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente)
);

CREATE TABLE pedido (
    id_pedido      INT PRIMARY KEY,
    dataemissao    DATE NOT NULL,
    valor_total    NUMERIC(10,2) NOT NULL,
    status         VARCHAR(10) NOT NULL,
    id_cliente     INT NOT NULL, 
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente)
);


CREATE TABLE pagamento (
    id_pag         INT PRIMARY KEY,
    forma_pag      VARCHAR(50) NOT NULL,
    valor          NUMERIC(10,2) NOT NULL,
    id_pedido      INT NOT NULL UNIQUE, 
    CONSTRAINT fk_pag_pedido FOREIGN KEY (id_pedido) REFERENCES pedido (id_pedido)
);

CREATE TABLE feedback (
    id_feedback    INT PRIMARY KEY,
    data_feedb     DATE NOT NULL,
    titulo         VARCHAR(100) NOT NULL,
    comentario     VARCHAR(500) NOT NULL,
    id_pedido      INT NOT NULL,
    id_cliente     INT NOT NULL,
    CONSTRAINT fk_feed_pedido FOREIGN KEY (id_pedido) REFERENCES pedido (id_pedido),
    CONSTRAINT fk_feed_cli    FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente)
);


CREATE TABLE pedido_produto (
    id_pedido      INT,
    id_produto     INT,
    quantidade     INT DEFAULT 1,
    PRIMARY KEY (id_pedido, id_produto),
    CONSTRAINT fk_pp_pedido  FOREIGN KEY (id_pedido) REFERENCES pedido (id_pedido),
    CONSTRAINT fk_pp_produto FOREIGN KEY (id_produto) REFERENCES produto (id_produto)
);


CREATE TABLE fornecedor_produto (
    id_fornecedor  INT,
    id_produto     INT,
    custo          NUMERIC(10,2) NOT NULL,
    PRIMARY KEY (id_fornecedor, id_produto),
    CONSTRAINT fk_fp_forn FOREIGN KEY (id_fornecedor) REFERENCES fornecedor (id_fornecedor),
    CONSTRAINT fk_fp_prod FOREIGN KEY (id_produto) REFERENCES produto (id_produto)
);


/*inserts*/
INSERT INTO cliente (id_cliente, cpf_cnpj, telefone, nome, endereco) VALUES
(1, '12345678901', '987654321', 'Ana Silva', 'Rua das Flores, 100'),
(2, '98765432100', '988887777', 'Carlos Oliveira', 'Av. Brasil, 450'),
(3, '45678912300', '992224444', 'Mariana Souza', 'Rua B, 32');


INSERT INTO funcionario (id_funcionario, cpf, matricula) VALUES
(1, '12233344', 1001),
(2, '56677788', 1002);


INSERT INTO produto (id_produto, nome, estoque, preco) VALUES
(1, 'Monitor 24"', 20, 799.90),
(2, 'Mouse Gamer', 50, 120.00),
(3, 'Teclado Mecânico', 35, 350.00);


INSERT INTO fornecedor (id_fornecedor, nome, cnpj, email, telefone) VALUES
(1, 'Tech Supply', '12345678000199', 'contato@techsupply.com', '99998888'),
(2, 'Digital Parts', '98765432000155', 'vendas@digitalparts.com', '77776666');


INSERT INTO devolucao (id_devolucao, motivo, data_reemb, valor) VALUES
(1, 'Produto com defeito', '2025-01-20', 120.00),
(2, 'Cliente desistiu', '2025-01-22', 799.90);


INSERT INTO pedido (id_pedido, dataemissao, valor_total, status, id_cliente) VALUES
(1, '2025-01-10', 150.90, 'pago', 1),
(2, '2025-01-12', 89.50, 'pendente', 2),
(3, '2025-01-15', 220.00, 'pago', 3);


INSERT INTO pagamento (id_pag, forma_pag, valor, id_pedido) VALUES
(1, 'Cartão', 150.90, 1),
(2, 'Pix', 220.00, 3);


INSERT INTO atendimento (id_atendimento, data_atend, id_funcionario, id_cliente) VALUES
(1, '2025-01-10', 1, 1),
(2, '2025-01-12', 2, 2),
(3, '2025-01-15', 1, 3);


INSERT INTO feedback (id_feedback, data_feedb, titulo, comentario, id_pedido, id_cliente) VALUES
(1, '2025-01-11', 'Muito bom', 'Atendimento ótimo e entrega rápida.', 1, 1),
(2, '2025-01-13', 'Pode melhorar', 'Demorou mais que o esperado.', 2, 2),
(3, '2025-01-16', 'Excelente', 'Produto impecável!', 3, 3);


INSERT INTO pedido_produto (id_pedido, id_produto) VALUES
(1, 1), /* -- Pedido 1 tem Monitor */
(1, 2), /* -- Pedido 1 tem Mouse */
(2, 2), /* -- Pedido 2 tem Mouse */
(3, 3); /* -- Pedido 3 tem Teclado */


INSERT INTO fornecedor_produto (id_fornecedor, id_produto, custo) VALUES
(1, 1, 500.00),
(1, 2, 60.00),
(2, 3, 200.00);

SELECT * FROM funcionario;
SELECT * FROM cliente;
SELECT * FROM produto;
SELECT * FROM fornecedor;
SELECT * FROM devolucao;
SELECT * FROM atendimento;
SELECT * FROM pedido;
SELECT * FROM pagamento;
SELECT * FROM feedback;
SELECT * FROM pedido_produto;
SELECT * FROM fornecedor_produto;
