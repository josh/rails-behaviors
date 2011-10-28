require 'rake/clean'

require 'sprockets'
require 'coffee-script'
require 'uglifier'

root = File.expand_path("..", __FILE__)
Assets = Sprockets::Environment.new(root) do |env|
  env.append_path "lib"
end

CLEAN.include "lib/rails/*.js"
CLOBBER.include "dist/*"

task :build do
  Dir["#{root}/lib/rails/*.coffee"].each do |file|
    Assets[file].write_to(file.sub(/\.coffee$/, '.js'))
  end
end

task :dist do
  Assets['rails.js'].write_to('dist/rails.js')
  Assets.js_compressor = Uglifier.new
  Assets['rails.js'].write_to('dist/rails.min.js')
end

task :default => :dist

task :test do
  Dir.chdir File.dirname(__FILE__)

  pid = fork do
    exec 'rackup', '-p', '3000', 'config.ru'
  end

  sleep 2

  system 'open', 'http://localhost:3000/'

  sleep 3

  Process.kill 'SIGINT', pid
  Process.wait pid
end
