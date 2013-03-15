require 'lwnn/stack'
require 'lwnn/trace'

module Lwnn
  class State
    include Trace

    def initialize
      @stack = []
      @bindings = {}
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
    end

    def []= key, value
      @bindings[key] = value
    end

    def lookup key
      return @bindings[key] if @bindings.has_key? key
    end

    def evaluate
      if peek
        @stack.pop.evaluate self
      else
        push_literal 'missing_expected_operand'
        nil
      end
    end

    def to_s
      @stack.join ' '
    end

    def let
      self[evaluate] = Stack.new @stack
      @stack.clear
      nil
    end
  end
end
