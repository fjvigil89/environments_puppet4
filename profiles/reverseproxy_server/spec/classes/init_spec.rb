require 'spec_helper'
describe 'reverseproxy_server' do
  context 'with default values for all parameters' do
    it { should contain_class('reverseproxy_server') }
  end
end
