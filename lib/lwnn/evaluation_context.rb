require 'lwnn/literal'
require 'lwnn/operation'
require 'lwnn/stack'

module Lwnn
  class EvaluationContext
    def initialize
      @stack = []
      @bindings = {}
      bind('+') {|l,r| l + r }
      bind('-') {|l,r| l - r }
      bind('*') {|l,r| l * r }
      bind('/') {|l,r| l / r }
    end

    def bind name, &block
      @bindings[name] = Operation.new name do |stack|
        l = stack.pop.evaluate stack
        r = stack.pop.evaluate stack
        block.call l, r
      end
    end

    def state
      'State: '+@stack.join(' ')
    end

    def lookup token
      return @bindings[token] if @bindings.has_key? token
      Literal.new token
    end

    def evaluate *tokens
      tokens.each do |token|
        case token
        when /[0-9]+/
          @stack.push Literal.new token.to_i
        when 'let'
          @bindings[@stack.pop.evaluate @stack] = Stack.new @stack
          @stack = []
        when '.'
          result = @stack.pop.evaluate @stack
          @stack.push Literal.new result if result
        else
          @stack.push lookup token
        end
      end
    end
  end
end
