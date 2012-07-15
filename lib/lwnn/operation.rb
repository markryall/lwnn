require 'lwnn/trace'

module Lwnn
  class Operation
    include Trace

    def initialize name, &block
      @name, @block = name, block
    end

    def evaluate state
      trace "calling operation #{@name}"
      @block.call state
    end

    def to_s
      @name.to_s
    end
  end
end
