AUTO_WORK="#{node['daas_b2bx']['autowork']}"


directory "#{AUTO_WORK}/app/pyconf/" do
recursive true
group 'oinstall'
owner 'oracle'
action :create
end

template  "#{AUTO_WORK}/app/pyconf/conf_22.py" do
        source 'conf_22.py.erb'
        owner 'oracle'
        group 'oinstall'
        mode '0755'
      variables ({
		:AUTO_WORK  => node[:daas_b2bx][:autowork]
        })

end

template  "#{AUTO_WORK}/app/pyconf/pwds_22.py" do
        source 'pwds_22.py.erb'
        owner 'oracle'
        group 'oinstall'
        mode '0755'
end
