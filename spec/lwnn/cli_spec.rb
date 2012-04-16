$: << 'lib'

require 'lwnn/cli'

describe Lwnn::Cli do
  it 'should abort on reading "exit"' do
    Lwnn::Cli.should_receive(:gets).and_return 'exit'
    Lwnn::Cli.run
  end
end
