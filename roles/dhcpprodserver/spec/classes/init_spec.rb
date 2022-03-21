require 'spec_helper'
describe 'dhcpprodserver' do

  context 'with defaults for all parameters' do
    it { should contain_class('dhcpprodserver') }
  end
end
