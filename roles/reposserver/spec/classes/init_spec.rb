require 'spec_helper'
describe 'reposserver' do
  context 'with default values for all parameters' do
    it { should contain_class('reposserver') }
  end
end
