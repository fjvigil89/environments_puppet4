require 'spec_helper'
describe 'haproxy_serv' do
  context 'with default values for all parameters' do
    it { should contain_class('haproxy_serv') }
  end
end
