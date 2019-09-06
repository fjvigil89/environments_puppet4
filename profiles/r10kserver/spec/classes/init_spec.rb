require 'spec_helper'
describe 'r10kserver' do
  context 'with default values for all parameters' do
    it { should contain_class('r10kserver') }
  end
end
