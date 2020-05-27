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
        daaskey = "#{key.to_s}".gsub(/'/, '')
        daasvalue = "#{value.to_s}".gsub(/'/, '')
        ENV[daaskey] = daasvalue
        end


directory "Creating log dir " do
path "#{AUTO_WORK}/log"
action :create
user 'oracle'
group 'oinstall'
end

execute "Creating OMC DB Schemas" do
cwd ENV['daas_ops_home'] + "/daas-ops/highlevel"
user 'oracle'
group 'oinstall'
command "export daas_node_instance=#{node[:daas_multinode][:autowork]}/app/ &&  python omc-db.py setup >> #{node[:daas_multinode][:autowork]}/log/omcdb.log 2>&1;touch #{node[:daas_multinode][:autowork]}/log/omcdb.done"
timeout 7200
not_if { ::File.exists?("#{AUTO_WORK}/log/omcdb.done") }
end

execute "Creating OMC RCU Schemas" do
cwd ENV['daas_ops_home'] + "/daas-ops/highlevel"
user 'oracle'
group 'oinstall'
command "export daas_node_instance=#{node[:daas_multinode][:autowork]}/app/ &&  python omc-rcus.py setup >> #{node[:daas_multinode][:autowork]}/log/omcdb.log 2>&1;touch #{node[:daas_multinode][:autowork]}/log/omcrcus.done"
timeout 7200
not_if { ::File.exists?("#{AUTO_WORK}/log/omcrcus.done") }
end

execute "Installing omcadmin server" do
cwd ENV['daas_ops_home'] + "/daas-ops/highlevel"
user 'oracle'
group 'oinstall'
command "export daas_node_instance=#{node[:daas_multinode][:autowork]}/app/ &&  python omcwlsadmin.py setup >> #{node[:daas_multinode][:autowork]}/log/omcsetup.log 2>&1"
timeout 7200
not_if { ::File.exists?("#{AUTO_WORK}/app/omcwlsadmin/Started") }
end

execute "Installing omc managed server" do
cwd ENV['daas_ops_home'] + "/daas-ops/highlevel"
user 'oracle'
group 'oinstall'
command "export daas_node_instance=#{node[:daas_multinode][:autowork]}/app/ &&  python omcwlsmanaged.py  setup >> #{node[:daas_multinode][:autowork]}/log/omcsetup.log.log 2>&1"
timeout 7200
not_if { ::File.exists?("#{AUTO_WORK}/app/omcwlsmanaged/Started") }
end


