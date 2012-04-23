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
    when '+'
      @stack.push @stack.pop.to_i + @stack.pop.to_i
    else
      @stack.push token
    end
  end
end
