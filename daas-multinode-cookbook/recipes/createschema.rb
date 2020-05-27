#
# Cookbook Name:: daas-multinode-cookbook
# Author:: siddharth.mohapatra@oracle.com
#         priyadarshee.kumar@oracle.com  
# Copyright 2016, Oracle
#
# All rights reserved - Do Not Redistribute

#include_recipe "cookbook-daasenv-setup::default"
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
path "#{node[:daas_multinode][:autowork]}/log"
action :create
user 'oracle'
group 'oinstall'
end

execute "Running DB.py Highlevel Script" do
cwd ENV['daas_ops_home'] + "/daas-ops/highlevel"
user 'oracle'
group 'oinstall'
command "export daas_node_instance=#{node[:daas_multinode][:autowork]}/app/ &&  python db.py setup >> #{node[:daas_multinode][:autowork]}/log/db.log 2>&1;touch #{node[:daas_multinode][:autowork]}/log/daasdb.done"
returns 0
timeout 7200
not_if { ::File.exists?("#{AUTO_WORK}/log/daasdb.done") }
end

execute "Running RCUS.py Highlevel Script" do
cwd ENV['daas_ops_home'] + "/daas-ops/highlevel"
user 'oracle'
group 'oinstall'
command "export daas_node_instance=#{node[:daas_multinode][:autowork]}/app/  && python rcus.py setup >> #{node[:daas_multinode][:autowork]}/log/db.log 2>&1;touch #{node[:daas_multinode][:autowork]}/log/rcus.done"
returns 0
timeout 7200
not_if { ::File.exists?("#{AUTO_WORK}/log/rucs.done") }
end

