require 'spec_helper'
describe 'ansibleserver' do
  context 'with default values for all parameters' do
    it { should contain_class('ansibleserver') }
  end
end
