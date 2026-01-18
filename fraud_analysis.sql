-- Financial Crime Detection Project
-- Objective: Identify high-risk fraud patterns in 1.2M transaction records.

-- 1. Total Fraud Loss Calculation
-- Result: $3.99 Million identified in total fraud.
SELECT 
    SUM(amt) AS Total_Fraud_Loss,
    COUNT(*) AS Total_Fraud_Transactions
FROM transactions
WHERE is_fraud = 1;

-- 2. Fraud by Category (Identifying the "Attack Vector")
-- Result: 'shopping_net' accounts for the highest loss volume.
SELECT 
    category,
    COUNT(*) AS Number_of_Frauds,
    ROUND(SUM(amt), 2) AS Total_Stolen
FROM transactions
WHERE is_fraud = 1
GROUP BY category
ORDER BY Total_Stolen DESC;

-- 3. Fraud by Geography (Hotspot Analysis)
-- Result: NY and CA are the highest risk states.
SELECT 
    state,
    COUNT(*) AS Fraud_Cases,
    ROUND(SUM(amt), 2) AS Total_Loss
FROM transactions
WHERE is_fraud = 1
GROUP BY state
ORDER BY Total_Loss DESC
LIMIT 5;

-- 4. Hourly Analysis (When does fraud happen?)
-- Analysis of high-risk time windows.
SELECT 
    strftime('%H', trans_date_trans_time) AS Hour_of_Day,
    COUNT(*) AS Fraud_Count
FROM transactions
WHERE is_fraud = 1
GROUP BY Hour_of_Day
ORDER BY Fraud_Count DESC;
