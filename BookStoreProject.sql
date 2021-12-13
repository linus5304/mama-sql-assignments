DROP database IF EXISTS bookStore_Db;

create database bookStore_Db;

use bookStore_Db;

create table customer (
    custID int not null AUTO_INCREMENT,
    FName VARCHAR(20),
    LName VARCHAR(20),
    email VARCHAR(50) not null unique,
    CONSTRAINT customer_PK PRIMARY KEY (custID)
);

insert into
    customer (custID, FName, LName, email)
values
    (1, 'Randolf', 'Chagg', 'rchagg0@squidoo.com'),
    (2, 'Jenifer', 'Dinsale', 'jdinsale1@etsy.com'),
    (
        3,
        'Maddie',
        'Sparham',
        'msparham2@bizjournals.com'
    ),
    (
        4,
        'Carrol',
        'Scrancher',
        'cscrancher3@yellowpages.com'
    ),
    (
        5,
        'Fayette',
        'Fatscher',
        'ffatscher4@taobao.com'
    ),
    (6, 'Chrystel', 'Whithorn', 'cwhithorn5@time.com'),
    (
        7,
        'Siward',
        'Kindleysides',
        'skindleysides6@auda.org.au'
    ),
    (8, 'Laughton', 'Kielt', 'lkielt7@ocn.ne.jp'),
    (9, 'Clerc', 'Drinkhall', 'cdrinkhall8@cisco.com'),
    (10, 'Andie', 'Aberdalgy', 'aaberdalgy9@nih.gov');

create table books(
    bookID int not null AUTO_INCREMENT,
    title VARCHAR(50) not null,
    author VARCHAR(20) not null,
    publisher VARCHAR(20),
    publishedDate DATE,
    price DOUBLE,
    genre VARCHAR(20),
    CONSTRAINT books_PK PRIMARY KEY (bookID)
);

INSERT INTO
    books (
        bookID,
        title,
        genre,
        author,
        price,
        publisher,
        publishedDate
    )
values
    (
        1,
        'The Tunnel of Love',
        'Romance',
        'El Theze',
        53.51,
        'Audrie Luke',
        '2021-03-15'
    ),
    (
        2,
        'Mr. Popper''s Penguins',
        'Comedy',
        'Atlanta Werndley',
        40.77,
        'Reeta Thurlow',
        '2021-04-25'
    ),
    (
        3,
        'Crusades, The',
        'Adventure',
        'Benjie Sach',
        72.45,
        'Leslie Dulanty',
        '2021-03-25'
    ),
    (
        4,
        'Boom Town',
        'Adventure',
        'Ianthe Beneteau',
        24.21,
        'Leslie Dulanty',
        '2021-10-25'
    ),
    (
        5,
        'Star for Two, A',
        'Romance',
        'Sukey Waszczyk',
        415.19,
        'Reeta Thurlow',
        '2021-09-24'
    ),
    (
        6,
        'Halloween',
        'Humor',
        'Jillayne Jerok',
        342.07,
        'Reeta Thurlow',
        '2020-12-29'
    ),
    (
        7,
        'Batman & Robin',
        'Horror',
        'Mira Sayers',
        180.07,
        'Bobbi Rentz',
        '2021-11-01'
    ),
    (
        8,
        'Duel at Diablo',
        'Adventure',
        'Costa Stockle',
        57.78,
        'Angela Yglesia',
        '2021-07-03'
    ),
    (
        9,
        'South, The (Sur)',
        'Drama',
        'Chelsea Kubanek',
        81.05,
        'Pepito Wessing',
        '2021-07-15'
    ),
    (
        10,
        'Welcome Farewell-Gutmann',
        'Children',
        'Grazia Showl',
        91.38,
        'Leslie Dulanty',
        '2021-07-02'
    );

create table orders(
    orderNumber int not null AUTO_INCREMENT,
    custID int,
    orderDate DATETIME,
    CONSTRAINT orders_PK PRIMARY KEY (orderNumber, custID),
    CONSTRAINT orders_FK FOREIGN KEY (custID) REFERENCES customer(custID) on delete cascade
);

insert into
    orders (orderNumber, custID, orderDate)
values
    (1, 2, '2021-07-08 12:49:20'),
    (2, 3, '2021-03-05 11:59:11'),
    (3, 1, '2021-03-05 11:59:11'),
    (4, 5, '2021-10-03 04:55:10'),
    (5, 1, '2021-03-14 22:28:11'),
    (6, 3, '2021-01-16 01:53:55'),
    (7, 6, '2021-04-08 21:13:03');

create table orderDetails (
    orderNumber int,
    bookID int,
    quantity int,
    CONSTRAINT orderDetails_PK PRIMARY KEY (orderNumber, bookID),
    CONSTRAINT orderDetails_FK1 FOREIGN KEY (orderNumber) REFERENCES orders(orderNumber) on delete cascade,
    CONSTRAINT orderDetails_FK2 FOREIGN KEY (bookID) REFERENCES books(bookID) on delete cascade
);

