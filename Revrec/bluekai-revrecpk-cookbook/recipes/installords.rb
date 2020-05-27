#
# Copyright 2016, Oracle Bluekai Cookbook
#
# All rights reserved - Do Not Redistribute
#
#recipe to install ords and connnect to NoSql
#
cookbook_version = run_context.cookbook_collection[cookbook_name].metadata.version

log "###" + cookbook_name + "::" + cookbook_version + "::" + recipe_name + " " + Time.now.inspect + ": Starting execution phase"
puts "###" + cookbook_name + "::" + cookbook_version + "::"+ recipe_name + " " + Time.now.inspect + ": Starting compile phase"





directory "Creating Project Directory" do
path node[:install_ords][:ords_home]
action [:create]
owner 'nosql'
group 'nosql'
mode '0755'
recursive true
not_if { ::File.exists?("#{node[:install_ords][:ords_home]}") }
end

user 'nosql' do
group 'nosql'
action [:create]
comment 'NoSQL ORDS User'
home node[:install_nosql][:nosql_home]
shell node[:install_nosql][:nosql_shell]
not_if 'grep nosql /etc/passwd', :user => 'nosql'
end


directory "Creating temp dir for media" do
path node[:revrec_env][:tmp_dir]
mode '0777'
action [:create]
end

remote_file "Download ORDS 3.x media" do
path "#{node[:revrec_env][:tmp_dir]}/#{node[:install_ords][:ords_media]}"
source "#{node['revrec-cookbook']['download_url']}/#{node[:install_ords][:ords_media]}"
user 'nosql'
group 'nosql'
mode '0755'
end



execute "yum -y install unzip"

execute "Unzipping ords media" do
cwd "#{node[:revrec_env][:tmp_dir]}"
user 'nosql'
group 'nosql'
command "unzip -o #{node[:install_ords][:ords_media]} -d #{node[:install_ords][:ords_home]}"
not_if { ::File.exists?("#{node[:install_ords][:ords_home]}/ords.war")}
end

ruby_block "javahome_bashprofile" do
                block do
                file = Chef::Util::FileEdit.new("#{node['install_nosql']['nosql_home']}/.bash_profile")
                file.insert_line_if_no_match("/JAVA_HOME/", "export JAVA_HOME=#{node['revrec_env']['java_home']}/jre")
                file.insert_line_if_no_match("/PATH/", "export PATH=$JAVA_HOME/bin:$PATH")
                file.write_file
           end
        end


bash "Executing ORDS" do
	environment (node[:install_nosql][:nosql_env])
	cwd "#{node[:install_ords][:ords_home]}"
end	


log "###" + cookbook_name + "::" + cookbook_version + "::" + recipe_name + " " + Time.now.inspect + ": Finishing execution phase"
puts "###" + cookbook_name + "::" + cookbook_version + "::"+ recipe_name + " " + Time.now.inspect + ": Finishing compile phase"





