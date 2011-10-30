module Rails
  module Behaviors
    PATH = File.expand_path("../..", __FILE__)

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
