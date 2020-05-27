#Environment Attributes
default['daas_b2bx']['download_url'] = "http://slcn09vmf0163.us.oracle.com/bigfiles/bluekai/techstacks/"
default['daas_b2bx']['nfs-path'] = "/u01/work/"
default['daas_b2bx']['tmp_dir'] = "/u01/work/tmp"
default['daas_b2bx']['autowork'] = "/u01/work"

#DB Attributes
default['daas_b2bx']['base_dir'] = "/u01/work/"
default['daas_b2bx']['java_bin'] = "/u01/install_jdk/jre/bin/java"
default['daas_b2bx']['ora_rpm'] = "oracle-rdbms-server-11gR2-preinstall"
default['daas_b2bx']['oradb_media'] = "11.2.0.4_database.tgz"
default['daas_b2bx']['oradb_tar'] = "11.2.0.4_database.tar"
default['daas_b2bx']['yum_proxy'] = "http://www-proxy.us.oracle.com:80"
default['daas_b2bx']['java_home'] = "/u01/work/install_jdk"
default['daas_b2bx']['ora_home'] = "/u01/work/app/oracle/dbhome1"
default['daas_b2bx']['installer_path'] = "/u01/work/tmp/database/Disk1"
default['daas_b2bx']['ora_base'] = "/u01/work/app/oracle"
default['daas_b2bx']['oraInventory'] = "/u01/work/app/oracle/oraInventory"
default['daas_b2bx']['oradata_path'] = "/u01/work/app/oracle/oradata"
default['daas_b2bx']['sid'] = "orcl"
default['daas_b2bx']['global_dbname'] = "orcl.us.oracle.com"
default['daas_b2bx']['response_file_path'] = "/u01/work/tmp/db_install.rsp"
default['daas_b2bx']['syspasswd'] = "welcome1"
default['daas_b2bx']['ora_port'] = "1521"
default['daas_b2bx']['ora_lock'] = "/var/lock/subsys/oracle"
default['daas_b2bx']['ora_env'] = {'ORACLE_BASE' => node[:daas_b2bx][:ora_base],
                                        'ORACLE_HOME' => node[:daas_b2bx][:ora_home],
                                        'ORACLE_SID' => node[:daas_b2bx][:sid],
					'TMP' => "#{node[:daas_b2bx][:tmp_dir]}/oratemp",
					'TEMP' => "#{node[:daas_b2bx][:tmp_dir]}/oratemp",
					'TEMPDIR' => "#{node[:daas_b2bx][:tmp_dir]}/oratemp",
                                        'PATH' => "#{node[:daas_b2bx][:java_home]}/jre/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:#{node[:daas_b2bx][:ora_home]}/bin"}
default[:daas_b2bx][:path] = "#{node[:daas_b2bx][:java_home]}/jre/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:#{node[:daas_b2bx][:ora_home]}/bin"
default['daas_b2bx']['current_version'] = "" 
default['daas_b2bx']['latest_version'] = "11.2.0.4"
default['daas_b2bx']['is_installed'] = false

#update from pyscript
default['daas_b2bx']['daas_zip'] = "http://artifactory-slc.oraclecorp.com/artifactory/daas-release-local/com/oracle/opc/definition/daas/17.1.3-201612141201/daas-17.1.3-201612141201.zip"
