#!/usr/bin/env puma

directory "/home/deployer/apps/mmss"
rackup "/home/deployer/apps/mmss/config.ru"
environment "production"

# tag ""

pidfile "/home/deployer/apps/mmss/shared/pids/puma.pid"
state_path "/home/deployer/apps/mmss/shared/pids/puma.state"
stdout_redirect "/home/deployer/apps/mmss/shared/log/puma.error.log", "/home/deployer/apps/mmss/shared/log/puma.access.log", true


threads 4,16



bind "unix:///home/deployer/apps/mmss/shared/sockets/mmss-puma.sock"

workers 2

preload_app!


on_restart do
  puts "Refreshing Gemfile"
  ENV["BUNDLE_GEMFILE"] = "/home/deployer/apps/mmss/Gemfile"
end


before_fork do
  ActiveRecord::Base.connection_pool.disconnect!
end

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end
