preview the dataset
SELECT *  FROM `sql_portfolio.sales` 

data cleaning 
checking for nulls in all the columns
select Sale_ID from `first-sql-project-358520.sql_portfolio.sales` where Sale_ID is null
select Date from `first-sql-project-358520.sql_portfolio.sales` where Date is NULL
select Store_ID from `first-sql-project-358520.sql_portfolio.sales` where Store_ID is NULL
select Product_ID from `first-sql-project-358520.sql_portfolio.sales` where Product_ID is NULL
select Units from `first-sql-project-358520.sql_portfolio.sales` where Units is NULL
select Product_price from `first-sql-project-358520.sql_portfolio.sales` where Product_price is NULL
select Product_cost from `first-sql-project-358520.sql_portfolio.sales` where Product_cost is NULL


analyzing the data
basic counts

total units sold
select sum(Units) as Total_units_sold
from `first-sql-project-358520.sql_portfolio.sales`

cost of goods sold
select sum(round(Product_price, 0)) as Cost_of_goods_sold
from `first-sql-project-358520.sql_portfolio.sales`

total profit generated
select sum(Product_price - product_cost) as Total_profit
from `first-sql-project-358520.sql_portfolio.sales`

average transaction value
select avg(round (Product_price, 0)) as ATV
from `first-sql-project-358520.sql_portfolio.sales`

total revenue generated
select sum (Units * Product_price) as Revenue
from `first-sql-project-358520.sql_portfolio.sales`


gross profit margin
select (sum(Revenue) - sum(Product_cost)) / sum(Revenue) * 100 as Gross_profit_margin
from `first-sql-project-358520.sql_portfolio.sales`

exploratory analysis 
product analysis
what is the best selling product?

select Product_Name as Product, sum(Revenue) as Revenue
from `first-sql-project-358520.sql_portfolio.products` as products
inner join `first-sql-project-358520.sql_portfolio.sales` as sales
on products.Product_ID = sales.Product_ID
group by Product_Name
order by Revenue desc

what is the best selling product category?

select Product_Category as Product_Category, sum(Revenue) as Revenue
from `first-sql-project-358520.sql_portfolio.products` as products
inner join `first-sql-project-358520.sql_portfolio.sales` as sales
on products.Product_ID = sales.Product_ID
group by Product_Category
order by Revenue desc

store location analysis
what is the number of stores in each location and city?

select count(Store_Name) as stores, 
count(Store_city) as city, 
count(Store_Location) as Location
from `first-sql-project-358520.sql_portfolio.stores`
group by Store_Location

what is the average transaction value by Store_City?

select Store_City as store, avg(Product_price) as Revenue
from `first-sql-project-358520.sql_portfolio.stores` as stores 
inner join `first-sql-project-358520.sql_portfolio.sales` as sales
on stores.Store_ID = sales.Store_ID
group by Store_City
order by Revenue desc

what is the distribution of stores in each location?

select Store_Location as location, count(Store_Name) as Stores
from `first-sql-project-358520.sql_portfolio.stores`
group by Store_Location
order by Stores desc

what is the average revenue per store_city?

select Store_City as city, avg(Revenue) as Revenue
from `first-sql-project-358520.sql_portfolio.stores` as stores
inner join `first-sql-project-358520.sql_portfolio.sales` as sales
on stores.Store_ID = sales.Store_ID
group by Store_city
order by Revenue desc

which store location brings in the most revenue?

select Store_Location as Location, sum(Revenue) as Revenue
from `first-sql-project-358520.sql_portfolio.stores` as stores
inner join `first-sql-project-358520.sql_portfolio.sales` as sales
on stores.Store_ID = sales.Store_ID
group by Store_Location
order by Revenue desc

Time series analysis
total revenue generated per year
i extracted the year from the date

select extract(year from Date) as year, Sum(Revenue) as Total_revenue
from `first-sql-project-358520.sql_portfolio.sales`
group by year
order by Total_revenue desc
