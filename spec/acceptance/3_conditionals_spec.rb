require_relative '../spec_helper'

describe 'basic types' do
  include LwnnHelper

  {
    'nup yep true if  .' => 'yep',
    'nup yep false if .' => 'nup',
    'nup yep 3 4 > if .' => 'yep',
    'nup yep 3 4 < if .' => 'nup',
    'nup yep 3 4 = if .' => 'nup'
  }.each do |input, expected|
    it(input) { evaluation_for(input).must_equal expected }
  end
end