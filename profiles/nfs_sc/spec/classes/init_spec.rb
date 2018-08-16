require 'spec_helper'
describe 'sc' do
  context 'with default values for all parameters' do
    it { should contain_class('sc') }
  end
end
