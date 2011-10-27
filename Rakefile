task :default => :test

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
