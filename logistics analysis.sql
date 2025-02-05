SELECT 
    SUM(`Shipping Cost`) AS Total_Shipping_Cost,
    AVG(`Shipping Cost` / Distance_Miles) AS Avg_Cost_Per_Mile
FROM Logistics;

SELECT 
    Carrier,
    COUNT(*) AS Total_Shipments,
    AVG(`Shipping Cost`) AS Avg_Shipping_Cost,
    AVG(Distance_Miles) AS Avg_Distance
FROM Logistics
GROUP BY Carrier
ORDER BY Avg_Shipping_Cost DESC;

SELECT 
    Cost_Category,
    COUNT(*) AS Shipment_Count,
    SUM(`Shipping Cost`) AS Total_Cost,
    AVG(`Shipping Cost`) AS Avg_Cost
FROM Logistics
GROUP BY Cost_Category
ORDER BY Total_Cost DESC;

SELECT 
    CASE 
        WHEN `Distance_Miles` BETWEEN 150 AND 300 THEN '150-300 miles'
        WHEN `Distance_Miles` BETWEEN 301 AND 600 THEN '301-600 miles'
        WHEN `Distance_Miles` BETWEEN 601 AND 900 THEN '601-900 miles'
        WHEN `Distance_Miles` BETWEEN 901 AND 1200 THEN '901-1200 miles'
        ELSE '1200+ miles'
    END AS Distance_Category,
    COUNT(*) AS Shipment_Count,
    SUM(`Shipping Cost`) AS Total_Cost,
    AVG(`Shipping Cost`) AS Avg_Cost,
    AVG(`Shipping Cost` / Distance_Miles) AS Avg_Cost_Per_Mile
FROM Logistics
GROUP BY Distance_Category
ORDER BY Total_Cost DESC;

SELECT 
    Carrier,
    CASE 
        WHEN `Distance_Miles` BETWEEN 150 AND 300 THEN '150-300 miles'
        WHEN `Distance_Miles` BETWEEN 301 AND 600 THEN '301-600 miles'
        WHEN `Distance_Miles` BETWEEN 601 AND 900 THEN '601-900 miles'
        WHEN `Distance_Miles` BETWEEN 901 AND 1200 THEN '901-1200 miles'
        ELSE '1200+ miles'
    END AS Distance_Category,
    COUNT(*) AS Shipment_Count,
    SUM(`Shipping Cost`) AS Total_Cost,
    AVG(`Shipping Cost`) AS Avg_Cost,
    AVG(`Shipping Cost` / `Distance_Miles`) AS Cost_Per_Mile
FROM Logistics
GROUP BY Carrier, Distance_Category
ORDER BY Distance_Category, Avg_Cost DESC;

SELECT 
    `Order ID`,
    Carrier,
    `Shipping Cost`,
    Distance_Miles
FROM Logistics
WHERE `Shipping Cost` > (SELECT AVG(`Shipping Cost`) FROM Logistics)
ORDER BY `Shipping Cost` DESC
LIMIT 10;


