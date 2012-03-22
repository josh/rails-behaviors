require 'rake/clean'

require 'erb'
require 'pygments'
require 'redcarpet'


def markdown(text)
  options  = {:autolink => true, :fenced_code_blocks => true}
  markdown = Redcarpet::Markdown.new(Render, options)
  markdown.render(text)
end

class Render < Redcarpet::Render::HTML
  def header(text, header_level)
    if header_level <= 2
      id = " id=\"#{text.downcase.gsub(/\s+/, '_')}\""
    end
    "\n<h#{header_level}#{id}>#{text}</h#{header_level}>\n"
  end

  def definition_table(code, header = false)
    definitions = []

    code.lines.each do |line|
      if line =~ /^(\S.+)\s+-\s+(.+)$/
        definitions << [$1, $2]
      elsif line =~ /^\s\s(.+)$/
        definitions.last[1] << "#{$1}\n"
      elsif line =~ /^(\S.+)$/
        definitions << [$1, ""]
      end
    end

    html = []
    html << "<table>"

    if header
      term, definition = definitions.shift
      html << "  <thead>"
      html << "    <th><p>#{term}</p></th>"
      html << "    <th><p>#{definition}</p></th>"
      html << "  </thead>"
    end

    html << "  <tbody>"

    definitions.each do |term, definition|
      html << "<tr>"
      html << "<td>#{markdown(term)}</td>"

      if definition =~ /^(\S.+)\s+-\s+(.+)$/
        html << "<td>#{definition_table(definition)}</td>"
      else
        html << "<td>#{markdown(definition)}</td>"
      end

      html << "</tr>"
    end

    html << "  </tbody>"
    html << "</table>"

    html.join("\n")
  end

  def block_code(code, language)
    if language == 'definition-table'
      definition_table(code, true)
    else
      Pygments.highlight(code, :lexer => language)
    end
  end
end

file "index.html" => ["index.html.erb", "README.md"] do
  readme   = markdown(File.read("README.md"))
  template = ERB.new(File.read("index.html.erb"))
  result   = template.result(binding)
  File.open("index.html", 'w') { |f| f.write result }
end
CLOBBER.include 'index.html'


task :default => ['index.html']
