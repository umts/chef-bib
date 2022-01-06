# frozen_string_literal: true

name             'bib_config'
maintainer       'UMass Transit Service'
maintainer_email 'transit-it@admin.umass.edu'
license          'MIT'
description      'Wrapper cookbook for configuring bib'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'fullscreen_chrome'
