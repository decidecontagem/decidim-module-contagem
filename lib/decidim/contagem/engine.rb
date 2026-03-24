# frozen_string_literal: true

require "rails"
require "decidim/core"

module Decidim
  module Contagem
    # This is the engine that runs on the public interface of contagem.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::Contagem

      routes do
        # Add engine routes here
        # resources :contagem
        # root to: "contagem#index"
      end

      initializer "Contagem.shakapacker.assets_path" do
        Decidim.register_assets_path File.expand_path("app/packs", root)
      end

      initializer "Contagem.data_migrate", after: "decidim_core.data_migrate" do
        DataMigrate.configure do |config|
          config.data_migrations_path << root.join("db/data").to_s
        end
      end

      initializer "Contagem.setup_omniauth" do
        Decidim.omniauth_providers[:govbr] = {
          enabled:        false,
          icon_path:      "media/images/govbr.svg",
        }
      end
    end
  end
end
