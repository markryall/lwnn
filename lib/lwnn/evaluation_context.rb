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

  OPERATIONS = {}

  def self.operation name, &block
    OPERATIONS[name] = Operation.new name do |stack|
      l = stack.pop.evaluate stack
      r = stack.pop.evaluate stack
      block.call l, r
    end
  end

  operation('+') {|l,r| l + r }
  operation('-') {|l,r| l - r }
  operation('*') {|l,r| l * r }
  operation('/') {|l,r| l / r }

  class EvaluationContext
    def initialize
      @stack = []
    end

    def state
      'State: '+@stack.join(' ')
    end

    def lookup token
      return OPERATIONS[token] if OPERATIONS.has_key? token
      Literal.new token
    end

    def evaluate *tokens
      tokens.each do |token|
        case token
        when /[0-9]+/
          @stack.push Literal.new token.to_i
        when '.'
          @stack.push Literal.new @stack.pop.evaluate @stack
        else
          @stack.push lookup token
        end
      end
    end
  end
end
