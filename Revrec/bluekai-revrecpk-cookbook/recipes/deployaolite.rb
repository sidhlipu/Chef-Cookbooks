#
# Copyright 2016, Oracle Bluekai Cookbook
#
# All rights reserved - Do Not Redistribute
#
#This recipe deploys AOLite 


aolite_tar_gz = node['deploy_aolite']['aolite_tar_gz']
aolite_tar = node['deploy_aolite']['aolite_tar']
aolite_home = node['deploy_aolite']['aolite_home']
aolite_home_parent = node['deploy_aolite']['aolite_home_parent']
aolite_tmpdir = "/opt/tmp/aolite"

directory  "Create aolite tmp dir" do
path "#{aolite_tmpdir}"
action :create
recursive true
owner 'oracle'
group 'oinstall'
mode '0755'
end

directory  "Create aolite home dir" do
path "#{node['deploy_aolite']['aolite_home']}"
action :create
recursive true
owner 'oracle'
group 'oinstall'
mode '0755'
end

remote_file "Download AOLite" do
path "#{aolite_tmpdir}/#{aolite_tar_gz}"
source "#{node['revrec-cookbook']['download_url']}/#{aolite_tar_gz}"
owner 'oracle'
group 'oinstall'
mode '0755'
use_conditional_get true
not_if { ::File.exists?("#{aolite_tmpdir}/#{aolite_tar_gz}") }
end

execute "Extracting AOLite from Archive" do
cwd "#{aolite_tmpdir}"
user 'oracle'
group 'oinstall'
command "gunzip #{aolite_tmpdir}/#{aolite_tar_gz} && tar -xvf #{aolite_tmpdir}/#{aolite_tar} -C #{aolite_home} --strip-components=1 "
action [:run]
not_if { ::File.exists?("#{aolite_home}/bin") }
end

#bash "run_aolite" do
#cwd  ::File.dirname("#{extract_location}/wls")
#code <<-EOH
#su -l oracle -c \"#{Java_Path}/jre/bin/java -jar "#{extract_location}/wls/#{wlsjarFile}" -mode=silent -silent_xml="#{extract_location}/wls/silent.xml" -log="#{extract_location}/wls/silent-install.log"\"
#EOH
#not_if { ::File.exists?("#{extract_location}/wls/silent-install.log") }
#end


