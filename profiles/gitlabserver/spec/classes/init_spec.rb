require 'spec_helper'
describe 'gitlabserver' do

  context 'with defaults for all parameters' do
    it { should contain_class('gitlabserver') }
  end
end
