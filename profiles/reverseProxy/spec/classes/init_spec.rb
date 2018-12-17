require 'spec_helper'
describe 'reverseProxy' do
  context 'with default values for all parameters' do
    it { should contain_class('reverseProxy') }
  end
end
