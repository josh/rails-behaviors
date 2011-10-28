require 'rake/clean'

require 'sprockets'
require 'coffee-script'
require 'uglifier'

root = File.expand_path("..", __FILE__)
Assets = Sprockets::Environment.new(root) do |env|
  env.append_path "src"
end

CLEAN.include "dist/*"

task :build do
  Dir["#{root}/src/rails/*.coffee"].each do |file|
    output = file.sub('src', 'lib').sub(/\.coffee$/, '.js')
    Assets[file].write_to(output)
  end
  FileUtils.cp "#{root}/src/rails.js", "#{root}/lib"
end

task :dist => :build do
  Assets['rails.js'].write_to('dist/rails.js')
  Assets.js_compressor = Uglifier.new
  Assets['rails.js'].write_to('dist/rails.min.js')
end

task :default => :dist

task :test => :build do
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
