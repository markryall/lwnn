require 'lwnn/state'
require 'lwnn/literal'
require 'lwnn/operation'
require 'lwnn/stack'
require 'lwnn/trace'

module Lwnn
  class EvaluationContext
    include Trace

    def initialize parent=nil
      @state, @parent = State.new, parent
    end

    def bind name, &block
      @state[name] = Operation.new name, &block
    end

    def bind_op name, &block
      @state[name] = Operation.new name do |state|
        args = []
        block.arity.times do
          value = state.evaluate
          break unless value
          args << value
        end
        block.call *args unless args.length < block.arity
      end
    end

    def state
      "State: #{@state}"
    end

    def evaluate *tokens
      tokens.each do |token|
        case token
        when /[0-9]+/
          @state.push_literal token.to_i
        when '.'
          trace "evaluating from #{@state.peek}"
          result = @state.pop.evaluate @state
          @state.push_literal result if result
        when 'peek'
          symbol = @state.peek
          puts symbol.class
          p symbol
        when 'pop'
          @state.pop
        when 'clear'
          @state.clear
        else
          @state.push_literal token
        end
      end
    end
  end
end
