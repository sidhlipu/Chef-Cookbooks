#
##
##
##Master recipe for installing oracle DB installation
##
##
#
#
#



cookbook_version = run_context.cookbook_collection[cookbook_name].metadata.version

log "###" + cookbook_name + "::" + cookbook_version + "::" + recipe_name + " " + Time.now.inspect + ": Starting execution phase"
puts "###" + cookbook_name + "::" + cookbook_version + "::"+ recipe_name + " " + Time.now.inspect + ": Starting compile phase"





include_recipe "bluekai-revrecpk-cookbook::setupenv"

if node['install_oradb']['is_installed']
 Chef::Log.info("Looks like Oracle DB is installed as Oracle installed flag attribute is found : #{node['install_oradb']['is_installed']}.")
 Chef::Log.info("Getting information about the installed version of Oracle DB.....")
 Chef::Log.info("Oracle DB with Version #{node[:install_oradb][:current_version]} installed on #{node[:install_oradb][:timestamp]}") 
 Chef::Log.info("Checking the Latest patch available.. ")
 Chef::Log.info("Latest patch found : #{node[:install_oradb][:patch_version]}")
 if node[:install_oradb][:patch_version] == node[:install_oradb][:current_version]
   Chef::Log.info("Latest version of Oracle is already installed")
   Chef::Log.info("Nothing to be patched..")
 else
   Chef::Log.info("Patching Oracle DB with Latest patch #{node[:install_oradb][:patch_version]}")
   Chef::Log.info("DB patching Recipe not yet ready...")
 end
else
 Chef::Log.info("Oracle DB is not installed..installing..")
 include_recipe "bluekai-revrecpk-cookbook::install_oracledb" unless node[:install_oradb][:is_installed]
 Chef::Log.info("DB installation done.. now populating DB with user/repo,schema,tables")
 include_recipe "bluekai-revrecpk-cookbook::create_schema"
 
 Chef::Log.info("DB installation done.. schema/user/repo/tables creation done...")
end


log "###" + cookbook_name + "::" + cookbook_version + "::" + recipe_name + " " + Time.now.inspect + ": Finishing execution phase"
puts "###" + cookbook_name + "::" + cookbook_version + "::"+ recipe_name + " " + Time.now.inspect + ": Finishing compile phase"




