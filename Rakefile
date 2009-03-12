require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "sinatra-prawn"
    s.summary = %Q{Sinatra extension to add support for pdf rendering with Prawn templates.}
    s.email = "brentf@unwwwired.net"
    s.homepage = "http://github.com/sbfaulkner/sinatra-prawn"
    s.description = "Sinatra extension to add support for pdf rendering with Prawn templates."
    s.authors = ["S. Brent Faulkner"]
    s.add_dependency "prawn"
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = 'sinatra-prawn'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib' << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |t|
    t.libs << 'test'
    t.test_files = FileList['test/**/*_test.rb']
    t.verbose = true
  end
rescue LoadError
  puts "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
end

task :default => :test
