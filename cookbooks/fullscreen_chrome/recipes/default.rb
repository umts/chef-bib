#
# Cookbook Name:: fullscreen_chrome
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
packages = %w(chromium matchbox-window-manager ntp xorg-server xorg-server-utils xorg-xinit)

packages.each do |pkg|
  package pkg do
    action :install
  end
end

pacman_aur 'xwit' do
  action [:build, :install]
end

template 'xinitrc' do
  action :create
  source 'xinitrc.erb'
  path "/home/#{node['fschrome']['user']}/.xinitrc"
  owner node['fschrome']['user']
  group node['fschrome']['user']
  mode '0755'

  variables(
    url: node['fschrome']['url'],
    options: node['fschrome']['options'].join(' ')
  )

  notifies :run, 'bash[restart_chrome]'
  only_if { node['fschrome']['user'] }
end

bash 'restart_chrome' do
  action :nothing
  code <<-EOS
    killall -TERM chromium
    killall -TERM matchbox-window-manager
    sleep 2
    killall -KILL chromium || true
    killall -KILL matchbox-window-manager || true
  EOS
  only_if 'ps -a | grep chromium'
end
