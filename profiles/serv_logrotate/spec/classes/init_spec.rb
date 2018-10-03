require 'spec_helper'
describe 'serv_logrotate' do
  context 'with default values for all parameters' do
    it { should contain_class('serv_logrotate') }
  end
end
