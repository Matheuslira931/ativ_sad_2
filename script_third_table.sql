
CREATE DATABASE third_db_atv2;

USE third_db_atv2;


CREATE TABLE dim_endereco (
	id   	smallint AUTO_INCREMENT PRIMARY KEY,
    pais    varchar(35) NULL,
    estado  varchar(35) NULL,
    cidade  varchar(35) NULL
);

CREATE TABLE dim_vendedor (
   id           smallint AUTO_INCREMENT PRIMARY KEY,
   nome         varchar(20),
   sexo      varchar(1),
   perccomissao decimal(19,2),
   matricula    smallint not null
);

CREATE TABLE dim_dependente (
   id          INT AUTO_INCREMENT PRIMARY KEY,
   nome        varchar(20),
   data_nascimento   date,
   sexo      varchar(1),
   inepescola  varchar(10),
   vendedor smallint,
   FOREIGN KEY (vendedor) REFERENCES dim_vendedor (id)
);

CREATE TABLE dim_produto(
    id 				  smallint AUTO_INCREMENT PRIMARY KEY,
    nome 			  varchar(30) NULL,
    tp_produto   varchar(1) NULL,
    unidade 		  varchar(2) NULL,
    saldo 			  int NULL,
    produto_status		  varchar(50) NULL
);

CREATE TABLE dim_cliente(
    id   		  smallint AUTO_INCREMENT PRIMARY KEY,
    nome   		  varchar(30) NULL,
    codigo_agencia smallint NULL,
    numero_classificacao smallint NULL,
    sexo        varchar(1),
    endereco   smallint,
    FOREIGN KEY (endereco) REFERENCES dim_endereco (id)
);

CREATE TABLE fato_venda (
    id SMALLINT AUTO_INCREMENT PRIMARY KEY,
    dtven DATE NULL,
    cliente SMALLINT NULL,
    canal varchar(12) NOT NULL,
    venda_status SMALLINT NULL,
    vendedor SMALLINT NULL,
    deletado varchar(3) NULL,
    FOREIGN KEY (cliente)
        REFERENCES dim_cliente (id),
    FOREIGN KEY (vendedor)
        REFERENCES dim_vendedor (id)
);

CREATE TABLE dim_item_venda(
    id           smallint AUTO_INCREMENT PRIMARY KEY,
    produto   smallint NULL,
    quantidade   int NULL,
    venda     smallint NULL,
    valor_unitario decimal(18, 2) NULL,
    valor_total    decimal(29, 2) NULL,
    FOREIGN KEY (produto) REFERENCES dim_produto (id),
    FOREIGN KEY (venda)   REFERENCES fato_venda (id)
);


