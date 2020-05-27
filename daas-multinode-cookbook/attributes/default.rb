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


#Host Properties
default['daas_multinode']['primaryhost'] = "slcn09vmf0252.us.oracle.com"
default['daas_multinode']['edq73host'] = "slcn09vmf0253.us.oracle.com"
default['daas_multinode']['edq79host'] = "slcn09vmf0254.us.oracle.com"
default['daas_multinode']['daaswlshost'] = "slcn09vmf0255.us.oracle.com"
default['daas_multinode']['solrzoohost'] = "slcn09vmf0256.us.oracle.com"
default['daas_multinode']['daas_daasdb_hostname'] = "slcn09vmf0252.us.oracle.com"
default['daas_multinode']['daasdaaswlsadmin_postdeploy_sdi_daasapp_baseuri'] = "slcn09vmf0252.us.oracle.com"
default['daas_multinode']['omchost'] = "slcn09vmf0256.us.oracle.com"


#DaaS IDM Properties
default['daas_multinode']['daas_daas_pod_name'] = "maintpod01"
default['daas_multinode']['daasdaaswlsadmin_oid_host'] = "slc08apu.us.oracle.com"
default['daas_multinode']['daas_daas_wlsadmin_username'] = "OCLOUD9_WLS_DATA_MAINTPOD01_APPID"
default['daas_multinode']['daas_prov_wlsadmin_username'] = "OCLOUD9_WLS_DATA_MAINTPOD01_APPID"
default['daas_multinode']['daas_edq73_wlsadmin_username'] = "OCLOUD9_WLS_DATA_MAINTPOD01_APPID"
default['daas_multinode']['daas_daas_wlsnodemanager_username'] = "cn=OCLOUD9_NM_DATA_MAINTPOD01_APPID,cn=ServiceAppIDs,cn=AppIDUsers,cn=Users,cn=maintpod01,cn=Data,orclmttenantguid=59026353090358351,dc=us,dc=oracle,dc=com"
default['daas_multinode']['daas_prov_wlsnodemanager_username'] = "cn=OCLOUD9_NM_DATA_MAINTPOD01_APPID,cn=ServiceAppIDs,cn=AppIDUsers,cn=Users,cn=maintpod01,cn=Data,orclmttenantguid=59026353090358351,dc=us,dc=oracle,dc=com"
default['daas_multinode']['daas_edq73_wlsnodemanager_username'] = "cn=OCLOUD9_NM_DATA_MAINTPOD01_APPID,cn=ServiceAppIDs,cn=AppIDUsers,cn=Users,cn=maintpod01,cn=Data,orclmttenantguid=59026353090358351,dc=us,dc=oracle,dc=com"
default['daas_multinode']['daasdaaswlsadmin_oid_port'] = "3060"
default['daas_multinode']['daasdaaswlsadmin_oid_username'] = "cn=maintpod01_DATASERVICE_IDROUSER,cn=SystemIDs,cn=Users,cn=maintpod01,cn=Data,orclmttenantguid=59026353090358351,dc=us,dc=oracle,dc=com"
default['daas_multinode']['daasdaaswlsadmin_oid_base_dn'] = "cn=Data,orclmttenantguid=59026353090358351,dc=us,dc=oracle,dc=com"
default['daas_multinode']['daasdaaswlsadmin_crosstenant_url'] = "ldap://slc08apu.us.oracle.com:3060"
default['daas_multinode']['daasdaaswlsadmin_crosstenant_username'] = "cn=maintpod01_DATASERVICE_IDROUSER,cn=SystemIDs,cn=Users,cn=maintpod01,cn=Data,orclmttenantguid=59026353090358351,dc=us,dc=oracle,dc=com"
default['daas_multinode']['daasdaaswlsadmin_deploy_daasappid_username'] = "MAINTPOD01_DATASERVICE_API_APPID"
default['daas_multinode']['daasedq73wlsadmin_owsm_role_name'] = "MAINTPOD01_DATASERVICE_API_APPID_ROLE"
default['daas_multinode']['daasdaaswlsadmin_deploy_daasedqws_username'] = "MAINTPOD01_DATASERVICE_API_APPID"
default['daas_multinode']['daasdaaswlsadmin_deploy_daascuratordnb_username'] = "MAINTPOD01_DATASERVICE_CCONSOLE_APPID"
default['daas_multinode']['daasdaaswlsadmin_deploy_daascuratordnb_password'] = "vfjnz_gb1X7uyv"
default['daas_multinode']['daasdaaswlsadmin_reassociate_username'] = "cn=PolicyRWUser,cn=SSUsers,cn=maintpod01,cn=Data,cn=CloudServicesPolicies,cn=OPSS"
default['daas_multinode']['daasdaaswlsadmin_reassociate_jpsroot'] = "cn=maintpod01,cn=Data,cn=CloudServicesPolicies,cn=OPSS"
default['daas_multinode']['daasdaaswlsadmin_reassociate_url'] = "ldap://slc08apu.us.oracle.com:4060"
default['daas_multinode']['daasdaaswlsadmin_crosstenant_base_dn'] = "dc=us,dc=oracle,dc=com"
default['daas_multinode']['daas_daas_wlsadmin_password'] = "cyoig.6kUvuw9l"
default['daas_multinode']['daas_daas_wlsnodemanager_password'] = "dl0dcvbkmo6.Vy"
default['daas_multinode']['daas_edq79_wlsadmin_password'] = "cyoig.6kUvuw9l"
default['daas_multinode']['daas_edq79_wlsnodemanager_password'] = "dl0dcvbkmo6.Vy"
default['daas_multinode']['daas_prov_wlsadmin_password'] = "cyoig.6kUvuw9l"
default['daas_multinode']['daas_prov_wlsnodemanager_password'] = "dl0dcvbkmo6.Vy"
default['daas_multinode']['daas_edq73_wlsadmin_password'] = "cyoig.6kUvuw9l"
default['daas_multinode']['daas_edq73_wlsnodemanager_password'] = "dl0dcvbkmo6.Vy"
default['daas_multinode']['daasdaaswlsadmin_oid_password'] = "Fusionapps1"
default['daas_multinode']['daasdaaswlsadmin_crosstenant_password'] = "Fusionapps1"
default['daas_multinode']['daasdaaswlsadmin_deploy_daasappid_password'] = "vjplJ6wrq.sd5y"
default['daas_multinode']['daasdaaswlsadmin_deploy_daasedqws_password'] = "vjplJ6wrq.sd5y"
default['daas_multinode']['daasdaaswlsadmin_reassociate_password'] = "Fusionapps1"
