CREATE DATABASE RetailStore;
USE RetailStore;

-- Customers
CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    JoinDate DATE
);

-- Products
CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10, 2),
    Stock INT
);

-- Orders
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- OrderItems
CREATE TABLE OrderItems (
    OrderItemID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Payments
CREATE TABLE Payments (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    PaymentDate DATE,
    Amount DECIMAL(10, 2),
    PaymentMethod VARCHAR(50),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
INSERT INTO Customers (Name, Email, JoinDate) VALUES
('Raj Pawar', 'raj@example.com', '2023-01-15'),
('Sneha Joshi', 'sneha@example.com', '2023-03-22'),
('Amit Deshmukh', 'amit@example.com', '2023-04-10'),
('Neha Sharma', 'neha@example.com', '2023-06-01'),
('Vikram Patel', 'vikram@example.com', '2023-07-18');
INSERT INTO Products (ProductName, Category, Price, Stock) VALUES
('Bluetooth Speaker', 'Electronics', 1500.00, 25),
('Running Shoes', 'Footwear', 2500.00, 15),
('Laptop Bag', 'Accessories', 1200.00, 10),
('Smartwatch', 'Electronics', 3500.00, 8),
('Formal Shirt', 'Clothing', 999.00, 20);
INSERT INTO Orders (CustomerID, OrderDate) VALUES
(1, '2023-07-20'),
(2, '2023-07-21'),
(3, '2023-08-01'),
(1, '2023-08-05'),
(4, '2023-08-15');
INSERT INTO OrderItems (OrderID, ProductID, Quantity) VALUES
(1, 1, 2),
(1, 3, 1),
(2, 2, 1),
(3, 4, 2),
(4, 5, 3),
(5, 1, 1),
(5, 2, 2);
INSERT INTO Payments (OrderID, PaymentDate, Amount, PaymentMethod) VALUES
(1, '2023-07-20', 4200.00, 'Credit Card'),
(2, '2023-07-21', 2500.00, 'UPI'),
(3, '2023-08-01', 7000.00, 'Debit Card'),
(4, '2023-08-05', 2997.00, 'Cash'),
(5, '2023-08-15', 5500.00, 'Credit Card');
SELECT 
    MONTH(OrderDate) AS Month,
    SUM(P.Amount) AS TotalSales
FROM Orders O
JOIN Payments P ON O.OrderID = P.OrderID
GROUP BY MONTH(OrderDate);
SELECT 
    P.ProductName,
    SUM(OI.Quantity) AS TotalSold
FROM OrderItems OI
JOIN Products P ON OI.ProductID = P.ProductID
GROUP BY P.ProductID
ORDER BY TotalSold DESC
LIMIT 5;
SELECT 
    C.Name,
    SUM(P.Amount) AS LifetimeValue
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN Payments P ON O.OrderID = P.OrderID
GROUP BY C.CustomerID;
SELECT 
    ProductName,
    Stock
FROM Products
WHERE Stock < 10;
