module Lwnn
  class Stack
    def initialize stack
      @stack = []
      stack.each {|item| @stack.push item }
    end

    def evaluate state
      @stack.each {|item| state.push item }
      state.evaluate
    end

    def to_s
      @stack.to_s
    end
  end
end
