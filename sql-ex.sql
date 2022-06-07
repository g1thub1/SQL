The database schema consists of four tables:
Product(maker, model, type)
PC(code, model, speed, ram, hd, cd, price)
Laptop(code, model, speed, ram, hd, price, screen)
Printer(code, model, color, type, price)
The Product table represents the manufacturer (maker), model number (model) and type ('PC' - PC, 'Laptop' - notebook PC or 'Printer' - printer).
Model numbers in the Product table are assumed to be unique across all manufacturers and product types.
In the PC table for each PC, uniquely identified by a unique code - code, the model is indicated - model (foreign key to the Product table),
speed - speed (processor in megahertz), memory size - ram (in megabytes), disk size - hd (in gigabytes),
the reader speed is cd (eg '4x') and the price is price (in dollars).
The Laptop table is similar to the PC table, except that instead of the CD speed, it contains the screen size -screen (in inches).
In the Printer table, for each printer model, it is indicated whether it is color - color ('y', if color), printer type - type
(laser - 'Laser', jet - 'Jet' or matrix - 'Matrix') and price - price.

Task: 1
Find the model number, speed, and hard drive size for all PCs under $500. Output: model, speed and hd
SELECT model, speed, hd
FROM PC
WHERE price < 500

Task: 2
Find printer manufacturers. Output: maker
SELECT maker
FROM Product
WHERE type = 'Printer'
GROUP BY maker

Task: 3
Find the model number, memory capacity, and screen sizes of Notebook PCs priced over $1,000.
SELECT model, ram, screen
FROM Laptop
WHERE price > 1000

Task: 4
Find all entries in the Printer table for color printers.
SELECT*FROM printer
WHERE color = 'y'

Task: 5
Find the model number, speed, and hard drive size of PCs that have 12x or 24x CDs and cost less than $600.
SELECT model, speed, hd
FROM PC
WHERE cd = '24x' and price < 600 or cd = '12x' and price < 600

Task: 8
Find a manufacturer that makes PCs, but not PC notebooks.
SELECT maker
FROM product
where type IN('Laptop', 'PC')
EXCEPT
SELECT maker
FROM product
where type IN('Laptop')

Task: 9
Find PC manufacturers with at least 450 MHz processor. Display: Maker
SELECT DISTINCT maker
FROM Product
JOIN pc ON product.Model = pc.Model
WHERE pc.Speed >= 450 AND type = 'PC'

Task: 10
Find the highest priced printer models. Output: model, price
SELECT model, price
FROM printer
WHERE price IN (SELECT max(price) FROM printer)

Task: 11
Find the average PC speed.
SELECT sum(speed)/COUNT(speed) as avgSpeedPC
FROM PC

Task: 12
Find the average speed of notebook PCs that cost more than $1,000.
SELECT sum(speed)/COUNT(speed) as avgSpeedLaptop
FROM laptop
WHERE price > 1000

Task: 13
Find the average speed of PCs manufactured by manufacturer A.
SELECT sum(speed)/COUNT(speed) as avgSpeedPc
FROM PC
JOIN product ON pc.model = product.model
WHERE maker = 'A'

The database of ships that participated in the Second World War is considered. There are the following relationships:
Classes (class, type, COUNTry, numGuns, bore, displacement)
Ships (name, class, launched)
Battles (name, date)
Outcomes (ship, battle, result)
The ships in the "classes" are built according to the same project, and the class is assigned either the name of the first ship built according to this project,
or the class name is given the name of the project, which does not match any of the ships in the database. 
The ship that gave the class its name is called the lead ship.
The Classes relation contains the class name, type (bb for a battleship (battleship) or bc for a battlecruiser), country in which the ship was built, 
number of main guns, gun caliber (gun barrel diameter in inches), and displacement (weight in tons). The Ships relation contains the name of the ship, 
the name of its class, and the year it was launched. The Battles relation includes the name and date of the battle in which the ships participated, 
and the Outcomes relation includes the result of the participation of this ship in the battle (sunk, damaged - damaged or unharmed - OK).
Remarks. 1) The Outcomes relation can include ships that are not present in the Ships relation. 2) A sunken ship does not take part in subsequent battles.

Task: 14
Find the class, name, and country for ships in the Ships table that have at least 10 guns.
SELECT ships.class, name, COUNTry
FROM ships
JOIN classes ON ships.class = classes.class
WHERE numGuns >= 10

Task: 15
Find hard drive sizes that match two or more PCs. Display: HD
SELECT hd
FROM pc
GROUP BY HD
HAVING COUNT(hd) >= 2

Task: 16
Find pairs of PC models that have the same speed and RAM. As a result, each pair is specified only once, i.e. (i,j) but not (j,i), Output order: higher model, lower model, speed, and RAM.
SELECT DISTINCT
pc1.Model,
pc2 Model,
pc1 Speed,
pc1.Ram
FROM pc as pc1, pc as pc2
WHERE pc1.Speed ​​= pc2.Speed ​​and pc1.Ram = pc2.Ram and pc1.Model>pc2.Model

Task: 17
Find notebook PC models that are slower than the speed of each of the PCs.
Output: type, model, speed
SELECT DISTINCT
type,
product.model,
speed
FROM laptop
JOIN product ON laptop.model = product.model
WHERE speed < (SELECT MIN(speed) FROM PC)

Task: 18
Find manufacturers of the cheapest color printers. Output: maker, price
SELECT DISTINCT
maker,
price
FROM printer
JOIN product ON printer.model = product.model
WHERE color = 'y' AND price IN
(SELECT MIN(price)
FROM printer
WHERE color='y')

