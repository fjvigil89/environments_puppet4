require 'spec_helper'
describe 'sambarepos_server' do
  context 'with default values for all parameters' do
    it { should contain_class('sambarepos_server') }
  end
end
