require 'bundler/capistrano'

#Basic config
set :application, "NoDevent"
set :repository, "git@github.com:cconstantine/NoDeventDemo.git"
set :scm, "git"
set :user, "cconstantine"
set :git_shallow_clone, 1
set :deploy_to, "/var/www/nodevent"
default_run_options[:pty] = true

set :rvm_ruby_string, '1.9.2-p318@nodevent'
set :rvm_install_ruby, :install
require "rvm/capistrano"

#Bundler
set :bundle_dir,          fetch(:shared_path)+"/bundle"
set :bundle_flags,       "--deployment --quiet"

#Servers
role :app, "ec2-75-101-164-22.compute-1.amazonaws.com"
role :db,  "ec2-75-101-164-22.compute-1.amazonaws.com", :primary => true


before "deploy:symlink", "deploy:migrate"
    
set :unicorn_pid, "#{shared_path}/pids/unicorn.pid"
require 'capistrano-unicorn'

