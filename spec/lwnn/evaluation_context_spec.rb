require 'lwnn/evaluation_context'

describe Lwnn::EvaluationContext do
  let(:evaluation_context) { Lwnn::EvaluationContext.new }

  it 'should store a single value in the stack' do
    evaluation_context.evaluate '1'
    evaluation_context.state.should == 'State: 1'
  end
end
