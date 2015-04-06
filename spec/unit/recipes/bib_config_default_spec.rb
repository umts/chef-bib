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
      expect(fschrome_url).to match(/stops=1/)
      expect(fschrome_url).not_to match(/routes=/)
      expect(fschrome_url).to match(/excluded_trips=Bus%20Garage[^+]*\+Bus%20Garage/)
      expect(fschrome_url).not_to match(/sort=time/)
      expect(fschrome_url).to match(/interval=30/)
      expect(fschrome_url).to match(/work_day_start=4/)
      expect(fschrome_url).not_to match(/_animation=/)
      expect(fschrome_url).to match(/title=Bus/)
    end
  end
end
