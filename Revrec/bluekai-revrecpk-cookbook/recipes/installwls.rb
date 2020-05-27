#
# Copyright 2016, Oracle Bluekai Cookbook
#
# All rights reserved - Do Not Redistribute
#
#
#This cookbook installs weblogic

cookbook_version = run_context.cookbook_collection[cookbook_name].metadata.version

log "###" + cookbook_name + "::" + cookbook_version + "::" + recipe_name + " " + Time.now.inspect + ": Starting execution phase"
puts "###" + cookbook_name + "::" + cookbook_version + "::"+ recipe_name + " " + Time.now.inspect + ": Starting compile phase"



extract_location = node['install_wls']['extract_location']
wlsjarFile = node['install_wls']['wlsjarFile']
Java_Path = node['revrec_env']['java_home']
passwords = Chef::EncryptedDataBagItem.load("revrec_secrets", "revrecpass")
wls_pass = passwords["weblogic_pass"]




directory  "Create temp dir" do
path "#{extract_location}/wls"
action :create
recursive true
owner 'oracle'
group 'oinstall'
mode '0755'
end

remote_file "Download WLS" do
path "#{extract_location}/wls/#{wlsjarFile}"
source "#{node['revrec-cookbook']['download_url']}/#{wlsjarFile}"
owner 'oracle'
group 'oinstall'
mode '0755'
use_conditional_get true
not_if { ::File.exists?("#{extract_location}/wls/#{wlsjarFile}") }
end


template "#{extract_location}/wls/silent.xml" do
source "silent.xml.erb"
owner 'oracle'
group 'oinstall'
mode '0755'
variables ({
        :BeaHome => node[:install_wls][:bea_home],
        :InstallDir => node[:install_wls][:installdir]+node[:install_wls][:version],
        :JvmHome => node[:install_wls][:local_jvm]
})
end

unless node['install_wls']['is_installed']

bash "install_wls" do
user 'oracle'
group 'oinstall'
cwd  ::File.dirname("#{extract_location}/wls")
code <<-EOH
#{Java_Path}/jre/bin/java -jar "#{extract_location}/wls/#{wlsjarFile}" -mode=silent -silent_xml="#{extract_location}/wls/silent.xml" -log="#{extract_location}/wls/silent-install.log"
EOH
node.set['install_wls']['is_iinstalled'] = true
not_if { ::File.exists?("#{extract_location}/wls/silent-install.log") }
end
end

template "#{extract_location}/wls/ServerCreate.py" do
source "ServerCreate.erb"
owner 'oracle'
group 'oinstall'
mode '0755'
variables ({
        :BeaHome => node[:install_wls][:installdir]+node[:install_wls][:version]
})
end
bash "Create Revrec Domain" do
    user 'oracle'
    group 'oinstall'
    cwd ::File.dirname("#{extract_location}")
    code <<-EOH
    bash "#{node[:install_wls][:installdir]}#{node[:install_wls][:version]}/server/bin/setWLSEnv.sh"
    bash "#{node[:install_wls][:installdir]}#{node[:install_wls][:version]}/common/bin/wlst.sh" "#{extract_location}/wls/ServerCreate.py"
    touch "#{node[:install_wls][:bea_home]}/domains/revrec/done"
    EOH
    not_if { ::File.exists?("#{node[:install_wls][:bea_home]}/domains/revrec/done") }
end


template "#{node[:install_wls][:bea_home]}/domains/revrec/domain.properties" do
source "domain.properties.erb"
owner 'oracle'
group 'oinstall'
mode '0755'
variables ({
        :BeaHome => node[:install_wls][:installdir]+node[:install_wls][:version],
	:JvmHome => node[:install_wls][:local_jvm]
})
end


template "#{node[:install_wls][:bea_home]}/domains/revrec/nodemanager.domains" do
source "nodemanager.domains.erb"
owner 'oracle'
group 'oinstall'
mode '0755'
variables ({
        :BeaHome => node[:install_wls][:installdir]+node[:install_wls][:version],
        :JvmHome => node[:install_wls][:local_jvm]
})
end

template "#{node[:install_wls][:bea_home]}/domains/revrec/nodemanager.properties" do
source "nodemanager.properties.erb"
owner 'oracle'
group 'oinstall'
mode '0755'
variables ({
        :BeaHome => node[:install_wls][:installdir]+node[:install_wls][:version],
        :JvmHome => node[:install_wls][:local_jvm]
})
end


template "#{node[:install_wls][:bea_home]}/domains/revrec/config/nodemanager/nm_password.properties" do
source "nm_password.properties.erb"
owner 'oracle'
group 'oinstall'
mode '0755'
end


template "#{node[:install_wls][:installdir]+node[:install_wls][:version]}/server/bin/startNodeManager.sh" do
source "startNodeManager.sh.erb"
owner 'oracle'
group 'oinstall'
mode '0755'
variables ({
        :BeaHome => node[:install_wls][:installdir]+node[:install_wls][:version],
        :JvmHome => node[:install_wls][:local_jvm]
})
end


template "#{node[:install_wls][:bea_home]}/domains/revrec/ServerStart.py" do
source "ServerStart.erb"
owner 'oracle'
group 'oinstall'
mode '0755'
variables ({
        :BeaHome => node[:install_wls][:installdir]+node[:install_wls][:version]
})
end

#bash "Start Servers" do
#user  'oracle'
#group 'oinstall'
#    cwd ::File.dirname("#{extract_location}")
#    code <<-EOH
#    bash "#{node[:install_wls][:installdir]}#{node[:install_wls][:version]}/common/bin/wlst.sh" "#{node[:install_wls][:bea_home]}/domains/revrec/ServerStart.py"
#    touch "#{node[:install_wls][:bea_home]}/domains/revrec/started"
#    EOH
#    not_if { ::File.exists?("#{node[:install_wls][:bea_home]}/domains/revrec/started") }
#end

script "Starting Servers" do
      interpreter "bash"
      user "oracle"
      group "oinstall"
      cwd "#{node[:install_wls][:bea_home]}/domains/revrec/"
      code "#{node[:install_wls][:installdir]}#{node[:install_wls][:version]}/common/bin/wlst.sh" " #{node[:install_wls][:bea_home]}/domains/revrec/ServerStart.py && touch #{node[:install_wls][:bea_home]}/domains/revrec/started"
    end




log "###" + cookbook_name + "::" + cookbook_version + "::" + recipe_name + " " + Time.now.inspect + ": Finishing execution phase"
puts "###" + cookbook_name + "::" + cookbook_version + "::"+ recipe_name + " " + Time.now.inspect + ": Finishing compile phase"




