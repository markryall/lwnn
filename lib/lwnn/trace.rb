module Lwnn
  module Trace
    def trace *messages
      puts messages.join(' ') if ENV['TRACE']
    end
  end
end
