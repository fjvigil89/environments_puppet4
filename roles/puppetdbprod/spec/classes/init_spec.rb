require 'spec_helper'
describe 'puppetdbprod' do

  context 'with defaults for all parameters' do
    it { should contain_class('puppetdbprod') }
  end
end
