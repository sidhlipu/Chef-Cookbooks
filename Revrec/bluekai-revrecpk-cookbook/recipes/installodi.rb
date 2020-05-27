#
# Copyright 2016, Oracle Bluekai Cookbook
#
# All rights reserved - Do Not Redistribute
#
#@siddharth.mohapatra@oracle.com
#
cookbook_version = run_context.cookbook_collection[cookbook_name].metadata.version

log "###" + cookbook_name + "::" + cookbook_version + "::" + recipe_name + " " + Time.now.inspect + ": Starting execution phase"
puts "###" + cookbook_name + "::" + cookbook_version + "::"+ recipe_name + " " + Time.now.inspect + ": Starting compile phase"





passwords = Chef::EncryptedDataBagItem.load("revrec_secrets", "revrecpass")
oradb_pass = passwords["ora_db_passwd"]


extract_location = "#{node[:revrec_env][:tmp_dir]}"
odi1Part = "#{node[:install_odi][:odi_media1]}"
odi2Part = "#{node[:install_odi][:odi_media2]}"
rcuzip = "#{node[:install_odi][:odi_rcu_media1]}"
odirsploc = "#{node['revrec_env']['base_dir']}/odi_install/silent.rsp"


directory "Creating temp dir for odi media" do
path "#{extract_location}/../odi_install"
action [:create]
user 'oracle'
group 'oinstall'
not_if { ::File.exists?("#{extract_location}/../odi_install")}
end

directory "Creating temp dir for odi media" do
path "#{extract_location}/../rcu_install"
action [:create]
user 'oracle'
group 'oinstall'
not_if { ::File.exists?("#{extract_location}/../rcu_install")}
end

remote_file "Download ODI-1" do
path "#{extract_location}/#{odi1Part}"
source "#{node['revrec-cookbook']['download_url']}#{odi1Part}"
owner 'oracle'
group 'oinstall'
mode '0755'
retries 2
use_conditional_get true
end

remote_file "Download ODI-2" do
path "#{extract_location}/#{odi2Part}"
source "#{node['revrec-cookbook']['download_url']}#{odi2Part}"
owner 'oracle'
group 'oinstall'
mode '0755'
retries 2
use_conditional_get true
end

remote_file "Download RCU" do
path "#{extract_location}/#{rcuzip}"
source "#{node['revrec-cookbook']['download_url']}#{rcuzip}"
owner 'oracle'
group 'oinstall'
mode '0755'
retries 2
use_conditional_get true
end


bash "Unzip ODI Disk1" do
cwd ::File.dirname("#{extract_location}")
user 'oracle'
code <<-EOH
cd "#{extract_location}";unzip -o "#{odi1Part}" -d "#{extract_location}/../odi_install"
touch "#{extract_location}/../odi_install/Disk1/done"
EOH
not_if { ::File.exists?("#{extract_location}/../odi_install/Disk1/done")}
end

bash "Unzip ODI Disk2" do
cwd ::File.dirname("#{extract_location}")
user 'oracle'
code <<-EOH
cd "#{extract_location}";unzip -o "#{odi2Part}" -d "#{extract_location}/../odi_install"
touch "#{extract_location}/../odi_install/Disk2/done"
EOH
not_if { ::File.exists?("#{extract_location}/../odi_install/Disk2/done")}
end



bash "Unzip RCU Files" do
user 'oracle'
cwd ::File.dirname("#{extract_location}")
code <<-EOH
cd "#{extract_location}";unzip -o "#{rcuzip}" -d "#{extract_location}/../rcu_install" && touch "#{extract_location}/../rcu_install/done"
EOH
not_if { ::File.exists?("#{extract_location}/../rcu_install/done")}
end


template "Copying ODIrcu password template" do
path "#{extract_location}/../rcu_install/odircupass"
source "password4odircu.erb"
user 'oracle'
group 'oinstall'
mode '0755'
variables ({
                :oradb_passwd => "#{oradb_pass}"

        })

end

template "Getting ODI silent file" do
path "#{extract_location}/../odi_install/silent.rsp"
source "odisilent.rsp.erb"
user 'oracle'
group 'oinstall'
mode '0755'
end



file "#{extract_location}/../odi_install/oraInst.loc" do
user 'oracle'
group 'oinstall'
action [:create]
end


ruby_block "prepare_orainstloc_odi" do
block do
file = Chef::Util::FileEdit.new("#{extract_location}/../odi_install/oraInst.loc")
file.insert_line_if_no_match("/inventory_loc/", "inventory_loc=#{extract_location}/../odi_install/oraInventory")
file.insert_line_if_no_match("/inst_group/", "inst_group=oinstall")
file.write_file
end
not_if ("grep -i \"inventory_loc=#{extract_location}/../odi_install/oraInventory\" #{extract_location}/../odi_install/oraInst.loc ")
end


unless node[:install_odi][:is_installed]
execute "Installing ODI" do
user 'oracle'
group 'oinstall'
command "#{node['revrec_env']['base_dir']}/odi_install/Disk1/runInstaller -jreLoc #{node[:revrec_env][:java_home]} -silent -response #{odirsploc} -ignoreSysPrereqs  -invPtrLoc #{node['revrec_env']['base_dir']}/odi_install/oraInst.loc -debug  ; sleep 300 ; touch #{node[:install_odi][:odi_ora_home]}/done"
not_if { ::File.exists?("#{node[:install_odi][:odi_ora_home]}/done") }
end
end

unless node[:install_odi][:is_installed]
execute "Creating ODI rcu repository" do
cwd "#{extract_location}/../rcu_install"
user 'oracle'
group 'oinstall'
command "#{extract_location}/../rcu_install/rcuHome/bin/rcu -silent -createRepository -databaseType ORACLE -connectString #{node[:fqdn]}:#{node[:install_oradb][:ora_port]}/#{node[:install_oradb][:global_dbname]} -dbUser sys -dbRole sysdba -schemaPrefix REVRECODI1 -component ODI -tablespace #{node[:install_odi][:odi_tablespace]} -tempTablespace  #{node[:install_odi][:odi_temp_tablespace]} -f < #{extract_location}/../rcu_install/odircupass && touch #{extract_location}/../rcu_install/rcudone"
not_if { ::File.exists?("#{extract_location}/../rcu_install/rcudone") }
end
end

unless node[:install_odi][:is_installed]
ruby_block 'flag attribute for ODI installation' do
  block do
    node.set[:install_odi][:is_installed] = true
  end
  action :create
end
end


log "###" + cookbook_name + "::" + cookbook_version + "::" + recipe_name + " " + Time.now.inspect + ": Finishing execution phase"
puts "###" + cookbook_name + "::" + cookbook_version + "::"+ recipe_name + " " + Time.now.inspect + ": Finishing compile phase"




