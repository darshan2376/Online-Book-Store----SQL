-- Advance Queries :


--  1) Retrieve the total number of books sold for each genre

select books.Genre, sum(orders.Quantity) as total_quantity
from books join orders
on books.Book_id = orders.Book_ID
group by books.Genre
order by total_quantity;

--  2) Find the average price of books in the "Fantasy" genre

select round(avg(price), 2) as avg_price from books
where Genre = "Fantasy";

--  3) List customers who have placed at least 2 orders

select o.Customer_Id, c.Name, count(o.Order_ID) as orders
from orders o
join customers c
on o.Customer_Id = c.Customer_ID
group by o.Customer_Id, c.Name
having orders >= 2;

--  4) Find the most frequently ordered book

select orders.Book_ID, books.title, count(orders.Order_ID) as order_count
 from orders
 join books
 on orders.Book_id = books.Book_id
 group by orders.Book_id, books.title
 order by order_count desc
 limit 1;


--  5) Show the top 3 most expensive books of 'Fantasy' Genre 

select title, Genre, price from books
where Genre = "fantasy"
order by price desc
limit 3;


-- 6) Retrieve the total quantity of books sold by each author

select books.Author, sum(orders.Quantity) as total_quantity
from books
join orders
on books.Book_id = orders.Book_ID
group by books.Author
order by total_quantity;

--  7) List the cities where customers who spent over $30 are located

select customers.City, sum(orders.Total_Amount) as total_amt 
from customers
join orders
on customers.Customer_ID = orders.Customer_Id
group by customers.City
having total_amt > 30
order by total_amt;

select distinct customers.City, orders.Total_Amount
from customers
join orders
on customers.Customer_ID = orders.Customer_Id
where orders.Total_Amount > 30;

--  8) Find the customer who spent the most on orders

select customers.name, sum(orders.Total_Amount) as total_amt
from customers
join orders
on customers.Customer_ID = orders.Customer_Id
group by customers.name
order by total_amt desc
limit 1;

--  9) Calculate the stock remaining after fulfilling all orders

select books.Book_id, books.title, books.Stock, coalesce(sum(orders.quantity), 0) as order_quantity,
	books.Stock - coalesce(sum(orders.quantity), 0)
from books
left join orders
on books.Book_id = orders.Book_ID
group by books.Book_id;


