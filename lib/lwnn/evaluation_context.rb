require 'lwnn/literal'
require 'lwnn/operation'
require 'lwnn/stack'
require 'lwnn/trace'

module Lwnn
  class EvaluationContext
    include Trace

    def self.build
      EvaluationContext.new.tap do |ec|
        ec.bind('+') {|l,r| l + r }
        ec.bind('-') {|l,r| l - r }
        ec.bind('*') {|l,r| l * r }
        ec.bind('/') {|l,r| l / r }
        ec.bind_lazy('dup') {|stack,bindings| stack.last.evaluate stack, bindings }
        ec.bind_lazy('swap') do |stack,bindings|
          a,b = stack.pop, stack.pop
          stack.push a
          b.evaluate stack, bindings
        end
        ec.bind_lazy('let') do |stack,bindings|
          bindings[stack.pop.evaluate(stack, bindings)] = Stack.new stack
          stack.clear
          nil
        end
        ec.bind_lazy('if') do |stack,bindings|
          con, t, f = stack.pop.evaluate(stack, bindings), stack.pop, stack.pop
          con == 'true' ? t.evaluate(stack, bindings) : f.evaluate(stack, bindings)
        end
      end
    end

    def initialize
      @stack = []
      @bindings = {}
    end

    def bind name, &block
      @bindings[name] = Operation.new name do |stack,bindings|
        args = []
        block.arity.times { args << stack.pop.evaluate(stack,bindings) }
        block.call *args
      end
    end

    def bind_lazy name, &block
      @bindings[name] = Operation.new name, &block
    end

    def state
      trace "#{@bindings.map {|b| b.join ' '}.join "\n"}"
      "State: #{@stack.join ' '}"
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
        when '.'
          trace "evaluating from #{@stack.last}"
          result = @stack.pop.evaluate @stack, @bindings
          @stack.push Literal.new result if result
        else
          @stack.push lookup token
        end
      end
    end
  end
end
