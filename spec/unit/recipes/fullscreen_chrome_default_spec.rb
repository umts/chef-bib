require 'spec_helper'

describe 'fullscreen_chrome::default' do
  context 'When all attributes are default, on archlinux' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new platform: 'arch', version: '4.10.13-1-ARCH'
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'installs various packages' do
      %w(chromium ratpoison ntp xorg-server xorg-xset xorg-xinit)
        .each do |pkg|
          expect(chef_run).to install_package(pkg)
        end
    end

    it 'does not make an xinitrc' do
      xinit_template = chef_run.template('xinitrc')
      expect(xinit_template).to do_nothing
    end
  end

  context 'With a specified fschrome user, on archlinux' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new platform: 'arch', version: '4.10.13-1-ARCH' do |node|
        node.normal['fschrome']['user'] = 'someguy'
      end
      runner.converge(described_recipe)
    end

    it 'creates an xinitrc' do
      expect(chef_run).to render_file('/home/someguy/.xinitrc')
        .with_content(/chromium --app/)
        .with_content(/exec ratpoison/)
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
