require 'spec_helper'

describe 'basic types' do
  include LwnnHelper

  {
   '1 2 +           ' => '3                        ',
   '1 2 -           ' => '1                        ',
   '2 3 *           ' => '6                        ',
   '2 4 /           ' => '2                        ',
   '2 3 + . 3 +     ' => '8                        ',
   '1 2 - 5 +       ' => '6                        ',
   '1 dup           ' => '1 1                      ',
   '1 2 swap        ' => '2 1                      ',
   '1 2 >           ' => 'true                     ',
   '1 2 <           ' => 'false                    ',
   '1 2 =           ' => 'false                    ',
   '1 2 <=          ' => 'false                    ',
   '1 2 >=          ' => 'true                     ',
   'true true and   ' => 'true                     ',
   'true false and  ' => 'false                    ',
   'true true or    ' => 'true                     ',
   'true false or   ' => 'true                     ',
   '+               ' => 'missing_expected_operand ',
   '1 +             ' => 'missing_expected_operand ',
   '1 2 rm          ' => '1                        '
  }.each do |input, output|
    it { input.should evaluate_to output }
  end
end