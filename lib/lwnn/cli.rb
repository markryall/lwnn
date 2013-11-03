require 'lwnn/tokeniser'
require 'lwnn/executor'
require 'lwnn/readline_io'
require 'readline'

module Lwnn
  class Cli
    attr_reader :readline, :tokeniser, :executor

    def initialize readline=nil, tokeniser=nil, executor=nil
      @readline = readline || ReadlineIo.new('> ')
      @tokeniser = tokeniser || Lwnn::Tokeniser.new
      @executor = executor || Lwnn::Executor.new
    end

    def run *args
      if args.empty?
        process readline, true
      else
        args.each {|arg| File.open(arg) {|file| process file, false } }
      end
    end

    def process io, interactive
      while line = io.gets
        line.chomp!
        return if line == 'exit'
        executor.execute *tokeniser.tokenise(line)
        executor.dump $stdout if interactive
      end
    end
  end
end
