require 'spec_helper'
describe 'freedaruis_serverf' do
  context 'with default values for all parameters' do
    it { should contain_class('freedaruis_serverf') }
  end
end
