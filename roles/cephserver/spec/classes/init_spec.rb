require 'spec_helper'
describe 'cephserver' do
  context 'with default values for all parameters' do
    it { should contain_class('cephserver') }
  end
end