Task: 19
For each manufacturer that has models in the Laptop table, find the average screen size of their notebook PCs.
Output: maker, average screen size.
SELECT
maker,
(SUM(screen) / COUNT(maker)) AS avgScreen
FROM laptop
JOIN product ON laptop.model = product.model
GROUP BY maker

Task: 20
Find manufacturers that make at least three different PC models. Output: Maker, number of PC models.
SELECT
maker,
COUNT(Model) AS countModel
FROM Product
WHERE type = 'PC'
GROUP BY maker
HAVING COUNT(Model) >=3

Task: 21
Find the maximum price of PCs produced by each manufacturer that has models in the PC table.
Output: maker, maximum price.
SELECT
maker,
MAX(price) maxPrice
FROM Product
RIGHT JOIN PC on product.Model=pc.Model
GROUP BY maker

Task: 22
For each PC speed that exceeds 600 MHz, determine the average price of a PC with the same speed. Output: speed, average price.
SELECT
speed,
AVG(price) avgPrice
FROM PC
WHERE speed > 600
GROUP BY speed

Task: 23
Find manufacturers that produce like PCs
with a speed of at least 750 MHz, and PC notebooks with a speed of at least 750 MHz.
Display: Maker
SELECT
maker
FROM Product
JOIN PC ON product.Model = PC.Model
WHERE speed >= 750 and maker IN
(SELECT
maker
FROM Product
JOIN Laptop ON product.Model = Laptop.Model
WHERE speed >= 750)
GROUP BY maker

Task: 24
List the model numbers of any type that have the highest price of all the products in the database.
SELECT model
FROM
(SELECT model, price FROM PC
UNION
SELECT model, price FROM Laptop
UNION
SELECT model, price FROM Printer) newTable
WHERE price =(
SELECT MAX(price)
FROM
(SELECT model, price FROM PC
UNION
SELECT model, price FROM Laptop
UNION
SELECT model, price FROM Printer) newTable2
)

Task: 25
Find printer manufacturers that make PCs with the least amount of RAM and the fastest processor among all PCs with the least amount of RAM. Display: Maker
SELECT DISTINCT maker
FROM PC
JOIN product ON pc.model=product.model
WHERE maker IN
(SELECT DISTINCT maker
FROM Product
WHERE type='printer')
AND speed = (
SELECT MAX(speed)
FROM PC
WHERE ram = (
SELECT MIN(ram)
FROM PC))
AND ram = (
SELECT MIN(ram)
FROM PC)

Task: 26
Find the average price of PCs and PC notebooks produced by manufacturer A (Latin letter). Output: one total average price.
SELECT SUM(price)/SUM(models) AS avgPrice
FROM(
SELECT
COUNT(pc.Model) models,
SUM(price) price
FROM PC
JOIN product ON product.Model=PC.model
WHERE maker= 'A'
UNION
SELECT
COUNT(laptop.Model) models,
SUM(price) price
FROM laptop
JOIN product ON product.Model=laptop.model
WHERE maker= 'A'
) newTable

Task: 27
Find the average PC disk size for each manufacturer that also makes printers. Output: maker, medium size HD.
SELECT
maker,
AVG(hd) as avgHd
FROM PC
JOIN product ON product.model=PC.model
WHERE maker IN (
SELECT maker
FROM product
WHERE type='printer'
)GROUP BY maker

Task: 28
Using the Product table, determine the number of manufacturers producing one model.
SELECT
COUNT(maker) countMaker
FROM(
SELECT maker
FROM product
GROUP by maker
HAVING COUNT(maker)=1) newTable

The company has several recycling points. Each point receives money for their issuance to recyclers.
Information about receiving money at reception points is recorded in the table:
Income_o(point, date, inc)
The primary key is (point, date). In this case, only the date (without time) is written to the date column, i.e. acceptance of money (inc) at each point
done no more than once a day. Information about the issuance of money to the deliverers of recyclables is recorded in the table:
Outcome_o(point, date, out)
In this table, the primary key (point, date) also guarantees that each point is reported on the issued money (out) no more than once a day.
In the case when the income and expenditure of money can be recorded several times a day, another scheme is used with tables that have the primary key code:
Income(code, point, date, inc)
Outcome(code, point, date, out)
Here too, the date column values ​​do not contain the time.

Task: 29
Assuming that the receipt and expenditure of money at each reception point is recorded no more than once a day [i.e. primary key(item, date)],
write a request with output data (item, date, income, expense). Use tables Income_o and Outcome_o.
SELECT
Income_o.point,
Income_o.[date],
inc,
out
FROM Income_o
LEFT JOIN Outcome_o ON Outcome_o.point=Income_o.point
AND Outcome_o.[date]=Income_o.[date]
UNION
SELECT
Outcome_o.point,
Outcome_o.[date],
inc,
out
FROM Income_o
RIGHT JOIN Outcome_o ON Outcome_o.point=Income_o.point
AND Outcome_o.[date]=Income_o.[date]

Task: 30
Assuming that the receipt and expenditure of money at each receiving point is fixed an arbitrary number of times (the primary key in the tables is the code column), 
it is required to obtain a table in which each point for each date of operations will correspond to one row.
Output: point, date, total point consumption per day (out), total point income per day (inc). Missing values ​​are considered null (NULL).
SELECT point, [date], SUM(outs), SUM(incs)
FROM(
SELECT point, [date], SUM(out) outs, null incs
FROM outcome
GROUP BY point, [date]
UNION
SELECT point, [date], null, SUM(inc) FROM income
GROUP BY point, [date]
) newTable
GROUP BY point, [date]
© 2022 GitHub, Inc.
Terms
Privacy
Security
Status
Docs
Contact GitHub
Pricing
