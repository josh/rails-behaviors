require File.expand_path("../lib/rails/behaviors", __FILE__)

Gem::Specification.new do |s|
  s.name    = "rails-behaviors"
  s.version = Rails::Behaviors::VERSION

  s.homepage = "https://github.com/josh/rails-behaviors"
  s.summary  = "Rails UJS Behaviors"
  s.description = "Implements Rails UJS Behaviors"

  s.files = Dir["README.md", "lib/**/*"]

  s.add_dependency "sprockets", "~>2.0"
  s.add_dependency "coffee-script", "~>2.2"
  s.add_dependency "coffee-script-source", "~>1.1"
  s.add_development_dependency "rake"
  s.add_development_dependency "uglifier"

  s.author = "Joshua Peek"
  s.email  = "josh@joshpeek.com"
end
