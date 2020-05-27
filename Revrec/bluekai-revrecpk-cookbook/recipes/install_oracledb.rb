#
# Copyright 2016, Oracle Bluekai Cookbook
#
# All rights reserved - Do Not Redistribute
#
#
#


cookbook_version = run_context.cookbook_collection[cookbook_name].metadata.version

log "###" + cookbook_name + "::" + cookbook_version + "::" + recipe_name + " " + Time.now.inspect + ": Starting execution phase"
puts "###" + cookbook_name + "::" + cookbook_version + "::"+ recipe_name + " " + Time.now.inspect + ": Starting compile phase"




include_recipe "bluekai-revrecpk-cookbook::setupenv"
ora_base = "#{node['install_oradb']['ora_base']}"

passwords = Chef::EncryptedDataBagItem.load("revrec_secrets", "revrecpass")
oradb_pass = passwords["ora_db_passwd"]


directory "#{ora_base}" do
	action [:create]
	owner 'oracle'
	group 'oinstall'
end



remote_file "Download Oracle 11g media" do
	path "#{node[:revrec_env][:tmp_dir]}/#{node['revrec_env']['oradb_media']}"
        source "#{node['revrec-cookbook']['download_url']}/#{node['revrec_env']['oradb_media']}"
        user 'oracle'
        group 'oinstall'
        mode '0755'
	retries 2
        use_conditional_get true
        not_if { ::File.exists?("#{node[:revrec_env][:tmp_dir]}/#{node['revrec_env']['oradb_tar']}") }
        end


execute 'Extracting Oracle Media files from Archive' do
	cwd node[:revrec_env][:tmp_dir]
	user 'oracle'
	command "gunzip #{node['revrec_env']['oradb_media']}"
	action [:run]
	not_if { ::File.exists?("#{node['revrec_env']['tmp_dir']}/#{node['revrec_env']['oradb_tar']}") }
	end


execute 'Untaring Oracle media' do
	cwd node[:revrec_env][:tmp_dir]
	user 'oracle'
	command "tar -xvf  #{node['revrec_env']['oradb_tar']}"
	action [:run]
	not_if { ::File.exists?("#{node['revrec_env']['tmp_dir']}/database") }
	end

file "#{ora_base}/oraInst.loc" do
	action [:create]
	owner 'oracle'
	group 'oinstall'
end



directory "#{node['revrec_env']['tmp_dir']}/oratemp" do
 action [:create]
 owner 'oracle'
 group 'oinstall'
end
 
mount "#{node['revrec_env']['tmp_dir']}/oratemp" do
  pass     0
  fstype   'tmpfs'
  device   'tmpfs'
  options  'defaults,size=16G'
  action   [:mount, :enable]
end

ruby_block "prepare_orainst.loc_file" do
                block do
                file = Chef::Util::FileEdit.new("#{ora_base}/oraInst.loc")
                file.insert_line_if_no_match("/inventory_loc/", "inventory_loc=#{node['install_oradb']['oraInventory']}")
	        file.insert_line_if_no_match("/inst_group/", "inst_group=dba")
                file.write_file
          end
	  not_if ("grep -i \"inventory_loc=#{node['install_oradb']['oraInventory']}\" #{ora_base}/oraInst.loc ")
end


template node['install_oradb']['response_file_path'] do
	source 'db_install.rsp.erb'
	owner 'oracle'
	group 'oinstall'
	mode '0755'
	variables ({
		:OraHome => node[:install_oradb][:ora_home],
		:OraBase => node[:install_oradb][:ora_base],
		:OraGlobalDbName => node[:install_oradb][:global_dbname],
		:OraDataPath => node[:install_oradb][:oradata_path],
		:OracleSid => node[:install_oradb][:sid],
		:oraInventory => node[:install_oradb][:oraInventory],
		:oradb_passwd => "#{oradb_pass}"

	})


end

execute "chown oracle" do
	user 'root'
	command "chown -R oracle:oinstall #{node['revrec_env']['base_dir']}"
end

execute "Checking oratab" do
	command "mv /etc/oratab /etc/oratab.old"
	only_if { ::File.exists?("/etc/oratab") }
end

bash "Installing Oracle 11g" do
	cwd "#{node['install_oradb']['installer_path']}"
	environment ( { 'TMP' => "#{node[:revrec_env][:tmp_dir]}/oratemp",'TEMP' => "#{node[:revrec_env][:tmp_dir]}/oratemp",'TEMPDIR' => "#{node[:revrec_env][:tmp_dir]}/oratemp"})
	code "su -l oracle -c \"#{node['revrec_env']['tmp_dir']}/database/Disk1/runInstaller  -showProgress -ignoreSysPrereqs  -ignorePrereq -invPtrLoc #{ora_base}/oraInst.loc -silent -waitforcompletion -responseFile #{node['install_oradb']['response_file_path']} \""
	not_if { ::File.exists?("#{node[:install_oradb][:ora_home]}/bin/sqlplus") }
end 
	



	

ruby_block "bashprofile_populate_with_dbdetails" do
                block do
                file = Chef::Util::FileEdit.new("#{node['revrec_env']['oracle_home']}/.bash_profile")
                file.insert_line_if_no_match("/ORACLE_HOSTNAME=/", "export ORACLE_HOSTNAME=#{node[:fqdn]}")
                file.insert_line_if_no_match("/ORACLE_HOME=/", "export ORACLE_HOME=#{node[:install_oradb][:ora_home]}")
                file.insert_line_if_no_match("/ORACLE_BASE=/", "export ORACLE_BASE=#{ora_base}")
                file.insert_line_if_no_match("/ORACLE_SID=/", "export ORACLE_SID=#{node['install_oradb']['sid']}")
                file.insert_line_if_no_match("/PATH=/", "export PATH=$ORACLE_HOME/bin:$PATH")
                file.write_file
          end
	  not_if ("grep -i \"export PATH=#{node[:install_oradb][:ora_home]}/bin:$PATH\" #{node['revrec_env']['oracle_home']}/.bash_profile")
end



execute "running root.sh" do
	command "sh #{node[:install_oradb][:ora_home]}/root.sh"
end

bash "Correcting oratab entries" do
	code "perl -p -i -e 's/^orcl(.*)N$/orcl$1Y/g' /etc/oratab"	
end

template "/etc/init.d/oracle" do
	source "orainit.erb"
	mode '0755'
end

unless node['install_oradb']['oradb_running']
service 'oracle' do
  action :start
  node.set['install_oradb']['oradb_running'] = true
  not_if { ::File.exists?("#{node[:install_oradb][:ora_lock]}") }
end
end

ruby_block 'flag attribute for oracle db installation' do
  block do
    node.set[:install_oradb][:is_installed] = true
  end
  action :create
end


ruby_block 'set oracle db version attribute' do
  block do
    node.set[:install_oradb][:current_version] = %x(su -l oracle #{node[:install_oradb][:ora_home]}/OPatch/opatch lsinventory lsinventory|grep -w "OUI" |cut -d: -f2 |sed 's/^ *//;s/ *$//')
  end
  action :create
end




log "###" + cookbook_name + "::" + cookbook_version + "::" + recipe_name + " " + Time.now.inspect + ": Finishing execution phase"
puts "###" + cookbook_name + "::" + cookbook_version + "::"+ recipe_name + " " + Time.now.inspect + ": Finishing compile phase"


