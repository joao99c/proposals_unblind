module Admin
  class TemplateController < ApplicationController
    before_action :set_deal
    before_action :set_template, except: %w[create]

    def create
      @template = Template.new(name: 'Primeiro Template', user: current_user)

      respond_to do |format|
        if @template.save
          @deal.template = @template
          @deal.save(validate: false)
          format.html { redirect_to admin_deal_editor_path(@deal, template_id: @template) }
        end
      end
    end

    def select
      @deal.template = @template
      respond_to do |format|
        if @deal.save(validate: false)
          format.html { redirect_to admin_deal_editor_path(@deal, template_id: @template) }
        end
      end
    end

    def destroy
      @template.destroy
      respond_to do |format|
        format.html { redirect_to step_2_admin_deal_path(@deal) }
      end
    end

    private

    def set_deal
      @deal = Deal.find(params[:deal_id])
    end

    def set_template
      @template = Template.find(params[:id])
    end

  end
end
