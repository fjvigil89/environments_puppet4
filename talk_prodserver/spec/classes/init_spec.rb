require 'spec_helper'
describe 'talk_prodserver' do
  context 'with default values for all parameters' do
    it { should contain_class('talk_prodserver') }
  end
end
