require 'lwnn/literal'
require 'lwnn/operation'
require 'lwnn/stack'

module Lwnn
  class EvaluationContext
    def self.build
      ec = EvaluationContext.new
      ec.bind('+') {|l,r| l + r }
      ec.bind('-') {|l,r| l - r }
      ec.bind('*') {|l,r| l * r }
      ec.bind('/') {|l,r| l / r }
      ec.bind_lazy('dup') {|stack| stack.push stack.last; nil }
      ec.bind_lazy('swap') {|stack| stack.push stack.pop, stack.pop; nil }
      ec
    end

    def initialize
      @stack = []
      @bindings = {}
    end

    def bind name, &block
      @bindings[name] = Operation.new name do |stack|
        args = []
        block.arity.times { args << stack.pop.evaluate(stack) }
        block.call *args
      end
    end

    def bind_lazy name, &block
      @bindings[name] = Operation.new name, &block
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
