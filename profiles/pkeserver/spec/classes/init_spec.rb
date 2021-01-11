require 'spec_helper'
describe 'pkeserver' do
  context 'with default values for all parameters' do
    it { should contain_class('pkeserver') }
  end
end
