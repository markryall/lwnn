require_relative '../spec_helper'
require 'lwnn/tokeniser'

describe Lwnn::Tokeniser do
  it 'should read single integer' do
    Lwnn::Tokeniser.new.tokenise('2').must_equal ['2']
  end
end
