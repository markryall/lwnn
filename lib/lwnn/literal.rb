require 'lwnn/trace'

module Lwnn
  class Literal
    include Trace

    def initialize value
      @value = value
    end

    def evaluate state
      trace "evaluating literal to #{@value}"
      @value
    end

    def to_s
      @value.to_s
    end
  end
end
