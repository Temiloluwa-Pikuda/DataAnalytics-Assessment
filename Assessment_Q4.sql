-- Customer Lifetime Value (CLV) Estimation
SELECT
    u.id AS customer_id,                                        
    CONCAT(u.first_name, ' ', u.last_name) AS name,            
    TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_months,  
    COUNT(s.id) AS total_transactions,                          

    -- Calculating CLV  (transactions per month × 12 months × average profit per transaction)
    ROUND(
        (COUNT(s.id) / NULLIF(TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()), 0)) * 12 * 
        (AVG(s.confirmed_amount) * 0.001),  -- 0.1% profit margin conversion
        2
    ) AS estimated_clv
    
FROM 
    users_customuser u                                          
JOIN 
    savings_savingsaccount s ON s.owner_id = u.id AND s.confirmed_amount > 0
    
-- Filtering out customers with less than 1 month tenure to avoid division by 0
WHERE 
    TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) > 0 AND
    s.transaction_status = 'success'
GROUP BY 
    u.id,
    u.first_name, 
    u.last_name,
    u.date_joined
ORDER BY 
    estimated_clv DESC;