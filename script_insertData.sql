
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


INSERT INTO endereco (cidade, estado, pais)
SELECT distinct cidcli, estcli, paicli
FROM first_db_ativ2.tbven;



INSERT INTO cliente (id, nome, agencia, classificacao, sexo_id, endereco_id)
SELECT distinct cdcli, nmcli, agecli, clacli, sexo.id, endereco.id
FROM first_db_ativ2.tbven as tbven
INNER JOIN sexo ON trim(tbven.sxcli) = sexo.abreviacao
INNER JOIN endereco on  tbven.cidcli = endereco.cidade
					and tbven.estcli = endereco.estado
                    and tbven.paicli = endereco.pais
WHERE cdcli IN (SELECT MAX(cdcli) FROM first_db_ativ2.tbven  GROUP BY cdcli);

INSERT INTO venda (id, dtven, cliente_id, canal_id, status_id, vendedor_id, deletado)
SELECT distinct cdven, dtven, cliente.id, canal_venda.id, status_venda.id, vendedor.id,
				IF(deleted > 0, 1, 0)
FROM first_db_ativ2.tbven as tbven
INNER JOIN cliente ON tbven.cdcli = cliente.id
INNER JOIN canal_venda on tbven.canal = canal_venda.nome
INNER JOIN status_venda on tbven.stven = status_venda.id
INNER JOIN vendedor on tbven.cdvdd = vendedor.id;



INSERT INTO item_venda (id, quantidade, vlr_unitario, vlr_total, produto_id, venda_id)
SELECT distinct cdvenitem, qtven, vruven, qtven*vruven, produto.id, venda.id
FROM first_db_ativ2.tbven_item as item
INNER JOIN produto ON item.cdpro = produto.id
INNER JOIN venda on item.cdven = venda.id;