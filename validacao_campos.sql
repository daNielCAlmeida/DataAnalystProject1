# Validating Table "contagem"
SELECT DISTINCT COUNT(*) AS contagem
FROM pcn.venda_promocao;

# Validating Table "clientes"
SELECT 
	MAX(STR_TO_DATE(dt_nasc, '%d/%m/%Y')) as MAXIMO,
    MIN(STR_TO_DATE(dt_nasc, '%d/%m/%Y')) as MINIMO
FROM
	pcn.clientes;
    
SELECT sexo, COUNT(*)
FROM pcn.clientes
GROUP BY 1; # Existem que não definiram seu sexo.

SELECT DISTINCT COUNT(id)
FROM pcn.clientes;

# Validating Table "pagamentos"
    SELECT 
	MAX(STR_TO_DATE(dt_pgto, '%d/%m/%Y')) as MAXIMO,
    MIN(STR_TO_DATE(dt_pgto, '%d/%m/%Y')) as MINIMO
FROM
	pcn.pagamentos;
    
# Validating Table "vendas"
SELECT
	id_vendas
FROM
	pcn.vendas
WHERE 
	id_cliente > 1000 AND
    id_loja > 10 AND
    id_produto > 10;

SELECT 
	MAX(STR_TO_DATE(dt_venda, '%d/%m/%Y')) as MAXIMO,
    MIN(STR_TO_DATE(dt_venda, '%d/%m/%Y')) as MINIMO
FROM 
	pcn.vendas;

