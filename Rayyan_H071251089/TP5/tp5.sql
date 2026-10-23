-- SOAL 1
SELECT	c.contactfirstname,
		c.customername,
		o.city,
		CONCAT(e.firstname, ' ', e.lastname) AS sales_rep_name
FROM customers c
JOIN employees e ON e.employeenumber = c.salesrepemployeenumber
JOIN offices o ON o.officecode = e.officecode
WHERE	c.contactfirstname ILIKE 'a%' AND
		NOT o.city = 'NYC'
ORDER BY c.customername;



-- SOAL 2
SELECT	c.customername,
		SUM(p.amount) AS total_payment,
		MAX(p.amount) AS max_single_payment
FROM customers c
JOIN payments p ON p.customernumber = c.customernumber
GROUP BY c.customername, c.customernumber
HAVING SUM(p.amount) > 50000
ORDER BY total_payment DESC;



-- SOAL 3
SELECT	c.customername,
		COUNT(DISTINCT o.ordernumber) AS total_order,
		ROUND(AVG(od.quantityordered), 2) AS avg_quantity_per_order
FROM customers c
JOIN orders o ON o.customernumber = c.customernumber
JOIN orderdetails od ON od.ordernumber = o.ordernumber
GROUP BY c.customername, c.customernumber
HAVING 	COUNT(DISTINCT o.ordernumber) > 3 AND
		AVG(od.quantityordered) > 35
ORDER BY total_order DESC, avg_quantity_per_order DESC;



-- SOAL 4
SELECT	p.productline,
		SUM(od.quantityordered) AS total_terjual,
		ROUND(AVG(od.priceeach), 2) AS rata_rata_harga,
		ROUND(AVG((1 - od.priceeach / p.msrp) * 100), 2) AS avg_discount_percentage
FROM products p
JOIN orderdetails od ON od.productcode = p.productcode
GROUP BY p.productline
HAVING	SUM(od.quantityordered) > 3000 AND
		AVG(od.priceeach) > 80
ORDER BY total_terjual DESC;



-- SOAL 5
SELECT	c.customername,
		SUM(od.quantityordered * od.priceeach) AS total_transaksi,
		COUNT(DISTINCT o.ordernumber) FILTER (WHERE o.status = 'Shipped') AS total_shipped_orders,
		ROUND(SUM(od.quantityordered * od.priceeach) / COUNT(DISTINCT o.ordernumber), 2) AS avg_transaction_per_order
FROM customers c
JOIN orders o ON o.customernumber = c.customernumber
JOIN orderdetails od ON od.ordernumber = o.ordernumber
GROUP BY c.customername, c.customernumber
HAVING COUNT(DISTINCT EXTRACT(YEAR FROM o.orderdate)) > 1
ORDER BY total_transaksi DESC
LIMIT 5;



-- SOAL 6
SELECT	c.customername,
		c.city AS customer_city,
		ofc.city AS office_city,
		SUM(od.quantityordered) AS total_unit_terjual,
		ROUND(SUM(od.quantityordered * od.priceeach) / COUNT(DISTINCT o.ordernumber), 2) AS avg_nilai_per_order
FROM customers c
JOIN 
	employees e ON e.employeenumber = c.salesrepemployeenumber
JOIN 
	offices ofc ON ofc.officecode = e.officecode
JOIN 
	orders o ON o.customernumber = c.customernumber
JOIN 
	orderdetails od ON od.ordernumber = o.ordernumber
WHERE ofc.territory = 'EMEA'
GROUP BY c.customername, c.city, ofc.city
HAVING 	COUNT(DISTINCT EXTRACT(YEAR FROM o.orderdate)) > 2 AND
		SUM(od.quantityordered) > 1000 AND 
		SUM(od.quantityordered * od.priceeach) / COUNT(DISTINCT o.ordernumber) > 10000
ORDER BY avg_nilai_per_order DESC;




SELECT	*
FROM customers c
JOIN 
	orders o ON o.customernumber = c.customernumber
JOIN 
	orderdetails od ON od.ordernumber = o.ordernumber
ORDER BY c.customernumber, o.ordernumber;

