#
# Cookbook Name:: artisan
# Recipe:: migrate
#
# Copyright 2012-2013, Venture Craft
#

Chef::Log.debug("Running artisan migrate")
node[:deploy].each do |app_name, deploy|

	command = "php artisan migrate"

	bash "migrate_db" do
		cwd "#{deploy[:deploy_to]}/current"
		code <<-EOH
			#{command}
		EOH
	end

end
