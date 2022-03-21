require 'spec_helper'
describe 'logstashserver' do
  context 'with default values for all parameters' do
    it { should contain_class('logstashserver') }
  end
end
