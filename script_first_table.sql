-- Criando o banco de dados (DDL)
-- Mudar o SeuNome
CREATE DATABASE first_db_ativ2;

-- Setar o BD para uso
USE first_db_ativ2;

-- ------------------------------------
-- Sugestão: Rodar trecho por trecho --
-- ------------------------------------

-- Criando a tabela de Vendedor (DDL)
---------------------------------------
CREATE TABLE tbvdd (
   cdvdd        smallint not null,
   nmvdd        varchar(20),
   sxvdd        smallint, -- 1 - M | 0 - F
   perccomissao decimal(19,2),
   matfunc      smallint not null,
   PRIMARY KEY (cdvdd)
);

-- Inserindo tbvdd (DML)
INSERT INTO tbvdd VALUES (1 , 'Vendedor 1'    , 1, 1  , 1 );
INSERT INTO tbvdd VALUES (2 , 'Vendedor 2    ', 1, 1  , 2 );
INSERT INTO tbvdd VALUES (3 , ' Vendedor 3'   , 1, 1  , 3 );
INSERT INTO tbvdd VALUES (4 , 'Vendedor 4    ', 1, 0.5, 4 );
INSERT INTO tbvdd VALUES (5 , ' Vendedor 5'   , 0, 0.5, 5 );
INSERT INTO tbvdd VALUES (6 , 'Vendedor 6'    , 1, 0.5, 6 );
INSERT INTO tbvdd VALUES (7 , 'Vendedor 7'    , 0, 0.5, 7 );
INSERT INTO tbvdd VALUES (8 , 'Vendedor 8'    , 1, 0.5, 8 );
INSERT INTO tbvdd VALUES (9 , 'Vendedor 9'    , 0, 0.5, 9 );
INSERT INTO tbvdd VALUES (10, 'Vendedor 10'   , 1, 0.5, 10);
INSERT INTO tbvdd VALUES (11, null, 0, 0.5, 11);

-- Consultando dados (DQL)
SELECT * FROM tbvdd;

---------------------------------------
-- Criação da Tabela Dependente (DDL)
CREATE TABLE tbdep (
   cddep      INT AUTO_INCREMENT PRIMARY KEY,
   nmdep      varchar(20),
   dtnasc     date,
   sxdep      varchar(2),
   cdvdd      smallint,
   inepescola varchar(10),
   FOREIGN KEY (cdvdd) REFERENCES tbvdd (cdvdd)
);

-- Populando tbdep (DML)
INSERT INTO tbdep (nmdep, dtnasc, sxdep, cdvdd, inepescola) 
       VALUES ('Dependente 1' , '2010-02-02', 'M' , 1, '11001887');

INSERT INTO tbdep (nmdep, dtnasc, sxdep, cdvdd, inepescola) 
       VALUES ('Dependente 2' , '2012-04-05', 'M' , 3, '11001364'),
              ('Dependente 3' , '2013-03-04', ' F', 3, '11001364'),
              ('Dependente 4' , '2010-05-05', 'F' , 2, '11001666');

-- new insert
INSERT INTO tbdep (nmdep, dtnasc, sxdep, cdvdd, inepescola) 
       VALUES ('Dependente 4' , '2010-05-05', 'F' , 2, '11001666');

-- Consultando (DQL)
SELECT * FROM tbdep;

---------------------------------------
-- Criação da Tabela de Produto (DDL)

CREATE TABLE tbpro(
    cdpro smallint AUTO_INCREMENT PRIMARY KEY, -- autoincremento - serial
    nmpro varchar(50) NULL,
    tppro varchar(1) NULL,
    undpro varchar(2) NULL,
    slpro int NULL,
    stpro varchar(50) NULL
);

-- Populando tbpro (DML)
INSERT INTO tbpro (nmpro, tppro, undpro, slpro, stpro) VALUES ('Produto A'  , 'A', 'KG' , 20000, 'Ativo');
INSERT INTO tbpro (nmpro, tppro, undpro, slpro, stpro) VALUES ('Produto C'  , 'A', 'KG' , 5000 , 'Ativo');
INSERT INTO tbpro (nmpro, tppro, undpro, slpro, stpro) VALUES ('Produto E'  , 'B', 'KG' , 2000 , 'Ativo');
INSERT INTO tbpro (nmpro, tppro, undpro, slpro, stpro) VALUES ('Produto CH' , 'A', 'KG' , 2000 , 'Ativo');
INSERT INTO tbpro (nmpro, tppro, undpro, slpro, stpro) VALUES ('Produto AB' , 'A', 'KG' , 100  , 'Inativo');
INSERT INTO tbpro (nmpro, tppro, undpro, slpro, stpro) VALUES ('Produto EH' , 'A', 'KG' , 2000 , 'Ativo');
INSERT INTO tbpro (nmpro, tppro, undpro, slpro, stpro) VALUES ('Produto FA' , 'C', 'KG' , 1000 , 'Ativo');
INSERT INTO tbpro (nmpro, tppro, undpro, slpro, stpro) VALUES ('Produto TO' , null, 'KG' , null , 'Ativo');

