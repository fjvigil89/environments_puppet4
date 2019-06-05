require 'spec_helper'

describe 'otrs_server' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "otrs_server class without any parameters" do
          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('otrs_server') }

        end
      end
    end
  end

end
