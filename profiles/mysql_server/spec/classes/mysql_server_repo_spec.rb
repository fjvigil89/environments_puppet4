require 'spec_helper'

describe 'mysql_server' do

  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts.merge({
            :hostname => 'testhost',
            :ipaddress => '157.193.40.1',
            :mysql_version => '5.7.17'
          })
        end

        context "mysql_server::repo class without any parameters" do
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('mysql_server::repo') }

          it { is_expected.to contain_apt__source('percona-apt-repo')
            .with({
              'location' => 'http://repo.percona.com/apt/',
              'release'  => "#{facts[:lsbdistcodename]}",
              'repos'    => 'main',
              'key'      => {
                'id'     => '4D1BB29D63D98E422B2113B19334A25F8507EFA5',
                'server' => 'keyserver.ubuntu.com',
              },
              'include'  =>  {
                'src'    => 'false',
              }
            })
          }
        end
      end
    end
  end

end
