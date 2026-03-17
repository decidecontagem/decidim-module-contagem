# frozen_string_literal: true

module Decidim
  module Contagem
    # This is the engine that runs on the public interface of `Contagem`.
    class AdminEngine < ::Rails::Engine
      isolate_namespace Decidim::Contagem::Admin

      paths["db/migrate"] = nil
      paths["lib/tasks"] = nil

      routes do
        # Add admin engine routes here
        # resources :contagem do
        #   collection do
        #     resources :exports, only: [:create]
        #   end
        # end
        # root to: "contagem#index"
      end

      def load_seed
        nil
      end
    end
  end
end
