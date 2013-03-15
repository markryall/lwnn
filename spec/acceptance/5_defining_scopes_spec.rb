require_relative '../spec_helper'

describe 'defining scopes for bindings' do
  include LwnnHelper

  {
    '4 a . s new .' => '4 a',
    #'a new . 3 e let . ^ . e .' => '3'
  }.each do |input, expected|
    it(input) { evaluation_for(input).must_equal expected }
  end
end
