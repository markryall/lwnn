Gem::Specification.new do |spec|
  spec.name = 'lwnn'
  spec.version = '0.0.1'
  spec.summary = 'an intense programming language that was written on a bus'
  spec.description = 'another pointless experiment with a new programming language'

  spec.authors << 'Mark Ryall'
  spec.email = 'mark@ryall.name'
  spec.homepage = 'http://github.com/markryall/lwnn'

  spec.files = Dir['lib/**/*'] + Dir['bin/*'] + ['README.rdoc', 'MIT-LICENSE']
  spec.executables << 'lwnn'

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'aruba'
end
