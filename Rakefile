require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "smsified"
  gem.homepage = "http://github.com/tropo/smsified-oneapi"
  gem.license = "MIT"
  gem.summary = "Gem for consuming the SMSified OneAPI"
  gem.description = "Gem for consuming the SMSified OneAPI"
  gem.email = "jsgoecke@voxeo.com"
  gem.authors = ["Jason Goecke"]
  gem.add_runtime_dependency 'httparty'
  gem.files = Dir.glob("{lib}/**/*") + %w(README.md)
  gem.require_path = 'lib'
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new
