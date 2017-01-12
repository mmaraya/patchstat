/*
 * Copyright (c) 2017 Mike Maraya <mike[dot]maraya[at]gmail[dot]com>
 * All rights reserved.
 *
 * This file is subject to the terms and conditions defined in
 * https://github.com/mmaraya/patchstat/blob/master/LICENSE,
 * which is part of this software package.
 *
 */

-- create tables
CREATE TABLE "network" ( `id` INTEGER NOT NULL UNIQUE, `network_name` TEXT NOT NULL UNIQUE, PRIMARY KEY(`id`) );
CREATE TABLE "scan" ( `id` INTEGER NOT NULL UNIQUE, `network_id` INTEGER NOT NULL, `scan_date` TEXT NOT NULL, PRIMARY KEY(`id`) );
CREATE TABLE "host" ( `id` INTEGER NOT NULL UNIQUE, `ip_address` TEXT NOT NULL UNIQUE, PRIMARY KEY(`id`) );
CREATE TABLE "vulnerability" ( `id` INTEGER NOT NULL UNIQUE, `severity` TEXT NOT NULL, `cve` TEXT, `cvss` NUMERIC, PRIMARY KEY(`id`) );
CREATE TABLE "scan_result" ( `scan_id` INTEGER NOT NULL, `host_id` INTEGER NOT NULL, `vulnerability_id` INTEGER NOT NULL, PRIMARY KEY(`scan_id`,`host_id`,`vulnerability_id`) );

-- scan summary
CREATE VIEW scan_summary AS
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
  GROUP BY  network_name, scan_date, severity
  ORDER BY  network, scan_date;

-- count all vulnerabilities by severity
CREATE VIEW vulnerabilities_all AS
    SELECT  severity, count(*) AS vulns FROM 
    (
      SELECT  host_id
             ,vulnerability_id
             ,severity
        FROM  scan_result
             ,vulnerability
       WHERE  scan_result.vulnerability_id = vulnerability.id
    GROUP BY  host_id, vulnerability_id
    )
GROUP BY severity;

-- count current vulnerabilities by severity
CREATE VIEW vulnerabilities_current AS
  SELECT  vulnerability.severity
         ,count(*) AS vulns
    FROM  scan 
         ,scan_result
         ,vulnerability
   WHERE  scan_result.scan_id = scan.id
     AND  vulnerability.id = scan_result.vulnerability_id
     AND  scan.id = (SELECT id FROM scan ORDER BY scan_date DESC LIMIT 1)
GROUP BY  severity;

-- count vulnerabilities remediated by severity
CREATE VIEW vulnerabilities_remediated AS
    SELECT  A.severity
           ,A.vulns - COALESCE(B.vulns, 0) AS remediated
      FROM  vulnerabilities_all A LEFT JOIN vulnerabilities_current B 
        ON (A.severity = B.severity);
