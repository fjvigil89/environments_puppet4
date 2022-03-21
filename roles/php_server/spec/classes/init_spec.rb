require 'spec_helper'
describe 'php_server' do
  context 'with default values for all parameters' do
    it { should contain_class('php_server') }
  end
end
