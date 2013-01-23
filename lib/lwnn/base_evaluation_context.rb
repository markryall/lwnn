require 'lwnn/evaluation_context'

module Lwnn
  module BaseEvaluationContext
    def self.build
      ec = EvaluationContext.new

      inj = lambda do |args, &block|
        first, *rest = args
        rest.inject first, &block
      end

      ec.bind_op('+') {|args| inj.call(args) {|a,v| a + v } }
      ec.bind_op('-') {|args| inj.call(args) {|a,v| a - v } }
      ec.bind_op('*') {|args| inj.call(args) {|a,v| a * v } }
      ec.bind_op('/') {|args| inj.call(args) {|a,v| a / v } }

      compare = lambda do |args, &comparator|
        l, *rest = args
        while r = rest.shift
          return 'false' unless comparator.call(l,r)
          l = r
        end
        return 'true'
      end

      ec.bind_op('<')   {|args| compare.call(args) {|l,r| l <  r } }
      ec.bind_op('>')   {|args| compare.call(args) {|l,r| l >  r } }
      ec.bind_op('>=')  {|args| compare.call(args) {|l,r| l >= r } }
      ec.bind_op('<=')  {|args| compare.call(args) {|l,r| l <= r } }
      ec.bind_op('=')   {|args| compare.call(args) {|l,r| l == r } }

      ec.bind_op('and') {|args| args.any? {|v| v == 'false'} ? 'false' : 'true' }
      ec.bind_op('or')  {|args| args.any? {|v| v == 'true'} ? 'true' : 'false' }

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
      ec
    end
  end
end
