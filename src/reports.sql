-- count all current and past vulnerabilities by severity
SELECT network_name, severity, vulns FROM
(
    SELECT  network.network_name AS network
           ,scan_date
           ,vulnerability.severity
           ,count(*) AS vulns
      FROM  scan        
           ,scan_result
           ,network
           ,vulnerability
     WHERE  scan_result.scan_id = scan.id
       AND  network.id = scan.network_id
       AND  vulnerability.id = scan_result.vulnerability_id
  GROUP BY  network_name, scan_date, severity
  ORDER BY  network_name, scan_date, severity
)
GROUP BY network_name, severity;

-- count all current vulnerabilities by severity
  SELECT  network.network_name AS network
         ,vulnerability.severity
         ,count(*) AS vulns
    FROM  scan 
         ,scan_result
         ,network
         ,vulnerability
   WHERE  scan_result.scan_id = scan.id
     AND  network.id = scan.network_id
     AND  vulnerability.id = scan_result.vulnerability_id
     AND  scan.id = (SELECT id FROM scan ORDER BY scan_date DESC LIMIT 1)
GROUP BY network_name, severity;

-- count all vulnerabilities remediated by severity
  SELECT  A.network_name AS network
         ,A.severity
         ,A.vulns - COALESCE(B.vulns, 0) AS remediated
    FROM  vulnerabilities_all A LEFT JOIN vulnerabilities_current B 
      ON (A.network_name = B.network_name AND A.severity = B.severity);
