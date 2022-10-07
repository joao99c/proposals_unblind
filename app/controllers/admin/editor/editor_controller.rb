# frozen_string_literal: true

module Admin
  module Editor
    class EditorController < ApplicationController
      layout 'editor'
      before_action :set_deal

      def index; end

      def preview; end

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
        @template = if params[:template]
                      Template.find(params[:template])
                    else
                      @deal.template
                    end
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
          :text_height,

          :section_heading_typeface_id,
          :section_heading_weight,
          :section_heading_spacing,
          :section_heading_height,

          :sub_section_heading_typeface_id,
          :sub_section_heading_weight,
          :sub_section_heading_spacing,
          :sub_section_heading_height,

          :link_typeface_id,
          :link_weight,
          :link_spacing,
          :link_height,

          :button_typeface_id,
          :button_weight,
          :button_spacing,
          :button_height,
          :button_background_color,
          :button_border_color,
          :button_border_width,
          :button_border_radius
        )
      end
    end
  end
end
