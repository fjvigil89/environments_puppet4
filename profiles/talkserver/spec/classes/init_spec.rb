require 'spec_helper'
describe 'talkserver' do

  context 'with defaults for all parameters' do
    it { should contain_class('talkserver') }
  end
end
