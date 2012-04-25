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
      @stack.push evaluate_stack
    else
      @stack.push token
    end
  end

  def evaluate_stack
    token = @stack.pop
    case token
    when /[0-9]+/
      token.to_i
    when '+'
      evaluate_stack + evaluate_stack
    when '-'
      evaluate_stack - evaluate_stack
    end
  end
end
