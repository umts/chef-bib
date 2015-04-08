require 'spec_helper'
require 'uri'
require 'net/http'
require 'json'

describe 'bib_config::default' do
  describe 'open Chromium tabs' do
    let(:debug_json) do
      JSON.parse(Net::HTTP.get(URI.parse('http://localhost:9753/json/list')))
    end

    let(:page_uri) do
      URI.parse(debug_json.first['url'])
    end

    it 'has only one' do
      expect(debug_json.size).to eq(1)
    end

    it 'is the bus info board' do
      expect(debug_json.first['title']).to eq('Bus Info Board')
      expect(page_uri.host).to eq('umts.github.io')
      expect(page_uri.path).to eq('/BusInfoBoard/')
    end
  end

  describe process('chromium') do
    its(:args) { are_expected.to match(%r{http://umts.github.io/BusInfoBoard}) }
    its(:args) { are_expected.to match(/remote-debugging-port/) }
  end
end
