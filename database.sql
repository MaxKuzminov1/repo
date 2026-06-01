CREATE DATABASE shop;
USE shop;
CREATE TABLE Users (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    Login VARCHAR(50),
    Password VARCHAR(50),
    Role VARCHAR(20),
    FIO VARCHAR(100)
);
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100)
);
CREATE TABLE Manufacturers (
    ManufacturerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100)
);
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100)
);
CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    CategoryID INT,
    Description TEXT,
    ManufacturerID INT,
    SupplierID INT,
    Price FLOAT,
    Unit VARCHAR(10),
    StockQuantity INT,
    Discount INT,
    ImagePath VARCHAR(255),

    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    FOREIGN KEY (ManufacturerID) REFERENCES Manufacturers(ManufacturerID),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    Status VARCHAR(50),
    DeliveryAddress TEXT,
    OrderDate DATE,
    IssueDate DATE,

    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
CREATE TABLE OrderItems (
    ItemID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ProductID INT,
    Quantity INT,

    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
INSERT INTO Users (Login, Password, Role, FIO)
VALUES ('admin', '123', 'admin', 'Иванов Иван Иванович');
INSERT INTO Users (Login, Password, Role, FIO)
VALUES ('manager', '123', 'manager', 'Иванов Иван Иванович');
INSERT INTO Users (Login, Password, Role, FIO)
VALUES ('client', '123', 'client', 'Самаричева Елена Андреевна');
INSERT INTO Categories (Name)
VALUES ('Электроника');
INSERT INTO Manufacturers (Name)
VALUES ('Apple');
INSERT INTO Manufacturers (Name)
VALUES ('Zara'), ('Bosh'), ('Кофе бук');
INSERT INTO Suppliers (Name)
VALUES ('ООО Поставка');
INSERT INTO Suppliers (Name)
VALUES ('ОАО Одежка'), ('ТехСтрой'), ('ОО Книженция');
INSERT INTO Products
(Name, CategoryID, Description, ManufacturerID, SupplierID, Price, Unit, StockQuantity, Discount)
VALUES
('iPhone 13', 1, 'Смартфон', 1, 1, 100000, 'шт', 10, 10);
INSERT INTO Products (Name, CategoryID, Description, ManufacturerID, SupplierID, Price, Unit, StockQuantity, Discount)
VALUES
('Samsung', 1, 'Телефон', 1, 1, 50000, 'шт', 5, 0),
('Xiaomi', 1, 'Телефон', 1, 1, 30000, 'шт', 0, 20);

INSERT INTO Categories (Name) VALUES
('Одежда'),
('Бытовая техника'),
('Книги');
INSERT INTO Products
(Name, CategoryID, Description, ManufacturerID, SupplierID, Price, Unit, StockQuantity, Discount)
VALUES
('Футболка', 2, 'Хлопковая', 1, 1, 1500, 'шт', 20, 5),
('Стиральная машина', 3, 'Автомат', 1, 1, 30000, 'шт', 3, 10),
('Роман', 4, 'Книга', 1, 1, 500, 'шт', 15, 0);

-- Заказ 1 (статус "Новый", дата заказа вчера, дата выдачи завтра)
INSERT INTO Orders (UserID, Status, DeliveryAddress, OrderDate, IssueDate)
VALUES (1, 'Новый', 'Москва, ул. Тверская, д.1', CURDATE() - 1, CURDATE() + 1);

-- Заказ 2 (статус "В обработке", адрес другой)
INSERT INTO Orders (UserID, Status, DeliveryAddress, OrderDate, IssueDate)
VALUES (1, 'В обработке', 'СПб, Невский пр., д.10', CURDATE(), CURDATE() + 3);

-- Заказ 3 (статус "Выдан", дата выдачи уже прошла)
INSERT INTO Orders (UserID, Status, DeliveryAddress, OrderDate, IssueDate)
VALUES (2, 'Выдан', 'Казань, ул. Баумана, д.5', CURDATE() - 5, CURDATE() - 2);

-- Например, в заказе 1 есть 2 единицы товара productID=1 (iPhone)
INSERT INTO OrderItems (OrderID, ProductID, Quantity) VALUES (1, 1, 2);
-- Заказ 2: товар ID=2 (Samsung) в количестве 1
INSERT INTO OrderItems (OrderID, ProductID, Quantity) VALUES (2, 2, 1);



SELECT role, FIO from users where login LIKE "manager" and password LIKE "123";

SELECT * from Suppliers ;
 SELECT p.ProductID, p.Name, c.Name, p.Description,
       m.Name, s.Name, p.Price,
       p.Unit, p.StockQuantity,
       p.Discount, p.ImagePath
            FROM Products p
            JOIN Categories c ON p.CategoryID = c.CategoryID
            JOIN Manufacturers m ON p.ManufacturerID = m.ManufacturerID
            JOIN Suppliers s ON p.SupplierID = s.SupplierID
            where p.Name = "" and p.SupplierID = 4;

SELECT p.ProductID, p.Name, c.Name, p.Description,
        m.Name, s.Name, p.Price,
        p.Unit, p.StockQuantity,
        p.Discount, p.ImagePath
            FROM Products p
            JOIN Categories c ON p.CategoryID = c.CategoryID
            JOIN Manufacturers m ON p.ManufacturerID = m.ManufacturerID
            JOIN Suppliers s ON p.SupplierID = s.SupplierID
        WHERE p.Name LIKE "%%"
        ORDER BY p.Price ASC ;
SELECT * from Products;


UPDATE Products SET
Name = "a", CategoryID = 2, Description = "s",ManufacturerID = 2, SupplierID = 3,Price = 1000, Unit="kg", Discount=13, ImagePath="s" WHERE ProductID = 3;