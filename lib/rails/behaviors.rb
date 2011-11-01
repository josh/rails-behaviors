module Rails
  module Behaviors
    PATH = File.expand_path("../..", __FILE__)

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
