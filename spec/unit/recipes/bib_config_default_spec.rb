require 'spec_helper'

describe 'bib_config::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'sets the fschrome url to the bib with defaults' do
      fschrome_url = chef_run.node['fschrome']['url']

      expect(fschrome_url).to match(%r{http://umts.github.io/BusInfoBoard})
      .and match(/stops=1/)
      .and match(/excluded_trips=Bus%20Garage[^+]*\+Bus%20Garage/)
      .and match(/interval=30/)
      .and match(/work_day_start=4/)
      .and match(/title=Bus/)
      expect(fschrome_url).to_not match(/routes=/)
      expect(fschrome_url).to_not match(/sort=time/)
      expect(fschrome_url).to_not match(/_animation=/)
    end
  end
end
