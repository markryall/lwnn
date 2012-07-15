require 'lwnn/evaluation_context'

describe Lwnn::EvaluationContext do
  let(:evaluation_context) { Lwnn::EvaluationContext.new }

  class EvaluationMatcher
    def initialize state
      @expected = state
    end

    def matches? tokens
      evaluation_context = Lwnn::EvaluationContext.build
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

  it 'should store an operation on a pair of integers' do
    %w[1 2 +].should evaluate_to 'State: 1 2 +'
  end

  it 'should trigger evaluation of an addition operation' do
    %w[1 2 + .].should evaluate_to 'State: 3'
  end

  it 'should trigger evaluation of a subtraction operation' do
    %w[1 2 - .].should evaluate_to 'State: 1'
  end

  it 'should trigger evaluation of a multiplication operation' do
    %w[4 2 * .].should evaluate_to 'State: 8'
  end

  it 'should trigger evaluation of a division operation' do
    %w[2 6 / .].should evaluate_to 'State: 3'
  end

  it 'should support multiple evaluations' do
    %w[2 3 + . 3 + .].should evaluate_to 'State: 8'
  end

  it 'should trigger nested evaluation' do
    %w[1 2 - 5 + .].should evaluate_to 'State: 6'
  end

  it 'should allow an operation to be defined' do
    %w[1 + e let . 2 e .].should evaluate_to 'State: 3'
  end

  it 'should allow stack elements to be duplicated' do
    %w[1 dup + .].should evaluate_to 'State: 2'
  end

  it 'should allow stack elements to be swapped' do
    %w[1 2 swap - .].should evaluate_to 'State: -1'
  end

  it 'should support a basic true conditional' do
    %w[1 2 true if .].should evaluate_to 'State: 2'
  end

  it 'should support a basic false conditional' do
    %w[1 2 false if .].should evaluate_to 'State: 1'
  end
end