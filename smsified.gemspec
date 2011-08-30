# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{smsified}
  s.version = "0.1.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = [%q{Jason Goecke}, %q{John Dyer}]
  s.date = %q{2011-08-30}
  s.description = %q{Gem for consuming the SMSified OneAPI}
  s.email = [%q{jsgoecke@voxeo.com}, %q{jdyer@voxeo.com}]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    "README.md",
    "lib/smsified.rb",
    "lib/smsified/helpers.rb",
    "lib/smsified/incoming_message.rb",
    "lib/smsified/oneapi.rb",
    "lib/smsified/reporting.rb",
    "lib/smsified/response.rb",
    "lib/smsified/subscriptions.rb"
  ]
  s.homepage = %q{http://github.com/tropo/smsified-oneapi}
  s.licenses = [%q{MIT}]
  s.require_paths = [%q{lib}]
  s.rubygems_version = %q{1.8.6}
  s.summary = %q{Gem for consuming the SMSified OneAPI}
  s.test_files = [
    "examples/sending_and_subscribing.rb",
    "spec/smsified_spec.rb",
    "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 2.3.0"])
      s.add_development_dependency(%q<yard>, ["~> 0.6.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<fakeweb>, [">= 0"])
      s.add_development_dependency(%q<awesome_print>, [">= 0"])
      s.add_development_dependency(%q<json>, [">= 0"])
      s.add_runtime_dependency(%q<httparty>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, ["~> 2.3.0"])
      s.add_dependency(%q<yard>, ["~> 0.6.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<fakeweb>, [">= 0"])
      s.add_dependency(%q<awesome_print>, [">= 0"])
      s.add_dependency(%q<json>, [">= 0"])
      s.add_dependency(%q<httparty>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 2.3.0"])
    s.add_dependency(%q<yard>, ["~> 0.6.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<fakeweb>, [">= 0"])
    s.add_dependency(%q<awesome_print>, [">= 0"])
    s.add_dependency(%q<json>, [">= 0"])
    s.add_dependency(%q<httparty>, [">= 0"])
  end
end

