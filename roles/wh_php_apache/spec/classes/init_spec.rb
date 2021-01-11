require 'spec_helper'
describe 'wh_php_apache' do

  context 'with defaults for all parameters' do
    it { should contain_class('wh_php_apache') }
  end
end
