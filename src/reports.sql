-- count all current and past vulnerabilities by severity
SELECT network_name, severity, vulns FROM
(
    SELECT  network.network_name
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
  SELECT  network.network_name
         ,vulnerability.severity
         ,count(*) AS vulns
    FROM  scan 
         ,scan_result
         ,network
         ,vulnerability
   WHERE  scan_result.scan_id = scan.id
     AND  network.id = scan.network_id
     AND  vulnerability.id = scan_result.vulnerability_id
     AND  scan.id = (SELECT MAX(id) FROM scan)
GROUP BY network_name, severity;

