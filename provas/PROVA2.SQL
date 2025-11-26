CREATE TABLE revisao (
codigo SERIAL PRIMARY KEY,
codautomovel INT NOT NULL,
dataservico DATE NOT NULL,
tiposervico VARCHAR(100) NOT NULL,
valor NUMERIC (10,2) CHECK (valor >= 0),
FOREIGN KEY (codautomovel) REFERENCES automovel (codigo)
);

INSERT INTO revisao (codautomovel, dataservico, tiposervico, valor) VALUES
(1, '2025-01-15', 'Troca de óleo e filtro', 350.00),
(2, '2025-02-10', 'Revisão dos 20.000km', 600.00),
(3, '2025-03-05', 'Troca de pastilhas de freio', 420.00),
(4, '2025-03-20', 'Alinhamento de balançeamento', 200.00),
(5, '2025-04-10', 'Revisão dos 30.000km', 750.00),
(6, '2025-04-25', 'Substituição de velas', 280.00),
(7, '2025-05-18', 'Troca de óleo e filtro', 340.00),
(8, '2025-06-02', 'Troca de correia dentada', 900.00),
(9, '2025-08-15', 'Revisão dos 40.000km', 850.00),
(10, '2025-09-05', 'Troca de fluido de freio', 300.00);



/* 2) alterar registros nas tabelas */
/* a) campo valor da revisão de codigo 5 para 800 */
UPDATE revisao
SET valor = 800.00
WHERE codigo = '5';

/* b) alterar campo tipo serviço de codigo 10 para "troca de oleo" e valor para 350.00 */
UPDATE revisao
SET tiposervico = 'Troca de óleo'
WHERE codigo = '10';

UPDATE revisao
SET valor = 350.00
WHERE codigo = '10';

/* c) adicionar ao valor da revisao juros de 5% em todas as revisões com data mes setembro 2025 */
UPDATE revisao
SET valor = valor + valor*1.05
WHERE codigo = '10';

/* d) data revisao codigo 3 para 05/02/2025 */
UPDATE revisao
SET dataservico = '2025-02-05'
WHERE codigo = '3';



/* 3) comandos SELECT */
/* 1) listar revisoes e info do veiculo */
SELECT revisao.codigo AS codigo_carro, revisao.tiposervico, revisao.dataservico FROM revisao INNER JOIN automovel ON revisao.codautomovel = automovel.codigo;
SELECT * FROM modelo;
SELECT * FROM automovel;
SELECT * FROM revisao;


/* 2) mostrar automoveis e revisoes */
SELECT automovel.codigo AS codigo_carro, automovel.placa, revisao.dataservico, revisao.tiposervico FROM automovel INNER JOIN revisao ON revisao.codautomovel = automovel.codigo;


/* 3) listar todas revisoes em automoveis */
SELECT revisao.codigo AS codigo_carro, revisao.tiposervico, revisao.dataservico, modelo.nome FROM revisao INNER JOIN modelo ON revisao.codautomovel = modelo.codigo;


/* 4) mostrar valor total gasto em revisões agrupado por automovel */
SELECT sum(revisao.valor) AS valor_revisao, automovel.codigo AS codigo_carro FROM revisao INNER JOIN automovel ON automovel.codigo = revisao.codigo GROUP BY automovel.codigo; 


/* 5 listar media do valor total em revisoes agrupados por automovel */
SELECT avg(revisao.valor) AS valor_m, automovel.codigo FROM revisao INNER JOIN automovel ON automovel.codigo = revisao.codigo GROUP BY automovel.codigo;


/* 6) mostrar revisoes feitas após abril, por automovel */
SELECT automovel.codigo AS codigo_carro, revisao.dataservico FROM automovel, revisao WHERE automovel.codigo = revisao.codigo AND revisao.dataservico > '2025-04-25' GROUP BY automovel.codigo, revisao.dataservico;


/* 7) quantidade de revisões por tipo de combustivel */
SELECT automovel.combustivel, count(revisao.codigo) AS qtd_revisoes FROM automovel INNER JOIN revisao ON automovel.codigo = revisao.codigo GROUP BY automovel.combustivel;


/* 8) mostrar total de revisoes por ano de veiculo */
SELECT automovel.ano, count(revisao.codigo) AS qtd_revisoes FROM automovel INNER JOIN revisao ON automovel.codigo = revisao.codigo GROUP BY automovel.ano;


/* 9) listar veiculos que nunca passaram por revisao */
SELECT modelo.nome, revisao.codigo FROM modelo INNER JOIN revisao ON modelo.codigo = revisao.codigo WHERE revisao.codigo IS NULL;

/* 10) listar revisoes e seus modelos, no mes de abril */
SELECT revisao.codigo AS codigo_carro, modelo.nome, revisao.tiposervico, revisao.dataservico FROM revisao INNER JOIN modelo ON revisao.codigo = modelo.codigo WHERE revisao.dataservico > '2025-04-01' AND revisao.dataservico < '2025-05-01';


/* 11) valor total gasto em revisoes por modelo */
SELECT modelo.nome, revisao.valor AS custo_revisao FROM modelo INNER JOIN revisao ON modelo.codigo = revisao.codigo;


/* 12) quantidade total de veiculos cadastrados por marca */
SELECT sum(automovel.codmarca), modelo.codigo FROM automovel INNER JOIN modelo ON automovel.codigo = modelo.codigo GROUP BY modelo.codigo;


/* 13) valor medio das revisoes por modelo */
SELECT avg(revisao.valor) AS valor_mrevisao, modelo.nome FROM revisao INNER JOIN modelo ON revisao.codigo = modelo.codigo GROUP BY modelo.nome;


/* 14) Listar revisões realizadas no periodo de março a maio de 2025 */
SELECT revisao.codigo AS codigo_carro, revisao.tiposervico, revisao.dataservico FROM revisao WHERE revisao.dataservico > '2025-03-01' AND revisao.dataservico < '2025-05-31';


/* 15) valor total das revisoes por mes em 2025 X*/
SELECT revisao.dataservico, sum(revisao.valor) FROM revisao GROUP BY revisao.dataservico;


/* 16) listar veiculos com revisões entre agosto e dezembro em 2025 */
SELECT automovel.codigo AS codigo_car, revisao.dataservico FROM automovel, revisao WHERE automovel.codigo = revisao.codigo AND revisao.dataservico > '2025-08-01' AND revisao.dataservico < '2025-12-31';


/* 17) listar veiculos que nao possuem revisao registrada */
SELECT automovel.codigo AS codigo_carro FROM automovel, revisao WHERE revisao.codigo IS NULL;
