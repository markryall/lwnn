require_relative '../spec_helper'

describe 'basic types' do
  include LwnnHelper

  {
    'a    ' => 'a',
    '2    ' => '2',
    '1 2  ' => '1 2',
    'true ' => 'true',
    '1 2 +' => '1 2 +'
  }.each do |input, expected|
    it(input) { evaluation_for(input).must_equal expected }
  end
end