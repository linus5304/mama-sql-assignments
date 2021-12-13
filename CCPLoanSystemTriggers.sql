-- create and use database
DROP DATABASE IF EXISTS CCPVehicleLoanSystem_DB;
CREATE DATABASE IF NOT EXISTS CCPVehicleLoanSystem_DB;
USE CCPVehicleLoanSystem_DB;
-- creation of the tables on the one side of the 1 - M relationship
-- Create the Department table
CREATE TABLE IF NOT EXISTS Faculty (
    empID INT,
    name VARCHAR(50),
    ranking INT,
    CONSTRAINT Faculty_PK PRIMARY KEY(empID)
);
-- Inserting into the faculty table
INSERT INTO faculty (empID, name, ranking)
VALUES (1, 'John Doe', 2),
    (2, 'Peter Smith', 3),
    (3, 'Johnson Kilk', 1),
    (4, 'Patience Ruther', 2),
    (5, 'Paul Allen', 4);
-- Create the Department table
CREATE TABLE IF NOT EXISTS Department(
    deptHeadID INT,
    deptName VARCHAR(50),
    depID INT,
    CONSTRAINT Department_PK PRIMARY KEY(deptHeadID)
);
-- inserting data into department 
INSERT INTO Department (deptHeadID, deptName, depID)
VALUES (1, 'Computer Science', 5100),
    (2, 'Biology', 5101),
    (3, 'Physics', 5102),
    (4, 'Business and Management', 5103),
    (5, 'Arts', 5104);
-- Create the Destination table
CREATE TABLE IF NOT EXISTS Destination (
    desID INT,
    city VARCHAR(50) NOT NULL,
    distance INT NOT NULL,
    state VARCHAR(50) NOT NULL,
    CONSTRAINT Destination_PK PRIMARY KEY(desID)
);
-- Inserting data into destination table
INSERT INTO Destination (desID, city, distance, state)
VALUES (1001, 'Spokane', 250, 'WA'),
    (1002, 'Philadelphia', 150, 'PA'),
    (1003, 'Huntsville', 210, 'AL'),
    (1004, 'Houston', 319, 'TX'),
    (1005, 'Dallas', 98, 'TX');
-- creation of tables on the many side of the 1 - M relationship
-- Create the TFAS_member table
CREATE TABLE IF NOT EXISTS TFAS_member(
    memberID INT,
    name VARCHAR(50) NOT NULL,
    certification VARCHAR(50),
    CONSTRAINT TFAS_member_PK PRIMARY KEY(memberID)
);
-- Inserting data into TFAS_memeber
INSERT INTO TFAS_member (memberID, name, certification)
VALUES (1, 'Jolie Sim', 'Journalism'),
    (2, 'Jacinta Noblet', 'Information Technology'),
    (3, 'Erin Churms', 'Music'),
    (4, 'Donny Manns', 'Business'),
    (5, 'Gorgery Hermans', 'Translation');
-- Create the Bills table
CREATE TABLE IF NOT EXISTS Bills(
    invoice_num INT,
    empID_FK INT,
    memberID_FK INT,
    amount INT,
    date DATE,
    credit_card VARCHAR(16),
    CONSTRAINT Bills_PK PRIMARY KEY (invoice_num, empID_FK, memberID_FK),
    CONSTRAINT Bills_FK1 FOREIGN KEY (empID_FK) REFERENCES Faculty (empID),
    CONSTRAINT Bills_FK2 FOREIGN KEY (memberID_FK) REFERENCES TFAS_member (memberID)
);
-- inserting data into the Bills table
INSERT INTO Bills (
        invoice_num,
        empID_FK,
        memberID_FK,
        amount,
        credit_card,
        date
    )
VALUES (1, 2, 1, 4155, '5100176646633723', '2021-05-25'),
    (2, 2, 1, 4155, '5100176646633723', '2021-05-25'),
    (3, 3, 2, 4975, '4041598283950067', '2021-09-09'),
    (4, 1, 2, 2225, '201650914582522', '2020-12-06'),
    (5, 1, 3, 1800, '4405759126659352', '2021-01-19');
-- Create the RequestForm table
CREATE TABLE IF NOT EXISTS RequestForm(
    empID_FK INT,
    deptHead_FK INT,
    dateRequested DATE,
    dateApproved DATE,
    approved BOOLEAN,
    type VARCHAR(50),
    CONSTRAINT RequestForm_PK PRIMARY KEY (empID_FK, deptHead_FK, dateRequested),
    CONSTRAINT RequestForm_FK1 FOREIGN KEY (empID_FK) REFERENCES Faculty (empID),
    CONSTRAINT RequestForm_FK2 FOREIGN KEY (deptHead_FK) REFERENCES Department (deptHeadID) ON DELETE CASCADE
);
-- Inserting data into request form
INSERT INTO RequestForm (
        empID_FK,
        deptHead_FK,
        dateRequested,
        dateApproved,
        approved,
        type
    )
VALUES (
        1,
        2,
        '2020-11-16',
        '2021-07-29',
        0,
        'Transportation'
    ),
    (
        2,
        1,
        '2020-11-27',
        '2021-06-18',
        1,
        'Information'
    ),
    (4, 5, '2021-03-14', '2021-05-14', 1, 'Time Off'),
    (
        3,
        3,
        '2020-12-19',
        '2021-09-24',
        0,
        'Purchase Order'
    ),
    (5, 4, '2020-05-12', '2021-05-08', 1, 'Work');
