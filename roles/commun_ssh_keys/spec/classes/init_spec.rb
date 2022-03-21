require 'spec_helper'
describe 'commun_ssh_keys' do
  context 'with default values for all parameters' do
    it { should contain_class('commun_ssh_keys') }
  end
end
