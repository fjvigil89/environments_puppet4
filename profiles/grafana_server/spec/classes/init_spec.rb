require 'spec_helper'
describe 'grafana_server' do

  context 'with defaults for all parameters' do
    it { should contain_class('grafana_server') }
  end
end
