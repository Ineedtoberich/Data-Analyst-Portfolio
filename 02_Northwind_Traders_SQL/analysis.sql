/* PROJECT: Northwind Traders Data Analysis
   GOAL: Identify purchasing trends, top markets, and high-value customers.
*/

-- 1. Top Performing Markets (Highlighting Germany)
-- Resume Point: "Identified top-performing markets (e.g., Germany)"
SELECT 
    c.Country, 
    ROUND(SUM(od.UnitPrice * od.Quantity), 2) AS Total_Sales,
    COUNT(DISTINCT o.OrderID) AS Total_Orders
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY c.Country
ORDER BY Total_Sales DESC;

-- 2. Ranking High-Value Customers
-- Resume Point: "Ranked high-value customers by volume"
SELECT 
    c.CompanyName, 
    c.Country,
    COUNT(o.OrderID) AS Order_Volume,
    SUM(od.UnitPrice * od.Quantity) AS Total_Spend
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY c.CompanyName, c.Country
HAVING COUNT(o.OrderID) > 5 -- Filtering for frequent buyers
ORDER BY Total_Spend DESC;

-- 3. Product Performance (Using Aggregate Functions)
-- Resume Point: "Executed complex SQL queries using Aggregate Functions"
SELECT 
    p.ProductName,
    SUM(od.Quantity) AS Total_Units_Sold,
    AVG(od.UnitPrice) AS Avg_Selling_Price
FROM Products p
INNER JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY Total_Units_Sold DESC;
