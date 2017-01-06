SELECT Host, PluginID, Risk, CVE, CVSS from data_20161231 where Risk in ('Low', 'Medium', 'High', 'Critical');
SELECT DISTINCT NULL, Host from data_20161231 where Risk in ('Low', 'Medium', 'High', 'Critical') and host not in (select ip_address from host);
DELETE FROM host;
INSERT INTO host SELECT DISTINCT null, Host from data_20161231 where Risk in ('Low', 'Medium', 'High', 'Critical') and host not in (select ip_address from host);
INSERT OR REPLACE INTO vulnerability SELECT PluginID, Risk, CVE, CVSS from data_20161231 where Risk in ('Low', 'Medium', 'High', 'Critical');

-- create scan_result entries
INSERT OR REPLACE INTO scan_result 
SELECT scan.id AS scan_id,
       host.id AS host_id, 
       vulnerability.id AS vulnerability_id 
  FROM data_20161231, 
       scan,
       host, 
       vulnerability 
 WHERE host.ip_address = data_20161231.host
   AND vulnerability.id = data_20161231.PluginID
   AND scan.network_id = 1
   AND scan.scan_date = "20161231"

-- hosts with vulnerabilities
SELECT network.network_name, 
       scan.scan_date,
       host.ip_address,
       scan_result.vulnerability_id, 
       vulnerability.severity
  FROM scan_result,
       scan,
       network,
       host,
       vulnerability
 WHERE host.id = scan_result.host_id
   AND scan_result.scan_id = scan.id
   AND network.id = scan.network_id
   AND vulnerability.id = scan_result.vulnerability_id

-- summary report
SELECT network.network_name,
       scan.scan_date,
       vulnerability.severity,
       count(*)
  FROM scan_result,
       scan,
       network,
       vulnerability
 WHERE scan_result.scan_id = scan.id
   AND network.id = scan.network_id
   AND vulnerability.id = scan_result.vulnerability_id
GROUP BY severity

-- load 1/3/17 data
INSERT INTO scan SELECT null, network.id, '20170103' FROM network WHERE network_name = 'home'
INSERT INTO host SELECT DISTINCT null, Host from data_20170103 where Risk in ('Low', 'Medium', 'High', 'Critical') and host not in (select ip_address from host);
INSERT OR REPLACE INTO vulnerability SELECT PluginID, Risk, CVE, CVSS from data_20170103 where Risk in ('Low', 'Medium', 'High', 'Critical')
INSERT OR REPLACE INTO scan_result 
SELECT scan.id AS scan_id,
       host.id AS host_id, 
       vulnerability.id AS vulnerability_id 
  FROM data_20170103 AS data, 
       scan,
       host, 
       network, 
       vulnerability 
 WHERE host.ip_address = data.host
   AND vulnerability.id = data.PluginID
   AND scan.network_id = network.id 
   AND scan.scan_date = "20170103"
   AND network.network_name = "home"


