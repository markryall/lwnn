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
      "Expected #{@expected.inspect} instead of #{@actual.inspect}"
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

  it 'should store a few strings in the stack' do
    %w["a" "b"].should evaluate_to 'State: "a" "b"'
  end

  it 'should store a few words in the stack' do
    %w[a b].should evaluate_to 'State: a b'
  end

  it 'should add a pair of integers' do
    %w[1 2 +].should evaluate_to 'State: 1 2 +'
  end

  it 'should trigger evaluation' do
    %w[1 2 + .].should evaluate_to 'State: 3'
  end
end
