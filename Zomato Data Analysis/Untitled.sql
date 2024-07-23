 -- Whuch item was purchased first by th customer after tehy became a member?
 
 
 Select * from
 (select c.*, rank() over(partition by userid order by created_date) rnk from
 (SELECT 
    a.userid, a.created_date, a.product_id, b.gold_signup_date
FROM
    sales a
        INNER JOIN
    goldusers_signup b ON a.userid = b.userid
        AND created_date > gold_signup_date)c)d where rnk=1;
        
        
-- Which item was purchased before the customer became a member?

 Select * from
 (select c.*, rank() over(partition by userid order by created_date) rnk from
 (SELECT 
    a.userid, a.created_date, a.product_id, b.gold_signup_date
FROM
    sales a
        INNER JOIN
    goldusers_signup b ON a.userid = b.userid
        AND created_date <= gold_signup_date)c)d where rnk=1;

-- What is the total orders and amouunt spent for each member before they became member?

Select userid, count(created_date) as order_purchased, sum(price) as total_amount from
(Select c.*, d.price from
(SELECT 
    a.userid, a.created_date, a.product_id, b.gold_signup_date
FROM
    sales a
        INNER JOIN
    goldusers_signup b ON a.userid = b.userid
        AND created_date <= gold_signup_date)c inner join product d on c.product_id=d.product_id)e
        Group by userid
        ;
        

