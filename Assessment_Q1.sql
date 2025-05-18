-- High-Value Customers with Multiple Products
SELECT 
    u.id AS owner_id,                                 
    CONCAT(u.first_name, ' ', u.last_name) AS name,    
    
    -- Counting savings plans 
    COUNT(DISTINCT CASE 
        WHEN p.is_regular_savings = 1 THEN p.id        
        END) AS savings_count,
    
    -- Counting investment plans 
    COUNT(DISTINCT CASE 
        WHEN p.is_a_fund = 1 THEN p.id               
        END) AS investment_count,
    
    -- Calculating total deposits and converting from kobo 
    ROUND(SUM(s.confirmed_amount) / 100, 2) AS total_deposits
FROM 
    users_customuser u                                
JOIN 
    plans_plan p ON u.id = p.owner_id                 
JOIN 
    savings_savingsaccount s ON s.plan_id = p.id      
WHERE 
    s.confirmed_amount IS NOT NULL AND
    s.transaction_status = 'success'            
GROUP BY 
    u.id, u.first_name, u.last_name                 
HAVING 
    -- Filtering to only users with at least one savings plan AND at least one investment plan
    savings_count >= 1 AND                           
    investment_count >= 1                            
ORDER BY 
    total_deposits DESC;                         