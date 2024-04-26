
USE third_db_atv2;

INSERT INTO dim_vendedor (id, nome, sexo, perccomissao, matricula)
SELECT id, nome, sexo, perccomissao, matricula
FROM second_db_atv2.vendedor;

INSERT INTO dim_data ( dataCalendario, ano, mes, dia)
SELECT DISTINCT
    dtven,
    YEAR(dtven),
    MONTH(dtven),
    DAY(dtven)
FROM second_db_atv2.venda;


INSERT INTO dim_dependente (id, nome, data_nascimento, sexo, inepescola, vendedor)
SELECT id, nome, data_nascimento, sexo, inepescola, vendedor
FROM second_db_atv2.dependente;


INSERT INTO dim_produto (id, nome,  tp_produto, unidade, saldo, produto_status)
SELECT id, nome,  tp_produto, unidade, saldo, produto_status
FROM second_db_atv2.produto;


INSERT INTO dim_cliente (id, nome, codigo_agencia, numero_classificacao, sexo, endereco, pais, estado, cidade)
SELECT cliente.id, nome, codigo_agencia, numero_classificacao, sexo, endereco, pais, estado, cidade
FROM second_db_atv2.cliente as cliente
INNER JOIN second_db_atv2.endereco as endereco ON cliente.endereco = endereco.id;


INSERT INTO fato_venda (id, item_id ,data_id, cliente, canal, venda_status, vendedor, deletado, produto, quantidade, valor_unitario, valor_total)
SELECT venda.id, item.id, dim_data.id, cliente, canal, venda_status, vendedor, deletado, produto, quantidade, valor_unitario, valor_total
FROM second_db_atv2.venda as venda
INNER JOIN second_db_atv2.item_venda as item ON venda.id = item.venda
INNER JOIN dim_data ON venda.dtven = dim_data.dataCalendario ;
