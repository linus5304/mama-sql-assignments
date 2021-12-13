-- A SQL trasaction allows you to execute a set of SQL instructions 
-- This ensures that the database never contains the result of partial operations
-- in a ser of operations, if one of them fails, 
-- The rollback occurs to restore the database to its original state
-- if no error occurs, 
-- The entire set of statements is committed to the database
-- By default, many DBMS automatically commits the changes permanently
-- to the database. To force SQL not to commit changes automatically, 
-- you can use the following statement options
SET
    autocommit = 0;

-- or
SET
    autocommit = OFF;

-- You use the following statement to enable the autocommit mode explicitly
SET
    autocommit = 1;

-- or
SET
    autocommit = ON;

-- show us the previous  order number
SELECT
    MAX(orderNumber)
from
    orders;

-- Let us look at a SQL transaction
-- 1. start a new transaction
START transaction;

-- 2. Get the latest order number
SELECT
    @orderNumber := MAX(orderNumber) + 1
from
    orders;

-- let us show previous order number
SELECT
    @orderNumber;

-- 3. insert a new order for customer 145
INSERT INTO
    orders(
        orderNumber,
        orderDate,
        requiredDate,
        shippedDate,
        status,
        customerNumber
    )
VALUES
    (
        @orderNumber,
        '2005-05-31',
        '2005-06-10',
        '2005-06-11',
        'In Process',
        145
    );

-- 4. Insert order line items
INSERT INTO
    orderdetails(
        orderNumber,
        productCode,
        quantityOrdered,
        priceEach,
        orderLineNumber
    )
values
    (@orderNumber, 'S18_1749', 30, '136', 1),
    (@orderNumber, 'S18_2248', 50, '55.09', 2);

-- 5. commit changes
COMMIT;

select
    a.orderNumber,
    orderDate,
    requiredDate,
    shippedDate,
    status,
    comments,
    customerNumber,
    orderLineNumber,
    productCode,
    quantityOrdered,
    priceEach
from
    orders a
    inner join orderdetails b using (orderNumber)
where
    a.orderNumber = 10426;


