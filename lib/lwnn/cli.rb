require 'lwnn/tokeniser'
require 'lwnn/base_evaluation_context'
require 'readline'

module Lwnn
  class ReadlineIo
    def initialize prompt
      @prompt = prompt
    end

    def gets
      Readline.readline @prompt, true
    end
  end

  class Cli
    def self.run *args
      if args.empty?
        process ReadlineIo.new('> '), true
      else
        args.each {|arg| File.open(arg) {|file| process file, false } }
      end
    end

    def self.process io, interactive
      tokeniser = Lwnn::Tokeniser.new
      evaluation_context = Lwnn::BaseEvaluationContext.build
      while line = io.gets
        line.chomp!
        return if line == 'exit'
        evaluation_context.evaluate *tokeniser.tokenise(line)
        $stdout.puts evaluation_context.state if interactive
      end
    end
  end
end
