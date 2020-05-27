#
### Copyright 2016, Oracle Bluekai Cookbook
###
### All rights reserved - Do Not Redistribute
###
###
###This cookbook install Oracle NoSql and sets the environment
cookbook_version = run_context.cookbook_collection[cookbook_name].metadata.version

log "###" + cookbook_name + "::" + cookbook_version + "::" + recipe_name + " " + Time.now.inspect + ": Starting execution phase"
puts "###" + cookbook_name + "::" + cookbook_version + "::"+ recipe_name + " " + Time.now.inspect + ": Starting compile phase"






group 'nosql' do
	action [:create]
end

user 'nosql' do
	action [:create]
        comment 'NoSQL ORDS User'
	group 'nosql'
        home node[:install_nosql][:nosql_home]
        shell node[:install_nosql][:nosql_shell]
        end

directory "tmp direcotyr" do
	path node[:revrec_env][:tmp_dir]
	action [:create]
	mode '777'
end


remote_file "Download Oracle NOSql KV ee media" do
        path "#{node[:revrec_env][:tmp_dir]}/#{node['install_nosql']['nosql_media']}"
        source "#{node['revrec-cookbook']['download_url']}/#{node['install_nosql']['nosql_media']}"
        user 'nosql'
        group 'nosql'
        mode '0755'
        use_conditional_get true
        not_if { ::File.exists?("#{node[:install_nosql][:kvhome]}/lib") }
       end

directory "Create project directory RosettaStone" do
	path node[:install_nosql][:project_dir]
	action [:create]
	user 'nosql'
	group 'nosql'
       end

directory "Create KV Home" do
	path node[:install_nosql][:kvhome]
	action [:create]
	user 'nosql'
	group 'nosql'
       end
	

execute "Extracting KV file" do
	 cwd node[:revrec_env][:tmp_dir]
         user 'nosql'
	 group 'nosql'
         command "gunzip -f #{node['install_nosql']['nosql_media']} && tar -xvf #{node['install_nosql']['nosql_tar']} -C #{node[:install_nosql][:kvhome]} --strip-components 1"
         action [:run]
         not_if { ::File.exists?("#{node['install_nosql']['kvstore_jar']}") }
        end


directory "Create KV Root" do
	path node[:install_nosql][:kvroot]
	action [:create]
	user 'nosql'
	group 'nosql'
       end


directory "Create KV data dir" do
	path node[:install_nosql][:kvdata]
	action [:create]
	user 'nosql'
	group 'nosql'
       end

ruby_block "bashprofile_populate_with nosql env details" do
                block do
                file = Chef::Util::FileEdit.new("#{node['install_nosql']['nosql_home']}/.bash_profile")
                file.insert_line_if_no_match("/KVHOME=/", "export KVHOME=#{node[:install_nosql][:kvhome]}")
                file.insert_line_if_no_match("/KVROOT=/", "export KVROOT=#{node[:install_nosql][:kvroot]}")
                file.insert_line_if_no_match("/KVDATA=/", "export KVDATA=#{node[:install_nosql][:kvdata]}")
                file.insert_line_if_no_match("/PATH=/", "export PATH=#{node[:revrec_env][:java_home]}/bin:$PATH")
                file.write_file
          end
	  not_if "grep -v KVHOME #{node['install_nosql']['nosql_home']}/.bash_profile}", :user => 'root'
end


execute "chown nosql:nosql -R #{node[:install_nosql][:project_dir]}"

if !node[:install_nosql][:is_installed]
bash "Storage node bootstraping" do
	cwd "#{node[:install_nosql][:project_dir]}"
	environment (node[:install_nosql][:nosql_env])
	code "su -l nosql -c \"#{node[:revrec_env][:java_bin]} -jar #{node[:install_nosql][:kvstore_jar]} makebootconfig -root #{node[:install_nosql][:kvroot]} -store-security none -capacity 1 -harange 5010,5030 -admin 5001 -port 5000 -memory_mb 1024 -host #{node[:fqdn]} -storagedir #{node[:install_nosql][:kvdata]}\" "
	not_if { ::File.exists?("#{node['install_nosql']['kvroot']}/config.xml") }
	end
end

template "/etc/init.d/nosqlstorage" do
	source "nosqlinit.erb"
	mode "0755"
	end
if !node[:install_nosql][:is_installed]
bash "Start storage node" do
	cwd "#{node[:install_nosql][:project_dir]}"
	environment (node[:install_nosql][:nosql_env])
	code "su -l nosql -c \"nohup #{node[:revrec_env][:java_bin]} -Xmx256m -Xms256m -jar #{node['install_nosql']['kvstore_jar']} start -root #{node[:install_nosql][:kvroot]} & \""
	not_if { ::File.exists?("#{node['install_nosql']['kvroot']}/adminboot_0.log") }
	end
end

template "#{node[:install_nosql][:nosql_topo]}" do
	source "nosqltopo.erb"
	user "nosql"
	group "nosql"
	mode '0755'	
	end
if !node[:install_nosql][:is_installed]
bash "Deploying Orcle NoSql KVStore topo" do
        cwd "#{node[:revrec_env][:tmp_dir]}"
        environment (node[:install_nosql][:nosql_env])
        code "su -l nosql -c \"bash #{node[:install_nosql][:nosql_topo]} \""
        #returns [0,1]
        not_if { ::File.exists?("#{node['install_nosql']['kvdata']}/rg1-rn1") }
        end
end
	
ruby_block 'flag attribute for NoSQL installation' do
  block do
    node.set[:install_nosql][:is_installed] = true
  end
  action :create
end

log "###" + cookbook_name + "::" + cookbook_version + "::" + recipe_name + " " + Time.now.inspect + ": Finishing execution phase"
puts "###" + cookbook_name + "::" + cookbook_version + "::"+ recipe_name + " " + Time.now.inspect + ": Finishing compile phase"




