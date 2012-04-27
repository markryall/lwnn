require 'lwnn/literal'
require 'lwnn/operation'

module Lwnn
  OPERATIONS = {}

  def self.operation name, &block
    OPERATIONS[name] = Operation.new name do |stack|
      l = stack.pop.evaluate stack
      r = stack.pop.evaluate stack
      block.call l, r
    end
  end

  operation('+') {|l,r| l + r }
  operation('-') {|l,r| l - r }
  operation('*') {|l,r| l * r }
  operation('/') {|l,r| l / r }

  class EvaluationContext
    def initialize
      @stack = []
    end

    def state
      'State: '+@stack.join(' ')
    end

    def lookup token
      return OPERATIONS[token] if OPERATIONS.has_key? token
      Literal.new token
    end

    def evaluate *tokens
      tokens.each do |token|
        case token
        when /[0-9]+/
          @stack.push Literal.new token.to_i
        when '.'
          @stack.push Literal.new @stack.pop.evaluate @stack
        else
          @stack.push lookup token
        end
      end
    end
  end
end
