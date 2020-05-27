daas-multinode-cookbook Cookbook
================================
TODO: This cookbook is used to setup DaaS Multinode with minimum 6 Hosts.


Requirements
------------
1. All the hosts are password less authenticated.
2. There is a common NFS share across the hosts to access the files.
3. There is a hosts file which keeps track of the hosts and their invidual roles

Attributes
----------
Default Attributes:
#Environment Attributes
default['daas_multinode']['download_url'] = "http://slcn09vmf0163.us.oracle.com/bigfiles/bluekai/techstacks/"
default['daas_multinode']['nfs-path'] = "/misc/common_multinode/"
default['daas_multinode']['tmp_dir'] = "/misc/common_multinode/tmp"
default['daas_multinode']['autowork'] = "/misc/common_multinode/work"

#DB Attributes
default['daas_multinode']['base_dir'] = "/misc/common_multinode/"
default['daas_multinode']['java_bin'] = "/misc/common_multinode/install_jdk/jre/bin/java"
default['daas_multinode']['ora_rpm'] = "oracle-rdbms-server-11gR2-preinstall"
default['daas_multinode']['oradb_media'] = "11.2.0.4_database.tgz"
default['daas_multinode']['oradb_tar'] = "11.2.0.4_database.tar"
default['daas_multinode']['yum_proxy'] = "http://www-proxy.us.oracle.com:80"
default['daas_multinode']['java_home'] = "/misc/common_multinode/install_jdk"
default['daas_multinode']['ora_home'] = "/misc/common_multinode/work/app/oracle/dbhome1"
default['daas_multinode']['installer_path'] = "/misc/common_multinode/tmp/database/Disk1"
default['daas_multinode']['ora_base'] = "/misc/common_multinode/work/app/oracle"
default['daas_multinode']['oraInventory'] = "/misc/common_multinode/work/app/oracle/oraInventory"
default['daas_multinode']['oradata_path'] = "/misc/common_multinode/work/app/oracle/oradata"
default['daas_multinode']['sid'] = "orcl"
default['daas_multinode']['global_dbname'] = "orcl.us.oracle.com"
default['daas_multinode']['response_file_path'] = "/misc/common_multinode/tmp/db_install.rsp"
default['daas_multinode']['syspasswd'] = "welcome1"
default['daas_multinode']['ora_port'] = "1521"
default['daas_multinode']['ora_lock'] = "/var/lock/subsys/oracle"
default['daas_multinode']['ora_env'] = {'ORACLE_BASE' => node[:daas_multinode][:ora_base],
                                        'ORACLE_HOME' => node[:daas_multinode][:ora_home],
                                        'ORACLE_SID' => node[:daas_multinode][:sid],
                                        'TMP' => "#{node[:daas_multinode][:tmp_dir]}/oratemp",
                                        'TEMP' => "#{node[:daas_multinode][:tmp_dir]}/oratemp",
                                        'TEMPDIR' => "#{node[:daas_multinode][:tmp_dir]}/oratemp",
                                        'PATH' => "#{node[:daas_multinode][:java_home]}/jre/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:#{node[:daas_multinode][:ora_home]}/bin"}
default[:daas_multinode][:path] = "#{node[:daas_multinode][:java_home]}/jre/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:#{node[:daas_multinode][:ora_home]}/bin"
default['daas_multinode']['current_version'] = ""
default['daas_multinode']['latest_version'] = "11.2.0.4"
default['daas_multinode']['is_installed'] = false


Usage
-----
1. makeconf.rb : This recipe takes care of creating pyconf/conf_22.py and pyconf/pwds_22.py property files.
2. installdb.rb: This recipe takes care of installing oracle db 11gR2.
3. createschema.rb :  This recipe takes care of creating tables and schema required for DaaS.
4. daaslwls.rb : This recipe installs daaswlsadmin, daaswlsmanaged, daasprovwlsadmin, daasprovwlsmanaged
5. edq73wls.rb : This recipe installs edq73admin, edq73rtwlsmanaged, edq73batchdataloadwlsmanaged, edq73batchwlsmanaged
6. edq79wls.rb: This recipe installs edq79wlsadmin, edq79wlsav
7. solr-zookeeper.rb: This recipe installs SolrZookeper and SolrNode
8. omcsetup.rb: This recipe creates tables and schema for OMC and installs Admin/Managed server.
9. setupohs.rb:  This recipe sets up OHS for daas,daasprov and edq73 [ In future for omc as well will be supported ]


License and Authors
-------------------
Authors: TODO: Sidharth Mohapatra (siddharth.mohapatra@oracle.com)
