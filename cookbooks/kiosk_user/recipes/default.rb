#
# Cookbook Name:: kiosk_user
# Recipe:: default
#
# Copyright 2015, UMass Transit Service
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
user node['kiosk']['username'] do
  action [:create, :manage]
  manage_home true
  home "/home/#{node['kiosk']['username']}"
end

directory "/home/#{node['kiosk']['username']}" do
  action :create
  user node['kiosk']['username']
end

group 'sysadmin' do
  action :create
  members node['kiosk']['username']
  append true
end

user 'root' do
  action :lock
end

directory '/etc/systemd/system/getty@tty1.service.d' do
  action :create
end

template 'autologin.conf' do
  action :create
  source 'autologin.conf.erb'
  path '/etc/systemd/system/getty@tty1.service.d/autologin.conf'
  variables username: node['kiosk']['username']
  notifies :run, 'bash[relaunch_tty]'
end

cookbook_file 'bash_profile' do
  source 'bash_profile'
  path "/home/#{node['kiosk']['username']}/.bash_profile"
  user node['kiosk']['username']
  mode '0644'
end

bash 'relaunch_tty' do
  action :nothing
  code <<-EOS
    systemctl daemon-reload
    systemctl reload-or-restart getty@tty1.service
  EOS
end
