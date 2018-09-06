require 'spec_helper'
describe 'repoFacult_server' do
  context 'with default values for all parameters' do
    it { should contain_class('repoFacult_server') }
  end
end
