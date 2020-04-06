require 'spec_helper'
describe 'elasticsearchserver' do
  context 'with default values for all parameters' do
    it { should contain_class('elasticsearchserver') }
  end
end
