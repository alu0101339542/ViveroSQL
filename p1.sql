  /*
  *	uso
  *	sudo su postgres
  *	psql
  * 	\i p1.sql
  */

  /*Remove all tables in 'public' schema*/
	DROP SCHEMA public CASCADE;
	CREATE SCHEMA public;
 
  /*Drop tables if exist */
	DROP TABLE IF EXISTS employee;
	DROP TABLE IF EXISTS region;
	DROP TABLE IF EXISTS orders;
	DROP TABLE IF EXISTS product;
	DROP TABLE IF EXISTS nursery;
  
  /*Create table 'region' */



  	CREATE TABLE region(
		region_name VARCHAR(30),
		region_productivity INT NOT NULL,
		region_sales INT,
		PRIMARY KEY(region_name)
	);
  /*Create table 'employee' */
	CREATE TABLE employee(
		employee_name VARCHAR(255) NOT NULL,
		employee_region VARCHAR(30) NOT NULL,
		employee_date_region_beg DATE, /*date when the employee started working in the region*/		
		employee_date_region_end DATE, /*date when the employee started working in the region*/		
		employee_productivity INT NOT NULL,
		CHECK (employee_productivity BETWEEN 1 AND 10),
		CHECK (employee_date_region_beg < employee_date_region_end),
		PRIMARY KEY(employee_name),
		 CONSTRAINT fk_region
      			FOREIGN KEY(employee_region) 
	  			REFERENCES region(region_name)
		);
  /*Create table 'order' */
	CREATE TABLE orders(
                order_id INT GENERATED ALWAYS AS IDENTITY,
                /*client ###Como es compuesto este atributo no se pone*/
                client_name VARCHAR(30),
		salesman_name VARCHAR(30),
                client_fidelity INT, /*= SELECT COUNT(order_id)
                                        FROM order
                                        GROUP BY client_name,*/
                PRIMARY KEY(order_id),
		CONSTRAINT fk_employee
			FOREIGN KEY(salesman_name)
				REFERENCES employee(employee_name)
		);
  /*Create table 'product' */
	CREATE TABLE product(
		product_id INT GENERATED ALWAYS AS IDENTITY,
		produced_amount INT DEFAULT -2,
		product_region VARCHAR(30),
		stock INT, /*= SELECT COUNT(produced_amount)
					FROM product*/
					/*Quiero restar el produced amount 						menos el region sales de la 						tabla region */
		/*CHECK(produced_amount >= SELECT (region_sales)
						FROM region),*/
		PRIMARY KEY(product_id),
		CONSTRAINT fk_product
			FOREIGN KEY(product_region)
				REFERENCES region(region_name)
	);
  /*Create table 'nursery' */
	CREATE TABLE nursery(
		nursery_name VARCHAR(30),
		nursery_region VARCHAR(30),
		PRIMARY KEY(nursery_name),
		CONSTRAINT fk_nursery
			FOREIGN KEY(nursery_region)
				REFERENCES region(region_name)
	);
  /*Insert*/
  INSERT INTO region(region_name, region_productivity, region_sales)
  VALUES
	('Aguagarcia', 6, 20),
	('Las Mercedes',7, 21),
        ('Tacoronte',3, 10),
	('Puerto de La Cruz', 5, 18),
	('Tegueste', 9, 50);
  INSERT INTO employee(employee_name, employee_productivity,  employee_region, employee_date_region_beg, employee_date_region_end)
  VALUES
	('Lewandowski',8, 'Aguagarcia', '2022-08-24',null),
	('Busquets', 7, 'Las Mercedes', '2006-06-01', '2021-09-12'),
	('Pique', 3, 'Aguagarcia', '2007-12-03', '2022-03-30'),
	('Pedri', 8, 'Tacoronte', '2019-06-30',null),
	('Ter Stegen', 7, 'Las Mercedes', '2017-06-30', null);
  INSERT INTO orders(client_name, salesman_name, client_fidelity)
  VALUES 
	('Alonso', 'Lewandowski',3),
	('Nadal', 'Pique',4 ),
	('Contador', 'Pique',5 ),
	('Shakira', 'Pedri', 6),
	('Vini', 'Busquets', 7);
  INSERT INTO product(produced_amount, product_region, stock)
  VALUES
	(40, 'Aguagarcia', 20 ),
	(26, 'Las Mercedes', 15),
	(31, 'Tacoronte', 19),
	(42, 'Puerto de La Cruz', 23),
	(51, 'Tegueste', 33);
  INSERT INTO nursery(nursery_name, nursery_region)
  VALUES
	('Vivero1', 'Aguagarcia'),
	('Viviero2', 'Las Mercedes'),
	('Vivero3', 'Aguagarcia'),
	('Vivero4', 'Tacoronte'),
	('Vivero5', 'Las Mercedes');

