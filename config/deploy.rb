# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'clarion'
set :repo_url, 'https://github.com/ignisf/clarion.git'

# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/home/barf/clarion'

# Default value for :scm is :git
# set :scm, :git
set :git_strategy, Capistrano::Git::SubmoduleStrategy

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :rvm_ruby_version, '2.2.2'

set :puma_bind, ["tcp://127.0.0.1:9087"]
set :puma_init_active_record, true
set :puma_access_log, "#{shared_path}/log/puma_access.log"
set :puma_error_log, "#{shared_path}/log/puma_error.log"
set :puma_preload_app, true

set :nginx_sites_available_path, "#{shared_path}"
set :nginx_sites_enabled_path, "/tmp"
set :nginx_server_name, 'cfp.openfest.org'

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute '/home/barf/restart-clarion-production-server'
    end
  end

  after :publishing, :restart
end
