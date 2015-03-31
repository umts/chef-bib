#!/usr/bin/env bash
set -e
pacman -S --needed git ruby base-devel --noconfirm
gem install chef --no-ri --no-rdoc --no-user-install

cd /tmp/chef-bib
rake clean
rake bib:install[test]
