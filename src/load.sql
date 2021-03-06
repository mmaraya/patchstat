/*
 * Copyright (c) 2017 Mike Maraya <mike[dot]maraya[at]gmail[dot]com>
 * All rights reserved.
 *
 * This file is subject to the terms and conditions defined in
 * https://github.com/mmaraya/patchstat/blob/master/LICENSE,
 * which is part of this software package.
 *
 */

-- add network
INSERT INTO network VALUES (null, 'home');

-- load 12/31/16 data
INSERT INTO scan SELECT null, network.id, '20161231' FROM network WHERE network_name = 'home';
INSERT INTO host SELECT DISTINCT null, Host from data_20161231 where Risk in ('Low', 'Medium', 'High', 'Critical') and host not in (select ip_address from host);
INSERT OR REPLACE INTO vulnerability SELECT PluginID, Risk, CVE, CVSS from data_20161231 where Risk in ('Low', 'Medium', 'High', 'Critical');
INSERT OR REPLACE INTO scan_result 
SELECT scan.id AS scan_id,
       host.id AS host_id, 
       vulnerability.id AS vulnerability_id 
  FROM data_20161231 AS data, 
       scan,
       host, 
       network, 
       vulnerability 
 WHERE host.ip_address = data.host
   AND vulnerability.id = data.PluginID
   AND scan.network_id = network.id 
   AND scan.scan_date = "20161231"
   AND network.network_name = "home";

-- load 1/3/17 data
INSERT INTO scan SELECT null, network.id, '20170103' FROM network WHERE network_name = 'home';
INSERT INTO host SELECT DISTINCT null, Host from data_20170103 where Risk in ('Low', 'Medium', 'High', 'Critical') and host not in (select ip_address from host);
INSERT OR REPLACE INTO vulnerability SELECT PluginID, Risk, CVE, CVSS from data_20170103 where Risk in ('Low', 'Medium', 'High', 'Critical');
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
   AND network.network_name = "home";

-- load 1/5/17 data
INSERT INTO scan SELECT null, network.id, '20170105' FROM network WHERE network_name = 'home';
INSERT INTO host SELECT DISTINCT null, Host from data_20170105 where Risk in ('Low', 'Medium', 'High', 'Critical') and host not in (select ip_address from host);
INSERT OR REPLACE INTO vulnerability SELECT PluginID, Risk, CVE, CVSS from data_20170105 where Risk in ('Low', 'Medium', 'High', 'Critical');
INSERT OR REPLACE INTO scan_result 
SELECT scan.id AS scan_id,
       host.id AS host_id, 
       vulnerability.id AS vulnerability_id 
  FROM data_20170105 AS data, 
       scan,
       host, 
       network, 
       vulnerability 
 WHERE host.ip_address = data.host
   AND vulnerability.id = data.PluginID
   AND scan.network_id = network.id 
   AND scan.scan_date = "20170105"
   AND network.network_name = "home";

