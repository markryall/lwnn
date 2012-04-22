require 'lwnn/evaluation_context'

describe Lwnn::EvaluationContext do
  let(:evaluation_context) { Lwnn::EvaluationContext.new }

  class EvaluationMatcher
    def initialize state
      @expected = state
    end

    def matches? tokens
      evaluation_context = Lwnn::EvaluationContext.new
      evaluation_context.evaluate *tokens
      @actual = evaluation_context.state
      @expected == @actual
    end

    def failure_message
      "Expected #{@expected} instead of #{@actual}"
    end
  end

  def evaluate_to state
    EvaluationMatcher.new state
  end

  it 'should store a single integer in the stack' do
    %w[1].should evaluate_to 'State: 1'
  end

  it 'should store a few integers in the stack' do
    %w[1 2].should evaluate_to 'State: 1 2'
  end
end
