/*A stored procedure to INSERT a row in the Order table.*/

CREATE PROCEDURE insert__Order
@OrderDate DATE,
@OrderPrice FLOAT,
@OrderType VARCHAR(50),
@OrderDescription VARCHAR(50),
@ProductName VARCHAR(50)
AS 
DECLARE @P_ID INT

SET @P_ID = (SELECT ProductID
                    FROM tbl_Menu M
                    WHERE M.ProductName = @ProductName)

IF @P_ID IS NULL
	BEGIN
		PRINT 'there is a NULL value in the variable; terminating process';
		THROW 52300, '@P_ID cannot be NULL. Incorrect Product Name entered', 1;
	END

BEGIN TRAN T1
INSERT INTO tbl_Order (OrderDate, OrderPrice, OrderType, OrderDescription, ProductID)
VALUES(@OrderDate, @OrderPrice, @OrderType, @OrderDescription, @P_ID)
COMMIT TRAN T1
GO


EXEC insert__Order
@OrderDate = '04-05-2021',
@OrderPrice = 30,
@OrderType = 'Drink,ToGo',
@OrderDescription = 'Ordered via phone',
@ProductName = 'Coffee Latte'
GO

EXEC insert__Order
@OrderDate = '06-05-2021',
@OrderPrice = 25,
@OrderType = 'Food,for here',
@OrderDescription = 'Ordered on front desk',
@ProductName = 'Chicken Sandwich'
GO

EXEC insert__Order
@OrderDate = '07-10-2021',
@OrderPrice = 10,
@OrderType = 'Drink,for here',
@OrderDescription = 'Ordered on front desk',
@ProductName = 'Americano'
GO

EXEC insert__Order
@OrderDate = '09-13-2021',
@OrderPrice = 20,
@OrderType = 'Drink, to go',
@OrderDescription = 'Ordered via Phone',
@ProductName = 'Orange Juice'
GO

EXEC insert__Order
@OrderDate = '01-13-2022',
@OrderPrice = 10,
@OrderType = 'Food',
@OrderDescription = 'Ordered via Phone',
@ProductName = 'Choloate Croissant'
GO

SELECT*
FROM tbl_Order
GO

/*A stored procedure to INSERT a row in the CUSTOMERS table.*/

CREATE PROCEDURE insert_Customer
@CustomerFirstName VARCHAR(50),
@CustomerLastName VARCHAR(50),
@Telephone VARCHAR(50),
@Email VARCHAR(50),
@OrderType VARCHAR(50)
AS
DECLARE @O_ID INT

SET @O_ID = (SELECT OrderID
                    FROM tbl_Order O
                    WHERE O.OrderType = @OrderType)

IF @O_ID IS NULL
	BEGIN
		PRINT 'there is a NULL value in the variable; terminating process';
		THROW 52300, '@OrderID cannot be NULL. Incorrect OrderType entered', 1;
	END

BEGIN TRAN T1 
INSERT INTO tbl_Customers (CustomerFirstName, CustomerLastName, Telephone, Email, OrderID)
VALUES(@CustomerFirstName,  @CustomerLastName, @Telephone, @Email, @O_ID)
COMMIT TRAN T1
GO

EXEC insert_Customer
@CustomerFirstName = 'Mary',
@CustomerLastName = 'Smith',
@Telephone = '6174502758',
@Email = 'MarryS@gmail.com',
@OrderType = 'Drink,ToGo'
GO

EXEC insert_Customer
@CustomerFirstName = 'John',
@CustomerLastName = 'Aiken',
@Telephone = '6174502780',
@Email = 'JohnA@gmail.com',
@OrderType = 'Food,for here'
GO

EXEC insert_Customer
@CustomerFirstName = 'Harold',
@CustomerLastName = 'Aiken',
@Telephone = '61745027082',
@Email = 'JohnA@gmail.com',
@OrderType = 'Food'
GO

SELECT*
FROM tbl_Customers
GO

/*A stored procedure to INSERT a row in the EMPLOYEES table.*/

CREATE PROCEDURE insert_employee
@EmployeeLastName VARCHAR(50),
@EmployeeFirstName VARCHAR(50),
@Telephone VARCHAR(50),
@Email VARCHAR(50),
@EmployeeAddress VARCHAR(50),
@EmployeeTypeName VARCHAR (50) 
AS
DECLARE @ET_ID INT

SET @ET_ID = (SELECT ET.EmployeeTypeID
                    FROM tbl_Employee_Type ET
                    WHERE ET.EmployeeTypeName = @EmployeeTypeName)

