require 'bundler/capistrano'

#Basic config
set :application, "NoDevent"
set :repository, "git@github.com:cconstantine/NoDeventDemo.git"
set :scm, "git"
set :user, "cconstantine"
set :git_shallow_clone, 1
set :deploy_to, "/var/www/nodeventdemo"
default_run_options[:pty] = true

set :rvm_ruby_string, 'ruby-1.9.3-p125@nodeventdemo'
set :rvm_install_ruby, :install
require "rvm/capistrano"

namespace :nodevent do
  desc "deploy the precompiled assets"
  task :deploy_assets, :except => { :no_release => true } do
    run_locally "bundle exec rake assets:precompile RAILS_ENV=production "
    upload("public/assets", "#{release_path}/public/assets", :via =>
           :scp, :recursive => true, :roles => :app)
    run_locally "bundle exec rake assets:clean RAILS_ENV=production"
  end
end

before "deploy:create_symlink",    "nodevent:deploy_assets", "deploy:migrate"

#Bundler
set :bundle_dir,          fetch(:shared_path)+"/bundle"

#Servers
role :app, "ec2-75-101-164-22.compute-1.amazonaws.com"
role :db,  "ec2-75-101-164-22.compute-1.amazonaws.com", :primary => true
    
set :unicorn_pid, "#{shared_path}/pids/unicorn.pid"
require 'capistrano-unicorn'

