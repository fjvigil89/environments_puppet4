require 'spec_helper'
describe 'squid_server' do
  context 'with default values for all parameters' do
    it { should contain_class('squid_server') }
  end
end
