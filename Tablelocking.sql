-- table locking

-- A lock is a table flag associated with a table
-- SQL allows a client session to explicitly acquire a table lock
-- This is for preventing other session from accessing the same table 
-- during a specific period

-- create our example table named Messages
-- The Messages table will keep track of messages

CREATE TABLE Messages 
(
    id int not null auto_increment,
    message varchar(100) not null,
    constraint Messages_PK PRIMARY KEY (id)
);


SELECT CONNECTION_ID(); 

-- Insert a message into the message table
INSERT INTO Messages(message)
VALUES('Hello');

-- Display inserted message to the console CLI
SELECT * FROM Messages;

-- This statement will lock the message table in a READ Mode
-- So once the READ lock is required 
-- You cannot write data to the table within the same session

LOCK TABLE Messages READ;


-- Try to insert a new row into the message table
-- This should now generate an error message 
INSERT INTO Messages(message)
VALUES ('hi'); 

-- let us examine session id for our current session
SELECT CONNECTION_ID(); 

-- we will now check the READ lock from a different session 
-- we will open a seperate session with the same user ID

-- Let us examine the session ID of the new session 
SELECT CONNECTION_ID(); 


-- query data from the messages table from the new session
SELECT * FROM Messages;

-- Try to insert a new row into the message table in the new session
INSERT INTO Messages(message)
VALUES ('bye'); 
 
-- The message that you will see that the command is Running 
-- The insert operation from the second session is in the waiting state
-- This is because a READ lock is already acquired on the message table
-- it is acquired by the first session and it has not been released yet


-- now lets toggle back to the first session
-- From the first session,
-- Use the SHOW PROCESSLIST statement to show detailed information
-- on current processes in the RDBMS

SHOW PROCESSLIST;

-- The result set will visually indicate that the 
-- insert statement is in a waiting state

-- Go back to the first session and release the lock

UNLOCK TABLES;

-- After releasing the READ lock from the first session,
-- the insert operation in the second session will execute 

-- Execute the show PROCESSLIST statement once more 
SHOW PROCESSLIST;

-- From the first session check the data of the messages table 
-- verify the INSERT operation from the second session really executed

SELECT * FROM messages;

-- write locks