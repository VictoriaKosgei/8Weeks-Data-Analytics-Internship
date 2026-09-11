-- 1. Which customer generated the most revenue?
SELECT Customer.CustomerId,
	   Customer.FirstName,
       Customer.LastName,
       SUM(Invoice.Total) AS TotalRevenue
FROM Customer 
INNER JOIN Invoice
ON Customer.CustomerId = Invoice.CustomerId
GROUP BY CustomerId
ORDER BY TotalRevenue
LIMIT 10;

-- 2. Top 10 Tracks by Revenue (InvoiceLine-Track)
SELECT Track.TrackId,
       Track.Name AS TrackName,
       SUM(InvoiceLine.Quantity * InvoiceLine.UnitPrice) AS TotalRevenue
FROM Track
INNER JOIN InvoiceLine
ON Track.TrackId = InvoiceLine.TrackId
GROUP BY TrackId
ORDER BY TotalRevenue DESC
LIMIT 10;

-- 3. Top 10 Artist by Revenue (Artist-Album-Track-InvoiceLine)
SELECT Artist.ArtistId,
       Artist.Name,
       SUM(InvoiceLine.Quantity * InvoiceLine.UnitPrice) AS TotalRevenue
FROM Artist
INNER JOIN Album
ON Artist.ArtistId = Album.ArtistId
INNER JOIN Track
ON Album.AlbumId = Track.AlbumId
INNER JOIN InvoiceLine
ON Track.TrackId = InvoiceLine.TrackId
GROUP BY Artist.ArtistId
ORDER BY TotalRevenue DESC
LIMIT 10;

-- 4. Revenue by Country
SELECT
    BillingCountry,
    SUM(Total) AS TotalRevenue
FROM Invoice
GROUP BY BillingCountry
ORDER BY TotalRevenue DESC;

-- 5.Avg invoice ny Country
SELECT
    BillingCountry,
    AVG(Total) AS AverageInvoiceValue
FROM Invoice
GROUP BY BillingCountry
ORDER BY AverageInvoiceValue DESC;
       
-- 6.Monthly Revenue Trend  
SELECT YEAR(InvoiceDate) AS Year,
	   MONTH(InvoiceDate) AS Month,
       SUM(Total) As TotalRevenue
FROM invoice
GROUP BY YEAR(InvoiceDate),
		 MONTH(InvoiceDate)	
ORDER BY Year,
		 Month;

-- 7. Top GENRE by Revenue  (Gernre-Track-InvoiceLine)
SELECT Genre.GenreId,
       Genre.Name,
       SUM(InvoiceLine.Quantity * InvoiceLine.UnitPrice) AS TotalRevenue
FROM Genre
INNER JOIN Track
ON Genre.GenreId = Track.GenreId
INNER JOIN InvoiceLine 
ON Track.TrackId = InvoiceLine.TrackId
GROUP BY Genre.GenreId
ORDER BY TotalRevenue DESC
LIMIT 10;

-- 8.Top Customers by Purchase Frequency (Customer-Invoice)
SELECT
    Customer.CustomerId,
    Customer.FirstName,
    Customer.LastName,
    COUNT(Invoice.InvoiceId) AS NumberOfPurchases,
    SUM(Invoice.Total) AS TotalSpent,
    AVG(Invoice.Total) AS AveragePurchase
FROM Customer
INNER JOIN Invoice
    ON Customer.CustomerId = Invoice.CustomerId
GROUP BY Customer.CustomerId
ORDER BY TotalSpent DESC
Limit 10;

-- END!!!!!!!!!!!!!!

