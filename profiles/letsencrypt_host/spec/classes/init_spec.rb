require 'spec_helper'
describe 'letsencrypt_host' do

  context 'with defaults for all parameters' do
    it { should contain_class('letsencrypt_host') }
  end
end
