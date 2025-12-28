
-- Create Database

CREATE DATABASE IF NOT EXISTS food_delivery;
USE food_delivery;


-- Orders Table

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    restaurant_id INT,
    city VARCHAR(50),
    cuisine VARCHAR(50),
    order_value DECIMAL(10,2),
    profit DECIMAL(10,2),
    profit_margin_pct DECIMAL(6,2),
    delivery_time INT,
    delivery_rating DECIMAL(2,1),
    order_day_type VARCHAR(10),
    is_peak_hour TINYINT,
    order_status VARCHAR(20)
);

-- -----------------------------
-- KPI QUERIES
-- -----------------------------
-- Total Orders
SELECT COUNT(*) AS total_orders FROM orders;

-- Total Revenue
SELECT SUM(order_value) AS total_revenue FROM orders;

-- Average Order Value
SELECT AVG(order_value) AS avg_order_value FROM orders;

-- Average Delivery Time
SELECT AVG(delivery_time) AS avg_delivery_time FROM orders;

-- Cancellation Rate
SELECT 
COUNT(CASE WHEN order_status = 'Cancelled' THEN 1 END) * 100.0 / COUNT(*) 
AS cancellation_rate
FROM orders;

-- Average Rating
SELECT AVG(delivery_rating) AS avg_rating FROM orders;

-- Revenue by City
SELECT city, SUM(order_value) AS revenue
FROM orders
GROUP BY city
ORDER BY revenue DESC;

-- Cuisine Performance
SELECT cuisine, COUNT(*) AS total_orders, SUM(order_value) AS revenue
FROM orders
GROUP BY cuisine
ORDER BY revenue DESC;

-- Peak Hour Demand
SELECT is_peak_hour, COUNT(*) AS total_orders
FROM orders
GROUP BY is_peak_hour;

-- Delivery Time by City
SELECT city, AVG(delivery_time) AS avg_delivery_time
FROM orders
GROUP BY city;

-- Restaurant Cancellation Rate
SELECT restaurant_id,
COUNT(CASE WHEN order_status='Cancelled' THEN 1 END) * 100.0 / COUNT(*) AS cancel_rate
FROM orders
GROUP BY restaurant_id;