require 'spec_helper'
describe 'reverseProxyServer' do
  context 'with default values for all parameters' do
    it { should contain_class('reverseProxyServer') }
  end
end