insert into
    orderDetails (orderNumber, bookID, quantity)
values
    (2, 10, 42),
    (5, 8, 85),
    (5, 3, 13),
    (4, 1, 11),
    (2, 3, 74),
    (6, 10, 13),
    (1, 5, 17),
    (3, 2, 17),
    (7, 2, 95),
    (1, 9, 95);

-- 1. Write a query that performs a Union on one of your main tables and another table
select
    *
from
    customer
union
select
    bookID,
    title,
    author,
    price
from
    books;

-- 2. Write a query that performs an intersection on one of your main tables and another table. 
select
    custID
from
    customer
intersect
select
    custID
from
    orders;

-- 3. Write two separate queries that perform a Difference Operation on your main tables and another table.
-- 4. You are to write a JOIN Query using two or more of your tables.  A table and two or more tables that it has a relationship with:
-- Books ordered by customer with custId = 1
select
    b.title,
    b.price,
    c.FName,
    c.custID
from
    customer c
    join orders o on c.custID = o.custID
    join orderDetails od on o.orderNumber = od.orderNumber
    join books b on od.bookID = b.bookID
where
    c.custID = 1;

-- 5. Create two queries that will alter the structure of your entity table
-- a. adding column address to customer table
desc customer;

alter table
    customer
add
    column address VARCHAR(50);

desc customer;

-- b. removing address from customer table 
desc customer;

alter table
    customer drop column address;

desc customer;

-- 6. Write two queries that will update two different categories of rows in the tables of the set of tables that you have chosen.
-- a. updating the book title, author, publisher, price and genre of the book with bookID = 5
update
    books
set
    title = 'Animal farm',
    author = 'Tapong Silvester',
    publisher = 'ASL Production',
    price = 100,
    genre = 'Drama'
where
    bookID = 5;

-- b. Upadating customer email of customer with custID = 3
update
    customer
set
    email = 'zshangdo@yahoo.com'
where
    custID = 3;

-- 7. Write two queries that will delete two different categories of rows in your tables.
-- a. Delete customer with custID = 5
delete from
    customer
where
    custID = 5;

-- b. Delete book with bookID = 5
delete from
    books
where
    bookID = 5;

-- 8. Write two queries that perform aggregate functions on at least your Primary Tables in your set of individual tables.
-- a. count The number of orders placed by customers
select
    count(*) as 'number of customers'
from
    customer;

-- b. select the most expensive book
select
    title,
    author,
    max(price) 'price'
from
    books;

-- 9. Write two queries that use a HAVING clause on different categories of rows in your set of tables chosen. 
-- a. selecting customers who placed orders before the month of April
select
    c.email,
    o.orderDate
from
    customer c
    join orders o on c.custID = c.custID
having
    MONTH(o.orderDate) < 4;

-- b. select books whose prices are > 100
select
    *
from
    books
having
    price > 100;

--10.  Write two queries that use both a GROUP BY and HAVING clause on different 
-- categories of rows in your entity tables or a combination of the set of tables chosen
-- a. Average price of books ordered in the month of March
select
    avg(b.price) 'avg price',
    date(o.orderDate) 'OrderDate'
from
    books b
    join orderDetails od on od.bookID = b.bookID
    join orders o on od.orderNumber = o.orderNumber
GROUP by
    month(o.orderDate)
having
    MONTH(OrderDate) = 3;

-- b. Total amount of money spend on books by customer with custID = 1
select
    c.custID,
    c.FName,
    c.email,
    sum(b.price) 'total amount spend on books'
from
    customer c
    join orders o on o.custID = c.custID
    join orderDetails od on o.orderNumber = od.orderNumber
    join books b on od.bookID = b.bookID
group by
    c.custID
having
    c.custID = 1;

--11. Write two queries that sort the results in Ascending and Descending order of the set of tables chosen.  
-- a. listing all customers ascending order of firstName
select
    *
from
    customer
order by
    FName asc;

-- b. Listing all books in descending order of prices
select
    *
from
    books
order by
    price desc;

-- 12. Write statements that create two SQL VIEWS.  The set of view statements should also include the SELECT Statements to execute them.
-- a. all customers who ordered adventure books 
create view adventureCustomers as
select
    c.*, b.title
from
    customer c
    join orders o on o.custID = c.custID
    join orderDetails od on o.orderNumber = od.orderNumber
    join books b on od.bookID = b.bookID
    where b.genre = 'Adventure';

-- Query the view adventureCustomers
select * from adventureCustomers;

-- b. all books published before Octorber 
create view beforOctoberBooks as 
select * from books
where month(publishedDate) < 10; 

-- 13. Write two Stored Procedures
-- a. 