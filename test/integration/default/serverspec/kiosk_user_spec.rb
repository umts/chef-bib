require 'spec_helper'

describe 'kiosk_user::default' do
  describe user('transit') do
    it { should exist }
    it { should belong_to_group 'transit' }
    it { should belong_to_group 'sysadmin' }
  end

  describe file('/home/transit') do
    it { should be_directory }
  end

  describe file('/etc/shadow') do
    # Root user is locked
    its(:content) { should match(/root:!/) }
  end
  describe file('/etc/systemd/system/getty@tty1.service.d/autologin.conf') do
    it { should be_file }
    its(:content) { should match(/autologin transit/) }
  end

  describe file('/home/transit/.bash_profile') do
    it { should be_file }
    it { should be_mode '644' }
    its(:content) { should match(/startx/) }
  end
end
