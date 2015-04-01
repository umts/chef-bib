#!/usr/bin/env bash
set -e
pacman -S --needed git ruby base-devel --noconfirm
rm /etc/gemrc
gem install chef --no-ri --no-rdoc

cd /tmp/chef-bib
rake clean
rake bib:install[test]
