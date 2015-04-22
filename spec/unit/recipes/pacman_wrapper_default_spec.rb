require 'spec_helper'

describe 'pacman_wrapper::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'updates the system' do
      expect(chef_run).to run_execute('update_system')
        .with(command: 'pacman -Syu --noconfirm')
    end

    it 'installs base-devel' do
      expect(chef_run).to install_pacman_group('base-devel')
    end
  end
end
