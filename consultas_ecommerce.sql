-- Total de pedidos
SELECT COUNT(*) AS 'Total de pedidos' FROM orders;

-- Todos os campos e registros de pedidos
SELECT * FROM orders;

-- Todos os campos de clientes e pedidos
SELECT * FROM clients AS c, orders as O WHERE c.idClient = o.idOrderClient;

-- Campos primeiro e último nomes concatenados, CPF, pedido e status do pedido
SELECT CONCAT(clientFname, " ", clientLastName) AS 'Nome completo', clientCPF AS 'CPF', idOrder AS 'Pedido', orderStatus AS 'Statuso pedido' 
FROM clients AS c, orders as O 
WHERE c.idClient = o.idOrderClient;

-- Campos primeiro e último nomes concatenados, CPF, pedido e status do pedido ordenados pelo nome
SELECT CONCAT(clientFname, " ", clientLastName) AS 'Nome completo', clientCPF AS 'CPF', idOrder AS 'Pedido', orderStatus AS 'Statuso pedido' 
FROM clients AS c, orders as O 
WHERE c.idClient = o.idOrderClient
ORDER BY c.clientFname;

-- Campos primeiro e último nomes concatenados, CPF e total de pedidos de cada cliente ordenados pelo nome
SELECT 
    c.idClient AS ClientID,
    c.clientFname || ' ' || c.clientLastName AS ClientName,
    c.clientCPF AS ClientCPF,
    COUNT(o.idOrder) AS TotalOrders
FROM 
    clients c
LEFT JOIN 
    orders o
ON 
    c.idClient = o.idOrderClient
GROUP BY 
    c.idClient, c.clientFname, c.clientLastName, c.clientCPF
ORDER BY 
    c.idClient;
	
-- Ordem com produtos que tenham " de " em seu nome
SELECT idOrder AS 'Ordem', productName AS 'Produto' FROM orders AS o, products
GROUP BY productCategory
HAVING productName LIKE '% de %';

SELECT * FROM storageProduct;

-- Locais de estoque dos produtos
SELECT
    sl.locationStorage AS 'Local de estoque',
    sl.locationAddress AS 'Endereço do estoque',
	p.idProduct AS 'Produto',
	sp.storageQuantity AS 'Quantidade em estoque'
FROM
    products AS p
LEFT JOIN 
    storageProduct AS sp
    ON p.idProduct = sp.idProductStorage
LEFT JOIN 
    storageLocation AS sl
    ON sp.idPlaceStorage = sl.idStoragePlace
GROUP BY
    p.idProduct,
    sl.locationStorage,
    sl.locationAddress
ORDER BY
	sl.locationStorage,
	p.idProduct;