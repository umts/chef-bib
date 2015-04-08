require 'spec_helper'

describe 'kiosk_user::default' do
  describe user('transit') do
    it { is_expected.to exist }
    it { is_expected.to belong_to_group 'transit' }
    it { is_expected.to belong_to_group 'sysadmin' }
  end

  describe file('/home/transit') do
    it { is_expected.to be_directory }
  end

  describe file('/etc/shadow') do
    # Root user is locked
    its(:content) { is_expected.to match(/root:!/) }
  end
  describe file('/etc/systemd/system/getty@tty1.service.d/autologin.conf') do
    it { is_expected.to be_file }
    its(:content) { is_expected.to match(/autologin transit/) }
  end

  describe file('/home/transit/.bash_profile') do
    it { is_expected.to be_file }
    it { is_expected.to be_mode '644' }
    its(:content) { is_expected.to match(/startx/) }
  end

  describe process('login') do
    it { is_expected.to be_running }
    its(:args) { are_expected.to match(/transit/) }
  end

  describe process('startx') do
    it { is_expected.to be_running }
    its(:user) { is_expected.to match(/transit/) }
  end
end
