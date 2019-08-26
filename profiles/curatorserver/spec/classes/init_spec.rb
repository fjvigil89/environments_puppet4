require 'spec_helper'
describe 'curatorserver' do
  context 'with default values for all parameters' do
    it { should contain_class('curatorserver') }
  end
end
