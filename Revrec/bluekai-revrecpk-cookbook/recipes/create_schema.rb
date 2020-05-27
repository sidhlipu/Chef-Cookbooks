### Copyright 2016, Oracle Bluekai Cookbook
###
### All rights reserved - Do Not Redistribute
###
###
###This recipe populate revrec database
#

cookbook_version = run_context.cookbook_collection[cookbook_name].metadata.version

log "###" + cookbook_name + "::" + cookbook_version + "::" + recipe_name + " " + Time.now.inspect + ": Starting execution phase"
puts "###" + cookbook_name + "::" + cookbook_version + "::"+ recipe_name + " " + Time.now.inspect + ": Starting compile phase"





include_recipe "bluekai-revrecpk-cookbook::setupenv"
include_recipe "bluekai-revrecpk-cookbook::install_oracledb"



template "#{node[:revrec_env][:tmp_dir]}/createschema.sh" do
	source "createschema.sh.erb" 
	user 'oracle'
	group 'oinstall'
	mode '0755'
end

bash "creating schemas for oridev and odi" do
	cwd node[:revrec_env][:tmp_dir]
	user 'oracle'
	group 'oinstall'
	environment node[:install_oradb][:ora_env]
	code "bash createschema.sh  "
	not_if { "grep -i success #{node[:install_oradb][:ora_datapath]}/exectbspstatus ; echo $?" =="0" }
end


template "#{node[:revrec_env][:tmp_dir]}/createdbuser.sh" do
        source "createdbuser.sh.erb"
        user 'oracle'
        group 'oinstall'
        mode '0755'
end

bash "creating db user and repository" do
        cwd node[:revrec_env][:tmp_dir]
        user 'oracle'
        group 'oinstall'
        environment node[:install_oradb][:ora_env]
        code "bash createdbuser.sh "
	not_if { "grep -i success #{node[:install_oradb][:ora_datapath]}/execusrstatus ;echo ?" == "0" }
end



remote_file "Downloading sql template for Creating tables in db" do
	path "#{node[:install_oradb][:sql_local_template]}"
	source "#{node[:install_oradb][:sql_remote_template]}"
	user 'oracle'
	group 'oinstall'
	mode '0755'
	use_conditional_get true
	not_if { ::File.exists?("#{node[:revrec_env][:sql_local_template]}") }
end

template "#{node[:revrec_env][:tmp_dir]}/populatetables.sh" do
        source "populatetables.sh.erb"
        user 'oracle'
        group 'oinstall'
        mode '0755'
end
		
bash "populating tables in db"do
        cwd node[:revrec_env][:tmp_dir]
        user 'oracle'
        group 'oinstall'
        environment node[:install_oradb][:ora_env]
        code "bash populatetables.sh  "
        not_if { "grep -i success #{node[:install_oradb][:ora_datapath]}/exectablestatus ;echo $?" == "0" }
end



log "###" + cookbook_name + "::" + cookbook_version + "::" + recipe_name + " " + Time.now.inspect + ": Finishing execution phase"
puts "###" + cookbook_name + "::" + cookbook_version + "::"+ recipe_name + " " + Time.now.inspect + ": Finishing compile phase"




