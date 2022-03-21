require 'spec_helper'
describe 'squidserver' do
  context 'with default values for all parameters' do
    it { should contain_class('squidserver') }
  end
end
