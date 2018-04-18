require 'spec_helper'

describe 'puppetserver' do
  let(:title) { 'puppetserver' }

  ['Debian', 'RedHat'].each do |osfamily|
    describe "puppetserver class without any parameters on #{osfamily}" do 
      let(:params) {{ }}
      let(:facts) { { :osfamily => osfamily } }

      it { should create_class('puppetserver') }
      it { should create_package('puppetserver') }
      it { should create_file('/etc/puppetserver.conf') }
      it {
        should create_file('/etc/puppetserver.conf')\
        .with_content(/^server pool.puppetserver.org$/)
      }
      if osfamily == 'RedHat' 
        it { should create_service('puppetserverd') }
      else
        it { should create_service('puppetserver') }
      end
    end
  end
end
