require 'spec_helper'

describe 'otrs_instance' do

  let :default_params do
    { :instance     => 'myotrs',
      :otrs_id      => 99,
      :system_id    => 'my_instance',
      :organization => 'ACME',
      :mapping      => 'myinstance',
      :server_name  => 'myotrs.com',
      :db_user      => 'otrs',
      :db_password  => 'srto',
      :db_name      => 'otrs_dev',
    }
  end

  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "otrs_instance class without any parameters" do
          it { is_expected.not_to compile.with_all_deps }
        end

        context "otrs_instance class with parameters" do
          let(:facts) do
            facts.merge({ :hostname => 'testhost', :ipaddress => '157.193.40.1' })
          end

          let :pre_condition do
            [
              '@user{"otrs":}',
              '@group{"otrs":}',
              'User <| title == "otrs" |>',
              'Group <| title == "otrs" |>',
            ]
          end

          let :params do
            default_params
          end

          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('otrs_instance') }
          it { is_expected.to contain_sudo__conf('otrs').with ({
            :priority => '1' })}

          it { is_expected.to contain_file('/srv/otrs_data') }
          it { is_expected.to contain_nshares__mount('/srv/otrs_data').with ( {:ensure => 'present', :sharename => 'otrs_data_myotrs' } ) }
        end

      end
    end
  end

end
