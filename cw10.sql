USE AdventureWorks2022
--1
BEGIN TRANSACTION;
UPDATE Production.Product
SET ListPrice = ListPrice*1.1
WHERE ProductID = 680
COMMIT TRANSACTION;
--2
BEGIN TRANSACTION;
INSERT INTO Production.Product(
      [Name]
      ,[ProductNumber]
      ,[MakeFlag]
      ,[FinishedGoodsFlag]
      ,[Color]
      ,[SafetyStockLevel]
      ,[ReorderPoint]
      ,[StandardCost]
      ,[ListPrice]
      ,[Size]
      ,[SizeUnitMeasureCode]
      ,[WeightUnitMeasureCode]
      ,[Weight]
      ,[DaysToManufacture]
      ,[ProductLine]
      ,[Class]
      ,[Style]
      ,[ProductSubcategoryID]
      ,[ProductModelID]
      ,[SellStartDate]
      ,[SellEndDate]
      ,[DiscontinuedDate]
      ,[rowguid]
      ,[ModifiedDate])
VALUES (
        'Nowy Produkt', 
        'NP-001', 
        1, 
        1, 
        'Czerwony', 
        500, 
        250, 
        100.00, 
        150.00, 
        'M', 
        'CM', 
        'KG', 
        1.00, 
        0, 
        'R', 
        'H', 
        'U', 
        (SELECT TOP 1 ProductSubcategoryID FROM Production.ProductSubcategory), -- przyk³ad uzyskania istniej¹cego ID
        (SELECT TOP 1 ProductModelID FROM Production.ProductModel), 
        GETDATE(), 
        NULL, 
        NULL, 
        NEWID(), 
        GETDATE()
);

COMMIT TRANSACTION;
--3 
BEGIN TRANSACTION;
DELETE FROM Production.Product
WHERE ProductID = 680;
ROLLBACK TRANSACTION;
--4
BEGIN TRANSACTION;
UPDATE Production.Product
SET StandardCost = 1.1*StandardCost

IF(SELECT SUM(StandardCost) FROM Production.Product)>5000
ROLLBACK TRANSACTION
ELSE
COMMIT TRANSACTION
--5
BEGIN TRANSACTION
IF EXISTS(SELECT * FROM sys.indexes WHERE name= 'AK_Product_ProductNumber' AND object_id = OBJECT_ID('Production.Product'))
BEGIN 
DROP INDEX AK_Product_ProductNumber ON Production.Product;
 END
 IF EXISTS(SELECT *FROM Production.Product WHERE ProductNumber = 'Nowy Numer Produktu')
 BEGIN 
 ROLLBACK TRANSACTION
 END
 ELSE
 BEGIN
 INSERT INTO Production.Product(
      [Name]
      ,[ProductNumber]
      ,[MakeFlag]
      ,[FinishedGoodsFlag]
      ,[Color]
      ,[SafetyStockLevel]
      ,[ReorderPoint]
      ,[StandardCost]
      ,[ListPrice]
      ,[Size]
      ,[SizeUnitMeasureCode]
      ,[WeightUnitMeasureCode]
      ,[Weight]
      ,[DaysToManufacture]
      ,[ProductLine]
      ,[Class]
      ,[Style]
      ,[ProductSubcategoryID]
      ,[ProductModelID]
      ,[SellStartDate]
      ,[SellEndDate]
      ,[DiscontinuedDate]
      ,[rowguid]
      ,[ModifiedDate])
VALUES (
        'NowyNumerProduktu', 
        'NP-001', 
        1, 
        1, 
        'Czerwony', 
        500, 
        250, 
        100.00, 
        150.00, 
        'M', 
        'CM', 
        'KG', 
        1.00, 
        0, 
        'R', 
        'H', 
        'U', 
        (SELECT TOP 1 ProductSubcategoryID FROM Production.ProductSubcategory), -- przyk³ad uzyskania istniej¹cego ID
        (SELECT TOP 1 ProductModelID FROM Production.ProductModel), 
        GETDATE(), 
        NULL, 
        NULL, 
        NEWID(), 
        GETDATE()
);

COMMIT TRANSACTION;
END
--6
BEGIN TRANSACTION
IF EXISTS(SELECT*FROM Sales.SalesOrderDetail WHERE OrderQty = 0)
BEGIN
ROLLBACK TRANSACTION
END 
ELSE
BEGIN 
UPDATE Sales.SalesOrderDetail
SET OrderQty=20
COMMIT TRANSACTION 
END
--7
BEGIN TRANSACTION;
DECLARE @AverageCost DECIMAL(18, 2);
SELECT @AverageCost = AVG(StandardCost) FROM Production.Product;
DELETE FROM Production.Product
WHERE StandardCost > @AverageCost;
IF @@ROWCOUNT > 10
BEGIN
 ROLLBACK TRANSACTION;
END
ELSE
BEGIN
    COMMIT TRANSACTION;
END