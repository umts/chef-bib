require 'spec_helper'

describe 'fullscreen_chrome::default' do
  describe file('/home/transit/.xinitrc') do
    it { is_expected.to be_file }
    it { is_expected.to be_readable.by_user 'transit' }
    its(:content) { is_expected.to match(/chromium --app/) }
    its(:content) { is_expected.to match(/exec matchbox-window-manager/) }
  end

  describe package('xwit') do
    it { is_expected.to be_installed }
  end

  describe process('matchbox-window-manager') do
    it { is_expected.to be_running }
    its(:user) { is_expected.to eq 'transit' }
    its(:args) { are_expected.to match(/titlebar no/) }
    its(:args) { are_expected.to match(/cursor no/) }
  end

  describe process('chromium') do
    it { is_expected.to be_running }
    its(:user) { is_expected.to eq 'transit' }
    its(:args) { are_expected.to match(/app=/) }
  end
end
