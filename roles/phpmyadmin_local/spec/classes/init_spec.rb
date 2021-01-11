require 'spec_helper'
describe 'phpmyadmin_local' do
  context 'with default values for all parameters' do
    it { should contain_class('phpmyadmin_local') }
  end
end
