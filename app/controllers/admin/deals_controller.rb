# frozen_string_literal: true

module Admin
  class DealsController < Admin::BaseController
    before_action :set_deal, only: %w[step_1]

    def index
      super
    end

    def new
      @deal = Deal.new
      @deal.tags << Tag.new if @deal.tags.empty?
    end

    def create
      @deal = Deal.new(deal_params)
      @deal.user = current_user

      respond_to do |format|
        if @deal.save
          format.html { redirect_to admin_deal_step_1_url(@deal), notice: 'Deal was successfully created.' }
          format.json { render :show, status: :created, location: @deal }
        else
          format.turbo_stream do
            render turbo_stream: turbo_stream.replace("#{helpers.dom_id(@deal)}_form", partial: 'admin/deals/new_form',
                                                      locals: { deal: @deal })
          end
        end
      end
    end

    def step_1; end

    private

    def set_deal
      @deal = Deal.find(params[:id])
    end

    def deal_params
      params.require(:deal).permit(
        :name,
        tag_ids: []
      )
    end

  end
end
