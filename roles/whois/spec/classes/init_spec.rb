require 'spec_helper'
describe 'whois' do
  context 'with default values for all parameters' do
    it { should contain_class('whois') }
  end
end
