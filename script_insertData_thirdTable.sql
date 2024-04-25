
USE third_db_atv2;


DELETE FROM dim_item_venda where id >= 0;
DELETE FROM fato_venda where id >= 0;
DELETE FROM dim_cliente where id >= 0;
DELETE FROM dim_endereco where id >= 0;
DELETE FROM dim_produto where id >= 0;
DELETE FROM dim_dependente where id >= 0;
DELETE FROM dim_vendedor where id >= 0;


INSERT INTO dim_vendedor (id, nome, sexo, perccomissao, matricula)
SELECT id, nome, sexo, perccomissao, matricula
FROM second_db_atv2.vendedor;


INSERT INTO dim_dependente (id, nome, data_nascimento, sexo, inepescola, vendedor)
SELECT id, nome, data_nascimento, sexo, inepescola, vendedor
FROM second_db_atv2.dependente;


INSERT INTO dim_produto (id, nome,  tp_produto, unidade, saldo, produto_status)
SELECT id, nome,  tp_produto, unidade, saldo, produto_status
FROM second_db_atv2.produto;


INSERT INTO dim_endereco (id, pais, estado, cidade)
SELECT id, pais, estado, cidade
FROM second_db_atv2.endereco;


INSERT INTO dim_cliente (id, nome, codigo_agencia, numero_classificacao, sexo, endereco)
SELECT id, nome, codigo_agencia, numero_classificacao, sexo, endereco
FROM second_db_atv2.cliente;


INSERT INTO fato_venda (id, dtven, cliente, canal, venda_status, vendedor, deletado)
SELECT id, dtven, cliente, canal, venda_status, vendedor, deletado
FROM second_db_atv2.venda;


INSERT INTO dim_item_venda (id, produto, quantidade, venda, valor_unitario, valor_total)
SELECT id, produto, quantidade, venda, valor_unitario, valor_total
FROM second_db_atv2.item_venda;