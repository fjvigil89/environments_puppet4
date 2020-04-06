require 'spec_helper'

describe 'puppetprodserver' do
  let(:title) { 'puppetprodserver' }

  ['Debian', 'RedHat'].each do |osfamily|
    describe "puppetprodserver class without any parameters on #{osfamily}" do 
      let(:params) {{ }}
      let(:facts) { { :osfamily => osfamily } }

      it { should create_class('puppetprodserver') }
      it { should create_package('puppetprodserver') }
      it { should create_file('/etc/puppetprodserver.conf') }
      it {
        should create_file('/etc/puppetprodserver.conf')\
        .with_content(/^server pool.puppetprodserver.org$/)
      }
      if osfamily == 'RedHat' 
        it { should create_service('puppetprodserverd') }
      else
        it { should create_service('puppetprodserver') }
      end
    end
  end
end
