require 'spec_helper'
describe 'keepass' do

  context 'with defaults for all parameters' do
    it { should contain_class('keepass') }
  end
end
