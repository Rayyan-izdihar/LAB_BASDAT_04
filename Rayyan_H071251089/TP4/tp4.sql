-- SOAL 1
SELECT	customernumber AS nomor_pelanggan,
		SUM(amount) AS total_akumulasi_dana,
		COUNT(checknumber) AS jumlah_transaksi,
		MAX(amount) AS setoran_terbesar
FROM payments
GROUP BY customernumber
HAVING COUNT(checknumber) > 4 AND AVG(amount) > 20000;


-- SOAL 2
SELECT	customernumber AS nomor_pelanggan,
		SUM(amount) AS total_akumulasi_dana
FROM payments
GROUP BY customernumber
HAVING SUM(amount) > 80000
ORDER BY total_akumulasi_dana DESC;


-- SOAL 3
SELECT	productline AS kategori_produk,
		COUNT(productcode) AS jumlah_produk_per_kategori,
		ROUND(AVG(msrp), 2) AS rata_rata_harga_jual,
		STRING_AGG(productname, ', ' ORDER BY productname ASC) AS daftar_nama_produk
FROM products
GROUP BY productline
HAVING COUNT(productcode) > 10;


-- SOAL 4
SELECT	employeenumber AS nomor_staf,
		jobtitle AS jabatan
FROM employees
WHERE employeenumber IN (SELECT DISTINCT reportsto FROM employees)
	EXCEPT
SELECT	employeenumber AS nomor_staf,
		jobtitle AS jabatan
FROM employees
WHERE jobtitle ILIKE '%vp%' OR jobtitle ILIKE '%president%';


-- SOAL 5
SELECT	productcode AS kode_produk,
		SUM(quantityordered) AS total_unit_terjual,
		ROUND(AVG(priceeach), 2) AS rata_rata_harga_jual
FROM orderdetails
WHERE priceeach > 100
GROUP BY productcode
HAVING SUM(quantityordered) > 50
ORDER BY total_unit_terjual DESC;


-- SOAL 6
SELECT	productcode AS kode_produk,
		SUM(quantityordered) AS total_unit_dipesan,
		SUM(quantityordered * priceeach) AS pendapatan_kotor,
		ROUND(AVG(priceeach), 2) AS rata_rata_harga_jual,
		MAX(priceeach) - MIN(priceeach) AS rentang_volatilitas
FROM orderdetails
WHERE quantityordered > 20
GROUP BY productcode
HAVING SUM(quantityordered * priceeach) > 50000
ORDER BY pendapatan_kotor DESC;


-- SOAL 7
SELECT customernumber FROM customers
WHERE creditlimit > 80000
	INTERSECT
SELECT customernumber FROM orders
WHERE status IN ('Cancelled', 'On Hold')
	EXCEPT
SELECT customernumber FROM payments
GROUP BY customernumber
HAVING SUM(amount) > 100000;







