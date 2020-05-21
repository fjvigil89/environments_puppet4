require 'spec_helper'

describe 'php_webserver::newrelic' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "php_webserver::newrelic class without any parameters" do
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('php_webserver::newrelic') }

          it { is_expected.to contain_class('newrelic::agent::php').with(
            'newrelic_php_package_ensure' => 'latest',
            'newrelic_php_service_ensure' => 'running',
            'newrelic_license_key'        => 'n/a',
          ) }

          it { is_expected.to contain_class('newrelic::server::linux').with(
            'newrelic_package_ensure' => 'latest',
            'newrelic_service_ensure' => 'running',
            'newrelic_license_key'    => 'n/a',
          ) }

        end

        context "php_webserver::newrelic class with enabled false" do
          let :params do {
              :enabled => false,
          }
          end
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('php_webserver::newrelic') }
          it { is_expected.not_to contain_class('newrelic::agent::php') }
          it { is_expected.not_to contain_class('newrelic::server::linux') }
        end
      end
    end
  end

end
