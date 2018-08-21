require 'spec_helper'
describe 'dns' do
  context 'with default values for all parameters' do
    it { should contain_class('dns') }
  end
end
