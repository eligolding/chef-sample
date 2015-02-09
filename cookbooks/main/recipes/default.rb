# start of by updating your repos

execute "apt-get update" do
  command "apt-get update"
end


# let's install some packages...

# get the basics

base-packages = ['curl', 'unzip', 'git', 'build-essential']

base-packages.each do |pckg|
  apt_package pckg do
    action :install
  end
end

# get all the php related stuff

php-packages = ["php5-fpm", 'php5-curl','php5-cli']

php-packages.each do |pckg|
  apt_package pckg do
    action :install
  end
end

# and a web server

apt_package "nginx" do
  action :install
end

# some databases

databases = ['mysql-server', 'redis-server', 'beanstalkd']

databases.each do |db|
  apt_package db do
    action :install
  end
end


# now we need to start up some services if we want our server to actually do things

services = ['nginx', 'php5-fpm', 'mysql', 'redis-server', 'beanstalkd']

services.each do |srvc|
  service srvc do
    action [ :enable, :start ]
  end
end

# almost done...

# set up a virtual host for our awesome site

template "/etc/nginx/sites-available/default" do
  source "vhost.erb"
  variables({
    :doc_root    => "/var/www",
    :server_name => "192.168.33.101"
  })
  action :create
  notifies :restart, resources(:service => "nginx")
end

# dance
