require_relative '../spec_helper'

describe 'defining scopes for bindings' do
  include LwnnHelper

  {
    # should be ''
    '1 a let . s new . 2 a let .' => '2 attempted_reassignment'
  }.each do |input, expected|
    it(input) { evaluation_for(input).must_equal expected }
  end
end
