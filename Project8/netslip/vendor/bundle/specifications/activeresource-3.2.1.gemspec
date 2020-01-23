# -*- encoding: utf-8 -*-
# stub: activeresource 3.2.1 ruby lib

Gem::Specification.new do |s|
  s.name = "activeresource".freeze
  s.version = "3.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["David Heinemeier Hansson".freeze]
  s.date = "2012-01-26"
  s.description = "REST on Rails. Wrap your RESTful web app with Ruby classes and work with them like Active Record models.".freeze
  s.email = "david@loudthinking.com".freeze
  s.extra_rdoc_files = ["README.rdoc".freeze]
  s.files = ["README.rdoc".freeze]
  s.homepage = "http://www.rubyonrails.org".freeze
  s.rdoc_options = ["--main".freeze, "README.rdoc".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7".freeze)
  s.rubygems_version = "3.0.3".freeze
  s.summary = "REST modeling framework (part of Rails).".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>.freeze, ["= 3.2.1"])
      s.add_runtime_dependency(%q<activemodel>.freeze, ["= 3.2.1"])
    else
      s.add_dependency(%q<activesupport>.freeze, ["= 3.2.1"])
      s.add_dependency(%q<activemodel>.freeze, ["= 3.2.1"])
    end
  else
    s.add_dependency(%q<activesupport>.freeze, ["= 3.2.1"])
    s.add_dependency(%q<activemodel>.freeze, ["= 3.2.1"])
  end
end
