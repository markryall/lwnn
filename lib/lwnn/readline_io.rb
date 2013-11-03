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
end