require 'lwnn/tokeniser'
require 'lwnn/executor'
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
      executor = Lwnn::Executor.new
      while line = io.gets
        line.chomp!
        return if line == 'exit'
        executor.execute *tokeniser.tokenise(line)
        executor.dump $stdout if interactive
      end
    end
  end
end
