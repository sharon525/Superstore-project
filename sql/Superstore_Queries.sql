-- Total sales and profit by region
select o.Region ,sum(od.Sales) as 'Total Sales',
sum(od.Profit) as 'Total Profit',
(sum(od.Profit)/ sum(od.Sales) * 100.0) as profit_margin
from order_details od join orders o 
on od.Order_ID = o.Order_ID
group by o.Region

-- Total sales and profit by country and state
select o.Country,o.State ,sum(od.Sales) as 'Total Sales', sum(od.Profit) as 'Total Profit',
(sum(od.Profit)/ sum(od.Sales) * 100.0) as profit_margin
from order_details od join orders o 
on od.Order_ID = o.Order_ID
group by o.Country,o.State
order by 'Total Profit' desc

-- Total sales and profit by category
select p.Category ,sum(od.Sales) as 'Total Sales', sum(od.Profit) as 'Total Profit',
(sum(od.Profit)/ sum(od.Sales) * 100.0) as profit_margin
from order_details od join products p 
on od.Product_ID = p.Product_ID
group by p.Category

-- Total sales and profit by segment
select  c.Segment ,sum(od.Sales) as 'Total Sales', sum(od.Profit) as 'Total Profit' ,
(sum(od.Profit)/ sum(od.Sales) * 100.0) as profit_margin
from order_details od join orders o
on od.Order_ID = o.Order_ID
join customers c 
on o.Customer_ID = c.Customer_ID
group by c.Segment

-- Yearly trend of sales and profit (excluding 2018 as it only contains data for January)
with yearly_change as (
select year(o.Ship_Date) as 'year',sum(od.Profit) as profits,
(sum(od.Profit)/ sum(od.Sales) * 100.0) as profit_margin
from orders o join order_details od
on o.Order_ID = od.Order_ID
group by year(o.Ship_Date)
having year(o.Ship_Date) !=2018
)
select [year],profits,round((profits - lag(profits)over(order by [year])) / 
lag(profits)over(order by [year]) * 100,2) as profits_change,profit_margin,
round((profit_margin - lag(profit_margin)over(order by [year])) / 
lag(profit_margin)over(order by [year]) * 100 ,2) as margin_change_from_last_year
from yearly_change


-- Monthly and yearly trend of sales and profit
select year(o.Ship_Date) as year_of_sale, month(o.Ship_Date) as month_of_sale,sum(od.Sales) as sales ,
sum(od.Profit) as profits,
(sum(od.Profit)/ sum(od.Sales) * 100.0) as profit_margin
from orders o join order_details od
on o.Order_ID = od.Order_ID
group by year(o.Ship_Date) , month(o.Ship_Date)
order by month_of_sale

-- Yearly trend of profit by region
select o.Region,year(o.Ship_Date) as 'year' ,sum(od.Profit) as Total_profit from orders o 
join order_details od
on o.Order_ID = od.Order_ID
where year(o.Ship_Date) != '2018'
group by o.Region, year(o.Ship_Date)
order by [year]

-- Top 10 products by total profit
select top 10 p.Product_ID,p.Product_Name,sum(od.Profit) as profit 
from products p join order_details od 
on p.Product_ID = od.Product_ID
group by p.Product_ID,p.Product_Name
order by profit desc


-- Average shipping time by shipping mode

with ship_mode_cte as (
select Ship_Mode,Region,State ,DATEDIFF(DAY,Order_Date,Ship_Date) as shiping_time from orders
)
select ship_mode , avg(shiping_time) as avarage_shiping from ship_mode_cte
group by ship_mode

-- Average shipping time by region
with region_cte as (
select Ship_Mode,Region,State ,DATEDIFF(DAY,Order_Date,Ship_Date) as shiping_time from orders
)
select Region , avg(shiping_time) shiping_time from region_cte
group by Region

-- Average shipping time by state
with statecte as (
select Ship_Mode,Region,State ,DATEDIFF(DAY,Order_Date,Ship_Date) as shiping_time from orders
)
select state , avg(shiping_time) as shiping_time from statecte
group by state

-- Average shipping time by region and shipping mode

with cte as (
select Ship_Mode,Region,State ,DATEDIFF(DAY,Order_Date,Ship_Date) as shiping_time from orders
)
select region,ship_mode , avg(shiping_time) as shiping from cte
group by region,ship_mode
order by ship_mode

----------
-- Total sales and profit by category and state
select o.State,p.Category,sum(od.Sales) as total_sales,sum(od.Profit) as total_profit,
sum(od.Profit)/sum(od.Sales) * 100 as profit_margin
from products p 
join order_details od
on p.Product_ID = od.Product_ID
join orders o 
on od.Order_ID = o.Order_ID
group by o.state,p.Category
order by o.State

----------
-- Total sales and profit grouped by sub-category
select p.Category, p.Sub_Category,sum(o.Sales) as total_sales,sum(o.Profit) as total_profit,
sum(o.Profit)/sum(o.Sales) * 100 as profit_margin
from products p 
join order_details o 
on p.Product_ID = o.Product_ID
group by p.Category,p.Sub_Category
order by Category

-- Identify top-performing and low-performing categories
select p.Category, sum(o.Sales) as total_sales,sum(o.Profit) as total_profit,
sum(o.Profit)/sum(o.Sales) * 100 as profit_margin
from products p 
join order_details o 
on p.Product_ID = o.Product_ID
group by p.Category


