require 'spec_helper'
describe 'metricbeatserver' do
  context 'with default values for all parameters' do
    it { should contain_class('metricbeatserver') }
  end
end
