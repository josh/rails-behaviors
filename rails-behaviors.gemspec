Gem::Specification.new do |s|
  s.name    = "rails-behaviors"
  s.version = "0.1.0"

  s.homepage = "https://github.com/josh/rails-behaviors"
  s.summary  = "Rails UJS Behaviors for jQuery"
  s.description = "Implements Rails UJS Behaviors"

  s.files = Dir["README.md", "lib/**/*.{rb,js}"]

  s.add_dependency "sprockets", "~>2.0"
  s.add_development_dependency "coffee-script"
  s.add_development_dependency "rake"
  s.add_development_dependency "uglifier"

  s.author = "Joshua Peek"
  s.email  = "josh@joshpeek.com"
end
