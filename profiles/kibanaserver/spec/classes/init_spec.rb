require 'spec_helper'
describe 'kibanaserver' do
  context 'with default values for all parameters' do
    it { should contain_class('kibanaserver') }
  end
end
