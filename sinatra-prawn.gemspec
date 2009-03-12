# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sinatra-prawn}
  s.version = "0.9.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["S. Brent Faulkner"]
  s.date = %q{2009-03-11}
  s.description = %q{Sinatra extension to add support for pdf rendering with Prawn templates.}
  s.email = %q{brentf@unwwwired.net}
  s.files = ["README.rdoc", "VERSION.yml", "lib/sinatra", "lib/sinatra/prawn.rb", "test/sinatra_prawn_test.rb", "test/test_helper.rb", "test/views", "test/views/hello.prawn"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/sbfaulkner/sinatra-prawn}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Sinatra extension to add support for pdf rendering with Prawn templates.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<prawn>, [">= 0"])
    else
      s.add_dependency(%q<prawn>, [">= 0"])
    end
  else
    s.add_dependency(%q<prawn>, [">= 0"])
  end
end
