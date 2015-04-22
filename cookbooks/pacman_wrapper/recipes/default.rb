#
# Cookbook Name:: pacman_wrapper
# Recipe:: default
#
# Copyright (c) 2015 UMass Transit, All Rights Reserved.
execute 'update_system' do
  command 'pacman -Syu --noconfirm'
end

pacman_group 'base-devel'
