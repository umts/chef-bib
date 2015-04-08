require 'spec_helper'

describe BIB::QueryString do
  describe :build_qs do
    let(:dummy_obj) do
      Class.new { include BIB::QueryString }.new
    end

    it 'joins parameters together with &' do
      params = { 'somekey' => 'somevalue', 'otherkey' => 'othervalue' }
      expect(dummy_obj.build_qs(params).split('&').count).to eq(2)
    end

    it 'URI escapes the query string' do
      params = { 'somekey' => 'A long string with spaces & punctuation!' }
      expect(dummy_obj.build_qs(params)).to_not match(/[ &!]/)
      expect(dummy_obj.build_qs(params)).to match(/spaces%20%26%20punctuation%21/)
    end

    it 'passes through all unrecognized params' do
      params = { 'somekey' => 'somevalue', 'otherkey' => 'othervalue' }
      expect(dummy_obj.build_qs(params)).to match(/somekey=somevalue/)
        .and match(/otherkey=othervalue/)
    end

    it 'deletes unwanted keys' do
      params = { 'base_url' => 'doesnt_matter', 'somekey' => 'somevalue' }
      expect(dummy_obj.build_qs(params).split('&').count).to eq(1)
      expect(dummy_obj.build_qs(params)).to match(/somekey/)
      expect(dummy_obj.build_qs(params)).to_not match(/base_url/)
    end

    it 'joins array values with plusses' do
      params = { 'stops' => [1, 2, 3], 'excluded_trips' => %w(some_trip some_other_trip) }
      expect(dummy_obj.build_qs(params).split('&').count).to eq(2)
      expect(dummy_obj.build_qs(params)).to match(/stops=1\+2\+3/)
      expect(dummy_obj.build_qs(params)).to match(/excluded_trips=some_trip\+some/)
    end

    it 'handles sort_by_time' do
      params = { 'sort_by_time' => true }
      expect(dummy_obj.build_qs(params)).to match(/sort=time/)
    end

    it 'handles route `all`' do
      params = { 'routes' => 'all' }
      expect(dummy_obj.build_qs(params)).to be_empty
    end

    it 'handles route :all' do
      params = { 'routes' => :all }
      expect(dummy_obj.build_qs(params)).to be_empty
    end
  end
end
