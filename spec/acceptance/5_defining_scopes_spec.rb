require_relative '../spec_helper'

describe 'defining scopes for bindings' do
  include LwnnHelper

  {
    '1 a let . down . a .' => '1',
    '1 a let . down . 2 a let . a .' => '2',
    '1 a let . down . 2 a let . up . a .' => '1'
  }.each do |input, expected|
    it(input) { evaluation_for(input).must_equal expected }
  end
end