-- Consultando (DML)
SELECT * FROM tbpro;

---------------------------------------
-- Criação da Tabela de Venda (DDL)

CREATE TABLE tbven(
    cdven   smallint primary key,
    dtven   date NULL,
    cdcli   smallint NULL,
    nmcli   varchar(50) NULL,
    agecli  smallint NULL,
    clacli  smallint NULL,
    sxcli   varchar(1) NULL,
    cidcli  varchar(50) NULL,
    estcli  varchar(50) NULL,
    paicli  varchar(50) NULL,
    canal   varchar(12) NOT NULL,
    stven   smallint NULL, -- 1 concluída, 2 em aberto e 3 é cancelada
    deleted smallint NULL,
    cdvdd   smallint NULL,
    FOREIGN KEY (cdvdd) REFERENCES tbvdd (cdvdd)
);

-- populando tbven (DML)
INSERT INTO tbven VALUES (1, '2010-02-01', 1, 'Cliente AA', 30, 3, 'M', 'Florianópolis', 'Santa Catarina', 'Brasil', 'Loja Própria', 1, 0, 1);
INSERT INTO tbven VALUES (2, '2022-07-08', 2, 'Cliente GRM', 57, 1, 'M', 'Gramado', 'Rio Grande do Sul', 'Brasil', 'Loja Virtual', 1, 0, 2);
INSERT INTO tbven VALUES (3, '2022-07-08', 3, 'Cliente ARM', 50, 1, 'F', 'Fortaleza', 'Ceará', 'Brasil', 'Loja Virtual', 1, 0, 4);
INSERT INTO tbven VALUES (4, '2022-07-08', 4, 'Cliente GRM', 57, 2, 'M', 'Canela', 'Rio Grande do Sul', 'Brasil', 'Loja Virtual', 1, 0, 2);
INSERT INTO tbven VALUES (5, '2019-07-08', 5, 'Cliente CRM', 22, 1, 'F', 'São Paulo', 'São Paulo', 'Brasil', 'Loja Virtual', 1, 0, 3);
INSERT INTO tbven VALUES (6, '2018-04-08', 6, 'Cliente ACM', 30, 4, 'F', 'São Paulo', 'São Paulo', 'Brasil', 'Loja Virtual', 1, 0, 4);
INSERT INTO tbven VALUES (7, '2020-05-08', 7, 'Cliente ABM', 41, 2, 'F', 'Rio de Janeiro', 'Rio de Janeiro', 'Brasil', 'Loja Virtual', 1, 0, 3);
INSERT INTO tbven VALUES (8, '2011-06-08', 8, 'Cliente AAM', 19, 1, 'F', 'Eusébio', 'Ceará', 'Brasil', 'Loja Própria', 3, 0, 8);
INSERT INTO tbven VALUES (9, '2012-07-04', 9, 'Cliente AAA', 28, 5, 'F', 'Salvador', 'Bahia', 'Brasil', 'Loja Virtual', 2, 0, 5);
INSERT INTO tbven VALUES (10, '2013-03-03', 9, 'Cliente AAA', 28, 5, 'F', 'Salvador', 'Bahia', 'Brasil', 'Loja Virtual', 1, 0, 6);
INSERT INTO tbven VALUES (11, '2016-07-01', 10, 'Cliente AAAD', 28, 2, 'F', 'Vitória', 'Espirito Santo', 'Brasil', 'Loja Virtual', 2, 0, 5);
INSERT INTO tbven VALUES (12, '2016-05-03', 11, 'Cliente AAAE', 29, 3, 'F', 'Natal', 'Rio Grande do Norte', 'Brasil', 'Loja Virtual', 1, 0, 6);
INSERT INTO tbven VALUES (13, '2015-07-01', 12, 'Cliente AAAF', 30, 1, 'F', 'Natal', 'Rio Grande do Norte', 'Brasil', 'Loja Virtual', 1, 0, 5);
INSERT INTO tbven VALUES (14, '2015-06-02', 13, 'Cliente AAAG', 31, 4, 'M', 'São Luis', 'Maranhão', 'Brasil', 'Loja Virtual', 1, 0, 6);
INSERT INTO tbven VALUES (15, '2017-07-04', 14, 'Cliente AAAH', 32, 4, 'F', 'Florianópolis', 'Santa Catarina', 'Brasil', 'Loja Virtual', 1, 0, 5);
INSERT INTO tbven VALUES (16, '2017-05-03', 15, 'Cliente AAAI', 33, 5, 'F', 'Aracaju', 'Sergipe', 'Brasil', 'Loja Virtual', 1, 0, 6);
INSERT INTO tbven VALUES (17, '2023-01-08', 16, 'Cliente WAAM', 19, 1, 'M', 'Eusébio', 'Ceará', 'Brasil', 'Loja Própria', 1, 0, 8);
INSERT INTO tbven VALUES (18, '2023-02-08', 16, 'Cliente WAAM', 19, 1, 'M', 'Eusébio', 'Ceará', 'Brasil', 'Loja Própria', 1, 0, 8);
INSERT INTO tbven VALUES (19, '2023-03-08', 16, 'Cliente WAAM', 19, 1, 'M', 'Eusébio', 'Ceará', 'Brasil', 'Loja Própria', 1, 0, 8);
INSERT INTO tbven VALUES (20, '2023-04-06', 7, 'Cliente ABM', 41, 2, 'F', 'Rio de Janeiro', 'Rio de Janeiro', 'Brasil', 'Loja Virtual', 1, 1, 3);

