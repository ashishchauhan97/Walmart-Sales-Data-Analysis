SELECT * FROM walmartsales.sales;

-- Add the time_of_day column------
SELECT
	time,
	(CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END) AS time_of_day
FROM sales;

ALTER TABLE sales 
ADD COLUMN time_of_day VARCHAR(20);

UPDATE sales
SET time_of_day = (
	CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END
);

------add day_name column-------
select date,
dayname(date)
from sales;

alter table sales
add column day_name varchar(10);

update sales
set day_name = dayname(date);

----Add month_Name column------------

select date,
monthname(date)
from sales;

alter table sales
add column month_name varchar(15);

update sales
set month_name = monthname(date);

--------------------------------------------------------------------------------------------------------------
----------------------------------------------Generic_Questions----------------------------------------------------------------
Q1.How many unique cities does the data have?
select distinct city 
from sales;
Q2.In which city is each branch?
select distinct city,branch
from sales;

------------------------Product-----------------------------------------------

1.How many unique product lines does the data have?
select * from sales;
select distinct product_line
from sales;

2.What is the most common payment method?
select payment,count(payment) from sales
group by payment;

3.What is the most selling product line?
select * from sales;
select product_line,sum(quantity)as qty from sales
group by product_line
order by qty desc;

4.What is the total revenue by month?
select * from sales;
select month_name,sum(total) as total_revenue
from sales
group by month_name
order by total_revenue;

5.What month had the largest COGS?
select * from sales;
select month_name,sum(cogs) as largest_cogs
from sales
group by month_name
order by largest_cogs desc;

6.What product line had the largest revenue?
select * from sales;
select product_line,sum(total) as largest_revenue
from sales
group by product_line
order by largest_revenue desc;

7.What is the city with the largest revenue?
select * from sales;
select city,sum(total)as largest_revenue 
from sales
group by city
order by largest_revenue desc;

8.What product line had the largest VAT?
select * from sales;
select product_line,sum(tax_pct) as largest_VAT
from sales
group by product_line
order by largest_VAT desc;

9.Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
select * from sales;
select avg(quantity)as avg_sales
from sales;

select product_line,
case
    when avg(quantity)>6 then 'Good'
    else 'Bad'
end as remarks
from sales
group by product_line;

10. Which branch sold more products than average product sold?
select * from sales;
select branch,sum(quantity)as qyt
from sales
group by branch
having sum(quantity) > (select avg(quantity)from sales);

11.What is the most common product line by gender?
select * from sales;
select gender,product_line,count(gender)as total_cnt
from sales
group by gender,product_line
order by total_cnt desc;

12.What is the average rating of each product line?
select * from sales;
select product_line,avg(rating)as avg_rating
from sales
group by product_line;

---------------------------------Sales--------------------------------------------------
1.Number of sales made in each time of the day per weekday
select * from sales;
select time_of_day,count(*)as total_sales
from sales
where day_name = 'Monday'
group by time_of_day
order by total_sales desc;

2.Which of the customer types brings the most revenue?
select * from sales;
select customer_type,sum(total)as most_revenue
from sales
group by customer_type
order by most_revenue desc;

3.Which city has the largest tax percent/ VAT (Value Added Tax)?
select*from sales;
select city,sum(tax_pct)as largest_pct
from sales
group by city
order by largest_pct desc;

4. Which customer type pays the most in VAT?
select * from sales;
select customer_type,count(tax_pct)as most_pct_payingcustomer
from sales
group by customer_type
order by most_pct_payingcustomer desc;

---------------------------Customer---------------------------------------------------
1.How many unique customer types does the data have?
select * from sales;
select distinct customer_type
from sales;

2. How many unique payment methods does the data have?
select * from sales;
select distinct payment
from sales;

3. What is the most common customer type?
select customer_type,count(*)as count
from sales
group by customer_type
order by count desc;

4. Which customer type buys the most?
SELECT
	customer_type,
    COUNT(*)
FROM sales
GROUP BY customer_type;

5. What is the gender of most of the customers?
select * from sales;
select gender,count(*)as gender_cnt
from sales
group by gender
order by gender_cnt desc;

6. What is the gender distribution per branch?
select * from sales;
select branch,count(gender)as gender_cnt
from sales
group by branch
order by gender_cnt;
7. Which time of the day do customers give most ratings?
select time_of_day,count(rating)as most_rating
from sales
group by time_of_day
order by most_rating desc;

8. Which time of the day do customers give most ratings per branch?
select time_of_day,branch,count(branch)as rating_branch
from sales
group by time_of_day,branch
order by rating_branch desc;

9.Which day of the week has the best avg ratings?
select * from sales;
select day_name,avg(rating)as avg_rating
from sales
where day_name = 'Monday'
group by day_name
order by avg_rating desc;

10. Which day of the week has the best average ratings per branch?
select * from sales;
select day_name,branch,avg(rating)as avg_rating
from sales
group by day_name,branch
order by avg_rating desc;
