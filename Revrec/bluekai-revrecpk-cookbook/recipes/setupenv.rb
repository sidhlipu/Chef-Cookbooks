#
## Copyright 2016, Oracle Bluekai Cookbook
##
## All rights reserved - Do Not Redistribute
##
##
##This cookbook sets the environment for orcle

cookbook_version = run_context.cookbook_collection[cookbook_name].metadata.version

log "###" + cookbook_name + "::" + cookbook_version + "::" + recipe_name + " " + Time.now.inspect + ": Starting execution phase"
puts "###" + cookbook_name + "::" + cookbook_version + "::"+ recipe_name + " " + Time.now.inspect + ": Starting compile phase"







if node[:platform].include?("oracle")
   if node[:platform_version].include?("6.")


	user 'oracle' do
  		action [:create]
  		comment 'Oraacle DB User'
  		home node[:revrec_env][:oracle_home]
  		shell node[:revrec_env][:oracle_shell]
		supports :manage_home => true
		password '$1$welcome1$TBb/A5223.2cPBLUyybf71'
	#	not_if { ::File.exists?("/home/oracle") }
	end

	group 'dba' do
 		action [:create]
 		members ['oracle']
	end
	group 'oinstall' do
 		action [:create]
 		members ['oracle']
	end
	#file "/var/log/revrecsetup.log" do
	#	content 'Oracle Bluekai Rev Rec Setup logs starts here'
	#	action [:create]
	#	mode '0755'
	#	owner 'oracle'
	#	group 'oinstall'
	#3end
	ruby_block "Adding yum proxy" do
                block do
                file = Chef::Util::FileEdit.new("/etc/yum.conf")
                file.insert_line_if_no_match("/proxy/", "proxy=#{node[:revrec_env][:yum_proxy]}")
                file.write_file
           end
	   not_if ("grep -i www-proxy /etc/yum.conf")
        end

	yum_package node[:revrec_env][:ora_rpm] do
  		action [:install]
	not_if ("rpm -qa |grep #{node[:revrec_env][:ora_rpm]}")
	end
	execute "yum --disablerepo=* --enablerepo=public_ol6_latest update -y"
  

	directory node[:revrec_env][:base_dir] do
		action [:create]
		owner 'oracle'
		group 'oinstall'
	end
	directory node[:revrec_env][:tmp_dir] do
		action [:create]
		owner 'oracle'
		mode '777'
		recursive true
	end
	
	directory "Creating java home directory" do 
		path node[:revrec_env][:java_home]
		action [:create]
		owner 'oracle'
		group 'oinstall'
	end
	
	remote_file "Download JRE File" do
		path "#{node[:revrec_env][:tmp_dir]}/#{node['revrec_env']['jdk_file']}"
		source "#{node['revrec-cookbook']['download_url']}/#{node['revrec_env']['jdk_file']}"
		user 'oracle'
		group 'oinstall'
		mode '0755'
		use_conditional_get true
                not_if { ::File.exists?("#{node[:revrec_env][:jdk_tar]}") }
	end

	execute "Extracting Java from Archive" do
		cwd node[:revrec_env][:tmp_dir]
		user 'oracle'
		group 'oinstall'
		command "gunzip #{node['revrec_env']['jdk_file']} && tar -xvf #{node['revrec_env']['jdk_tar']} -C #{node['revrec_env']['java_home']} --strip-components=1 "
		action [:run]
		not_if { ::File.exists?("#{node[:revrec_env][:java_bin]}") }
	end

	ruby_block "javahome_bashprofile" do
  		block do
    		file = Chef::Util::FileEdit.new("#{node['revrec_env']['oracle_home']}/.bash_profile")
    		file.insert_line_if_no_match("/JAVA_HOME/", "export JAVA_HOME=#{node['revrec_env']['java_home']}")
    		file.insert_line_if_no_match("/PATH/", "export PATH=$JAVA_HOME/bin:$PATH")
    		file.write_file
  	   end
	   only_if { "grep JAVA_HOME #{node['revrec_env']['oracle_home']}/.bash_profile ; echo $?" == "0" }
	end
        

    end
end


log "###" + cookbook_name + "::" + cookbook_version + "::" + recipe_name + " " + Time.now.inspect + ": Finishing execution phase"
puts "###" + cookbook_name + "::" + cookbook_version + "::"+ recipe_name + " " + Time.now.inspect + ": Finishing compile phase"

