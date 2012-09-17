task :default => :test

task :test do
  Dir.chdir File.dirname(__FILE__)

  port = ENV.fetch("PORT", "3000")

  pid = fork do
    $stderr.reopen "/dev/null" # silence WEBrick output
    exec 'rackup', '-p', port, './test/config.ru'
  end
  sleep 2

  status = system 'phantomjs', './vendor/run-qunit.coffee', "http://localhost:#{port}/"

  Process.kill 'SIGINT', pid
  Process.wait pid

  exit status
end
