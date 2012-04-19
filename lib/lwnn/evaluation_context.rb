module Lwnn
end

class Lwnn::EvaluationContext
  def evaluate *tokens
    puts 'Stack: '+tokens.join(' ')
  end
end
