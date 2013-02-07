require 'spec_helper'

describe 'defining scopes for bindings' do
  include LwnnHelper

  {
  }.each do |input, output|
    it { input.should evaluate_to output }
  end
end