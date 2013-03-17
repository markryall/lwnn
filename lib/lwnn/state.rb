require 'lwnn/stack'
require 'lwnn/trace'

module Lwnn
  class State
    include Trace

    def initialize
      @stack = []
      @contexts = [{}]
    end

    def down
      @contexts.unshift({})
      nil
    end

    def up
      @contexts.shift
      nil
    end

    def clear
      @stack.clear
    end

    def peek
      @stack.last
    end

    def pop
      trace "state #{@stack} before popping #{peek}"
      @stack.pop
    end

    def push value
      trace "state #{@stack} before pushing #{value}"
      @stack.push value
    end

    def push_literal value
      push Literal.new value, self
      nil
    end

    def []= key, value
      @contexts.first[key] = value
    end

    def has_binding? key
      @contexts.first.has_key? key
    end

    def lookup key
      @contexts.each do |context|
        return context[key] if context.has_key? key
      end
      nil
    end

    def evaluate
      if peek
        @stack.pop.evaluate self
      else
        push_literal 'missing_expected_operand'
      end
    end

    def to_s
      @stack.join ' '
    end

    def let
      if peek.bound?
        pop
        push_literal 'attempted_reassignment'
      else
        self[pop.value] = Stack.new @stack
        @stack.clear
        nil
      end
    end
  end
end