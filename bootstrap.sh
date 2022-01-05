#!/usr/bin/env bash
set -e
pacman -Sy --noconfirm
pacman -S --needed ruby ruby-rake base-devel --noconfirm

if ! command -v chef-solo &> /dev/null
then
  rm -f /etc/gemrc
  gem install chef-bin --clear-sources \
    -s https://packagecloud.io/cinc-project/stable \
    -s https://rubygems.org
fi

cd /tmp/chef-bib
rake clean
rake bib:install[test]
