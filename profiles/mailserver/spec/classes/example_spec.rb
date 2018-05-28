require 'spec_helper'

describe 'mailserver' do
  let(:title) { 'mailserver' }

  ['Debian', 'RedHat'].each do |osfamily|
    describe "mailserver class without any parameters on #{osfamily}" do 
      let(:params) {{ }}
      let(:facts) { { :osfamily => osfamily } }

      it { should create_class('mailserver') }
      it { should create_package('mailserver') }
      it { should create_file('/etc/mailserver.conf') }
      it {
        should create_file('/etc/mailserver.conf')\
        .with_content(/^server pool.mailserver.org$/)
      }
      if osfamily == 'RedHat' 
        it { should create_service('mailserverd') }
      else
        it { should create_service('mailserver') }
      end
    end
  end
end
