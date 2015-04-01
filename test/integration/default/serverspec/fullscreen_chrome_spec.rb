require 'spec_helper'

describe 'fullscreen_chrome::default' do
  describe file('/home/transit/.xinitrc') do
    it { should be_file }
    it { should be_readable.by_user 'transit' }
    its(:content) { should match(/chromium --app/) }
    its(:content) { should match(/exec matchbox-window-manager/) }
  end

  describe package('xwit') do
    it { should be_installed }
  end

  describe process('matchbox-window-manager') do
    it { should be_running }
    its(:user) { should eq 'transit' }
    its(:args) { should match(/titlebar no/) }
    its(:args) { should match(/cursor no/) }
  end

  describe process('chromium') do
    it { should be_running }
    its(:user) { should eq 'transit' }
    its(:args) { should match(/app=/) }
  end
end
