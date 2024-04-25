
USE second_db_atv2;


DELETE FROM item_venda where id >= 0;
DELETE FROM venda where id >= 0;
DELETE FROM cliente where id >= 0;
DELETE FROM endereco where id >= 0;
DELETE FROM produto where id >= 0;
DELETE FROM dependente where id >= 0;
DELETE FROM vendedor where id >= 0;


INSERT INTO vendedor (id, nome, sexo, perccomissao, matricula)
SELECT cdvdd, nmvdd, IF(sxvdd > 0, 'M', 'F'), perccomissao, matfunc
FROM first_db_ativ2.tbvdd;


INSERT INTO dependente (id, nome, data_nascimento, sexo, inepescola, vendedor)
SELECT cddep, nmdep, dtnasc, trim(sxdep), inepescola, cdvdd
FROM first_db_ativ2.tbdep;


INSERT INTO produto (id, nome,  tp_produto, unidade, saldo, produto_status)
SELECT cdpro, nmpro, tppro, undpro, slpro, stpro
FROM first_db_ativ2.tbpro;



INSERT INTO endereco (pais, estado, cidade)
SELECT distinct paicli, estcli, cidcli 
FROM first_db_ativ2.tbven;



INSERT INTO cliente (id, nome, codigo_agencia, numero_classificacao, sexo, endereco)
SELECT distinct cdcli, nmcli, agecli, clacli, sxcli, endereco.id
FROM first_db_ativ2.tbven as tbven
INNER JOIN endereco on  tbven.cidcli = endereco.cidade
					and tbven.estcli = endereco.estado
                    and tbven.paicli = endereco.pais;


INSERT INTO venda (id, dtven, cliente, canal, venda_status, vendedor, deletado)
SELECT distinct cdven, dtven, cliente.id, canal, stven, vendedor.id,
				IF(deleted > 0, 'Sim', 'Nao')
FROM first_db_ativ2.tbven as tbven
INNER JOIN cliente ON tbven.cdcli = cliente.id
INNER JOIN vendedor on tbven.cdvdd = vendedor.id;



INSERT INTO item_venda (id, produto, quantidade, venda, valor_unitario, valor_total)
SELECT distinct cdvenitem, produto.id, qtven, venda.id, vruven, qtven*vruven
FROM first_db_ativ2.tbven_item as item
INNER JOIN produto ON item.cdpro = produto.id
INNER JOIN venda on item.cdven = venda.id;