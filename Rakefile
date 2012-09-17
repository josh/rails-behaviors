require 'coffee-script'

task :build do
  Dir['lib/**/*.coffee'].each do |src|
    dest = src.sub(/\.coffee/, '.js')
    data = CoffeeScript.compile(File.read(src))
    File.open(dest, 'w') { |f| f.write(data) }
  end
end

task :default => :build
