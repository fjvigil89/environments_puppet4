require 'spec_helper'
describe 'elknodeserver' do
  context 'with default values for all parameters' do
    it { should contain_class('elknodeserver') }
  end
end
