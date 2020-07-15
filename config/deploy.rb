# config valid for current version and patch releases of Capistrano
lock "~> 3.14.1"

set :rbenv_type, :user
set :rbenv_ruby, '2.7.1'

server 'lsa-math-mmss.miserver.it.umich.edu', roles: %w{app db web}, primary: true

set :application, "mmss"
set :repo_url, "git@github.com:rsmoke/mmss.git"
set :user, "deployer"
set :puma_threads,    [4, 16]
set :puma_workers,    0
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Don't change these unless you know what you're doing
set :pty,             true
# set :use_sudo,        false
set :stage,           :production
# set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
set :puma_preload_app, true
# set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord
# Avoid permissions issues with using /tmp
set :tmp_dir, '/home/deployer/tmp'

# Default value for keep_releases is 5
set :keep_releases, 3

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  desc 'Upload to shared/config'
  task :upload do
    on roles (:app) do
     upload! "config/master.key",  "#{shared_path}/config/master.key"
     upload! "config/puma_prod.rb",  "#{shared_path}/config/puma.rb"
     upload! "config/nginx_prod.conf",  "#{shared_path}/config/nginx.conf"
    end
  end


  desc "reload the database with seed data"
  task :seed do
    puts "Seeding db with seed file located at db/seeds.rb"
    run "cd #{current_path}; bin/rails db:seed RAILS_ENV=production"
  end


  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end

namespace :maintenance do
  desc "Maintenance start (edit config/maintenance_template.yml to provide parameters)"
  task :start do
    on roles(:web) do
      upload! "config/maintenance_template.yml", "#{current_path}/tmp/maintenance.yml"
    end
  end

  desc "Maintenance stop"
  task :stop do
    on roles(:web) do
      execute "rm #{current_path}/tmp/maintenance.yml"
    end
  end
end

# Default value for :linked_files and linked_dirs is []
set :linked_files, %w{config/puma.rb config/nginx.conf config/master.key}
set :linked_dirs,  %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle .bundle public/system public/uploads}
set :linked_dirs, fetch(:linked_dirs, []).push('public/packs', 'node_modules')

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true





# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
