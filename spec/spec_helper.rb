require 'minitest/autorun'
require 'pp'

module LwnnHelper
  def evaluation_for input
    lines = `echo '#{input}' | ./bin/lwnn`.split("\n")
    match = /State: /.match lines.last
    match.post_match
  end
end
