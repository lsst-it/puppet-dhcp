require 'spec_helper'

describe 'dhcp::host' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :title do 'myhost' end

      describe 'minimal parameters' do
        let :params do {
          :ip  => '10.0.0.100',
          :mac => '01:02:03:04:05:06',
        } end

        let :facts do
          facts
        end

        let :pre_condition do
          "class { '::dhcp': interfaces => ['eth0']}"
        end

        it {
          verify_concat_fragment_with_comments(catalogue, 'dhcp.hosts+10_myhost.hosts', [
            'host myhost {',
            '  hardware ethernet   01:02:03:04:05:06;',
            '  fixed-address       10.0.0.100;',
            '  ddns-hostname       "myhost";',
            '}',
          ])
        }
      end

      describe 'comment parameter' do
        let :params do {
          :ip      => '10.0.0.100',
          :mac     => '01:02:03:04:05:06',
          :comment => 'a useful comment',
        } end

        let :facts do
          facts
        end

        let :pre_condition do
          "class { '::dhcp': interfaces => ['eth0']}"
        end

        it {
          verify_concat_fragment_with_comments(catalogue, 'dhcp.hosts+10_myhost.hosts', [
            '# a useful comment',
            'host myhost {',
            '  hardware ethernet   01:02:03:04:05:06;',
            '  fixed-address       10.0.0.100;',
            '  ddns-hostname       "myhost";',
            '}',
          ])
        }
      end
    end
  end
end