/*we can see that the furniture category profit is very low compared to others 
lets check if its overall or there are sub categories that cut our profit
*/

-- Analyze profit margins within the Furniture category by sub-category
select p.Category, p.Sub_Category,sum(o.Sales) as total_sales,sum(o.Profit) as total_profit,
sum(o.Profit)/sum(o.Sales) * 100 as profit_margin
from products p 
join order_details o 
on p.Product_ID = o.Product_ID
group by p.Category,p.Sub_Category
having Category = 'Furniture'

-- Are Tables unprofitable in every state?
select o.State,p.Category, p.Sub_Category,sum(od.Sales) as total_sales,sum(od.Profit) as total_profit,
sum(od.Profit)/sum(od.Sales) * 100 as profit_margin
from products p 
join order_details od
on p.Product_ID = od.Product_ID
join orders o 
on od.Order_ID = o.Order_ID
group by o.state,p.Category,p.Sub_Category
having category = 'Furniture'
and Sub_Category = 'tables'
order by profit_margin

-- Are Bookcases unprofitable in every state?
-- Same structure as previous query, but for Bookcases
select o.State,p.Category, p.Sub_Category,sum(od.Sales) as total_sales,sum(od.Profit) as total_profit,
sum(od.Profit)/sum(od.Sales) * 100 as profit_margin
from products p 
join order_details od
on p.Product_ID = od.Product_ID
join orders o 
on od.Order_ID = o.Order_ID
group by o.state,p.Category,p.Sub_Category
having category = 'Furniture'
and Sub_Category = 'bookcases'
order by profit_margin


-- Profit analysis without Tables and Bookcases
select p.Category , sum(od.Sales) as sales, sum(od.Profit) as profit ,
sum(od.Profit)/sum(od.Sales) * 100 as profit_margin 
from products p join order_details od
on p.Product_ID = od.Product_ID
where p.Sub_Category != 'tables'
and p.Sub_Category !='bookcases'
group by  p.Category

-- removing the tables and bookcases makes the furniture category profit and margin significantly higher
--althogh its still low compared to other categories

-- Identify unprofitable states
select o.State,count(o.Order_ID) as number_of_orders ,sum(od.Sales) as average_sales 
,sum(od.Profit) as average_profit 
from orders o join order_details od
on o.Order_ID = od.Order_ID
group by o.State
order by average_profit

-- Average profit per order by region

select o.Region,count(o.Order_ID) as number_of_orders ,avg(od.Sales) as average_sales 
,avg(od.Profit) as average_profit from orders o 
join order_details od 
on o.Order_ID = od.Order_ID
group by o.Region
order by number_of_orders


-- Rank regions within each segment by profit margin
select o.Region,c.Segment ,sum(od.Sales) as sales ,sum(od.Profit) as profit,
sum(od.Profit)/sum(od.Sales)*100 as profit_margin,
RANK()over(partition by segment order by sum(od.Profit)/sum(od.Sales)*100 desc )as 'Rank'
from customers c join orders o
on c.Customer_ID = o.Customer_ID
join order_details od
on o.Order_ID = od.Order_ID
group by c.Segment ,o.Region
order by segment

/*
- We can see that the Consumer segment in the Central region
  is more than three times less profitable than the most profitable region for that segment.

- Additionally, the Home Office segment in the South region
  shows significantly lower profitability compared to other regions in the same segment.

- From our previous queries, we saw that the 'Tables' sub-category is consistently unprofitable.

  Does this mean we should remove it entirely from the catalog?
  Not necessarily — further analysis is needed to understand:
    Whether the losses are consistent across all regions and segments
    If there are specific products that are profitable within this sub-category
    Whether sales trends show improvement or decline over time

*/

-- Yearly trend of Table orders

select count(p.Product_ID) Tables_sold , month(o.Order_Date)as 'month',year(o.Order_Date)as 'year'
from products p join order_details od
on p.Product_ID = od.Product_ID
join orders o
on od.Order_ID = o.Order_ID
where p.Sub_Category = 'tables'
group by year(o.Order_Date),month(o.Order_Date)
order by 'year','month'


-- Are Tables unprofitable across all market segments?

SELECT c.Segment,COUNT(DISTINCT o.[Order_ID]) AS NumOrdersWithTables,
SUM(od.Sales) AS TotalSales,SUM(od.Profit) AS TotalProfit
FROM order_details od
JOIN products p ON od.[Product_ID] = p.[Product_ID]
JOIN orders o ON od.[Order_ID] = o.[Order_ID]
JOIN customers c ON o.[Customer_ID] = c.[Customer_ID]
WHERE p.Sub_Category = 'Tables'
GROUP BY c.Segment;

-- Are Tables unprofitable in every state?
select o.State, sum(od.Profit) as profit from order_details od
join products p
on od.Product_ID = p.Product_ID
join orders o 
on od.Order_ID = o.Order_ID
where p.Sub_Category ='tables'
group by o.State
order by profit

-- Which Table products are profitable?
select p.Product_Name,count(p.Product_ID) as times_sold ,sum(od.Profit)as total_profit 
from products p join order_details od
on p.Product_ID = od.Product_ID
where p.Sub_Category = 'tables'
group by p.Product_Name
order by total_profit

-- from 56 tables in catalog only 14 are profitable