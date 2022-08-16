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

      def sections; end

      private

      def set_deal
        @deal = Deal.find(params[:deal_id])
      end

      def deal_text_section_params
        params.require(:deal_section).permit(:preHeading, :heading, :subHeading)
      end
    end
  end
end
