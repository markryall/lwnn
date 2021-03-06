require_relative '../spec_helper'

describe 'defining bindings' do
  include LwnnHelper

  {
    '1 + e let . 2 e .          ' => '3',
    'f + e let . 3 f let . f e .' => '6',
    '1 a let . 2 a let .' => '2 attempted_reassignment'
  }.each do |input, expected|
    it(input) { evaluation_for(input).must_equal expected }
  end
end
