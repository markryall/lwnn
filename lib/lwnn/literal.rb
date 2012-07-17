require 'lwnn/trace'

module Lwnn
  class Literal
    include Trace

    def initialize value, state
      @value, @state = value, state
    end

    def evaluate state
      binding = @state.lookup @value
      if binding
        trace "evaluating binding associated with #{@value}"
        binding.evaluate @state
      else
        trace "evaluating unbound literal to #{@value}" unless binding
        @value
      end
    end

    def to_s
      @value.to_s
    end
  end
end
