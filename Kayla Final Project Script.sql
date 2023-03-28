/*Create Tables*/

CREATE TABLE tbl_BranchStore
(BranchID INT NOT NULL IDENTITY,
 BranchName VARCHAR(50) NOT NULL,
 City VARCHAR(50) NOT NULL,
 BranchAddress VARCHAR(50) NOT NULL,
 ContactNumber VARCHAR(50) NOT NULL,
 ManagerName VARCHAR(50) NOT NULL,
);
 go

CREATE TABLE tbl_Employees
(EmployeeID INT NOT NULL IDENTITY,
 EmployeeLastName VARCHAR(50) NOT NULL,
 EmployeeFirstName VARCHAR(50) NOT NULL,
 Telephone VARCHAR(50) NOT NULL,
 Email VARCHAR(50) NOT NULL,
 EmployeeAddress VARCHAR(50) NOT NULL,
);
 go

CREATE TABLE tbl_StockProduct
(StockProductID INT NOT NULL IDENTITY,
 StockName VARCHAR(50) NOT NULL,
 StockType VARCHAR(50) NOT NULL,
 Quantity VARCHAR(50) NOT NULL,
 StockDiscription VARCHAR(100),
 StockDeliveryDate DATE NOT NULL,
);
 go

CREATE TABLE tbl_Menu
(ProductID INT NOT NULL IDENTITY,
 ProductName VARCHAR(50) NOT NULL,
 ProductType VARCHAR(50) NOT NULL,
 ProductPrice FLOAT NOT NULL,
);
 go

CREATE TABLE tbl_Order
(OrderID INT NOT NULL IDENTITY,
 OrderDate DATE NOT NULL,
 OrderPrice FLOAT NOT NULL,
 OrderType VARCHAR(50) NOT NULL,
 OrderDescription VARCHAR(50),
);
 go

CREATE TABLE tbl_Customers
(CustomerID INT NOT NULL IDENTITY,
 CustomerFirstName VARCHAR(50) NOT NULL,
 CustomerLastName VARCHAR(50) NOT NULL,
 Telephone VARCHAR(50) NOT NULL,
 Email VARCHAR(50) NOT NULL,
);
 go


CREATE TABLE tbl_Employee_Type
(EmployeeTypeID INT NOT NULL IDENTITY,
 EmployeeTypeName VARCHAR(50) NOT NULL,
 Duty VARCHAR(100) NOT NULL,
 BaseSalary FLOAT NOT NULL,
);
 go


CREATE TABLE tbl_Supplier
(SupplierID INT NOT NULL IDENTITY,
 SupplierName VARCHAR(50) NOT NULL,
 SupplierType VARCHAR(50) NOT NULL,
 SupplierContactName VARCHAR(50) NOT NULL,
 SupplierContactPhone VARCHAR(50) NOT NULL,
);
 go

CREATE TABLE tbl_Equipment
(EuipmentID INT NOT NULL IDENTITY,
 EuipmentPrice FLOAT NOT NULL,
 EuipmentBrand VARCHAR(50) NOT NULL,
 EuipmentOrderDate DATE NOT NULL,
 WarrantyDate DATE NOT NULL,
);
 go

CREATE TABLE tbl_Equipment_Type
(EuipmentTypeID INT NOT NULL IDENTITY,
 EuipmentTypeName VARCHAR(50) NOT NULL,
 EuipmentTypeFunction VARCHAR(50) NOT NULL,
 TypeQuantity INT NOT NULL,
);
 go

CREATE TABLE tbl_Event
(EventID INT NOT NULL IDENTITY,
 EventName VARCHAR(50) NOT NULL,
 EventDescription VARCHAR(100) NOT NULL,
 Budget FLOAT NOT NULL,
 EventDate DATE NOT NULL,
 EventTime TIME NOT NULL,
 EventType VARCHAR(50) NOT NULL,
);
go
 
/*Assign Foreign Keys*/

ALTER TABLE tbl_BranchStore
 ADD EmployeeID INT NOT NULL;
GO

ALTER TABLE tbl_BranchStore
 ADD ProductID INT NOT NULL;
GO

ALTER TABLE tbl_BranchStore
ADD StockProductID INT NOT NULL;
GO

ALTER TABLE tbl_BranchStore
 ADD EquipmentID INT NOT NULL;
GO

ALTER TABLE tbl_BranchStore
 ADD EventD INT NOT NULL;
GO

ALTER TABLE tbl_StockProduct
 ADD SupplierID INT NOT NULL;
GO
 
ALTER TABLE tbl_Employees
 ADD EmployeeTypeID INT NOT NULL;
GO

ALTER TABLE tbl_Order
 ADD ProductID INT NOT NULL;
GO

ALTER TABLE tbl_Customers
 ADD OrderID INT NOT NULL;
GO

ALTER TABLE tbl_Equipment
 ADD EuipmentTypeID INT NOT NULL;
GO

/*Insert statement*/
INSERT INTO tbl_Supplier
(SupplierName, SupplierType, SupplierContactName, SupplierContactPhone)
VALUES ('Alamo Refrigeration','Kitchen Supplies', 'John Smith','617-870-2930'), 
('Alto-Shaam','Cooking Technology', 'Harold Lambert','510-248-1293'),
('IKEA','Furniture', 'Davis Brown','206-760-3280'),
('Walmart','Food Supplies', 'Mike Parker','617-659-3324'),
('Whole Food','Food Supplies', 'Luvienne Sans ','315-406-2780');
GO

INSERT INTO tbl_Equipment_Type
(EuipmentTypeName, EuipmentTypeFunction, TypeQuantity)
VALUES ('Kitchenware', 'Used for cooking', 90.0),
('Funiture', 'Tables, Chairs, checkout counter', 80),
('Electronic Device', 'For communications, electrocity, or entertainment', 15),
('Cleaning Tool', 'Used for cleaning the store', 23),
('Decoration', 'Used for store decorations', 30);
GO

INSERT INTO tbl_Event
(EventName, EventDescription, Budget, EventDate, EventTime, EventType)
VALUES ('Ceremony', 'Subscribe to membership and get one free drink', 300, '2023-02-10', '10:00', 'Social'),
('Valentines', 'Buy one get one beravge free for couples', 200, '2023-02-14', '9:00', 'Holiday'),
('Spring Outdoor Event', 'Get 25% of seasonl drinks', 250, '2023-03-12', '9:00', 'Seasonal'),
('Suumer Outdoor Event', 'Get 25% of seasonl drinks', 100, '2023-05-25', '9:00', 'Seasonal'),
('National Day Special Offer', 'Special decoration package and donate to national government', 250, '2023-07-04', '9:00', 'Fund-Rasing');
GO

INSERT INTO tbl_Menu
(ProductName, ProductType, ProductPrice)
VALUES ('Coffee Latte', 'Beverage', 6.5),
('Americano', 'Beverage', 3.5),
('Orange Juice', 'Beverage', 7),
('Chicken Sandwich', 'Food', 1),
('Choloate Croissant', 'Food', 6.5);


INSERT INTO tbl_Employee_Type
(EmployeeTypeName, Duty, BaseSalary)
VALUES ('Cashier', 'Responsible for customer checks', 20),
('Bookkeeper', 'Collecting revenue, profits, cost, and budget', 10),
('Brasti', 'Making beverage', 40),
('Baker', 'Making sweets and cooking foods', 20),
('Hourly Employer ', 'Internship, contract, part-time employees', 15);
GO