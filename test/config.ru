require 'sprockets'
require 'coffee-script'
require 'json'

Root = File.expand_path("../..", __FILE__)

FRAMEWORKS = %w[ jquery-1.7.2 jquery-1.8.3 jquery-1.9.1 jquery-2.0.3 jquery-2.1.3 zepto-1.0 zepto-1.1.6 ]

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

run lambda { |env|
  if '/' == env['PATH_INFO']
    frameworks = FRAMEWORKS
    html = ERB.new(File.read("#{Root}/test/index.html")).result(binding)
    [200, {'Content-Type' => 'text/html'}, [html]]
  elsif env['PATH_INFO'] =~ %r{^/(.+)\.html$} && FRAMEWORKS.include?($1)
    html = <<-HTML
      <script type="text/javascript" src="/js/#{$1}.js"></script>
      <script type="text/javascript" src="/js/index.js"></script>
    HTML
    [200, {'Content-Type' => 'text/html'}, [html]]
  else
    [404, {'Content-Type' => 'text/plain'}, ["Not found"]]
  end
}
