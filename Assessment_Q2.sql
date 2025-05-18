-- Transaction Frequency Analysis 
WITH customer_transaction_freq AS (
    SELECT
        owner_id,                                                          
        
        -- Calculating average monthly transaction frequency for each customer
        -- by dividing total successful transactions by the number of unique active months
        COUNT(*) / COUNT(DISTINCT DATE_FORMAT(transaction_date, '%Y-%m')) AS avg_transactions_per_month,
        
        -- Categorizing customers based on their transaction frequency
        CASE
            WHEN COUNT(*) / COUNT(DISTINCT DATE_FORMAT(transaction_date, '%Y-%m')) >= 10 THEN 'High Frequency'
            WHEN COUNT(*) / COUNT(DISTINCT DATE_FORMAT(transaction_date, '%Y-%m')) BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM 
        savings_savingsaccount                              
    WHERE 
        transaction_status = 'success'                      
    GROUP BY 
        owner_id                                            
)

SELECT
    frequency_category,                                    
    COUNT(*) AS customer_count,                             
    ROUND(AVG(avg_transactions_per_month), 1) AS avg_transactions_per_month
FROM 
    ccustomer_transaction_freq                                       
GROUP BY 
    frequency_category                                      
ORDER BY 
    FIELD(frequency_category, 'High Frequency', 'Medium Frequency', 'Low Frequency');