require 'spec_helper'
describe 'reverseProxy_Server' do
  context 'with default values for all parameters' do
    it { should contain_class('reverseProxy_Server') }
  end
end
