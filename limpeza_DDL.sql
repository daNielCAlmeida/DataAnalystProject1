SET SQL_SAFE_UPDATES = 0;

# Rename Tables
RENAME TABLE pcn.caso_estudo_clientes TO pcn.clientes;
RENAME TABLE pcn.caso_estudo_lojas TO pcn.lojas;
RENAME TABLE pcn.caso_estudo_pagamentos TO pcn.pagamentos;
RENAME TABLE pcn.caso_estudo_produtos TO pcn.produtos;
RENAME TABLE pcn.caso_estudo_venda_promocao TO pcn.venda_promocao;
RENAME TABLE pcn.caso_estudo_vendas TO pcn.vendas;

# Alter columns name
ALTER TABLE pcn.venda_promocao RENAME COLUMN promoÃ§Ã£o TO promocao;
ALTER TABLE pcn.produtos RENAME COLUMN ï»¿id TO id_produto;
ALTER TABLE pcn.lojas RENAME COLUMN ï»¿id TO id_loja;
ALTER TABLE pcn.pagamentos RENAME COLUMN ï»¿id TO id_pagamento;
ALTER TABLE pcn.vendas RENAME COLUMN ï»¿id TO id_vendas;

# Rename incorrect fields
UPDATE pcn.produtos SET produto = 'laptop basico' WHERE id_produto = 3;
UPDATE pcn.lojas SET cidade = 'Sao Paulo' WHERE id_loja = 1;
UPDATE pcn.lojas SET cidade = 'Brasilia' WHERE id_loja = 8;
UPDATE pcn.lojas SET cidade = 'Vitoria' WHERE id_loja = 10;
UPDATE pcn.produtos SET produto = 'pc gamer' WHERE id_produto = 10;
UPDATE pcn.produtos SET valor = '3200' WHERE id_produto = 10;

# Select all tables
SELECT * FROM pcn.lojas;
SELECT * FROM pcn.produtos;
SELECT * FROM pcn.venda_promocao;
SELECT * FROM pcn.clientes;
SELECT * FROM pcn.pagamentos;
SELECT * FROM pcn.vendas;

# Tabelas com erro
DROP TABLE pcn.vendas;
DROP TABLE pcn.pagamentos;
DROP TABLE pcn.clientes;

