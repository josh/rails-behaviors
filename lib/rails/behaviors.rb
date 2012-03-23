module Rails
  module Behaviors
    PATH = File.expand_path("../..", __FILE__)
    VERSION = File.readlines("#{PATH}/rails.js")[1][/v([\d\.]+)$/,1]

    # Exposes JS load path for Sprockets.
    #
    # Examples
    #
    #   Assets.append_path Rails::Behaviors.path
    #
    def self.path
      PATH
    end

    # Internal: Get inline documentation for module.
    #
    # path - String require path for module
    #
    # Examples
    #
    #   Rails::Behaviors.documentation_for("rails/remote")
    #
    # Returns HTML string.
    def self.documentation_for(path)
      require 'rails/behaviors/documentation'
      unless File.exist?(path)
        filename = "#{File.join(Rails::Behaviors.path, path)}.coffee"
      end
      Documentation.parse(filename)
    end

    # BS for Rails
    if defined? ::Rails::Railtie
      class Railtie < ::Rails::Railtie
        initializer "rails.behaviors" do |app|
          app.assets.append_path Behaviors.path
        end
      end
    end
  end
end
