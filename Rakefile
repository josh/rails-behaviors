task :default => :dist

task :dist do
  require 'sprockets'
  require 'coffee-script'
  require 'uglifier'

  root = File.expand_path("..", __FILE__)
  env = Sprockets::Environment.new(root)
  env.append_path "lib"

  env['rails.js'].write_to('dist/rails.js')

  env.js_compressor = Uglifier.new
  env['rails.js'].write_to('dist/rails.min.js')
end

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
