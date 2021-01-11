require 'spec_helper'
describe 'ftp' do
  context 'with default values for all parameters' do
    it { should contain_class('ftp') }
  end
end
