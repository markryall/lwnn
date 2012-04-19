require 'lwnn/tokeniser'
require 'lwnn/evaluation_context'

module Lwnn
  class Cli
    def self.run *args
      if args.empty?
        process $stdin
      else
        args.each {|arg| File.open(arg) {|file| process file } }
      end
    end

    def self.process io
      tokeniser = Lwnn::Tokeniser.new
      evaluation_context = Lwnn::EvaluationContext.new
      while line = io.gets
        line.chomp!
        return if line == 'exit'
        evaluation_context.evaluate *tokeniser.tokenise(line)
        $stdout.puts evaluation_context.state
      end
    end
  end
end
