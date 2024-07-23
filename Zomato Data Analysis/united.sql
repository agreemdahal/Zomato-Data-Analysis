-- What is The total amount each customer spent on zomato?

SELECT a.userid, sum(b.price) as Total
FROM sales a 
INNER JOIN product b ON a.product_id = b.product_id 
GROUP BY a.userid 
LIMIT 0, 1000;

-- How many days each customer visited zomato?

select userid, count(distinct created_date) from sales
group by userid;

-- What was first prodcut purchased by each customer?

Select * from 
(Select *, rank() over(partition by userid order by created_date) rnk from sales) a where rnk=1;

-- what is the most purchased item on menu and how many times was it purchased by all customers?

SELECT userid, COUNT(product_id) AS cnt 
FROM sales 
WHERE product_id = (
    SELECT product_id 
    FROM sales 
    GROUP BY product_id 
    ORDER BY COUNT(product_id) DESC 
    LIMIT 1
) 
GROUP BY userid 
LIMIT 0, 1000;