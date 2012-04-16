module Lwnn
  class Cli
    def self.run *args
      while line = gets
        line.chomp!
        return if line == 'exit'
        puts 'Stack: 2'
      end
    end
  end
end
