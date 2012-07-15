module Lwnn
  class Stack
    def initialize stack
      @stack = []
      stack.each {|item| @stack.push item }
    end

    def evaluate stack, bindings
      @stack.each {|item| stack.push item }
      stack.pop.evaluate stack, bindings
    end

    def to_s
      @stack.to_s
    end
  end
end
