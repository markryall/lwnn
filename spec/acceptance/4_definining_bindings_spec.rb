require 'spec_helper'

describe 'basic types' do
  include LwnnHelper

  {
   '1 + e let . 2 e .          ' => '3',
   'f + e let . 3 f let . f e .' => '6'
  }.each do |input, output|
    it { input.should evaluate_to output }
  end
end