module Lwnn
end

class Lwnn::EvaluationContext
  def state
    'State: '+@stack.join(' ')
  end

  def evaluate *tokens
    @stack ||= []
    tokens.each { |token| process token }
  end
private
  def process token
    case token
    when '.'
      evaluate_stack
    else
      @stack.push token
    end
  end

  def evaluate_stack
    operation = @stack.pop
    case operation
    when '+'
      @stack.push @stack.pop.to_i + @stack.pop.to_i
    when '-'
      @stack.push @stack.pop.to_i - @stack.pop.to_i
    end
  end
end
