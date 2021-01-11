require 'spec_helper'
describe 'puppetboardserver' do

  context 'with defaults for all parameters' do
    it { should contain_class('puppetboardserver') }
  end
end
