require 'spec_helper_acceptance'

describe 'php with default settings' do
  context 'default parameters' do
    it 'works with defaults' do
      pp = 'include php'
      # Run it twice and test for idempotency
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    case default[:platform]
    when %r{ubuntu-16.04}
      packagename = 'php7.0-fpm'
    when %r{ubuntu-14.04}
      packagename = 'php5-fpm'
    when %r{el}
      packagename = 'php-fpm'
    when %r{debian}
      packagename = 'php5-fpm'
    end
    describe package(packagename) do
      it { is_expected.to be_installed }
    end

    describe service(packagename) do
      it { is_expected.to be_running }
      it { is_expected.to be_enabled }
    end
  end
end
