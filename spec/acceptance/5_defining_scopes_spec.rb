require_relative '../spec_helper'

describe 'defining scopes for bindings' do
  include LwnnHelper

  {
    '4 a let . s new .' => '',
  }.each do |input, expected|
    it(input) { evaluation_for(input).must_equal expected }
  end
end
