SELECT Host, PluginID, Risk, CVE, CVSS from data_20161231 where Risk in ('Low', 'Medium', 'High', 'Critical');
SELECT DISTINCT NULL, Host from data_20161231 where Risk in ('Low', 'Medium', 'High', 'Critical') and host not in (select ip_address from host);
DELETE FROM host;
INSERT INTO host SELECT DISTINCT null, Host from data_20161231 where Risk in ('Low', 'Medium', 'High', 'Critical') and host not in (select ip_address from host);
INSERT OR REPLACE INTO vulnerability SELECT PluginID, Risk, CVE, CVSS from data_20161231 where Risk in ('Low', 'Medium', 'High', 'Critical');
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

