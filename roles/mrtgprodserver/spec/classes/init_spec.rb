require 'spec_helper'
describe 'mrtg_server' do
  context 'with default values for all parameters' do
    it { should contain_class('mrtg_server') }
  end
end
