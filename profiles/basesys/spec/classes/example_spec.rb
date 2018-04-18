require 'spec_helper'

describe 'basesys' do
  let(:title) { 'basesys' }

  ['Debian', 'RedHat'].each do |osfamily|
    describe "basesys class without any parameters on #{osfamily}" do 
      let(:params) {{ }}
      let(:facts) { { :osfamily => osfamily } }

      it { should create_class('basesys') }
      it { should create_package('basesys') }
      it { should create_file('/etc/basesys.conf') }
      it {
        should create_file('/etc/basesys.conf')\
        .with_content(/^server pool.basesys.org$/)
      }
      if osfamily == 'RedHat' 
        it { should create_service('basesysd') }
      else
        it { should create_service('basesys') }
      end
    end
  end
end
