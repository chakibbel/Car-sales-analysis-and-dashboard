/**** Car sales KPI analysis ****/
use car_sales
go 

/*** Sales Overview ***/

-- Year-to-Date (YTD) Total Sales
select concat(round(sum(Price)/1000000, 1), ' M') as [YTD Total Sales ($)]
from CarSales 
where Year(Date) = 2023 

-- Month-to-Date (MTD) Total Sales
select concat(round(sum(Price)/1000000, 1), ' M') as [MTD Total Sales ($)]
from CarSales 
where [Date] >= '2023-12-01';

-- Year-over-Year (YOY) Growth in Total Sales
select round(((sum(Price) - (select sum(Price) from CarSales where Year(Date) = 2022)) / (select sum(Price) from CarSales where Year(Date) = 2022)),4)*100 as [YOY Total Sales (%)]
from CarSales
where Year(Date) = 2023

-- Difference between YTD Sales and Previous Year-to-Date (PTYD) Sales
select CONCAT(round((SUM(Price) - (select SUM(Price) from CarSales Where YEAR(Date) = 2022))/1000000,2),' M$') as [Diff Tot Sales]
from CarSales
where YEAR(Date) = 2023

/*** Average Price Analysis ***/
-- YTD Average Price   
select concat(round(avg(Price)/1000, 1), ' K') as [YTD Average Price ($)]
from CarSales 
where Year(Date) = 2023 

--MTD Average Price
select concat(round(avg(Price)/1000, 2), ' K') as [MTD Average Sales ($)]
from CarSales 
where [Date] >= '2023-12-01';

-- YOY Growth in Average Price
select round(((avg(Price) - (select avg(Price) from CarSales where Year(Date) = 2022)) / (select avg(Price) from CarSales where Year(Date) = 2022)),4)*100 as [YOY Average Sales (%)]
from CarSales
where Year(Date) = 2023

-- Difference between YTD Average Price and PYTD Average Price
select CONCAT(round((avg(Price) - (select avg(Price) from CarSales Where YEAR(Date) = 2022))/1000,2),' K$') as [Diff Average Sales]
from CarSales
where YEAR(Date) = 2023

/*** Cars Sold Metrics ***/

-- YTD Cars Sold
select count(Car_id) as [YTD Total Cars Sold]
from CarSales 
where Year(Date) = 2023

-- MTD Cars Sold
select count(Car_id) as [MTD Total Cars Sold]
from CarSales
where [Date] >= '2023-12-01';

-- YOY Growth in Cars Sold
SELECT
	ROUND ((
	(CAST(COUNT(Car_id) as decimal(10,2)) - (SELECT CAST(COUNT(Car_id) as decimal(10,2)) from CarSales where Year(Date) = 2022))/
	(SELECT CAST(COUNT(Car_id) as decimal(10,2)) from CarSales where Year(Date) = 2022)), 4) * 100
	AS [YOY Cars Sold Growth (%)]
FROM CarSales
where Year(Date) = 2023

-- Difference between YTD Cars Sold and PTYD Cars Sold
select count(Car_id) - (select COUNT(Car_id) from CarSales where Year(Date) = 2022) as [YTD Diff PTYD cars sold]
from CarSales 
where Year(Date) = 2023