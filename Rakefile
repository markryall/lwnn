require 'bundler/gem_tasks'

task :default => :test
task(:spec) { sh 'rspec spec' }
task(:cuke) { sh 'cucumber' }
task :test => [:spec, :cuke]
