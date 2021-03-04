require 'spec_helper'
describe 'client' do
  context 'with default values for all parameters' do
    it { should contain_class('client') }
  end
end
