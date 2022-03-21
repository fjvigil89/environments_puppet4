require 'spec_helper'
describe 'dhcpserver' do

  context 'with defaults for all parameters' do
    it { should contain_class('dhcpserver') }
  end
end
