require 'spec_helper'

describe 'puppetdevserver' do
  let(:title) { 'puppetdevserver' }

  ['Debian', 'RedHat'].each do |osfamily|
    describe "puppetdevserver class without any parameters on #{osfamily}" do 
      let(:params) {{ }}
      let(:facts) { { :osfamily => osfamily } }

      it { should create_class('puppetdevserver') }
      it { should create_package('puppetdevserver') }
      it { should create_file('/etc/puppetdevserver.conf') }
      it {
        should create_file('/etc/puppetdevserver.conf')\
        .with_content(/^server pool.puppetdevserver.org$/)
      }
      if osfamily == 'RedHat' 
        it { should create_service('puppetdevserverd') }
      else
        it { should create_service('puppetdevserver') }
      end
    end
  end
end
