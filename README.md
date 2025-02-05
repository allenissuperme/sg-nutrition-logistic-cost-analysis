# Logistics Cost Analysis

This repository contains SQL queries for analyzing logistics costs and carrier performance. The analysis helps identify cost-saving opportunities and optimize carrier selection.

## Total Shipping Cost & Average Cost Per Mile

```sql
SELECT 
    SUM(`Shipping Cost`) AS Total_Shipping_Cost,
    AVG(`Shipping Cost` / Distance_Miles) AS Avg_Cost_Per_Mile
FROM Logistics;
```

## Carrier Performance Comparison

```sql
SELECT 
    Carrier,
    COUNT(*) AS Total_Shipments,
    AVG(`Shipping Cost`) AS Avg_Shipping_Cost,
    AVG(Distance_Miles) AS Avg_Distance,
    AVG(`Shipping Cost`)/AVG(Distance_Miles) AS Avg_cost_per_mile
FROM Logistics
GROUP BY Carrier
ORDER BY Avg_Shipping_Cost DESC;
```

### Insights
- Identify carriers with higher-than-average costs.
- Explore savings opportunities by switching to cost-efficient carriers.

## Segmenting Deliveries by Distance

```sql
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
```

### Insights
- **901-1200 miles** shipments are the most expensive.
- **601-900 miles** shipments are significantly cheaper.
- **150-300 miles** shipments are the most affordable; consider regional warehouses to increase shipments in this range.

## Carrier Performance by Distance Segmentation

```sql
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
```

![Alt text](image_url)

### Insights
- **TNT** is the best for short-distance (150-300 miles) shipments.
- Reduce reliance on **USPS and FedEx** for short-distance deliveries.
- **DHL** is cost-effective for 601-900 mile shipments, saving ~$84 per shipment.
- **USPS** is the cheapest for 901-1200 mile shipments.

## Identifying Most Expensive Deliveries

```sql
SELECT 
    `Order ID`,
    Carrier,
    `Shipping Cost`,
    Distance_Miles
FROM Logistics
WHERE `Shipping Cost` > (SELECT AVG(`Shipping Cost`) FROM Logistics)
ORDER BY `Shipping Cost` DESC
LIMIT 10;
```

### Insights
- Identify the top 10 most expensive shipments.
- Negotiate better rates with carriers for recurring high-cost shipments.
