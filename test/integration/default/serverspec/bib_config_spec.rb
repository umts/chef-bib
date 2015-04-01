require 'spec_helper'
require 'uri'
require 'net/http'
require 'json'

describe 'bib_config::default' do
  describe 'open Chromium tabs' do
    def debug_json
      @json_response ||= JSON.parse(Net::HTTP.get(URI.parse('http://localhost:9753/json/list')))
    end

    def page_uri
      URI.parse(debug_json.first['url'])
    end

    it 'has only one' do
      debug_json.size.should eq 1
    end

    it 'is the bus info board' do
      debug_json.first['title'].should eq 'Bus Info Board'
      page_uri.host.should eq 'umts.github.io'
      page_uri.path.should eq '/BusInfoBoard/'
    end
  end

  describe process('chromium') do
    its(:args) { should match(/http:\/\/umts.github.io\/BusInfoBoard/) }
    its(:args) { should match(/remote-debugging-port/) }
  end
end
