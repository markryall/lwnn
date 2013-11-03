require_relative '../spec_helper'
require 'lwnn/cli'

describe Lwnn::Cli do
  let(:tokeniser) { Minitest::Mock.new }
  let(:executer) { Minitest::Mock.new }
  let(:io) { Minitest::Mock.new }
  let(:cli) { Lwnn::Cli.new io, tokeniser, executer }

  describe 'when run interactively' do
    it 'should abort on reading "exit"' do
      io.expect :gets, 'exit'
      cli.run
    end

    it 'should abort on eof' do
      io.expect :gets, nil
      cli.run
    end

    it 'should tokenise commands' do
      io.expect :gets, '1'
      io.expect :gets, nil
      tokeniser.expect :tokenise, ['1'], ['1']
      executer.expect :execute, nil, ['1']
      executer.expect :dump, nil, [$stdout]
      cli.run
    end
  end

  describe 'with file parameter' do
    it 'open file' do
      file_callback = ->(n) { n.must_equal 'foo.lwnn' }

      File.stub :open, file_callback do
        Lwnn::Cli.new.run 'foo.lwnn'
      end
    end
  end
end
