#!/usr/bin/env bash
set -e
pacman -Sy --noconfirm
pacman -S --needed ruby ruby-rake git base-devel --noconfirm

if ! command -v chef-solo &> /dev/null
then
  CCDIR="/home/vagrant/chef-client"
  rm -rf "$CCDIR"
  su -c "git clone https://aur.archlinux.org/chef-client.git \"$CCDIR\"" vagrant
  cd "$CCDIR"
  su -- vagrant makepkg -sri --noconfirm
fi

cd /tmp/chef-bib
rake clean
rake bib:install[test]
