AUTO_WORK="#{node['daas_multinode']['autowork']}"


daashome="#{node['daas_multinode']['autowork']}/app/daas-ops-home-#{node['daas_multinode']['daas_ver']}"

def Replace(strtofind,strtoreplace)
	conf22="#{AUTO_WORK}/app/pyconf/conf_22.py"
	conf22new="#{AUTO_WORK}/app/pyconf/conf_22.py_new"
        file=File.read(conf22)
        data=file.gsub(/^.*#{Regexp.quote(strtofind)}.*$/, strtoreplace)
        file=File.open(conf22new,"w")
        file.write(data)
        file.close()
        File.rename(conf22new,conf22)
end

Replace("daas_ops_home","daas_ops_home='#{daashome}'")
Replace("daas_tech_stack_media_dir","daas_tech_stack_media_dir='#{node[:daas_multinode][:autowork]}/app/media'")
Replace("daas_installation_root_dir","daas_installation_root_dir='#{node[:daas_multinode][:autowork]}/app'")
Replace("daas_daas_pod_name","daas_daas_pod_name='#{node[:daas_multinode][:daas_daas_pod_name]}'")
Replace("daas_daas_admin_host","daas_daas_admin_host='#{ node[:daas_multinode][:daaswlshost]}:7001'")
Replace("daas_daas_managed_hosts","daas_daas_managed_hosts='#{node[:daas_multinode][:daaswlshost]}:7005'")
Replace("daas_daas_wlsadmin_username","daas_daas_wlsadmin_username='#{node[:daas_multinode][:daas_daas_wlsadmin_username]}'")
Replace("daas_daas_wlsnodemanager_username","daas_daas_wlsnodemanager_username='#{node[:daas_multinode][:daas_daas_wlsnodemanager_username]}'")
Replace("daas_prov_managed_hosts","daas_prov_managed_hosts='#{ node[:daas_multinode][:daaswlshost]}:8005'")
Replace("daas_prov_admin_host","daas_prov_admin_host='#{node[:daas_multinode][:daaswlshost]}:8001'")
Replace("daas_prov_wlsadmin_username","daas_prov_wlsadmin_username='#{node[:daas_multinode][:daas_prov_wlsadmin_username]}'")
Replace("daas_prov_wlsnodemanager_username","daas_prov_wlsnodemanager_username='#{node[:daas_multinode][:daas_prov_wlsnodemanager_username]}'")
Replace("daas_solr_zookeeper_quorum","daas_solr_zookeeper_quorum='#{node[:daas_multinode][:solrzoohost]}'")
Replace("daas_solr_zookeeper_nodes","daas_solr_zookeeper_nodes='#{node[:daas_multinode][:solrzoohost]}'")
Replace("daas_edq73_admin_host","daas_edq73_admin_host='#{node[:daas_multinode][:edq73host]}:9991'")
Replace("daas_edq73_wlsadmin_username","daas_edq73_wlsadmin_username='#{node[:daas_multinode][:daas_edq73_wlsadmin_username]}'")
Replace("daas_edq73_wlsnodemanager_username","daas_edq73_wlsnodemanager_username='#{node[:daas_multinode][:daas_edq73_wlsnodemanager_username]}'")
Replace("daas_edq73rt_managed_hosts","daas_edq73rt_managed_hosts='#{node[:daas_multinode][:edq73host]}:9993'")
Replace("daas_edq73batch_managed_hosts","daas_edq73batch_managed_hosts='#{node[:daas_multinode][:edq73host]}:9995'")
Replace("daas_edq73batchdataload_managed_hosts","daas_edq73batchdataload_managed_hosts='#{node[:daas_multinode][:edq73host]}:9997'")
Replace("daas_edq79_admin_host","daas_edq79_admin_host='#{node[:daas_multinode][:edq79host]}:9996'")
Replace("daas_edq79_wlsadmin_username","daas_edq79_wlsadmin_username='#{node[:daas_multinode][:daas_edq73_wlsadmin_username]}'")
Replace("daas_edq79_wlsnodemanager_username","daas_edq79_wlsnodemanager_username='#{node[:daas_multinode][:daas_edq73_wlsnodemanager_username]}'")
Replace("daas_edq79_av_hosts","daas_edq79_av_hosts='#{node[:daas_multinode][:edq79host]}:9999'")
Replace("daas_daasdb_hostname","daas_daasdb_hostname='#{node[:daas_multinode][:primaryhost]}'")
Replace("daas_daasdb_tsc_dbpath","daas_daasdb_tsc_dbpath='#{node[:daas_multinode][:autowork]}/app/oracle'")
Replace("daasdaaswlsadmin_deploy_daasappid_username","daasdaaswlsadmin_deploy_daasappid_username='#{node[:daas_multinode][:daasdaaswlsadmin_deploy_daasappid_username]}'")
Replace("daasdaaswlsadmin_deploy_daasedqws_username","daasdaaswlsadmin_deploy_daasedqws_username='#{node[:daas_multinode][:daasdaaswlsadmin_deploy_daasedqws_username]}'")
Replace("daasdaaswlsadmin_postdeploy_search_inputdir","daasdaaswlsadmin_postdeploy_search_inputdir='#{node[:daas_multinode][:autowork]}/app/dnbhier'")
Replace("daasdaaswlsadmin_postdeploy_sxssf_temp_dir","daasdaaswlsadmin_postdeploy_sxssf_temp_dir='#{node[:daas_multinode][:autowork]}/app/poiTemp'")
Replace("daasdaaswlsadmin_postdeploy_dnbbatch_inputdir","daasdaaswlsadmin_postdeploy_dnbbatch_inputdir='#{node[:daas_multinode][:autowork]}/app/dnbinput'")
Replace("daasdb_daas_curatordnb_inputfileurl","daasdb_daas_curatordnb_inputfileurl='ftp://#{ node[:daas_multinode][:primaryhost]}'")
Replace("daasdb_daas_curatordnb_remoteLocation","daasdb_daas_curatordnb_remoteLocation='#{node[:daas_multinode][:autowork]}/app/ftp'")
Replace("daas_patch_solr_index_backup_location","daas_patch_solr_index_backup_location='#{node[:daas_multinode][:autowork]}/app/backup'")
Replace("daasdaaswlsadmin_postdeploy_curatordnb_dbmrdseedrootdir","daasdaaswlsadmin_postdeploy_curatordnb_dbmrdseedrootdir='#{node[:daas_multinode][:autowork]}/app/seeds'")
Replace("daasdaaswlsadmin_postdeploy_curatordnb_dbmrdindexrootdir","daasdaaswlsadmin_postdeploy_curatordnb_dbmrdindexrootdir='#{node[:daas_multinode][:autowork]}/app/tmp/index'")
Replace("daasdaaswlsadmin_postdeploy_sdi_provisioning_baseuri","daasdaaswlsadmin_postdeploy_sdi_provisioning_baseuri='http://#{node[:daas_multinode][:primaryhost]}:8571'")
Replace("daasdaaswlsadmin_postdeploy_sdi_daasapp_baseuri","daasdaaswlsadmin_postdeploy_sdi_daasapp_baseuri='http://#{node[:daas_multinode][:primaryhost]}:8471'")
Replace("daasdaasohs_host","daasdaasohs_host='#{node[:daas_multinode][:primaryhost]}'")
Replace("daasedq73ohs_host","daasedq73ohs_host='#{node[:daas_multinode][:primaryhost]}'")
Replace("daasprovohs_host","daasprovohs_host='#{node[:daas_multinode][:primaryhost]}'")
Replace("daasedq79avohs_host","daasedq79avohs_host='#{node[:daas_multinode][:primaryhost]}'")
Replace("daasedq73wlsadmin_owsm_role_name","daasedq73wlsadmin_owsm_role_name='#{node[:daas_multinode][:daasedq73wlsadmin_owsm_role_name]}'")
Replace("daasedq79wlsadmin_owsm_role_name","daasedq79wlsadmin_owsm_role_name='#{node[:daas_multinode][:daasedq73wlsadmin_owsm_role_name]}'")
Replace("daas_solr_index_root_dir","daas_solr_index_root_dir='#{node[:daas_multinode][:autowork]}/app/solrindex'")
Replace("daasdaaswlsadmin_oid_host","daasdaaswlsadmin_oid_host='#{node[:daas_multinode][:daasdaaswlsadmin_oid_host]}'")
Replace("daasdaaswlsadmin_oid_username","daasdaaswlsadmin_oid_username='#{ node[:daas_multinode][:daasdaaswlsadmin_oid_username]}'")
Replace("daasdaaswlsadmin_oid_base_dn","daasdaaswlsadmin_oid_base_dn='#{node[:daas_multinode][:daasdaaswlsadmin_oid_base_dn]}'")
Replace("daasdaaswlsadmin_crosstenant_url","daasdaaswlsadmin_crosstenant_url='#{node[:daas_multinode][:daasdaaswlsadmin_crosstenant_url]}'")
Replace("daasdaaswlsadmin_crosstenant_username","daasdaaswlsadmin_crosstenant_username='#{node[:daas_multinode][:daasdaaswlsadmin_crosstenant_username]}'")
Replace("daasdaaswlsadmin_reassociate_username","daasdaaswlsadmin_reassociate_username='#{node[:daas_multinode][:daasdaaswlsadmin_reassociate_username]}'")
Replace("daasdaaswlsadmin_reassociate_url","daasdaaswlsadmin_reassociate_url='#{node[:daas_multinode][:daasdaaswlsadmin_reassociate_url]}'")
Replace("daasdaaswlsadmin_reassociate_jpsroot","daasdaaswlsadmin_reassociate_jpsroot='#{node[:daas_multinode][:daasdaaswlsadmin_reassociate_jpsroot]}'")
Replace("daas_omc_admin_host","daas_omc_admin_host='#{node[:daas_multinode][:omchost]}:11001'")
Replace("daas_omc_managed_hosts","daas_omc_managed_hosts='#{node[:daas_multinode][:omchost]}:11005'")
Replace("daas_omc_wlsadmin_username","daas_omc_wlsadmin_username='#{node[:daas_multinode][:daas_edq73_wlsadmin_username]}'")
Replace("daas_omc_wlsnodemanager_username","daas_omc_wlsnodemanager_username='#{node[:daas_multinode][:daas_edq73_wlsadmin_username]}'")
Replace("daasomcohs_host","daasomcohs_host='#{node[:daas_multinode][:primaryhost]}'")
Replace("daasdaaswlsadmin_deploy_daascuratordnb_username","daasdaaswlsadmin_deploy_daascuratordnb_username='oracle'")
Replace("daasdaasohs_listen ","daasdaasohs_listen=8471")
Replace("daasprovohs_listen ","daasprovohs_listen=8571")
Replace("daasedq73ohs_listen ","daasedq73ohs_listen=8671")
Replace("daasdaasohs_listen_ssl_port =","daasdaasohs_listen_ssl_port=7779")
Replace("daasedq73ohs_listen_ssl_port =","daasedq73ohs_listen_ssl_port=7789")
Replace("daasprovohs_listen_ssl_port =","daasprovohs_listen_ssl_port=7782")


conf22="#{AUTO_WORK}/app/pyconf/conf_22.py"
open("#{AUTO_WORK}/app/pyconf/tmpfile1", 'w') do |tmp|
  File.open("#{conf22}").each do |line|
    tmp << line.gsub(/^\s+/, '') unless line =~ /#(?!\!).+/
  end
end
File.rename("#{AUTO_WORK}/app/pyconf/tmpfile1", "#{conf22}")

open("#{AUTO_WORK}/app/pyconf/tmpfile2", 'w') do |tmp|
  File.open("#{conf22}").each do |line|
    tmp << line.gsub(/\s+=\s+/, '=')
  end
end
File.rename("#{AUTO_WORK}/app/pyconf/tmpfile2", "#{conf22}")



def ReplacePwds(strtofind,strtoreplace)
        pwds22="#{AUTO_WORK}/app/pyconf/pwds_22.py"
        pwds22new="#{AUTO_WORK}/app/pyconf/pwds_22.py_new"
        file=File.read(pwds22)
        data=file.gsub(/^.*#{Regexp.quote(strtofind)}.*$/, strtoreplace)
        file=File.open(pwds22new,"w")
        file.write(data)
        file.close()
        File.rename(pwds22new,pwds22)
end



ReplacePwds("daas_owsm_keystore_password","daas_owsm_keystore_password='welcome1'")
ReplacePwds("daas_daasdb_sys_password","daas_daasdb_sys_password='welcome1'")
ReplacePwds("daas_daasdb_user_password","daas_daasdb_user_password='daas_app'")
ReplacePwds("daas_edqdb_sys_password","daas_edqdb_sys_password='welcome1'")
ReplacePwds("daas_edqdb_user_password","daas_edqdb_user_password='daas_edq'")
ReplacePwds("daas_dbmrddb_sys_password","daas_dbmrddb_sys_password='welcome1'")
ReplacePwds("daas_dbmrddb_user_password","daas_dbmrddb_user_password='daas_dbmrd'")
ReplacePwds("daas_owsmdb_sys_password","daas_owsmdb_sys_password='welcome1'")
ReplacePwds("daas_owsmdb_schema_password","daas_owsmdb_schema_password='welcome1'")
ReplacePwds("daas_daas_wlsadmin_password","daas_daas_wlsadmin_password='#{node[:daas_multinode][:daas_daas_wlsadmin_password]}'")
ReplacePwds("daas_daas_wlsnodemanager_password","daas_daas_wlsnodemanager_password='#{node[:daas_multinode][:daas_daas_wlsnodemanager_password]}'")
ReplacePwds("daas_edq73_wlsadmin_password","daas_edq73_wlsadmin_password='#{node[:daas_multinode][:daas_edq73_wlsadmin_password]}'")
ReplacePwds("daas_edq73_wlsnodemanager_password","daas_edq73_wlsnodemanager_password='#{node[:daas_multinode][:daas_edq73_wlsnodemanager_password]}'")
ReplacePwds("daas_edq79_wlsadmin_password","daas_edq79_wlsadmin_password='#{node[:daas_multinode][:daas_edq79_wlsadmin_password]}'")
ReplacePwds("daas_edq79_wlsnodemanager_password","daas_edq79_wlsnodemanager_password='#{node[:daas_multinode][:daas_edq79_wlsnodemanager_password]}'")
ReplacePwds("daas_prov_wlsadmin_password","daas_prov_wlsadmin_password='#{node[:daas_multinode][:daas_prov_wlsadmin_password]}'")
ReplacePwds("daas_prov_wlsnodemanager_password","daas_prov_wlsnodemanager_password='#{node[:daas_multinode][:daas_prov_wlsnodemanager_password]}'")
ReplacePwds("daas_daas_zookeeper_auth_password","daas_daas_zookeeper_auth_password='bobsecret'")
ReplacePwds("daasdaaswlsadmin_oid_password","daasdaaswlsadmin_oid_password='#{node[:daas_multinode][:daasdaaswlsadmin_oid_password] }'")
ReplacePwds("daasdaaswlsadmin_crosstenant_password","daasdaaswlsadmin_crosstenant_password='#{node[:daas_multinode][:daasdaaswlsadmin_crosstenant_password] }'")
ReplacePwds("daasdaaswlsadmin_deploy_daasappid_password","daasdaaswlsadmin_deploy_daasappid_password='#{node[:daas_multinode][:daasdaaswlsadmin_deploy_daasappid_password]}'")
ReplacePwds("daasdaaswlsadmin_deploy_daasedqws_password","daasdaaswlsadmin_deploy_daasedqws_password='#{node[:daas_multinode][:daasdaaswlsadmin_deploy_daasedqws_password]}'")
ReplacePwds("daasdaaswlsadmin_deploy_daascuratordnb_password","daasdaaswlsadmin_deploy_daascuratordnb_password='welcome1'")
ReplacePwds("daasdaaswlsadmin_reassociate_password","daasdaaswlsadmin_reassociate_password='#{node[:daas_multinode][:daasdaaswlsadmin_reassociate_password] }'")
ReplacePwds("daasemagent_registration_password","daasemagent_registration_password='welcome1'")
ReplacePwds("daasedq73wlsadmin_owsmdb_sys_password","daasedq73wlsadmin_owsmdb_sys_password='welcome1'")
ReplacePwds("daasedq79wlsadmin_owsmdb_sys_password","daasedq79wlsadmin_owsmdb_sys_password='welcome1'")
ReplacePwds("daasedq73wlsadmin_owsmdb_schema_password","daasedq73wlsadmin_owsmdb_schema_password='daas_owsm'")
ReplacePwds("daasedq79wlsadmin_owsmdb_schema_password","daasedq79wlsadmin_owsmdb_schema_password='daas_owsm'")
ReplacePwds("daas_opssdb_schema_password","daas_opssdb_schema_password='daasapp'")
ReplacePwds("daasdaaswlsadmin_deploy_dnbbatch_password","daasdaaswlsadmin_deploy_dnbbatch_password='Good7Luck'")
ReplacePwds("daasdaaswlsadmin_deploy_dnbrealtime_password","daasdaaswlsadmin_deploy_dnbrealtime_password='Good7Luck'")
ReplacePwds("daas_omcdb_user_password","daas_omcdb_user_password='welcome1'")
ReplacePwds("daas_omc_wlsadmin_password","daas_omc_wlsadmin_password='#{node[:daas_multinode][:daas_daas_wlsadmin_password]}'")
ReplacePwds("daas_omc_wlsnodemanager_password","daas_omc_wlsnodemanager_password='#{node[:daas_multinode][:daas_daas_wlsnodemanager_password]}'")
ReplacePwds("daas_omc_client_secret","daas_omc_client_secret='welcome1'")
ReplacePwds("daas_test_identity_domain_user_password","daas_test_identity_domain_user_password='Welcome1'")
ReplacePwds("daas_daaswlsadmin_opssdb_schema_password","daas_daaswlsadmin_opssdb_schema_password='welcome1'")
ReplacePwds("daas_daasprovwlsadmin_opssdb_schema_password","daas_daasprovwlsadmin_opssdb_schema_password='welcome1'")
ReplacePwds("daas_edq79wlsadmin_opssdb_schema_password","daas_edq79wlsadmin_opssdb_schema_password='welcome1'")


pwds22="#{AUTO_WORK}/app/pyconf/pwds_22.py"
open("#{AUTO_WORK}/app/pyconf/tmpfile1", 'w') do |tmp|
  File.open("#{pwds22}").each do |line|
    tmp << line.gsub(/^\s+/, '') unless line =~ /#(?!\!).+/
  end
end
File.rename("#{AUTO_WORK}/app/pyconf/tmpfile1", "#{pwds22}")



bash "change permission of pyconf" do
code <<-EOF
chown -R oracle:oinstall #{AUTO_WORK}/app/pyconf/
EOF
end
