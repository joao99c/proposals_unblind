# frozen_string_literal: true

module Admin
  module Editor
    class DealSectionsController < ApplicationController
      before_action :set_deal_section, only: %i[show edit update reorder confirm_destroy destroy]
      before_action :set_deal

      # GET /admin/editor/deal_sections or /admin/editor/deal_sections.json
      def index; end

      # GET /admin/editor/deal_sections/1 or /admin/editor/deal_sections/1.json
      def show; end

      def reorder
        @deal_section.insert_at(params[:position].to_i)
        head :ok
      end

      # GET /admin/editor/deal_sections/new
      def new
        @deal_section = DealSection.new
      end

      # GET /admin/editor/deal_sections/1/edit
      def edit; end

      # POST /admin/editor/deal_sections or /admin/editor/deal_sections.json
      def create
        @deal_section = @deal.deal_sections.new(params.permit(:section_id))
        respond_to do |format|
          if @deal_section.save
            format.turbo_stream do
              render turbo_stream: turbo_stream.update(
                helpers.dom_id(@deal, :sidebar),
                partial: 'admin/editor/deal_sections/edit', locals: { deal: @deal, deal_section: @deal_section }
              )
            end
          else
            format.html { render :new, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /admin/editor/deal_sections/1 or /admin/editor/deal_sections/1.json
      def update

        if @deal_section.section.is_bio?
          @deal_section.links ||= {}
          link_params = params.require(:deal_section).permit(:twitter, :facebook, :instagram, :pinterest, :linkdin, :youtube, :tiktok, :website, :mail)
          link_params.each do |key, value|
            @deal_section.links[key] = { name: key, url: value } unless value.blank?
          end
        end

        @deal_section.assign_attributes(deal_section_params)

        respond_to do |format|
          if @deal_section.save
            format.turbo_stream do
              render turbo_stream: [
                # turbo_stream.update(helpers.dom_id(@deal, :sidebar), ''),
                # turbo_stream.update(helpers.dom_id(@deal_section), inline: helpers.render_section(@deal_section))
              ]
            end
          else
            format.html { render :edit, status: :unprocessable_entity }
          end
        end
      end

      def confirm_destroy; end

      # DELETE /admin/editor/deal_sections/1 or /admin/editor/deal_sections/1.json
      def destroy
        @deal_section.destroy

        respond_to do |format|
          format.html do
            redirect_to admin_deal_editor_deal_sections_path(deal_id: @deal.id),
                        notice: 'Deal section item was successfully destroyed.'
          end
        end
      end

      private

      def set_deal
        @deal = Deal.find(params[:deal_id])
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_deal_section
        @deal_section = DealSection.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def deal_section_params
        params.require(:deal_section).permit(
          :section_id,
          :preHeading,
          :heading,
          :subHeading,
          :buttonSubtext,
          :theme,
          :background,
          :button,
          :button2,
          :text,
          :mediaAlignment,
          :mediaStyle,
          :position
        )
      end
    end
  end
end
