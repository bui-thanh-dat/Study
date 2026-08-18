-- cach 1: JOIN 
SELECT c.company_code,
        c.founder, 
        COUNT(DISTINCT lm.lead_manager_code),
        COUNT(DISTINCT sm.senior_manager_code),
        COUNT(DISTINCT m.manager_code),
        COUNT(DISTINCT e.employee_code)
FROM Company c 
JOIN Lead_Manager lm ON lm.company_code = c.company_code
JOIN Senior_Manager sm ON sm.company_code = c.company_code
JOIN Manager        m  ON m.company_code  = c.company_code
JOIN Employee       e  ON e.company_code  = c.company_code

GROUP BY c.company_code,
        c.founder
        
ORDER BY c.company_code;

-- cách 2 : UNION 

SELECT c.company_code,
		c.founder, 
        COUNT(CASE WHEN t.lvl = 'LM' THEN 1 END ),
        COUNT(CASE WHEN t.lvl = 'SM' THEN 1 END ),
        COUNT(CASE WHEN t.lvl = 'M' THEN 1 END ),
        COUNT(CASE WHEN t.lvl = 'E' THEN 1 END )
FROM Company c 
JOIN (
	SELECT company_code, 'LM' AS lvl, lead_manager_code 	AS code FROM Lead_Manager
    UNION 
    SELECT company_code, 'SM' 		 , senior_manager_code  		FROM Senior_Manager 
	UNION 
    SELECT company_code, 'M' 		 , manager_code 		   		FROM Manager 
    UNION 
    SELECT company_code, 'E' 		 , employee_code 				FROM Employee 
) t 
departmentsON t.company_code = c.company_code

GROUP BY c.company_code,
		c.founder
ORDER BY c.company_code;

