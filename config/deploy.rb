require 'deprec'
  
set :application, "alltimetop5"
set :domain, "alltimetop5.com"
set :gems_for_project, %w(acts_as_taggable) # list of gems to be installed

# Update these if you're not running everything on one host.
role :app, domain
role :web, domain
role :db,  domain, :primary => true

# If you aren't deploying to /opt/apps/#{application} on the target
# servers (which is the deprec default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

default_run_options[:pty] = true
set :repository,  "git@github.com:joho/alltimetop5.git"
set :scm, "git"
set :scm_passphrase, "" #This is your custom users password
set :user, "joho"

namespace :deploy do
  task :restart, :roles => :app, :except => { :no_release => true } do
    top.deprec.mongrel.restart
  end
end