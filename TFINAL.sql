CREATE TABLE funcionario (
	id_funcionario INT PRIMARY KEY,
	cpf VARCHAR(11) UNIQUE NOT NULL,
	matricula INT UNIQUE NOT NULL
);


CREATE TABLE cliente (
	id_cliente INT PRIMARY KEY,
	cpf_cnpj VARCHAR(14) UNIQUE NOT NULL,
	telefone VARCHAR(11) NOT NULL,
	nome VARCHAR(50) UNIQUE NOT NULL,
	endereco VARCHAR(50) NOT NULL
);


CREATE TABLE produto (
	id_produto INT PRIMARY KEY,
	nome VARCHAR(50) UNIQUE,
	estoque INT NOT NULL,
	preco NUMERIC(10,2) NOT NULL
);


CREATE TABLE fornecedor (
	id_fornecedor INT PRIMARY KEY,
	nome VARCHAR(50) NOT NULL,
	cnpj VARCHAR(14) NOT NULL,
	email VARCHAR(30) UNIQUE,
	telefone VARCHAR(11) UNIQUE
);


CREATE TABLE atendimento (
	id_atendimento INT PRIMARY KEY,
	data_atend DATE NOT NULL,
	id_funcionario INT,
	id_cliente INT,
	FOREIGN KEY (id_funcionario) REFERENCES funcionario (id_funcionario),
	FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente)
);

CREATE TABLE pedido (
	id_pedido INT PRIMARY KEY,
	dataemissao DATE NOT NULL,
	valor_total NUMERIC(7,2) NOT NULL,
	status VARCHAR(10) NOT NULL,
	id_cliente INT, 
	FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente)
);


CREATE TABLE pagamento (
	id_pag INT PRIMARY KEY,
	forma_pag VARCHAR(50) NOT NULL,
	valor NUMERIC(10,2) NOT NULL,
	id_pedido INT NOT NULL, 
	FOREIGN KEY (id_pedido) REFERENCES pedido (id_pedido)
);


CREATE TABLE feedback (
	id_feedback INT PRIMARY KEY,
	data_feedb DATE NOT NULL,
	titulo VARCHAR(100) NOT NULL,
	comentario VARCHAR(500) NOT NULL,
	id_pedido INT,
	id_cliente INT,
	FOREIGN KEY (id_pedido) REFERENCES pedido (id_pedido),
	FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente)
);


CREATE TABLE devolucao (
	id_devolucao INT PRIMARY KEY,
	motivo VARCHAR(100) NOT NULL, 
	data_reemb DATE NOT NULL,
	valor NUMERIC(10,2) NOT NULL
);


CREATE TABLE pedido_cliente (
	id_cliente INT,
	id_pedido INT,
	PRIMARY KEY (id_cliente, id_pedido),
	FOREIGN KEY (id_cliente) REFERENCES cliente (id_cliente),
	FOREIGN KEY (id_pedido) REFERENCES pedido (id_pedido)
);


CREATE TABLE pedido_produto (
	id_pedido INT,
	id_produto INT,
	PRIMARY KEY (id_pedido, id_produto),
	FOREIGN KEY (id_pedido) REFERENCES pedido (id_pedido),
	FOREIGN KEY (id_produto) REFERENCES produto (id_produto)
);


CREATE TABLE fornecedor_produto (
	id_fornecedor INT,
	id_produto INT,
	custo NUMERIC (10,2) NOT NULL,
	PRIMARY KEY (id_fornecedor, id_produto),
	FOREIGN KEY (id_fornecedor) REFERENCES fornecedor (id_fornecedor),
	FOREIGN KEY (id_produto) REFERENCES produto (id_produto)
);