require 'sprockets'
require 'coffee-script'
require 'json'

Root = File.expand_path("../..", __FILE__)

Assets = Sprockets::Environment.new(Root) do |env|
  env.append_path "."
  env.append_path "test"
  env.append_path "vendor"
end

map "/css" do
  run Assets
end

map "/js" do
  run Assets
end

map "/jquery-1.7.2.html" do
  run lambda { |env|
    html = <<-HTML
      <script type="text/javascript" src="/js/jquery-1.7.2.js"></script>
      <script type="text/javascript" src="/js/index.js"></script>
    HTML
    [200, {'Content-Type' => 'text/html'}, [html]]
  }
end

map "/jquery-1.8.3.html" do
  run lambda { |env|
    html = <<-HTML
      <script type="text/javascript" src="/js/jquery-1.8.3.js"></script>
      <script type="text/javascript" src="/js/index.js"></script>
    HTML
    [200, {'Content-Type' => 'text/html'}, [html]]
  }
end

map "/jquery-1.9.1.html" do
  run lambda { |env|
    html = <<-HTML
      <script type="text/javascript" src="/js/jquery-1.9.1.js"></script>
      <script type="text/javascript" src="/js/index.js"></script>
    HTML
    [200, {'Content-Type' => 'text/html'}, [html]]
  }
end

map "/jquery-2.0.3.html" do
  run lambda { |env|
    html = <<-HTML
      <script type="text/javascript" src="/js/jquery-2.0.3.js"></script>
      <script type="text/javascript" src="/js/index.js"></script>
    HTML
    [200, {'Content-Type' => 'text/html'}, [html]]
  }
end

map "/zepto-1.0.html" do
  run lambda { |env|
    html = <<-HTML
      <script type="text/javascript" src="/js/zepto-1.0.js"></script>
      <script type="text/javascript" src="/js/index.js"></script>
    HTML
    [200, {'Content-Type' => 'text/html'}, [html]]
  }
end


map "/echo" do
  use Rack::MethodOverride

  run lambda { |env|
    req = Rack::Request.new(env)
    env['params'] = req.params

    iframe   = env['QUERY_STRING'][/iframe=1/, 0]
    callback = env['QUERY_STRING'][/callback=(\w+)/, 1]

    if iframe && callback
      html = "<script>window.top.#{$1}(#{env.to_json})</script>"
      [200, {'Content-Type' => 'text/html'}, [html]]
    elsif callback
      js = "#{$1}(#{env.to_json})"
      [200, {'Content-Type' => 'application/javascript'}, [js]]
    else
      [200, {'Content-Type' => 'application/json'}, [env.to_json]]
    end
  }
end


map("/") { run Rack::File.new("#{Root}/test/index.html") }
