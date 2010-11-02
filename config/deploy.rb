set :use_sudo, false
set :application, "17clip.com"
set :repository,  "git://github.com/mifan/clip.git"
set :scm, :git
set :scm_username, "mifan"

#set :branch, "origin/master"
set :user, "rails3"
set :deploy_to, "/home/#{user}/#{application}"

set :deploy_via, :remote_cache
set :git_shallow_clone, 1

role :web, "www.17clip.com"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :web, :except => { :no_release => true } do
    run "/home/#{user}/#{application}/shared/run.sh"
  end
end
