module Lwnn
  class Literal
    def initialize value
      @value = value
    end

    def evaluate stack
      @value
    end

    def to_s
      @value.to_s
    end
  end
end
