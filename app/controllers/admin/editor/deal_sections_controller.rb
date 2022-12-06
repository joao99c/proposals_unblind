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
        when '4' # Grelha
          @deal_section = GridSection.new
          @deal_section.deal_section_items = []
        when '6' # Galeria
          @deal_section = GallerySection.new
        when '7' # Contéudo
          @deal_section = ContentSection.new
        when '8' # Acordeão
          @deal_section = AccordionSection.new
        when '9' # Sobre nós
          @deal_section = AboutUsSection.new(@template)
        when '10' # Equipa
          @deal_section = TeamSection.new(@template)
        when '11' # Passo a Passo
          @deal_section = StepByStepSection.new(@template)
        when '12' # Portfolio
          @deal_section = PortfolioSection.new(@template)
        when '13' # Os nossos clientes
          @deal_section = OurClientsSection.new(@template)
        when '14' # Faq's
          @deal_section = FaqsSection.new(@template)
        end
        @deal_section.template = @template
        @deal_section = @deal_section.becomes(DealSection)

        respond_to do |format|
          if @deal_section.save
            @deal.broadcast_preview_create(@deal_section)
            format.turbo_stream do
              render turbo_stream: turbo_stream.update(
                helpers.dom_id(@deal, :sidebar),
                partial: 'admin/editor/deal_sections/edit', locals: { template: @template, deal_section: @deal_section }
              )
            end
          else
            format.html { render :new, status: :unprocessable_entity }
          end
        end
      end

      # PATCH/PUT /admin/editor/deal_sections/1 or /admin/editor/deal_sections/1.json
      def visibility_heading
        # code here
      end

      def update
        if @deal_section.section.is_cabecalho?
          if params.require(:deal_section).permit(:date)[:date]
            @deal.send_date = params.require(:deal_section).permit(:date)[:date]
            @deal.save(validate: false)
          end

          if params.require(:deal_section)[:color_background] && (params.require(:deal_section)[:color_background] != @deal_section.theme['colors']['background'])
            @deal_section.theme['colors']['background'] = params.require(:deal_section)[:color_background]
            @deal_section.background_image = nil
          else
            @deal_section.background_image = params.require(:deal_section)[:background_image] if params.require(:deal_section)[:background_image].present?
          end
          @deal_section.logo = params.require(:deal_section)[:logo] if params.require(:deal_section)[:logo].present?
          @deal_section.theme ||= {}
          @deal_section.theme['colors'] ||= {}
          @deal_section.theme['company'] ||= {}

          @deal_section.theme['company']['name'] = params.require(:deal_section).permit(:company_name)[:company_name] if params.require(:deal_section).permit(:company_name)[:company_name].present?
          @deal_section.theme['colors']['background'] = params.require(:deal_section)[:color_background] if params.require(:deal_section)[:color_background] && (params.require(:deal_section)[:color_background] != @deal_section.theme['colors']['background'])
          @deal_section.theme['colors']['overlay'] = params.require(:deal_section)[:color_overlay] if params.require(:deal_section)[:color_overlay].present?
          @deal_section.theme['colors']['title'] = params.require(:deal_section)[:color_title] if params.require(:deal_section)[:color_title].present?
          @deal_section.theme['colors']['description'] = params.require(:deal_section)[:color_description] if params.require(:deal_section)[:color_description].present?
          @deal_section.theme['colors']['client_name'] = params.require(:deal_section)[:color_client_name] if params.require(:deal_section)[:color_client_name].present?
          @deal_section.theme['colors']['date'] = params.require(:deal_section)[:color_date] if params.require(:deal_section)[:color_date].present?
        end

        if @deal_section.section.is_proposta?
          if params.require(:deal_section)[:color_background] && (params.require(:deal_section)[:color_background] != @deal_section.theme['colors']['background'])
            @deal_section.theme['colors']['background'] = params.require(:deal_section)[:color_background]
            @deal_section.background_image = nil
          else
            @deal_section.background_image = params.require(:deal_section)[:background_image] if params.require(:deal_section)[:background_image].present?
          end

          @deal_section.theme ||= {}
          @deal_section.theme['colors'] ||= {}
          @deal_section.theme['border'] ||= {}

          @deal_section.theme['colors']['overlay'] = params.require(:deal_section)[:color_overlay] if params.require(:deal_section)[:color_overlay].present?
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
          if params.require(:deal_section)[:color_background] && (params.require(:deal_section)[:color_background] != @deal_section.theme['colors']['background'])
            @deal_section.theme['colors']['background'] = params.require(:deal_section)[:color_background]
            @deal_section.background_image = nil
          else
            @deal_section.background_image = params.require(:deal_section)[:background_image] if params.require(:deal_section)[:background_image].present?
          end

          @deal_section.theme ||= {}
          @deal_section.theme['colors'] ||= {}
          @deal_section.theme['contacto'] ||= {}

          @deal_section.theme['contacto']['email'] = params.require(:deal_section)[:email] if params.require(:deal_section)[:email].present?
          @deal_section.theme['contacto']['tel'] = params.require(:deal_section)[:tel] if params.require(:deal_section)[:tel].present?

          @deal_section.theme['colors']['overlay'] = params.require(:deal_section)[:color_overlay] if params.require(:deal_section)[:color_overlay].present?
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

          if params.require(:deal_section)[:color_background] && (params.require(:deal_section)[:color_background] != @deal_section.theme['colors']['background'])
            @deal_section.theme['colors']['background'] = params.require(:deal_section)[:color_background] if params.require(:deal_section)[:color_background] && (params.require(:deal_section)[:color_background] != @deal_section.theme['colors']['background'])
            @deal_section.background_image = nil
          else
            @deal_section.background_image = params.require(:deal_section)[:background_image] if params.require(:deal_section)[:background_image].present?
          end

          @deal_section.theme['colors']['overlay'] = params.require(:deal_section)[:color_overlay] if params.require(:deal_section)[:color_overlay].present?
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

          if params.require(:deal_section)[:color_background] && (params.require(:deal_section)[:color_background] != @deal_section.theme['colors']['background'])
            @deal_section.theme['colors']['background'] = params.require(:deal_section)[:color_background] if params.require(:deal_section)[:color_background] && (params.require(:deal_section)[:color_background] != @deal_section.theme['colors']['background'])
            @deal_section.background_image = nil
          else
            @deal_section.background_image = params.require(:deal_section)[:background_image] if params.require(:deal_section)[:background_image].present?
          end

          @deal_section.theme['colors']['overlay'] = params.require(:deal_section)[:color_overlay] if params.require(:deal_section)[:color_overlay].present?
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

        if @deal_section.section.is_conteudo?
          @deal_section.theme ||= {}
          @deal_section.theme['colors'] ||= {}
          @deal_section.theme['border'] ||= {}
          @deal_section.theme['image'] ||= {}

          if params.require(:deal_section)[:color_background] && (params.require(:deal_section)[:color_background] != @deal_section.theme['colors']['background'])
            @deal_section.theme['colors']['background'] = params.require(:deal_section)[:color_background] if params.require(:deal_section)[:color_background] && (params.require(:deal_section)[:color_background] != @deal_section.theme['colors']['background'])
            @deal_section.background_image = nil
          else
            @deal_section.background_image = params.require(:deal_section)[:background_image] if params.require(:deal_section)[:background_image].present?
          end

          @deal_section.theme['colors']['overlay'] = params.require(:deal_section)[:color_overlay] if params.require(:deal_section)[:color_overlay].present?
          @deal_section.theme['colors']['title'] = params.require(:deal_section)[:color_title] if params.require(:deal_section)[:color_title].present?
          @deal_section.theme['colors']['description'] = params.require(:deal_section)[:color_description] if params.require(:deal_section)[:color_description].present?
          @deal_section.theme['colors']['items_title'] = params.require(:deal_section)[:color_items_title] if params.require(:deal_section)[:color_items_title].present?
          @deal_section.theme['colors']['items_description'] = params.require(:deal_section)[:color_items_description] if params.require(:deal_section)[:color_items_description].present?
          @deal_section.theme['colors']['links'] = params.require(:deal_section)[:color_links] if params.require(:deal_section)[:color_links].present?
          @deal_section.theme['colors']['border_images'] = params.require(:deal_section)[:color_border_images] if params.require(:deal_section)[:color_border_images].present?
          @deal_section.theme['border']['width'] = params.require(:deal_section)[:border_images] if params.require(:deal_section)[:border_images].present?

        end

        if @deal_section.section.is_acordeao?
          @deal_section.theme ||= {}
          @deal_section.theme['colors'] ||= {}
          @deal_section.theme['border'] ||= {}
          @deal_section.theme['image'] ||= {}

          if params.require(:deal_section)[:color_background] && (params.require(:deal_section)[:color_background] != @deal_section.theme['colors']['background'])
            @deal_section.theme['colors']['background'] = params.require(:deal_section)[:color_background] if params.require(:deal_section)[:color_background] && (params.require(:deal_section)[:color_background] != @deal_section.theme['colors']['background'])
            @deal_section.background_image = nil
          else
            @deal_section.background_image = params.require(:deal_section)[:background_image] if params.require(:deal_section)[:background_image].present?
          end

          @deal_section.theme['colors']['overlay'] = params.require(:deal_section)[:color_overlay] if params.require(:deal_section)[:color_overlay].present?
          @deal_section.theme['colors']['title'] = params.require(:deal_section)[:color_title] if params.require(:deal_section)[:color_title].present?
          @deal_section.theme['colors']['description'] = params.require(:deal_section)[:color_description] if params.require(:deal_section)[:color_description].present?
          @deal_section.theme['colors']['border_accordion'] = params.require(:deal_section)[:color_border_accordion] if params.require(:deal_section)[:color_border_accordion].present?
          @deal_section.theme['border']['accordion'] = params.require(:deal_section)[:border_accordion] if params.require(:deal_section)[:border_accordion].present?
          @deal_section.theme['colors']['border_separator'] = params.require(:deal_section)[:color_border_separator] if params.require(:deal_section)[:color_border_separator].present?
          @deal_section.theme['border']['separator'] = params.require(:deal_section)[:border_separator] if params.require(:deal_section)[:border_separator].present?
          @deal_section.theme['colors']['items_title'] = params.require(:deal_section)[:color_items_title] if params.require(:deal_section)[:color_items_title].present?
          @deal_section.theme['colors']['items_description'] = params.require(:deal_section)[:color_items_description] if params.require(:deal_section)[:color_items_description].present?
          @deal_section.theme['colors']['background_accordion'] = params.require(:deal_section)[:color_background_accordion] if params.require(:deal_section)[:color_background_accordion].present?

        end

        @deal_section.theme ||= {}
        @deal_section.theme['hidden'] ||= {}
        %w[heading logo text button email tel address date company_name].each do |visibility_item|
          @deal_section.theme['hidden'][visibility_item.to_s] = params.require(:deal_section)["hidden_#{visibility_item}"] if params.require(:deal_section)["hidden_#{visibility_item}"].present?
        end

        @deal_section.button ||= {}
        @deal_section.button[:text] = params.require(:deal_section)[:button_text] if params.require(:deal_section)[:button_text].present?
        @deal_section.button[:url] = params.require(:deal_section)[:button_url] if params.require(:deal_section)[:button_url].present?
        @deal_section.assign_attributes(deal_section_params)

        if @deal_section.save
          @deal.broadcast_preview_update(@deal_section)
        end
      end

      # DELETE /admin/editor/deal_sections/1 or /admin/editor/deal_sections/1.json
      def destroy
        @deal.broadcast_preview_destroy(@deal_section)
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
        @template = if params[:template]
                      Template.find(params[:template])
                    else
                      @deal.template
                    end
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
