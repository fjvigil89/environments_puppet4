require 'spec_helper'
describe 'telefonos' do
  context 'with default values for all parameters' do
    it { should contain_class('telefonos') }
  end
end
