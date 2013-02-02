require 'lwnn/evaluation_context'

module Lwnn
  module BaseEvaluationContext
    def self.build
      EvaluationContext.new.tap do |ec|
        ec.bind_op('+') {|l,r| l + r }
        ec.bind_op('-') {|l,r| l - r }
        ec.bind_op('*') {|l,r| l * r }
        ec.bind_op('/') {|l,r| l / r }

        ec.bind_op('<') {|l,r| l < r ? 'true' : 'false'}
        ec.bind_op('>') {|l,r| l > r ? 'true' : 'false'}
        ec.bind_op('>=') {|l,r| l >=r ? 'true' : 'false'}
        ec.bind_op('<=') {|l,r| l <=r ? 'true' : 'false'}
        ec.bind_op('=') {|l,r| l == r ? 'true' : 'false'}

        ec.bind_op('and') {|l,r| l == 'true' && r == 'true' ? 'true' : 'false'}
        ec.bind_op('or') {|l,r| l == 'true' || r == 'true' ? 'true' : 'false'}

        ec.bind('rm') {|state| state.pop; state.pop }

        ec.bind('dup') {|state| state.peek.evaluate state }
        ec.bind('swap') do |state|
          a,b = state.pop, state.pop
          state.push a
          b.evaluate state
        end
        ec.bind('let') {|state| state.let }
        ec.bind('if') do |state|
          con, t, f = state.evaluate, state.pop, state.pop
          con == 'true' ? t.evaluate(state) : f.evaluate(state)
        end
      end
    end
  end
end
