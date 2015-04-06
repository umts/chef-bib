require 'spec_helper'

describe 'kiosk_user::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      chef_run # This should not raise an error
    end

    it 'creates an admin user and home directory' do
      expect(chef_run).to create_user('transit').with(group: 'transit', home: '/home/transit')
      expect(chef_run).to create_directory('/home/transit')
      expect(chef_run).to create_group('sysadmin').with(members: ['transit'])
    end

    it 'has the kiosk user start X' do
      expect(chef_run).to render_file('/home/transit/.bash_profile')
        .with_content(/exec startx/)
    end

    it 'locks the root user' do
      expect(chef_run).to lock_user('root')
    end

    it 'sets up an auto-login' do
      directory = '/etc/systemd/system/getty@tty1.service.d'
      expect(chef_run).to create_directory(directory)
      expect(chef_run).to render_file("#{directory}/autologin.conf")
        .with_content(/autologin transit/)
    end

    it 'relaunches the tty' do
      resource = chef_run.template('autologin.conf')
      expect(resource).to notify('bash[relaunch_tty]').to(:run)
    end
  end
end
