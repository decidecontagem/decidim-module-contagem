module Decidim
  module ContentBlocks
    class HorizontalMenuCell < Decidim::ViewModel
      def show
        render if published_components.any?
      end

      private

      def published_components
        return [] unless participatory_space

        @published_components ||= participatory_space.components.published.where(visible: true)
      end

      def participatory_space
        current_participatory_space
      end

      def component_path(component)
        Decidim::EngineRouter.main_proxy(component).root_path
      end
    end
  end
end