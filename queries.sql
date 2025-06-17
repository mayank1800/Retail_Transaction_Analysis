-- 1. Drop existing table if exists.
DROP TABLE IF EXISTS retail_transactions;

-- 2. Create table
CREATE TABLE retail_transactions (
    CustomerID INTEGER,
    ProductID VARCHAR(20),
    ProductCategory VARCHAR(50),
    Quantity INTEGER,
    Price NUMERIC(10, 2),
    DiscountApplied NUMERIC(5,2),
    DiscountedPrice NUMERIC(10,2),
    TotalAmount NUMERIC(10,2),
    PaymentMethod VARCHAR(50),
	TransactionDate TIMESTAMP,
	YEAR INTEGER,
	Month INTEGER,
	Day INTEGER,
	Weekday VARCHAR(10),
	Hour INTEGER,
    City VARCHAR(100),
    State VARCHAR(100),
	Zipcode INTEGER
);

-- 3. Getting cleaned CSV file.
COPY retail_transactions FROM '/Users/mayanksinghrawat/Desktop/Projects/Project 1/Retail_cleaned.csv' DELIMITER ',' CSV HEADER;

-- 4. Verifying Table
Select *
From retail_transactions
Limit 10;

-- 5. KPIs

-- 5.a Top 5 store per revenue
Select 
	state, city, zipcode, 
	Sum(totalamount) over(Partition by zipcode) as Total_revenue
From retail_transactions
Order by Total_revenue Desc
Limit 5;

-- 5.b Top 5 Product Categories by Revenue
Select 
	productcategory, count(*) as product_sale, sum(totalamount) as Revenue
From retail_transactions
group by productcategory
Order by sum(totalamount) Desc
Limit 5;

-- 5.c Top Product per Category by Revenue
with procat as(
	Select productid, productcategory, sum(totalamount) as revenue, 
	rank() over(partition by productcategory order by sum(totalamount) Desc) as Pro_Rank
	from retail_transactions
	group by productid, productcategory
)
select productid, productcategory, revenue
from procat
where pro_rank = 1;

-- 5.d ProductCategory Preferences (rank1) by State
with Categoryrank as(
	Select 
		state, productcategory, 
		Count(*) as numberofsales, Rank() over(partition by state order by count(*) desc) as sale_rank
	from retail_transactions
	group by state, productcategory
)
Select *
From Categoryrank
where sale_rank = 1;

-- 5.e Monthly transaction trend/count
SELECT 
    TO_CHAR(transactiondate, 'Mon') AS Month, year,
    COUNT(*) AS TransactionCount
FROM retail_transactions
GROUP BY TO_CHAR(transactiondate, 'Mon'), year
ORDER BY TransactionCount Desc;

-- 5.f Peak Purchase Hour
Select 
	hour, count(*) as numberofsales, sum(totalamount) as Sales
from retail_transactions
group by hour
order by numberofsales desc
limit 3;

-- 5.g Top 10 customers by spend
Select 
	customerid, sum(totalamount) as spend
From retail_transactions
group by customerid
order by spend Desc
limit 10;

-- 5.h Peak Purchase Hour
Select 
	hour, count(*) as numberofsales, sum(totalamount) as Sales
from retail_transactions
group by hour
order by numberofsales desc
limit 3;

-- 5.i Average Basket Size (Items per Transaction)
SELECT AVG(Quantity) AS AvgBasketSize
FROM retail_transactions;

-- 5.j Repeat vs One-time Customers
SELECT 
    COUNT(*) FILTER (WHERE customer_count = 1) AS OneTimeCustomers,
    COUNT(*) FILTER (WHERE customer_count > 1) AS RepeatCustomers
FROM (
    SELECT customerID, COUNT(*) AS customer_count
    FROM retail_transactions
    GROUP BY customerID
) AS customer_stats;


-- 5.k Month-over-Month Revenue Growth
with monthly_revenue as(
	select 
		month,year, sum(totalamount) as revenue
	from retail_transactions
	group by month,year
),
previous_month_revenue as (
	Select
		month,year,revenue,
		lag(revenue) over(order by year,month) as previous_month_rev
	from monthly_revenue
),
MoMgrowth as (
	select *,
		round(((revenue - previous_month_rev)/previous_month_rev)*100,2) as MOM_growth
	from previous_month_revenue
)
select month,year,revenue,previous_month_rev,
	case
		when mom_growth is null then null
		else concat(mom_growth,'%')
	end as mom_growth
from MoMgrowth;

-- 5.l Distribution & revenue by Payment Methods
Select PaymentMethod, Count(*) as NumTransactions, sum(totalamount) as revenue
From retail_transactions
Group by PaymentMethod
Order by NumTransactions DESC;



