/*
 * Copyright (c) 2016 Mike Maraya <mike[dot]maraya[at]gmail[dot]com>
 * All rights reserved.
 *
 * This file is subject to the terms and conditions defined in
 * https://github.com/mmaraya/patchstat/blob/master/LICENSE,
 * which is part of this software package.
 *
 */

-- count all vulnerabilities by severity
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

-- count current vulnerabilities by severity
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

-- count remediated vulnerabilities by severity
  SELECT  A.network_name AS network
         ,A.severity
         ,A.vulns - COALESCE(B.vulns, 0) AS remediated
    FROM  vulnerabilities_all A LEFT JOIN vulnerabilities_current B 
      ON (A.network_name = B.network_name AND A.severity = B.severity);

-- scan results
  SELECT  network_name AS network
         ,scan_date
         ,severity
         ,count(*) AS vulns
    FROM  scan 
         ,scan_result
         ,network
         ,vulnerability
   WHERE  scan_result.scan_id = scan.id
     AND  network.id = scan.network_id
     AND  vulnerability.id = scan_result.vulnerability_id
GROUP BY  network_name, scan_date, severity;

