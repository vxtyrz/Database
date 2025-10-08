DROP TABLE IF EXISTS treinador;
DROP TABLE IF EXISTS modalidade;
DROP TABLE IF EXISTS atleta;

create table treinador(
codigo int not null,
nome varchar(50) not null,
primary key (codigo)
);

create table modalidade (
codigo int not null,
nome varchar(50) not null,
codtreinador int not null,
primary key (codigo),
foreign key (codtreinador) references treinador (codigo)
);

create table atleta(
codigo int not null,
nome varchar(50) not null,
endereco varchar(50) not null,
cidade varchar(50) not null,
estado char(2) not null,
datanascimento date not null,
peso decimal(5,2) not null,
altura decimal(4,2) not null,
codmodalidade int not null,
primary key (codigo),
foreign key (codmodalidade) references modalidade (codigo)
);

/*alterar estrutura da tabela
ADD (adicionar) alter (modificar) drop (remover)
*/

alter table treinador 
add column telefone numeric(20) not null;

alter table treinador
alter column telefone type numeric(15);

alter table treinador
drop column fone


/* insert (inserir informaçoes na tabela) */

insert into treinador (codigo,nome,telefone)
values (1,'filipe luis',123);

insert into treinador (codigo,nome,telefone)
values (2,'jose mourinho',123);

insert into treinador (codigo,nome,telefone)
values (3,'diniz',123);


insert into modalidade (codigo,nome,codtreinador)
values (1,'futebol',1);

insert into modalidade (codigo,nome,codtreinador)
values (2,'futebol',2);

insert into modalidade (codigo,nome,codtreinador)
values (3,'futebol',3);


insert into atleta (codigo,nome,endereco,cidade,estado,datanascimento,peso,altura,codmodalidade, telefone)
values (1,'Cristiano Ronaldo','Arabia saudita','Riad','AS','05/02/1985',83.00,'1.87',1, 67676767),
(2,'Ronaldo Nazario','Brasil','Sao Paulo','SP','05/02/1972',120.00,'1.83',1, 69696969),
(3,'Lionel Messi','EUA','Miami','RD','03/05/1987',67.00,'1.67',1, 3333333),
(4,'Joao Felix','Arabia saudita','dubai','AS','11/09/2001',70.00,'1.76',1, 6666666);

select * from atleta
where codigo between 1 and 3


create table campeonato(
codigo int not null,
datainscricao date not null,
valor decimal(6,2) not null,
codatleta int not null,
codmodalidade int not null,
primary key (codigo),
foreign key (codatleta) references atleta (codigo),
foreign key (codmodalidade) references modalidade (codigo)
);

insert into campeonato (codigo,datainscricao,valor,codatleta,codmodalidade)
values (1,'01/09/2025',150.00,1,1),
(2,'05/09/2025',150.00,4,1),
(3,'10/09/2025',150.00,2,2),
(4,'10/09/2025',200.00,3,2);


/* 1) inserir 2 treinadores */
select * from treinador;

insert into treinador (codigo, nome, telefone)
values (6, 'Guardiola' ,444);

insert into treinador (codigo, nome, telefone)
values (7, 'José Mourinho' ,777);


/* 2) inserir mais 2 */

INSERT INTO treinador (codigo, nome, telefone)
VALUES (8, 'Jorge Jesus', 249756230);

INSERT INTO treinador (codigo, nome, telefone)
VALUES (9, 'Graham Potter', 56565656);

SELECT * FROM treinador;


/* 2 modalidades + */
INSERT INTO modalidade (codigo, nome, codtreinador)
VALUES (6, 'BASQUETE', 6),
(7, 'HANDEBOL', 7),
(8, 'KARATE', 8),
(9, 'JUDO', 9);

SELECT * FROM modalidade;


/* 3) 3 novos atletas */
INSERT INTO atleta (codigo, nome, endereco, cidade, estado, telefone, datanascimento, peso, altura, codmodalidade)
VALUES (5, 'Neymar JR', 'Villa', 'Santos', 'SP', '45647564757', '05/02/1992', 65.00, 1.75, '1'),
(6, 'Kevin De Bruyne', 'Rua Napoles', 'Napoli', 'CA', '35730035730', '28/06/1991', 70.00, 1.78, '1');

SELECT * FROM atleta;


/* 4) Adicionar campo 'patrocinador' na tabela campeonato e preencher com valor padrão */
UPDATE modalidade
SET nome = 'Golfe'
WHERE codigo = 2;

UPDATE modalidade
SET nome = 'Volêi'
WHERE codigo = 3;

UPDATE atleta
SET codmodalidade = 2
WHERE codigo = 5;

ALTER TABLE campeonato
ADD COLUMN patrocinador VARCHAR(50);

UPDATE campeonato SET patrocinador = 'Daniel Lanches'

SELECT * FROM campeonato;


/* 5) Inserir novo registro na tabela campeonato (para o atleta de volêi) */
SELECT * FROM atleta;
SELECT * FROM modalidade;

INSERT INTO campeonato (codigo, datainscricao, valor, codatleta, codmodalidade)
VALUES (5, '29/12/2006', 450.00, 5, 2); 

SELECT * FROM campeonato;

/* 6) novo valor campeonato */
UPDATE campeonato
SET valor = 600.00
WHERE codigo = 5

SELECT * FROM campeonato;


/* 8) adicionar campo premiação */
ALTER TABLE campeonato
ADD COLUMN premiacao decimal(6,2);
SELECT * FROM campeonato;

UPDATE campeonato
SET premiacao = valor * 0.75; /* colocar o valor numerico */
SELECT * FROM campeonato

UPDATE campeonato
SET premiacao = 1000.00
WHERE codigo = 5
SELECT * FROM campeonato


/* 9) modalide -> tenis de mesa */
UPDATE modalidade
SET nome = 'Tênis de Mesa'
WHERE codigo = 7
SELECT * FROM modalidade;


/* 10) aumentar valor de inscrição */
UPDATE campeonato
SET valor = valor * 1.2
WHERE codmodalidade = 2
SELECT * FROM campeonato;


/* 11) Listar todos os atletas do basquete */
SELECT atleta.nome, modalidade.nome FROM atleta, modalidade WHERE atleta.codmodalidade = modalidade.codigo AND modalidade.nome = 'futebol';


/* 12) listar atletas e premiações do futebol */
SELECT atleta.nome, premiacao.campeonato FROM atleta, campeonato, modalidade WHERE atleta.codmodalidade = campeonato.codmodalidade AND modalidade.nome = 'futebol';