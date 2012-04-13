module Lwnn
  class Cli
    def self.run *args
      while line = gets
        line.chomp!
        exit if line == 'exit'
        puts 'Stack: 2'
      end
    end
  end
end
