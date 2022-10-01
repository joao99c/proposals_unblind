# frozen_string_literal: true

module Admin
  module Editor
    class DealSectionItemsController < ApplicationController
      before_action :set_deal_section_item, only: %i[show edit update destroy reorder]
      before_action :parent
      before_action :set_deal

      # GET /deal_section_items or /deal_section_items.json
      def index
        @deal_section_items = @parent.deal_section_items
      end

      # GET /deal_section_items/1/edit
      def edit; end

      # POST /deal_section_items or /deal_section_items.json
      def create
        theme ||= {}
        if @parent.section.is_galeria?
          heading = "Imagem #{@parent.deal_section_items.length + 1}"
        elsif @parent.section.is_grelha?
          heading = "Item"
        elsif @parent.section.is_conteudo?
          heading = "Secção"
          theme ||= {}
          theme['image'] ||= {}
          theme['image']['organization'] = "left"
        elsif @parent.section.is_acordeao?
          heading = "Secção"
          theme ||= {}
        end
        @deal_section_item = @parent.deal_section_items.new(
          {
            child_attributes:
              {
                template: @template,
                section: Section.find_by_name('Grelha_Filho'),
                heading:,
                preHeading: '',
                subHeading: '',
                child: true,
                parent_id: @parent.id,
                theme:
              }
          }
        )

        respond_to do |format|
          if @deal_section_item.save
            @deal.broadcast_preview_create(@parent)
            format.html do
              redirect_to admin_deal_editor_deal_section_deal_section_items_url(deal: @deal.id, deal_section_id: @parent.id, template: @template),
                          notice: 'Deal section item was successfully created.'
            end
          end
        end
      end

      # PATCH/PUT /deal_section_items/1 or /deal_section_items/1.json
      def update
        @deal_section_item.child.button ||= {}
        @deal_section_item.child.button[:text] = params.require(:deal_section_item).dig("child_attributes", "button_text") if params.require(:deal_section_item).dig("child_attributes", "button_text")
        @deal_section_item.child.button[:url] = params.require(:deal_section_item).dig("child_attributes", "button_url") if params.require(:deal_section_item).dig("child_attributes", "button_url")

        if @parent.section.is_conteudo?
          @deal_section_item.child.theme ||= {}
          @deal_section_item.child.theme['image'] ||= {}
          @deal_section_item.child.theme['image']['organization'] = params.require(:deal_section_item)[:image_organization] if params.require(:deal_section_item)[:image_organization].present?
        end

        @deal_section_item.child.theme ||= {}
        @deal_section_item.child.theme['hidden'] ||= {}
        %w[heading logo text button].each do |visibility_item|
          @deal_section_item.child.theme['hidden'][visibility_item.to_s] = params.require(:deal_section_item)["hidden_#{visibility_item}"] if params.require(:deal_section_item)["hidden_#{visibility_item}"].present?
        end

        @deal_section_item.assign_attributes(deal_section_item_params)

        respond_to do |format|
          if @deal_section_item.save
            @deal.broadcast_preview_update(@parent)
            format.turbo_stream { render turbo_stream: [] }
          else
            format.html { render :edit, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /deal_section_items/1 or /deal_section_items/1.json
      def destroy
        @deal_section_item.destroy
        @deal.broadcast_preview_update(@parent)
        respond_to do |format|
          format.html do
            redirect_to edit_admin_deal_editor_deal_section_path(deal_id: @deal.id, id: @parent.id),
                        notice: 'Deal section item was successfully destroyed.'
          end
          format.json { head :no_content }
        end
      end

      def reorder
        @deal_section_item.insert_at(params[:position].to_i)
        head :ok
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_deal_section_item
        @deal_section_item = DealSectionItem.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def deal_section_item_params
        params.require(:deal_section_item).permit(
          child_attributes: %i[id heading text section_id logo]
        )
      end

      def parent
        @parent = DealSection.find(params[:deal_section_id])
      end

      def set_deal
        @deal = Deal.find(params[:deal_id])
        @template = if params[:template]
                      Template.find(params[:template])
                    else
                      @deal.template
                    end
      end
    end
  end
end
