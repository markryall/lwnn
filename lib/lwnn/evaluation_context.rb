module Lwnn
end

class Lwnn::EvaluationContext
  def state
    'State: '+@tokens.join(' ')
  end

  def evaluate *tokens
    @tokens = tokens
  end
end
