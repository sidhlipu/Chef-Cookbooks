#
# Cookbook Name:: daas-multinode-cookbook
# Author:: siddharth.mohapatra@oracle.com
#         priyadarshee.kumar@oracle.com  
# Copyright 2016, Oracle
#
# All rights reserved - Do Not Redistribute

AUTO_WORK="#{node['daas_multinode']['autowork']}"

        hash = {}
        File.open("#{AUTO_WORK}/app/pyconf/conf_22.py") do |fp|
          fp.each do |line|
            key, value = line.chomp.split("=",2)
            hash[key] = value

          end
        end


hash.each do |key,value|
        daaskey = "#{key.to_s}".gsub("'", '')
        daasvalue = "#{value.to_s}".gsub("'", '')
        ENV[daaskey] = daasvalue
          end

        hash2 = {}
        File.open("#{AUTO_WORK}/app/pyconf/pwds_22.py") do |fp|
          fp.each do |line|
            key, value = line.chomp.split("=",2)
            hash2[key] = value
          end
        end

hash2.each do |key,value|
        daaskey = "#{key.to_s}".gsub(/"/, '')
        daasvalue = "#{value.to_s}".gsub(/"/, '')
        ENV[daaskey] = daasvalue
        end

directory "Creating log dir " do
path "#{AUTO_WORK}/log"
action :create
user 'oracle'
group 'oinstall'
end


execute "Installing edq73admin server" do
cwd ENV['daas_ops_home'] + "/daas-ops/highlevel"
user 'oracle'
group 'oinstall'
command "export daas_node_instance=#{node[:daas_multinode][:autowork]}/app/ &&  python edq73wlsadmin.py setup >> #{node[:daas_multinode][:autowork]}/log/edq73admin.log 2>&1"
timeout 7200
not_if { ::File.exists?("#{node[:daas_multinode][:autowork]}/app/edq73wlsadmin/Started") }
end

execute "Installing edq73rtwlsmanaged server" do
cwd ENV['daas_ops_home'] + "/daas-ops/highlevel"
user 'oracle'
group 'oinstall'
command "export daas_node_instance=#{node[:daas_multinode][:autowork]}/app/ &&  python edq73rtwlsmanaged.py setup >> #{node[:daas_multinode][:autowork]}/log/edq73rtwlsmanaged.log 2>&1"
timeout 7200
not_if { ::File.exists?("#{node[:daas_multinode][:autowork]}/app/edq73rtwlsmanaged/Started") }
end


execute "Installing edq73batchdataloadwlsmanaged server" do
cwd ENV['daas_ops_home'] + "/daas-ops/highlevel"
user 'oracle'
group 'oinstall'
command "export daas_node_instance=#{node[:daas_multinode][:autowork]}/app/ &&  python edq73batchdataloadwlsmanaged.py setup >> #{node[:daas_multinode][:autowork]}/log/edq73batchdataloadwlsmanaged.log 2>&1"
timeout 7200
not_if { ::File.exists?("#{node[:daas_multinode][:autowork]}/app/edq73batchdataloadwlsmanaged/Started") }
end

execute "Installing edq73batchwlsmanaged server" do
cwd ENV['daas_ops_home'] + "/daas-ops/highlevel"
user 'oracle'
group 'oinstall'
command "export daas_node_instance=#{node[:daas_multinode][:autowork]}/app/ &&  python edq73batchwlsmanaged.py setup >> #{node[:daas_multinode][:autowork]}/log/edq73batchwlsmanaged.log 2>&1"
timeout 7200
not_if { ::File.exists?("#{node[:daas_multinode][:autowork]}/app/edq73batchwlsmanaged/Started") }
end


