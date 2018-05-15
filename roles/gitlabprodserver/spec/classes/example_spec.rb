require 'spec_helper'

describe 'gitlabprodserver' do
  let(:title) { 'gitlabprodserver' }

  ['Debian', 'RedHat'].each do |osfamily|
    describe "gitlabprodserver class without any parameters on #{osfamily}" do 
      let(:params) {{ }}
      let(:facts) { { :osfamily => osfamily } }

      it { should create_class('gitlabprodserver') }
      it { should create_package('gitlabprodserver') }
      it { should create_file('/etc/gitlabprodserver.conf') }
      it {
        should create_file('/etc/gitlabprodserver.conf')\
        .with_content(/^server pool.gitlabprodserver.org$/)
      }
      if osfamily == 'RedHat' 
        it { should create_service('gitlabprodserverd') }
      else
        it { should create_service('gitlabprodserver') }
      end
    end
  end
end
