-- Explore the Schema
USE chinook;

SHOW TABLES;

DESCRIBE customer;

-- Verify Customer → Invoice relationship
SELECT
    customer.CustomerId,
    customer.FirstName,
    customer.LastName,
    invoice.InvoiceId,
    invoice.InvoiceDate,
    invoice.Total
FROM customer
INNER JOIN invoice
    ON customer.CustomerId = invoice.CustomerId
LIMIT 10;

-- Core SQL: SELECT,WHERE,ORDERBY.....
SELECT
    CustomerId,
    FirstName,
    LastName,
    Country
FROM customer
WHERE Country = 'USA'
ORDER BY LastName DESC;

-- GROUP BY + COUNT
SELECT * FROM customer;

SELECT
    Country,
    COUNT(*) AS CustomerCount
FROM customer
GROUP BY Country
ORDER BY CustomerCount DESC;

-- Aggregates
SELECT * FROM invoice;

SELECT SUM(Total) AS TotalRevenue
FROM invoice;

SELECT AVG(Total) AS AvgRevenue
FROM invoice;

-- GROUP BY + SUM()
SELECT * FROM Invoice;

SELECT
    BillingCountry,
    SUM(Total) AS TotalRevenue
FROM Invoice
GROUP BY BillingCountry
ORDER BY TotalRevenue DESC;

-- Having
SELECT
    BillingCountry,
    SUM(Total) AS TotalRevenue
FROM Invoice
GROUP BY BillingCountry
HAVING SUM(Total) > 40
ORDER BY TotalRevenue DESC;

-- All Core SQL Values
SELECT
    BillingCountry,
    SUM(Total) AS TotalRevenue
FROM Invoice
WHERE Total > 5
GROUP BY BillingCountry
HAVING SUM(Total) > 20
ORDER BY TotalRevenue DESC;

-- JOINS
SELECT
    Customer.CustomerId,
    Customer.FirstName,
    Customer.LastName,
    SUM(Invoice.Total) AS TotalSpent
FROM Customer
INNER JOIN Invoice
    ON Customer.CustomerId = Invoice.CustomerId
GROUP BY Customer.CustomerId
HAVING SUM(Invoice.Total) > 40
ORDER BY TotalSpent DESC;


-- COALESCE() - Changes null to 0
SELECT
    Customer.CustomerId,
    Customer.FirstName,
    Customer.LastName,
    COALESCE(SUM(Invoice.Total), 0) AS TotalSpent
FROM Customer
LEFT JOIN Invoice
    ON Customer.CustomerId = Invoice.CustomerId
GROUP BY Customer.CustomerId
ORDER BY TotalSpent DESC;

-- Join 3 tables
SELECT
    Customer.FirstName,
    Customer.LastName,
    Invoice.InvoiceId,
    InvoiceLine.TrackId,
    InvoiceLine.Quantity,
    InvoiceLine.UnitPrice,
    InvoiceLine.Quantity * InvoiceLine.UnitPrice AS LineTotal
FROM Customer
INNER JOIN Invoice
    ON Customer.CustomerId = Invoice.CustomerId
INNER JOIN InvoiceLine
    ON Invoice.InvoiceId = InvoiceLine.InvoiceId
ORDER BY LineTotal DESC;

-- SUBQUERIES
SELECT
    CustomerId,
    FirstName,
    LastName,
    Country
FROM Customer
WHERE CustomerId IN (
    SELECT CustomerId
    FROM Invoice
    WHERE BillingCountry = 'USA'
)
ORDER BY LastName;

SELECT
    InvoiceId,
    CustomerId,
    Total
FROM Invoice
WHERE Total = (
    SELECT MAX(Total)
    FROM Invoice
);

-- ROW_NUMBER()
SELECT
    InvoiceId,
    CustomerId,
    Total,
    ROW_NUMBER() OVER (
        ORDER BY Total DESC
    ) AS InvoiceRank
FROM Invoice;

-- RANK
SELECT
    InvoiceId,
    CustomerId,
    Total,
    RANK() OVER (
        ORDER BY Total DESC
    ) AS InvoiceRank
FROM Invoice;

-- PARTITION BY
SELECT
    InvoiceId,
    CustomerId,
    Total,
    ROW_NUMBER() OVER (
        PARTITION BY CustomerId
        ORDER BY Total DESC
    ) AS CustomerInvoiceRank
FROM Invoice;


-- RANK + PARTITION BY
SELECT
    InvoiceId,
    CustomerId,
    Total,
    RANK() OVER (
        PARTITION BY CustomerId
        ORDER BY Total DESC
    ) AS CustomerInvoiceRank
FROM Invoice;

-- ROW_NUMBER + PARTITION BY
SELECT
    InvoiceId,
    CustomerId,
    Total,
    ROW_NUMBER() OVER (
        PARTITION BY CustomerId
        ORDER BY Total DESC
    ) AS CustomerInvoiceRank
FROM Invoice;

-- END!!!!!!!!