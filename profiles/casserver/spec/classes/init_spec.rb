require 'spec_helper'
describe 'casserver' do
  context 'with default values for all parameters' do
    it { should contain_class('casserver') }
  end
end
