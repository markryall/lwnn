require 'spec_helper'

describe 'defining scopes for bindings' do
  include LwnnHelper

  {
    'a new .' => '',
    #'a new . 3 e let . ^ . e .' => '3'
  }.each do |input, output|
    it { input.should evaluate_to output }
  end
end