require 'spec_helper'
describe 'freedaruis_server' do
  context 'with default values for all parameters' do
    it { should contain_class('freedaruis_server') }
  end
end
