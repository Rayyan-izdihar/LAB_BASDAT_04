--Soal 1
SELECT 
	productCode, 
	productName, 
	msrp, 
	quantityInStock,
CASE
	WHEN msrp < 50 AND quantityInStock  > 500 THEN 'Ekonomis - Stok Tinggi'
	WHEN msrp < 50 AND quantityInStock <= 500 THEN 'Ekonomis - Stok Rendah'
	WHEN msrp BETWEEN 50 AND 100 THEN 'Harga Menengah'
	WHEN msrp > 100 THEN 'Harga Premium'
END AS kategori
FROM products
ORDER BY msrp DESC;


--Soal 2
SELECT
	productcode,
	SUM(quantityordered) AS total_unit_terjual,
	COUNT(DISTINCT ordernumber) AS jumlah_pemesanan
FROM orderdetails
GROUP BY productcode
HAVING  SUM(quantityordered) > (
			SELECT AVG(quantityordered)
			FROM orderdetails
		)
		AND COUNT(DISTINCT ordernumber) > 10
ORDER BY total_unit_terjual DESC;


--Soal 3
SELECT 
	productcode,
	productname, 
	quantityinstock,
	msrp 
FROM products
WHERE quantityinstock > (
		SELECT AVG (quantityinstock)
		FROM products
	) AND msrp > (
		SELECT AVG (msrp)
		FROM products
	)
ORDER BY quantityinstock DESC;


--Soal 4
BEGIN;


UPDATE orders
SET status = 'Pengiriman'
WHERE ordernumber = 10100;

SELECT * FROM orders
WHERE ordernumber = 10100;

SAVEPOINT status_pengiriman;


UPDATE orders
SET status = 'Batal'
WHERE ordernumber = 10100;

SELECT * FROM orders
WHERE ordernumber = 10100;


ROLLBACK TO SAVEPOINT status_pengiriman;

-- ROLLBACK;
-- COMMIT; /