require 'lwnn/stack'

module Lwnn
  class State
    def initialize
      @stack = []
      @bindings = {}
    end

    def peek
      @stack.last
    end

    def pop
      @stack.pop
    end

    def push value
      @stack.push value
    end

    def []= key, value
      @bindings[key] = value
    end

    def lookup key
      return @bindings[key] if @bindings.has_key? key
      Literal.new key
    end

    def evaluate
      @stack.pop.evaluate self
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