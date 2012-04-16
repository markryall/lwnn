$: << 'lib'

require 'lwnn/cli'

describe Lwnn::Cli do
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
end
