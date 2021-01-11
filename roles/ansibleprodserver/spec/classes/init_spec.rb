require 'spec_helper'
describe 'ansibleprodserver' do
  context 'with default values for all parameters' do
    it { should contain_class('ansibleprodserver') }
  end
end
