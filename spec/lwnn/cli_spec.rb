$: << 'lib'

require 'lwnn/cli'

describe Lwnn::Cli do
  let(:tokeniser) { stub 'tokeniser' }
  let(:evaluation_context) { stub 'evaluation context', :evalua => nil, :state => nil }

  before do
    Lwnn::Tokeniser.stub!(:new).and_return tokeniser
    Lwnn::EvaluationContext.stub!(:new).and_return evaluation_context
    evaluation_context.stub!(:evaluate)
  end

  def with_stdin *strings
    strings.each {|string| $stdin.should_receive(:gets).and_return string }
  end

  it 'should abort on reading "exit"' do
    with_stdin 'exit'
    Lwnn::Cli.run
  end

  it 'should abort on eof' do
    with_stdin nil
    Lwnn::Cli.run
  end

  it 'should tokenise commands' do
    with_stdin '1', nil
    tokeniser.should_receive(:tokenise).with('1').and_return(['1'])
    evaluation_context.should_receive(:evaluate).with('1')
    Lwnn::Cli.run
  end

  it 'should write out stack to stdout when running interactively' do
    with_stdin '1', nil
    tokeniser.should_receive(:tokenise).with('1').and_return(['1'])
    evaluation_context.should_receive(:state).and_return 'state'
    $stdout.should_receive(:puts).with 'state'
    Lwnn::Cli.run
  end

  describe 'with file parameter' do
    let(:io) { stub 'io', :gets => nil }

    it 'should read from file instead of stdin when passed parameters' do
      File.should_receive(:open).with('foo.lwnn').and_yield io
      Lwnn::Cli.run 'foo.lwnn'
    end
  end
end
