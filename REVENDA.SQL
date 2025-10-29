/* 1) criar tabela */
CREATE TABLE marca (
codigo serial NOT NULL,
nome VARCHAR(50) NOT NULL,
PRIMARY KEY (codigo)
);

CREATE TABLE modelo (
codigo serial NOT NULL,
nome VARCHAR(100) NOT NULL,
PRIMARY KEY (codigo)
);

CREATE TABLE automovel (
codigo serial NOT NULL,
placa VARCHAR(10) NOT NULL,
codmarca INT NOT NULL,
codmodelo INT NOT NULL,
ano INT NOT NULL,
cor VARCHAR(20) NOT NULL,
combustivel VARCHAR (20) NOT NULL,
valor NUMERIC(10,2) NOT NULL,
PRIMARY KEY (codigo),
FOREIGN KEY (codmarca) REFERENCES marca(codigo),
FOREIGN KEY (codmodelo) REFERENCES modelo(codigo)
);

/* 2) adicionar info */
INSERT INTO marca (nome)
VALUES ('Koenigseg'),
('Ferrari'),
('Lamborghini'),
('Chevrolet'),
('Acura'),
('Ford'),
('Hoonigan'),
('Lancia'),
('Audi'),
('BMW');

INSERT INTO modelo (nome)
VALUES ('Jesko'),
('599x'),
('Huracan STO'),
('Corvette Stingray'),
('NSX'),
('Fiesta'),
('Hoonicorn'),
('Delta'),
('A7'),
('M3 Competition');

INSERT into automovel (placa, codmarca, codmodelo, ano, cor, combustivel, valor)
VALUES ('ABC1A23', 1, 1, 2020, 'Branco', 'Gasolina', 95000.00),
('BCD2634', 2, 2, 2019, 'Vermelho', 'Flex', 87000.00),
('CDE3C45', 3, 3, 2018, 'Azul', 'Gasolina', 78000.00),
('DEF4D56', 4, 4, 2021, 'Laranja', 'Flex', 92000.00),
('EFG5E67', 5, 5, 2022, 'Branco', 'Gasolina', 105000.00),
('FGH6F78', 6, 6, 2023, 'Dourado', 'Flex', 88000.00),
('GHI7G89', 7, 7, 2020, 'Preto', 'Gasolina', 89000.00),
('HIJ8H90', 8, 8, 2021, 'Vermelho', 'Flex', 65000.00),
('IJK9I01', 9, 9, 2022, 'Azul Escuro', 'Gasolina', 59000.00),
('JKL0J12', 10, 10, 2023, 'Verde-Turquesa', 'Diesel', 155000.00);

/* 3) alteracoes no banco (update)
a) alterar valor do automovel com placa EFG5E67 (valor 120000) */
UPDATE automovel 
SET valor = 120000.00
WHERE placa = 'EFG5E67';

/* b) alterar cor do automovel com placa 'IJK9I01' (cor branco) */
UPDATE automovel
SET cor = 'Branco'
WHERE placa = 'IJK9I01';

/* pesquisas simples (SELECT) */
a) listar as marcas cadastradas
SELECT * FROM marca;

b) listar nome modelos 
SELECT nome FROM modelo;

/* c) listar todos os automoveis da cor "vermelho" */
SELECT codigo, placa, ano, cor, valor FROM automovel
WHERE cor = 'Vermelho';

/* d) listar todos os automoveis com gasolina */
SELECT placa, ano, cor, valor, combustivel FROM automovel
WHERE combustivel = 'Gasolina'

/* e) listar todos automoveis com diesel valor acima de 80000 */
SELECT placa, ano, valor, combustivel FROM automovel
WHERE combustivel = 'Diesel' 
AND valor >= 80000.00;
