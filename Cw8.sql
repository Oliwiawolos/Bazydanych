USE AdventureWorks2022
--Task 1
WITH fb (n, f, fi) AS(
SELECT 1 AS n, CAST(0 AS BIGINT) AS f, CAST(1 AS BIGINT) AS fi
UNION all
SELECT n+1, fi, f + fi FROM fb WHERE n < 93 
)
SELECT n, f FROM fb
OPTION (MAXRECURSION 0); 
GO
--Task 2
CREATE TRIGGER UppperCaseLastNames
ON Person.Person
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE person
    SET person.LastName = UPPER(i.LastName) 
    FROM Person.Person person
    JOIN inserted i ON person.BusinessEntityID = i.BusinessEntityID 
END;
GO
--Task 
CREATE TRIGGER taxRateMonitorings
ON Sales.SalesTaxRate
AFTER UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT *
        FROM inserted i
        JOIN deleted d ON i.SalesTaxRateID = d.SalesTaxRateID 
        WHERE i.TaxRate > 0 AND ABS(i.TaxRate - d.TaxRate) / d.TaxRate > 0.3
    )
    BEGIN
        RAISERROR ('Error: Tax rate change exceeds 30%', 16, 1)
        ROLLBACK TRANSACTION;
    END
END
