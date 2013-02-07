class LwnnMatcher
  def initialize expected, suffix=''
    @expected, @suffix = expected.strip, suffix
  end

  def matches? input
    lines = `echo '#{input} #{@suffix}' | ./bin/lwnn`.split("\n")
    match = /State: /.match lines[1]
    @actual = match.post_match
    @actual == @expected
  end

  def failure_message
    "expected:\n\t#{@expected.inspect}\nactual:\n\t#{@actual.inspect}"
  end
end

module LwnnHelper
  def evaluate_to string
    LwnnMatcher.new string, ' .'
  end

  def result_in string
    LwnnMatcher.new string
  end
end