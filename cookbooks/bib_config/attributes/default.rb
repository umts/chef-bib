# frozen_string_literal: true

default['bib']['base_url'] = 'http://umts.github.io/BusInfoBoard'
default['bib']['stops'] = [1]
default['bib']['routes'] = :all
default['bib']['excluded_trips'] =
  ['Bus Garage via Mass Ave', 'Bus Garage via Compsci']
default['bib']['sort_by_time'] = false
default['bib']['interval'] = 30
default['bib']['work_day_start'] = 4
default['bib']['start_animation'] = nil
default['bib']['end_animation'] = nil
default['bib']['title'] = 'Bus Departures'
