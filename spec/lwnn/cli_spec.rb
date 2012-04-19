$: << 'lib'

require 'lwnn/cli'

describe Lwnn::Cli do
  let(:tokeniser) { stub 'tokeniser' }
  let(:evaluation_context) { stub 'evaluation context' }

  before do
    Lwnn::Tokeniser.stub!(:new).and_return tokeniser
    Lwnn::EvaluationContext.stub!(:new).and_return evaluation_context
  end

  it 'should abort on reading "exit"' do
    $stdin.should_receive(:gets).and_return 'exit'
    Lwnn::Cli.run
  end

  it 'should abort on eof' do
    $stdin.should_receive(:gets).and_return nil
    Lwnn::Cli.run
  end

  it 'should read from file instead of stdin when passed parameters' do
    io = stub 'io'
    io.should_receive(:gets).and_return nil
    File.should_receive(:open).with('foo.lwnn').and_yield io
    Lwnn::Cli.run 'foo.lwnn'
  end

  it 'should tokenise commands' do
    tokeniser.should_receive(:tokenise).with('1').and_return(['1'])
    $stdin.should_receive(:gets).and_return '1'
    $stdin.should_receive(:gets).and_return nil
    evaluation_context.should_receive(:evaluate).with('1')
    #$stdout.should_receive(:puts).with 'Stack: 1'
    Lwnn::Cli.run
  end
end
