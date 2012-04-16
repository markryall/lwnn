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
      while line = io.gets
        line.chomp!
        return if line == 'exit'
        puts 'Stack: 2'
      end
    end
  end
end
