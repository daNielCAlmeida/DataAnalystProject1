# See all tables together
SELECT *
FROM pcn.vendas v
LEFT JOIN pcn.venda_promocao vp ON vp.id_venda = v.id_vendas
LEFT JOIN pcn.produtos pr ON pr.id_produto = v.id_produto
LEFT JOIN pcn.pagamentos p ON p.id_venda = v.id_vendas
LEFT JOIN pcn.lojas l ON l.id_loja = v.id_loja
LEFT JOIN pcn.clientes c ON c.id = v.id_cliente;

# Most sold product per city
WITH vendas_por_cidade AS (
    SELECT
        l.cidade,
        pr.produto,
        COUNT(pr.produto) AS qtd
    FROM
        pcn.vendas v
    LEFT JOIN pcn.lojas l ON l.id_loja = v.id_loja
    LEFT JOIN pcn.produtos pr ON pr.id_produto = v.id_produto
    GROUP BY l.cidade, pr.produto # VENDAS POR CIDADE E PRODUTO
)
SELECT
    vpc.cidade,
    vpc.produto,
    vpc.qtd
FROM
    vendas_por_cidade vpc
JOIN (
    SELECT
        cidade,
        MAX(qtd) AS max_qtd
    FROM
        vendas_por_cidade
    GROUP BY cidade #VENDAS MAXIMAS POR CIDADE
) vpc_max ON vpc.cidade = vpc_max.cidade AND vpc.qtd = vpc_max.max_qtd;

# Most sold product per gender
WITH produtos_por_sexo AS (
	SELECT 
		c.sexo, 
		p.produto,
		COUNT(p.id_produto) as qtd
	FROM pcn.clientes c
    LEFT JOIN pcn.vendas v ON c.id = v.id_cliente 
    LEFT JOIN pcn.produtos p ON p.id_produto = v.id_produto
    GROUP BY 1, 2
) 
SELECT
	pps.sexo,
    pps.produto,
    pps.qtd
FROM
	produtos_por_sexo pps
JOIN (
	SELECT 
		pps.sexo,
        MAX(qtd) as max_qtd
	FROM produtos_por_sexo pps
    GROUP BY 1
) pps_max ON pps.sexo = pps_max.sexo AND pps.qtd = pps_max.max_qtd
WHERE produto IS NOT NULL;

# Count customers that make 2 or more purchases 
SELECT COUNT(*) FROM(
SELECT id_cliente, COUNT(id_cliente) 
FROM pcn.vendas 
GROUP BY 1
HAVING COUNT(id_cliente) > 1
ORDER BY 2 DESC) AS oiii;

# Count canceled payments
SELECT COUNT(*)
FROM pcn.vendas v
LEFT JOIN pcn.pagamentos p ON p.id_venda = v.id_vendas
WHERE p.id_pagamento IS NULL;

# Count most canceled products
SELECT 
	p.produto,
    COUNT(*) as qtd
FROM
	pcn.produtos p
LEFT JOIN pcn.vendas v ON v.id_produto = p.id_produto
LEFT JOIN pcn.pagamentos pg ON pg.id_venda = v.id_vendas
WHERE pg.id_pagamento IS NULL
GROUP BY 1
ORDER BY 2 DESC;

# Payment time
SELECT 
	id_pagamento,
	STR_TO_DATE(dt_venda, '%d/%m/%Y') as dt_vendas,
    STR_TO_DATE(dt_pgto, '%d/%m/%Y') as dt_pgto,
    datediff(str_to_date(dt_pgto, '%d/%m/%Y'),str_to_date(dt_venda, '%d/%m/%Y')) as tempo_pgto
FROM pcn.vendas v
INNER JOIN pcn.pagamentos pg ON pg.id_venda = v.id_vendas 
WHERE dt_venda IS NOT NULL;

# Average Payment Time
SELECT 
	ROUND(AVG(DATEDIFF(
		STR_TO_DATE(dt_pgto, '%d/%m/%Y'), STR_TO_DATE(dt_venda, '%d/%m/%Y'))),2) 
	AS media_tempo_gasto
FROM pcn.pagamentos pg
LEFT JOIN pcn.vendas v ON v.id_vendas = pg.id_venda;

# Average Value Canceled
SELECT 
    ROUND(AVG(p.valor),2) AS media_valor_cancelado
FROM pcn.vendas v
LEFT JOIN pcn.produtos p ON p.id_produto = v.id_produto
LEFT JOIN pcn.pagamentos pg ON pg.id_venda = v.id_vendas
LEFT JOIN pcn.venda_promocao vp ON vp.id_venda = v.id_vendas
WHERE pg.id_pagamento IS NULL;

# % discount
SELECT 
	COUNT(v.id_vendas) as qtd,
    vp.promocao,
    CONCAT(ROUND((COUNT(v.id_VENDAS) / (SELECT COUNT(*) FROM pcn.vendas) * 100), 2), '%') as percentage
FROM pcn.vendas v
LEFT JOIN pcn.venda_promocao vp ON vp.id_venda = v.id_vendas
GROUP BY 2;

# % Canceled Discount
SELECT 
	COUNT(v.id_vendas) as qtd,
    vp.promocao,
    CONCAT(ROUND((COUNT(v.id_VENDAS) / (SELECT COUNT(*) FROM pcn.vendas) * 100), 2), '%') as percentage
FROM pcn.vendas v
LEFT JOIN pcn.venda_promocao vp ON vp.id_venda = v.id_vendas
GROUP BY 2;



