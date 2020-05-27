#
# Cookbook Name:: daas-b2bx-cookbook
# Author:: siddharth.mohapatra@oracle.com
#         priyadarshee.kumar@oracle.com  
# Copyright 2016, Oracle
#
# All rights reserved - Do Not Redistribute
AUTO_WORK="#{node['daas_b2bx']['autowork']}"

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


execute "Installing daaswlsadmin server" do
cwd ENV['daas_ops_home'] + "/daas-ops/highlevel"
user 'oracle'
group 'oinstall'
command "export daas_node_instance=#{node[:daas_b2bx][:autowork]}/app/ &&  python daaswlsadmin.py setup >> #{node[:daas_b2bx][:autowork]}/log/daaswlsadmin.log && touch #{AUTO_WORK}/app/daaswlsadmin/Started 2>&1"
timeout 7200
not_if { ::File.exists?("#{AUTO_WORK}/app/daaswlsadmin/Started") }
end

execute "Installing daaswlsmanaged server" do
cwd ENV['daas_ops_home'] + "/daas-ops/highlevel"
user 'oracle'
group 'oinstall'
command "export daas_node_instance=#{node[:daas_b2bx][:autowork]}/app/ &&  python daaswlsmanaged.py setup >> #{node[:daas_b2bx][:autowork]}/log/daaswlsmanaged.log  && touch #{AUTO_WORK}/app/daaswlsmanaged/Started 2>&1"
timeout 7200
not_if { ::File.exists?("#{AUTO_WORK}/app/daaswlsmanaged/Started") }
end


execute "Daaswlsadmin Deploy" do
cwd ENV['daas_ops_home'] + "/daas-ops/highlevel"
user 'oracle'
group 'oinstall'
command "export daas_node_instance=#{node[:daas_b2bx][:autowork]}/app/ &&  python daaswlsadmin.py deploy >> #{node[:daas_b2bx][:autowork]}/log/daaswlsadmin-deploy.log && touch #{AUTO_WORK}/app/daaswlsadmin/deploy-started 2>&1"
timeout 7200
not_if { ::File.exists?("#{AUTO_WORK}/app/daaswlsadmin/deploy-started") }
end



execute "Daaswlsadmin Post-Deploy" do
cwd ENV['daas_ops_home'] + "/daas-ops/highlevel"
user 'oracle'
group 'oinstall'
command "export daas_node_instance=#{node[:daas_b2bx][:autowork]}/app/ &&  python daaswlsadmin.py postdeploy >> #{node[:daas_b2bx][:autowork]}/log/daaswlsadmin-postdeploy.log && touch #{AUTO_WORK}/app/daaswlsadmin/postdeploy-started 2>&1"
timeout 7200
not_if { ::File.exists?("#{AUTO_WORK}/app/daaswlsadmin/deploy-started") }
end
