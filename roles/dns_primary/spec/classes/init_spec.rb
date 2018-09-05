require 'spec_helper'
describe 'dns_primary' do
  context 'with default values for all parameters' do
    it { should contain_class('dns_primary') }
  end
end
