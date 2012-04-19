require 'lwnn/tokeniser'

describe Lwnn::Tokeniser do
  let(:tokeniser) { Lwnn::Tokeniser.new }
  it 'should read single integer' do
    tokeniser.tokenise('2').should == ['2']
  end
end
