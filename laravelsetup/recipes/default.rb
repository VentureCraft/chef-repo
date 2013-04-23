#
# Cookbook Name:: laravelsetup
# Recipe:: default
#
# Copyright 2012-2013, Escape Studios
#
Chef::Log.debug("Running laravelsetup")
node[:deploy].each do |app_name, deploy|

    Chef::Log.debug("Node: #{deploy[:deploy_to]}")

    # directory "/srv/www/hired_incoming/current/app/storage" do
    # directory "#{deploy[:deploy_to]}/current/app/storage" do
      # Chef::Log.debug("Setting permissions on #{deploy[:deploy_to]}/current/app/storage")
      # # group "root"
      # # owner "deploy"
      # mode 0777
      # recursive true
    # end

    permissions_command = "sudo chmod -Rf 777 app/storage"

    bash "change_permissions" do
        Chef::Log.debug("Setting permissions on #{deploy[:deploy_to]}/current/app/storage")
        cwd "#{deploy[:deploy_to]}/current"
        code <<-EOH
            #{permissions_command}
        EOH
    end



    artisan_dump_autoload_command = "php artisan dump-autoload"

    bash "artisan_dump_autoload" do
        Chef::Log.debug("Running #{composer_command} in #{deploy[:deploy_to]}/current")
        cwd "#{deploy[:deploy_to]}/current"
        # cwd "/srv/www/hired_incoming/current"
        code <<-EOH
            #{artisan_dump_autoload_command}
        EOH
    end


    composer_command = "php composer.phar install"

    bash "composer_install" do
        Chef::Log.debug("Running #{composer_install} in #{deploy[:deploy_to]}/current")
        cwd "#{deploy[:deploy_to]}/current"
        # cwd "/srv/www/hired_incoming/current"
        code <<-EOH
            #{composer_command}
        EOH
    end
end
