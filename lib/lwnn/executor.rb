require 'lwnn/base_evaluation_context'

module Lwnn
  class Executor
    def initialize
      @base = BaseEvaluationContext.build
    end

    def execute *tokens
      @base.evaluate *tokens
    end

    def dump io
      io.puts @base.state
    end
  end
end