-- Create the Vehicle table
CREATE TABLE IF NOT EXISTS Vehicle(
    year YEAR,
    VIN CHAR(17) NOT NULL,
    make VARCHAR(50),
    model VARCHAR(50),
    milliadge INT,
    type VARCHAR(50),
    CONSTRAINT Vehicle_PK PRIMARY KEY (VIN)
);
-- Inserting data into the vehicles table
INSERT INTO vehicle (year, VIN, make, model, milliadge, type)
VALUES (
        '2013',
        '5GAER23748J566671',
        'Ford',
        'Transit Connect',
        400,
        'SPORTS CAR'
    ),
    (
        '2010',
        'WP0CA2A86CS539435',
        'Buick',
        'Enclave',
        233,
        'MINIVAN'
    ),
    (
        '1994',
        'WA1LFBFP0CA542140',
        'Isuzu',
        'Space',
        448,
        'CONVERTIBLE'
    ),
    (
        '2007',
        '3GYEK63N13G351973',
        'Jaguar',
        'X-Type',
        481,
        'SPORTS CAR'
    ),
    (
        '1985',
        '3VW517AT0FM093576',
        'Mazda',
        'B2000',
        208,
        'COUPE'
    );
-- Create the Borrows Table
-- (weak entity in the tertiary relationship of TFAS_member, Faculty and Vehicle)
CREATE TABLE IF NOT EXISTS Borrows (
    empID_FK INT,
    VIN_FK CHAR(17),
    date DATE,
    memberID_FK INT,
    milliadge INT,
    CONSTRAINT Borrow_PK PRIMARY KEY (empID_FK, VIN_FK, memberID_FK, date),
    CONSTRAINT Borrow_FK1 FOREIGN KEY (empID_FK) REFERENCES Faculty (empID),
    CONSTRAINT Borrow_FK2 FOREIGN KEY (memberID_FK) REFERENCES TFAS_member (memberID),
    CONSTRAINT Borrow_FK3 FOREIGN KEY (VIN_FK) REFERENCES Vehicle (VIN)
);
-- inserting data in the table borrows
INSERT INTO borrows (empID_FK, VIN_FK, date, memberID_FK, milliadge)
VALUES (1, '5GAER23748J566671', '2021-08-18', 2, 400),
    (3, 'WP0CA2A86CS539435', '2021-08-05', 1, 233),
    (2, 'WA1LFBFP0CA542140', '2021-10-22', 3, 448),
    (4, '3VW517AT0FM093576', '2021-09-20', 5, 208),
    (5, '3GYEK63N13G351973', '2021-09-20', 4, 481);
-- Create the Returns table 
-- (weak entity in the tertiary relationship of TFAS_member, Faculty and Vehicle)
CREATE TABLE IF NOT EXISTS Returns(
    memberID_FK INT,
    empID_FK INT,
    VIN_FK CHAR(17),
    date DATE,
    complaint VARCHAR(255),
    gas FLOAT,
    milliadge INT,
    CONSTRAINT Returns_PK PRIMARY KEY (empID_FK, VIN_FK, memberID_FK, date),
    CONSTRAINT Returns_FK1 FOREIGN KEY (empID_FK) REFERENCES Faculty (empID),
    CONSTRAINT Returns_FK2 FOREIGN KEY (memberID_FK) REFERENCES TFAS_member (memberID),
    CONSTRAINT Returns_FK3 FOREIGN KEY (VIN_FK) REFERENCES Vehicle (VIN)
);
-- Insert Statements
-- Inserting data into the Returns table
INSERT INTO Returns (
        memberID_FK,
        empID_FK,
        VIN_FK,
        date,
        complaint,
        gas,
        milliadge
    )
VALUES (
        1,
        1,
        '5GAER23748J566671',
        '2021-04-08',
        'too Old',
        4.2,
        400
    ),
    (
        2,
        3,
        'WP0CA2A86CS539435',
        '2021-06-18',
        'makes a lot of noise',
        5.1,
        233
    ),
    (
        3,
        2,
        'WA1LFBFP0CA542140',
        '2021-07-12',
        'weak breaks',
        3.2,
        448
    ),
    (
        4,
        5,
        '3VW517AT0FM093576',
        '2021-10-10',
        'A conditioner is bad',
        6.5,
        208
    ),
    (
        5,
        4,
        '3GYEK63N13G351973',
        '2021-01-21',
        'A conditioner is bad',
        3.0,
        481
    );
-- 

-- Create table statement for the department_audit table
CREATE TABLE department_audit (
    deptHeadID INT AUTO_INCREMENT PRIMARY KEY,
    deptName VARCHAR(50) NOT NULL,
    changedate DATETIME DEFAULT NULL,
    action VARCHAR(50) DEFAULT NULL
);

-- Creation of a Before Update Trigger 
CREATE TRIGGER before_department_update 
    BEFORE UPDATE ON department
    FOR EACH ROW 
 INSERT INTO department_audit
 SET action = 'update',
     deptHeadID = OLD.deptHeadID,
     deptName = OLD.deptName,
     changedate = NOW();


-- Creation of a Before Delete Trigger 
CREATE TRIGGER before_department_delete 
    BEFORE DELETE ON department
    FOR EACH ROW 
 INSERT INTO department_audit
 SET action = 'delete',
    deptName = OLD.deptName,
     changedate = NOW();


-- show triggers which have been created
SHOW TRIGGERS;


-- Update statement to test pour trigger
UPDATE department 
SET 
    deptName = 'Information Technology'
WHERE
    deptHeadID = 1;

DELETE FROM department
WHERE deptHeadID = 5;


SELECT * FROM department_audit;

