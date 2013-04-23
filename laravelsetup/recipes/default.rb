#
# Cookbook Name:: laravelsetup
# Recipe:: default
#
# Copyright 2012-2013, Escape Studios
#
Chef::Log.debug("Running laravelsetup")
migrated = false
node[:deploy].each do |app_name, deploy|

    if migrated == false
        migrate_command = "php artisan migrate"

        bash "run_migrate_command" do
            Chef::Log.debug("Running migrate database (#{migrate_command}) in #{deploy[:deploy_to]}/current")
            cwd "#{deploy[:deploy_to]}/current"
            code <<-EOH
                #{migrate_command}
            EOH
        end

        migrated = true
    end

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



    workbench_composer_install_command = "php ../../../composer.phar install"


    directory = "#{deploy[:deploy_to]}/current/workbench/venturecraft"
    workbenches = Dir.entries(directory).select {|file| File.directory? File.join(directory, file) and !(file =='.' || file == '..') }
    workbenches.each { |workbench|
        bash "workbench_composer_install_command" do
            Chef::Log.debug("Running #{workbench_composer_install_command} in #{deploy[:deploy_to]}/current/workbench/venturecraft/#{workbench}")
            cwd "#{deploy[:deploy_to]}/current/workbench/venturecraft/#{workbench}"
            code <<-EOH
                #{workbench_composer_install_command}
            EOH
        end
    }



    composer_install_command = "php composer.phar install"

    bash "composer_install_command" do
        Chef::Log.debug("Running #{composer_install_command} in #{deploy[:deploy_to]}/current")
        cwd "#{deploy[:deploy_to]}/current"
        # cwd "/srv/www/hired_incoming/current"
        code <<-EOH
            #{composer_install_command}
        EOH
    end



    artisan_dump_autoload_command = "php artisan dump-autoload"

    bash "artisan_dump_autoload" do
        Chef::Log.debug("Running #{artisan_dump_autoload_command} in #{deploy[:deploy_to]}/current")
        cwd "#{deploy[:deploy_to]}/current"
        # cwd "/srv/www/hired_incoming/current"
        code <<-EOH
            #{artisan_dump_autoload_command}
        EOH
    end


end
