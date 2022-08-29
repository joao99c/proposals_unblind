# frozen_string_literal: true

module Admin
  module Editor
    class EditorController < ApplicationController
      layout 'editor'
      before_action :set_deal

      def index; end

      def preview
        @text_preview_item = TextSection.new
        @bio_preview_item = BioSection.new
        @grid_preview_item = GridSection.new
      end

      def fonts; end

      def update_fonts
        @deal.update(deal_params)
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: [
              # turbo_stream.update(helpers.dom_id(@deal, :sidebar), ''),
              # turbo_stream.update(helpers.dom_id(@deal_section), inline: helpers.render_section(@deal_section))
            ]
          end
        end
      end

      private

      def set_deal
        @deal = Deal.find(params[:deal_id])
      end

      def deal_params
        params.require(:deal).permit(
          :heading_typeface_id,
          :heading_weight,
          :heading_spacing,
          :heading_height,

          :text_typeface_id,
          :text_weight,
          :text_spacing,
          :text_height
        )
      end
    end
  end
end
