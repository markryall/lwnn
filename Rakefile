require 'bundler/gem_tasks'
require 'rake/testtask'

task default: [:test, :acc]

Rake::TestTask.new(:acc) do |t|
  t.libs.push "lib"
  t.test_files = FileList['spec/acceptance/*_spec.rb']
  t.verbose = true
end

Rake::TestTask.new do |t|
  t.libs.push "lib"
  t.test_files = FileList['spec/lwnn/*_spec.rb']
  t.verbose = true
end