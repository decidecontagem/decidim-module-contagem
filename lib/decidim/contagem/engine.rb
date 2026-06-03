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

      initializer "Contagem.add_cells_view_paths" do
        Cell::ViewModel.view_paths << File.expand_path("#{Decidim::Contagem::Engine.root}/app/cells")
      end

      initializer "Contagem.content_blocks" do
        Decidim.content_blocks.register(:participatory_process_homepage, :horizontal_menu) do |content_block|
          content_block.cell = "decidim/content_blocks/horizontal_menu"
          content_block.public_name_key = "decidim.content_blocks.horizontal_menu.name"
        end

        Decidim.content_blocks.register(:assembly_homepage, :horizontal_menu) do |content_block|
          content_block.cell = "decidim/content_blocks/horizontal_menu"
          content_block.public_name_key = "decidim.content_blocks.horizontal_menu.name"
        end
      end
    end
  end
end
