require 'lwnn/state'
require 'lwnn/literal'
require 'lwnn/operation'
require 'lwnn/stack'
require 'lwnn/trace'

module Lwnn
  class EvaluationContext
    include Trace

    def self.build
      EvaluationContext.new.tap do |ec|
        ec.bind_op('+') {|l,r| l + r }
        ec.bind_op('-') {|l,r| l - r }
        ec.bind_op('*') {|l,r| l * r }
        ec.bind_op('/') {|l,r| l / r }
        ec.bind('dup') {|state| state.peek.evaluate state }
        ec.bind('swap') do |state|
          a,b = state.pop, state.pop
          state.push a
          b.evaluate state
        end
        ec.bind('let') {|state| state.let }
        ec.bind('if') do |state|
          con, t, f = state.evaluate, state.pop, state.pop
          con == 'true' ? t.evaluate(state) : f.evaluate(state)
        end
      end
    end

    def initialize
      @state = State.new
    end

    def bind name, &block
      @state[name] = Operation.new name, &block
    end

    def bind_op name, &block
      @state[name] = Operation.new name do |state|
        args = []
        block.arity.times { args << state.evaluate }
        block.call *args
      end
    end

    def state
      "State: #{@state}"
    end

    def evaluate *tokens
      tokens.each do |token|
        case token
        when /[0-9]+/
          @state.push Literal.new token.to_i
        when '.'
          trace "evaluating from #{@state.peek}"
          result = @state.pop.evaluate @state
          @state.push Literal.new result if result
        else
          @state.push @state.lookup token
        end
      end
    end
  end
end