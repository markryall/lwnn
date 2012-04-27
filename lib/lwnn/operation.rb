module Lwnn
  class Operation
    def initialize name, &block
      @name, @block = name, block
    end

    def evaluate stack
      @block.call stack
    end

    def to_s
      @name.to_s
    end
  end
end
