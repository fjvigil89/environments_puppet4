require 'spec_helper'
describe 'elkserver' do
  context 'with default values for all parameters' do
    it { should contain_class('elkserver') }
  end
end
