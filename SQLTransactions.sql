-- ROLLBACK example

-- Identifies the session number

SELECT CONNECTION_ID();

-- start transaction
START transaction;

-- view the number of order prior to deletion
select count(*) from orders;

-- Delete all rows from the orders table
DELETE from orders;

-- There is a problem due to referential intergrity 
-- The foreign key records associated with this primary key
-- Must be deleted first 
-- review the information on setting up a cascade delete

DELETE FROM orderdetails;

DELETE FROM orders;

-- view number of orders after deletion
SELECT count(*) from orders;

-- Log into mysql database server in a seperate session 
-- the query data from the orders table

-- After deleting rows from orders table 
-- view number of orders from a different login session
SELECT count(*) from orders;


-- We ave made changed in the first session
-- However, the changes are not permanent
-- in the first session, we can either commit or roll back the changes


-- toggle over to the first session

ROLLBACK;

SELECT count(*) from orders;

SELECT count(*) from orderdetails;
