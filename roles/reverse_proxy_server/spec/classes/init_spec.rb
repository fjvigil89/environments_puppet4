require 'spec_helper'
describe 'reverse_proxy_server' do
  context 'with default values for all parameters' do
    it { should contain_class('reverse_proxy_server') }
  end
end
