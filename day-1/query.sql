-- question 
-- find new and repeat customers expected o/p 
-- order_date,new_customer_count,repeat_customer_count 
-- 2022-01-01,3,0
-- 2022-01-02,2,1
-- 2022-01-03,1,2
-- script 

CREATE TABLE customer_orders
  (
     order_id     INTEGER,
     customer_id  INTEGER,
     order_date   DATE,
     order_amount INTEGER
  );

SELECT *
FROM   customer_orders

INSERT INTO customer_orders
VALUES     (1,
            100,
            Cast('2022-01-01' AS DATE),
            2000),
            (2,
             200,
             Cast('2022-01-01' AS DATE),
             2500),
            (3,
             300,
             Cast('2022-01-01' AS DATE),
             2100),
            (4,
             100,
             Cast('2022-01-02' AS DATE),
             2000),
            (5,
             400,
             Cast('2022-01-02' AS DATE),
             2200),
            (6,
             500,
             Cast('2022-01-02' AS DATE),
             2700),
            (7,
             100,
             Cast('2022-01-03' AS DATE),
             3000),
            (8,
             400,
             Cast('2022-01-03' AS DATE),
             1000),
            (9,
             600,
             Cast('2022-01-03' AS DATE),
             3000); 

select * from customer_orders;


WITH customer_first_order
     AS (SELECT customer_id,
                Min(order_date) AS first_order
         FROM   customer_orders
         GROUP  BY customer_id)
SELECT co.order_date,
       Sum (CASE
              WHEN co.order_date = cfo.first_order THEN 1
              ELSE 0
            END) AS new_customer,
       Sum(CASE
             WHEN co.order_date > cfo.first_order THEN 1
             ELSE 0
           END)  AS repeat_customer
FROM   customer_first_order AS cfo
       INNER JOIN customer_orders AS co
               ON cfo.customer_id = co.customer_id
GROUP  BY co.order_date
ORDER  BY co.order_date 