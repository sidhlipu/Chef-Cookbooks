#Default attributes for all the cookbooks

default['revrec-cookbook']['download_url'] = "http://slcn09vmf0163.us.oracle.com/bigfiles/bluekai/techstacks/"






default['revrec_env']['base_dir'] = "/opt"
default['revrec_env']['oracle_home'] = "/home/oracle"
default['revrec_env']['oracle_shell'] = "/bin/bash"
default['revrec_env']['tmp_dir'] = "/opt/tmp"
default['revrec_env']['java_home'] = "/opt/install_jdk/"
default['revrec_env']['java_bin'] = "/opt/install_jdk/jre/bin/java"
default['revrec_env']['ora_rpm'] = "oracle-rdbms-server-11gR2-preinstall"
default['revrec_env']['oradb_media'] = "11.2.0.4_database.tgz"
default['revrec_env']['oradb_tar'] = "11.2.0.4_database.tar"
default['revrec_env']['jdk_file'] = "jdk-8u91-linux-x64.tar.gz"
default['revrec_env']['jdk_tar'] = "/opt/tmp/jdk-8u91-linux-x64.tar"
default['revrec_env']['yum_proxy'] = "http://www-proxy.us.oracle.com:80"

default['deploy_aolite']['aolite_home'] = "#{node[:revrec_env][:base_dir]}/jobs/audienceon-lite"
default['deploy_aolite']['aolite_home_parent'] = "#{node[:revrec_env][:base_dir]}/jobs"
default['deploy_aolite']['aolite_tar_gz'] = "audienceon-lite-2.0-dist.tar.gz"
default['deploy_aolite']['aolite_tar'] = "audienceon-lite-2.0-dist.tar"


#
##
##Oracle DB installation related attributes
##
#


default['install_oradb']['ora_home'] = "/opt/oracle/dbhome1"
default['install_oradb']['installer_path'] = "/opt/tmp/database/Disk1"
default['install_oradb']['ora_base'] = "/opt/oracle"
default['install_oradb']['oraInventory'] = "/opt/oracle/oraInventory"
default['install_oradb']['oradata_path'] = "/opt/oracle/oradata"
default['install_oradb']['sid'] = "orcl"
default['install_oradb']['global_dbname'] = "orcl.us.oracle.com"
default['install_oradb']['response_file_path'] = "/opt/tmp/db_install.rsp"
default['install_oradb']['syspasswd'] = "Welcome1"

default['install_oradb']['ora_port'] = "1521"
default['install_oradb']['ora_lock'] = "/var/lock/subsys/oracle"

default['install_oradb']['ora_env'] = {'ORACLE_BASE' => node[:install_oradb][:ora_base],
                                        'ORACLE_HOME' => node[:install_oradb][:ora_home],
                                        'ORACLE_SID' => node[:install_oradb][:sid],
					'TMP' => "#{node[:revrec_env][:tmp_dir]}/oratemp",
					'TEMP' => "#{node[:revrec_env][:tmp_dir]}/oratemp",
					'TEMPDIR' => "#{node[:revrec_env][:tmp_dir]}/oratemp",
                                        'PATH' => "#{node[:revrec_env][:java_home]}/jre/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:#{node[:install_oradb][:ora_home]}/bin"}

default[:install_oradb][:path] = "#{node[:revrec_env][:java_home]}/jre/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:#{node[:install_oradb][:ora_home]}/bin"
default['install_oradb']['current_version'] = "" 
default['install_oradb']['latest_version'] = "11.2.0.4"
default['install_oradb']['is_installed'] = false
default['install_oradb']['patch_installed'] = false
default['install_oradb']['sql_remote_template'] = "http://slcn09vmf0163.us.oracle.com/bigfiles/bluekai/techstacks/templates/1_exptables.sql"
default['install_oradb']['sql_local_template'] = "#{node[:revrec_env][:tmp_dir]}/1_exptables.sql"
default['install_oradb']['oradb_running'] = false

#
##
##Install WLS
#
#a
##
default['install_wls']['version'] = "10.3"
default['install_wls']['bea_home'] = "/opt/weblogic/middleware"
default['install_wls']['installdir'] = "/opt/weblogic/middleware/wls"
default['install_wls']['local_jvm'] = "/opt/install_jdk"
default['install_wls']['extract_location'] = "/opt/tmp"
default['install_wls']['wlsjarFile'] = "wls1036_generic.jar"
default['install_wls']['is_installed'] = false
default['install_wls']['Admin_Running'] = false
default['install_wls']['Managed_Running'] = false

##
###
### Install ODI related attributes
##
##

default['install_odi']['odi_ora_home'] = "#{node[:install_wls][:bea_home]}/odi"
default['install_odi']['odi_tablespace'] = "DAAS_B2BX"
default['install_odi']['odi_temp_tablespace'] = "DAAS_B2BX_TEMPD"
default['install_odi']['odi_media1'] = "ofm_odi_generic_11.1.1.9.0_disk1_1of2.zip"
default['install_odi']['odi_media2'] = "ofm_odi_generic_11.1.1.9.0_disk1_2of2.zip"
default['install_odi']['odi_rcu_media1'] = "ofm_rcu_linux_11.1.1.9.0_64_disk1_1of1.zip"
default['install_odi']['is_installed'] = false

#
##
##Oracle NoSQL installation related attributes
##
#


default['install_nosql']['project_dir'] = "#{node[:revrec_env][:base_dir]}/RosettaStone"
default['install_nosql']['kvhome'] = "#{node[:install_nosql][:project_dir]}/KVHOME"
default['install_nosql']['kvroot'] = "#{node[:install_nosql][:project_dir]}/KVROOT"
default['install_nosql']['kvdata'] = "#{node[:install_nosql][:project_dir]}/kvdata"
default['install_nosql']['nosql_media'] = "kv-ee-3.5.2.tar.gz"
default['install_nosql']['nosql_tar'] = "kv-ee-3.5.2.tar"
default['install_nosql']['nosql_home'] = "/home/nosql"
default['install_nosql']['nosql_shell'] = "/bin/bash"
default['install_nosql']['nosql_topo'] = "#{node[:revrec_env][:tmp_dir]}/kvstoretopo"
default['install_nosql']['nosql_env'] = {'KVHOME' => node[:install_nosql][:kvhome],
					 'KVROOT' => node[:install_nosql][:kvroot],
					 'KVPATH' => node[:install_nosql][:kvpath],
					 'PATH' => "#{node[:revrec_env][:java_home]}/jre/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin"}

default['install_nosql']['kvstore_jar'] = "#{node[:install_nosql][:kvhome]}/lib/kvstore.jar" 
default['install_nosql']['nosql_lock'] = "/var/lock/subsys/nosql"
default[:install_nosql][:is_installed] = false



#
##
##Oracle RDS installation related attributes
##
#

default['install_ords']['ords_home'] = "#{node[:install_nosql][:project_dir]}/ords"
default['install_ords']['ords_media'] = "ords.3.0.6.176.08.46.zip"
default['install_ords']['ords_env'] = {'KVHOME' => node[:install_nosql][:kvhome],
					 'KVROOT' => node[:install_nosql][:kvroot],
					 'KVPATH' => node[:install_nosql][:kvpath],
					 'PATH' => "#{node[:revrec_env][:java_home]}/jre/bin:/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin"}
