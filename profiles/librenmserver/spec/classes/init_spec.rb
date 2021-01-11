require 'spec_helper'
describe 'librenmserver' do
  context 'with default values for all parameters' do
    it { should contain_class('librenmserver') }
  end
end
