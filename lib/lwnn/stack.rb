module Lwnn
  class Stack
    def initialize stack
      @stack = stack
    end

    def evaluate stack
      @stack.each {|item| stack.push item }
      nil
    end

    def to_s
      @stack.to_s
    end
  end
end
