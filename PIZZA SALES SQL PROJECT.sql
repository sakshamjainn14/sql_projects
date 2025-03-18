CREATE DATABASE PIZZAHUT;
USE pizzahut;
DROP TABLE orders;

CREATE TABLE orders (
order_id INT NOT NULL,
order_date DATE NOT NULL,
order_time TIME NOT NULL,
PRIMARY KEY(order_id)
);

CREATE TABLE order_details (
order_details_id INT NOT NULL,
order_id INT NOT NULL,
pizza_id VARCHAR (20) NOT NULL,
quantity INT NOT NULL,
PRIMARY KEY(order_details_id)
);

SELECT * FROM ORDER_DETAILS;

-- Retrieve the total number of orders placed.
SELECT COUNT(order_id) AS total_order FROM orders;

-- Calculate the total revenue generated from pizza sales.
SELECT
SUM(pizzas.price * order_details.quantity) AS total_revenue
FROM pizzas
JOIN order_details
ON pizzas.pizza_id = order_details.pizza_id;

-- Identify the highest-priced pizza.
SELECT pizza_types.name, pizzas.price
FROM pizzas
INNER JOIN pizza_types
ON pizzas.pizza_type_id = pizza_types.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;

-- Identify the most common pizza size ordered.
SELECT pizzas.size, COUNT(order_details.order_details_id) AS total
FROM pizzas
JOIN order_details
ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size ORDER BY total DESC;

-- List the top 5 most ordered pizza types along with their quantities
SELECT pizza_types.name, SUM(order_details.quantity) AS total_quantity
FROM pizza_types 
JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name ORDER BY total_quantity DESC
LIMIT 5;

-- Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT pizza_types.category, SUM(order_details.quantity) AS total_quantity
FROM pizza_types
JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category ORDER BY total_quantity DESC;

-- Determine the distribution of orders by hour of the day
SELECT HOUR(order_time), COUNT(order_id) FROM orders
GROUP BY HOUR(order_time);

-- Join relevant tables to find the category-wise distribution of pizzas
SELECT pizza_types.category, COUNT(name)
FROM pizza_types
GROUP BY pizza_types.category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT AVG(quantity) FROM
(SELECT orders.order_date, SUM(order_details.quantity) AS quantity
FROM orders
JOIN order_details
ON orders.order_id = order_details.order_id
GROUP BY orders.order_date) AS order_qauntity;

-- Determine the top 3 most ordered pizza types based on revenue.
SELECT pizza_types.name,
SUM(order_details.quantity * pizzas.price) AS revenue
FROM pizza_types
JOIN pizzas
ON pizzas.pizza_type_id = pizza_types.pizza_type_id
JOIN order_details
ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name ORDER BY revenue DESC 
LIMIT 3;

-- END OF PROJECT.

