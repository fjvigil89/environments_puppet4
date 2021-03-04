require 'spec_helper'
describe 'graphite_server' do

  context 'with defaults for all parameters' do
    it { should contain_class('graphite_server') }
  end
end
