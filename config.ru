require 'sprockets'
require 'coffee-script'
require 'json'

Root = File.expand_path("..", __FILE__)

Assets = Sprockets::Environment.new(Root) do |env|
  env.append_path "test"
  env.append_path "lib"
  env.append_path "vendor"
end

map "/css" do
  run Assets
end

map "/js" do
  run Assets
end

map "/echo" do
  use Rack::MethodOverride

  run lambda { |env|
    req = Rack::Request.new(env)
    env['params'] = req.params

    if env['QUERY_STRING'] =~ /callback=(\w+)/
      html = "<script>window.top.#{$1}(#{env.to_json})</script>"
      [200, {'Content-Type' => 'text/html'}, [html]]
    else
      [200, {'Content-Type' => 'application/json'}, [env.to_json]]
    end
  }
end

map "/" do
  run Rack::File.new("#{Root}/test/test.html")
end
