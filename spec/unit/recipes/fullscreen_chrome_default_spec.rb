require 'spec_helper'

describe 'fullscreen_chrome::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'installs various packages' do
      %w(chromium matchbox-window-manager ntp xorg-server xorg-server-utils xorg-xinit)
        .each do |pkg|
          expect(chef_run).to install_package(pkg)
        end
    end

    it 'installs xwit from aur' do
      expect(chef_run).to build_pacman_aur('xwit')
      expect(chef_run).to install_pacman_aur('xwit')
    end

    it 'does not make an xinitrc' do
      xinit_template = chef_run.template('xinitrc')
      expect(xinit_template).to do_nothing
    end
  end

  context 'With a specified fschrome user, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new do |node|
        node.set['fschrome']['user'] = 'someguy'
      end
      runner.converge(described_recipe)
    end

    it 'creates an xinitrc' do
      expect(chef_run).to render_file('/home/someguy/.xinitrc')
        .with_content(/chromium --app/)
        .with_content(/exec matchbox-window-manager/)
        .with_content(%r{http://example.com})
    end

    it 'does not always relaunce Chromium' do
      restart_script = chef_run.bash('restart_chrome')
      expect(restart_script).to do_nothing
    end

    it 'relaunches Chromium if notified' do
      xinit_template = chef_run.template('xinitrc')
      expect(xinit_template).to notify('bash[restart_chrome]').to(:run)
    end
  end
end