---------------------------------------
-- Criação da Tabela de Item de Venda (DDL)
CREATE TABLE tbven_item(
    cdvenitem   smallint primary key,
    cdpro       smallint NULL,
    qtven       int NULL,
    vruven      decimal(18, 2) NULL,
    vrtven      decimal(29, 2) NULL,
    cdven       smallint NULL,
    FOREIGN KEY (cdpro) REFERENCES tbpro (cdpro),
    FOREIGN KEY (cdven) REFERENCES tbven (cdven)
);

-- Populando tbven_item (DML)
INSERT INTO tbven_item VALUES (1, 1, 4000, 0.34, 0, 1),
                               (2, 1, 6000, 0.34, 0, 1),
                               (3, 1, 4500, 0.34, 0, 2),
                               (4, 1, 5000, 0.34, 0, 3),
                               (5, 2, 300, 1.50, 0, 4),
                               (6, 3, 4000, 0.50, 0, 4),
                               (8, 1, 4000, 0.34, 0, 5),
                               (9, 1, 6000, 0.34, 0, 6),
                               (10, 1, 4500, 0.34, 0, 7),
                               (11, 1, 5000, 0.34, 0, 7),
                               (12, 2, 300, 1.50, 0, 8),
                               (13, 3, 4000, 0.50, 0, 8),
                               (14, 1, 4000, 0.34, 0, 9),
                               (15, 1, 6000, 0.34, 0, 9),
                               (16, 1, 4500, 0.34, 0, 9),
                               (17, 1, 5000, 0.34, 0, 10),
                               (18, 2, 300, 1.50, 0, 10),
                               (19, 3, 4000, 0.50, 0, 11),
                               (20, 7, 4000, 0.34, 0, 12),
                               (21, 7, 6000, 0.34, 0, 13),
                               (22, 7, 4500, 0.34, 0, 14),
                               (23, 1, 5000, 0.34, 0, 14),
                               (24, 8, 300, 1.50, 0, 15),
                               (25, 8, 4000, 0.50, 0, 15),
                               (26, 1, 4000, 0.34, 0, 16),
                               (27, 7, 6000, 0.34, 0, 17),
                               (28, 7, 4500, 0.34, 0, 18),
                               (29, 1, 5000, 0.34, 0, 18),
                               (30, 2, 300, 1.50, 0, 19),
                               (31, 6, 4000, 0.50, 0, 20),
                               (32, 1, 4000, 0.34, 0, 5),
                               (33, 1, 6000, 0.34, 0, 6),
                               (34, 1, 4500, 0.34, 0, 7),
                               (35, 1, 5000, 0.34, 0, 7),
                               (36, 2, 300, 1.50, 0, 8),
                               (37, 3, 4000, 0.50, 0, 8),
                               (38, 1, 4000, 0.34, 0, 9),
                               (39, 1, 6000, 0.34, 0, 9),
                               (40, 1, 4500, 0.34, 0, 9),
                               (41, 1, 5000, 0.34, 0, 10),
                               (42, 2, 300, 1.50, 0, 10),
                               (43, 3, 4000, 0.50, 0, 11),
                               (44, 7, 4000, 0.34, 0, 12),
                               (45, 7, 6000, 0.34, 0, 13),
                               (46, 7, 4500, 0.34, 0, 14),
                               (47, 1, 5000, 0.34, 0, 14),
                               (48, 8, 300, 1.50, 0, 15),
                               (49, 8, 4000, 0.50, 0, 15),
                               (50, 1, 4000, 0.34, 0, 16),
                               (51, 7, 6000, 0.34, 0, 17),
                               (52, 7, 4500, 0.34, 0, 18),
                               (53, 1, 5000, 0.34, 0, 18),
                               (54, 2, 300, 1.50, 0, 19),
                               (55, 6, 4000, 0.50, 0, 20);
                               
SELECT * FROM tbven_item;
