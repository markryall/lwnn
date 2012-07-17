require 'lwnn/trace'

module Lwnn
  class Stack
    include Trace

    def initialize stack
      @stack = []
      stack.each {|item| @stack.push item }
      trace "binding now #{@stack}"
    end

    def evaluate state
      trace "evaluating binding #{@stack}"
      @stack.each {|item| state.push item }
      state.evaluate
    end

    def to_s
      @stack.to_s
    end
  end
end
