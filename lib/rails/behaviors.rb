module Rails
  module Behaviors
    PATH = File.expand_path("../..", __FILE__)
    VERSION = File.readlines("#{PATH}/rails.js")[1][/v([\d\.]+)$/,1]

    # Exposes JS load path for Sprockets.
    #
    #   Assets.append_path Rails::Behaviors.path
    #
    def self.path
      PATH
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
