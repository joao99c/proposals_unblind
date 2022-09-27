# frozen_string_literal: true

module Admin
  module Editor
    class DealSectionsController < ApplicationController
      before_action :set_deal_section, only: %i[show edit update reorder destroy]
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
        case params.permit(:section_id)[:section_id]
        when '1'
          @deal_section = TextSection.new
        when '2'
          @deal_section = BioSection.new
        when '4'
          @deal_section = GridSection.new
          @deal_section.deal_section_items = []
        when '6'
          @deal_section = GallerySection.new
        end
        @deal_section.deal = @deal
        @deal_section = @deal_section.becomes(DealSection)

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
        if @deal_section.section.is_cabecalho?
          if params.require(:deal_section).permit(:date)[:date]
            @deal.send_date = params.require(:deal_section).permit(:date)[:date]
            @deal.save(validate: false)
          end

          if params.require(:deal_section)[:background_color].present?
            @deal_section.background_color = params.require(:deal_section)[:background_color]
            @deal_section.background_image = nil
          else
            @deal_section.background_image = params.require(:deal_section)[:background_image] if params.require(:deal_section)[:background_image].present?
          end
          @deal_section.logo = params.require(:deal_section)[:logo] if params.require(:deal_section)[:logo].present?
          @deal_section.theme ||= {}
          @deal_section.theme['colors'] ||= {}

          @deal_section.theme['colors']['background'] = params.require(:deal_section)[:color_background] if params.require(:deal_section)[:color_background].present?
          @deal_section.theme['colors']['overlay'] = params.require(:deal_section)[:color_overlay] if params.require(:deal_section)[:color_overlay].present?
          @deal_section.theme['colors']['title'] = params.require(:deal_section)[:color_title] if params.require(:deal_section)[:color_title].present?
          @deal_section.theme['colors']['description'] = params.require(:deal_section)[:color_description] if params.require(:deal_section)[:color_description].present?
          @deal_section.theme['colors']['client_name'] = params.require(:deal_section)[:color_client_name] if params.require(:deal_section)[:color_client_name].present?
          @deal_section.theme['colors']['date'] = params.require(:deal_section)[:color_date] if params.require(:deal_section)[:color_date].present?
        end

        if @deal_section.section.is_proposta?
          if params.require(:deal_section)[:background_color].present?
            @deal_section.background_color = params.require(:deal_section)[:background_color]
            @deal_section.background_image = nil
          else
            @deal_section.background_image = params.require(:deal_section)[:background_image] if params.require(:deal_section)[:background_image].present?
          end

          @deal_section.theme ||= {}
          @deal_section.theme['colors'] ||= {}
          @deal_section.theme['border'] ||= {}

          @deal_section.theme['colors']['title'] = params.require(:deal_section)[:color_title] if params.require(:deal_section)[:color_title].present?
          @deal_section.theme['colors']['description'] = params.require(:deal_section)[:color_description] if params.require(:deal_section)[:color_description].present?
          @deal_section.theme['colors']['table_border'] = params.require(:deal_section)[:color_table_border] if params.require(:deal_section)[:color_table_border].present?
          @deal_section.theme['border']['width'] = params.require(:deal_section)[:table_border] if params.require(:deal_section)[:table_border].present?

          @deal_section.theme['colors']['background_table_title'] = params.require(:deal_section)[:color_background_table_title] if params.require(:deal_section)[:color_background_table_title].present?
          @deal_section.theme['colors']['background_table'] = params.require(:deal_section)[:color_background_table] if params.require(:deal_section)[:color_background_table].present?
          @deal_section.theme['colors']['table_title'] = params.require(:deal_section)[:color_table_title] if params.require(:deal_section)[:color_table_title].present?
          @deal_section.theme['colors']['table_description'] = params.require(:deal_section)[:color_table_description] if params.require(:deal_section)[:color_table_description].present?
        end

        if @deal_section.section.is_contacto?
          if params.require(:deal_section)[:background_color].present?
            @deal_section.background_color = params.require(:deal_section)[:background_color]
            @deal_section.background_image = nil
          else
            @deal_section.background_image = params.require(:deal_section)[:background_image] if params.require(:deal_section)[:background_image].present?
          end

          @deal_section.theme ||= {}
          @deal_section.theme['colors'] ||= {}
          @deal_section.theme['contacto'] ||= {}

          @deal_section.theme['contacto']['email'] = params.require(:deal_section)[:email] if params.require(:deal_section)[:email].present?
          @deal_section.theme['contacto']['tel'] = params.require(:deal_section)[:tel] if params.require(:deal_section)[:tel].present?

          @deal_section.theme['colors']['title'] = params.require(:deal_section)[:color_title] if params.require(:deal_section)[:color_title].present?
          @deal_section.theme['colors']['description'] = params.require(:deal_section)[:color_description] if params.require(:deal_section)[:color_description].present?
          @deal_section.theme['colors']['contacto_title'] = params.require(:deal_section)[:color_contacto_title] if params.require(:deal_section)[:color_contacto_title].present?
          @deal_section.theme['colors']['contacto_description'] = params.require(:deal_section)[:color_contacto_description] if params.require(:deal_section)[:color_contacto_description].present?
        end

        if @deal_section.section.is_grelha?
          @deal_section.theme ||= {}
          @deal_section.theme['colors'] ||= {}
          @deal_section.theme['border'] ||= {}
          @deal_section.theme['image'] ||= {}

          if params.require(:deal_section)[:color_background].present?
            @deal_section.theme['colors']['background'] = params.require(:deal_section)[:color_background] if params.require(:deal_section)[:color_background].present?
            @deal_section.background_image = nil
          else
            @deal_section.background_image = params.require(:deal_section)[:background_image] if params.require(:deal_section)[:background_image].present?
          end

          @deal_section.theme['colors']['title'] = params.require(:deal_section)[:color_title] if params.require(:deal_section)[:color_title].present?
          @deal_section.theme['colors']['description'] = params.require(:deal_section)[:color_description] if params.require(:deal_section)[:color_description].present?
          @deal_section.theme['colors']['background_items'] = params.require(:deal_section)[:color_background_items] if params.require(:deal_section)[:color_background_items].present?
          @deal_section.theme['colors']['border_items'] = params.require(:deal_section)[:color_border_items] if params.require(:deal_section)[:color_border_items].present?
          @deal_section.theme['colors']['items_title'] = params.require(:deal_section)[:color_items_title] if params.require(:deal_section)[:color_items_title].present?
          @deal_section.theme['colors']['items_description'] = params.require(:deal_section)[:color_items_description] if params.require(:deal_section)[:color_items_description].present?
          @deal_section.theme['colors']['links'] = params.require(:deal_section)[:color_links] if params.require(:deal_section)[:color_links].present?

          @deal_section.theme['border']['width'] = params.require(:deal_section)[:border_items] if params.require(:deal_section)[:border_items].present?
          @deal_section.theme['image']['format'] = params.require(:deal_section)[:image_format]

        end

        if @deal_section.section.is_galeria?
          @deal_section.theme ||= {}
          @deal_section.theme['colors'] ||= {}
          @deal_section.theme['border'] ||= {}
          @deal_section.theme['image'] ||= {}

          if params.require(:deal_section)[:color_background].present?
            @deal_section.theme['colors']['background'] = params.require(:deal_section)[:color_background] if params.require(:deal_section)[:color_background].present?
            @deal_section.background_image = nil
          else
            @deal_section.background_image = params.require(:deal_section)[:background_image] if params.require(:deal_section)[:background_image].present?
          end

          @deal_section.theme['colors']['title'] = params.require(:deal_section)[:color_title] if params.require(:deal_section)[:color_title].present?
          @deal_section.theme['colors']['description'] = params.require(:deal_section)[:color_description] if params.require(:deal_section)[:color_description].present?
          @deal_section.theme['colors']['border_images'] = params.require(:deal_section)[:color_border_images] if params.require(:deal_section)[:color_border_images].present?

          @deal_section.theme['border']['width'] = params.require(:deal_section)[:border_images] if params.require(:deal_section)[:border_images].present?
          @deal_section.theme['image']['organization'] = params.require(:deal_section)[:image_organization] if params.require(:deal_section)[:image_organization].present?

        end

        if @deal_section.section.is_bio?
          @deal_section.links ||= {}
          link_params = params.require(:deal_section).permit(:twitter, :facebook, :instagram, :pinterest, :linkdin, :youtube, :tiktok, :website, :mail)
          link_params.each do |key, value|
            @deal_section.links[key] = { name: key, url: value }
          end
        end

        # @deal_section.button ||= {}
        # @deal_section.button[:text] = params.require(:deal_section)[:button_text]
        # @deal_section.button[:url] = params.require(:deal_section)[:button_url]
        #
        # @deal_section.button2 ||= {}
        # @deal_section.button2[:text] = params.require(:deal_section)[:button2_text]
        # @deal_section.button2[:url] = params.require(:deal_section)[:button2_url]

        # @deal_section.theme ||= {}
        # @deal_section.theme[:colors] ||= {}
        #
        # @deal_section.theme[:colors][:background] = params.require(:deal_section)[:background_color]
        # @deal_section.theme[:colors][:heading] = params.require(:deal_section)[:heading_color]
        # @deal_section.theme[:colors][:text] = params.require(:deal_section)[:text_color]
        # @deal_section.theme[:colors][:button_background] = params.require(:deal_section)[:button_background_color]
        # @deal_section.theme[:colors][:button_text] = params.require(:deal_section)[:button_text_color]

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
          :address,
          :headingAlignment,
          :contentAlignment,
          :contentLayout,
          :contentStyle,
          :mediaAlignment,
          :mediaStyle,
          :position
        )
      end
    end
  end
end
