require 'spec_helper'
describe 'filebeatserver' do
  context 'with default values for all parameters' do
    it { should contain_class('filebeatserver') }
  end
end