IF @ET_ID IS NULL
	BEGIN
		PRINT 'there is a NULL value in the variable; terminating process';
		THROW 52300, '@ET_ID cannot be NULL. Incorrect Employee Type Name entered', 1;
	END

BEGIN TRAN T1 
INSERT INTO tbl_Employees (EmployeeLastName, EmployeeFirstName, Telephone, Email, EmployeeAddress, EmployeeTypeID)
VALUES(@EmployeeLastName,  @EmployeeFirstName, @Telephone, @Email, @EmployeeAddress, @ET_ID)
COMMIT TRAN T1
GO

EXEC insert_employee
@EmployeeLastName = 'Ainsley',
@EmployeeFirstName = 'Emerson',
@Telephone = '5556773284',
@Email = 'AE22@gmail.com',
@EmployeeAddress = '86 Baker St. North Sydney NSW 2156',
@EmployeeTypeName = 'Cashier' 
GO

EXEC insert_employee
@EmployeeLastName = 'Anderson',
@EmployeeFirstName = 'Griffin',
@Telephone = '5103742608',
@Email = 'AG@gmail.com',
@EmployeeAddress = '85 Bradford Lane, Vincentown, NJ 08120',
@EmployeeTypeName = 'Brasti' 
GO

EXEC insert_employee
@EmployeeLastName = 'Hudson',
@EmployeeFirstName = 'Logan',
@Telephone = '3154736203',
@Email = 'HudLogan@gmail.com',
@EmployeeAddress = 'Cecelia Havens, 456 White Finch St.SC',
@EmployeeTypeName = 'Baker' 
GO

EXEC insert_employee
@EmployeeLastName = 'Hayden',
@EmployeeFirstName = 'Carlin',
@Telephone = '6174296201',
@Email = 'HayC@yahoo.com',
@EmployeeAddress = 'Robert Robertson, 1234 NW Bobcat Lane',
@EmployeeTypeName = 'Hourly Employer' 
GO

SELECT * FROM tbl_EMPLOYEES
GO

/*Create two triggers*/
CREATE TRIGGER Trigger_Order
ON tbl_Order
INSTEAD OF INSERT 
AS BEGIN 
    DECLARE @OrderDate DATE;
    DECLARE @OrderPrice FLOAT;
    DECLARE @OrderType VARCHAR(50);
    DECLARE @OrderDescription VARCHAR(50);
        SELECT @OrderDate = OrderDate, @OrderPrice = OrderPrice, @OrderType = OrderType, @OrderDescription = OrderDescription FROM INSERTED;
        IF @OrderDescription IS NULL SET @OrderDescription = 'N/A';
    INSERT INTO tbl_Order (OrderDate, OrderPrice, OrderType, OrderDescription)
    VALUES (@OrderDate, @OrderPrice, @OrderType, @OrderDescription)
END;
GO

CREATE TRIGGER Trigger_Employees
ON tbl_Employee_Type
INSTEAD OF INSERT
AS BEGIN
    DECLARE @basesalary VARCHAR (20)
    SELECT @basesalary = BaseSalary FROM inserted
    IF @basesalary < 10
    RAISERROR ('The Salary is too low to for reaching the minimum salary base', 11, 1) with log
END;
GO

INSERT INTO tbl_Employee_Type
(EmployeeTypeName, Duty, BaseSalary)
VALUES ('Internship', 'Admistration Support', '6')


/*Create two computed Column*/
ALTER TABLE tbl_Employee_Type
ADD MonthlySalary AS (BaseSalary * 25 * 30);
GO

ALTER TABLE tbl_Employee_Type
ADD Bonus AS (BaseSalary * 12 * 0.2)
GO

SELECT *
FROM tbl_Employee_Type


/*Query to find the employee who has the highest base salary */
SELECT TOP 1 BaseSalary, EmployeeFirstName, EmployeeLastName
FROM tbl_Employee_Type ET
    JOIN tbl_Employees E
    ON ET.EmployeeTypeID = E.EmployeeTypeID
ORDER BY ET. BaseSalary DESC

/*Query to find the customers who ordered on Apr.5 2021, in which the product he/she ordered has a total product price larger than $5 */
SELECT CustomerFirstName, CustomerLastName, SUM(ProductPrice) AS Sum_product_price
FROM tbl_Customers C
    JOIN tbl_Order O ON C.OrderID = O.OrderID
    JOIN tbl_Menu M ON M.ProductID = O.ProductID
WHERE OrderDate = '04-05-2021'
GROUP BY CustomerFirstName, CustomerLastName
HAVING SUM(ProductPrice) > 5