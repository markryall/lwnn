require 'spec_helper'

describe 'basic types' do
  include LwnnHelper

  {
    'a     ' => 'a      ',
    '2     ' => '2      ',
    '1 2   ' => '1 2    ',
    'true  ' => 'true   ',
    '1 2 + ' => '1 2 +  '
  }.each do |input, output|
    it { input.should result_in output }
  end
end