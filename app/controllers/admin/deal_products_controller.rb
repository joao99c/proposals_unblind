# frozen_string_literal: true

module Admin
  class DealProductsController < ApplicationController
    before_action :set_deal

    def index; end

    def new
      @dealproduct = @deal.deal_products.new
    end

    def create
      dp = @deal.deal_products.new(deal_product_params)
      respond_to do |format|
        if dp.save
          format.turbo_stream do
            render turbo_stream: [
              turbo_stream.append(
                helpers.dom_id(@deal, :products_list),
                partial: 'admin/deal_products/deal_product',
                locals: { deal: @deal, dp: }
              )
            ]
          end
          format.json { render :show, status: :created, location: @deal }
        else
          format.turbo_stream do
            render turbo_stream: turbo_stream.replace("#{helpers.dom_id(deal)}_form", partial: 'admin/deal_products/new_form',
                                                      locals: { deal: })
          end
        end
      end
    end

    def destroy
      id = params[:dp_id]
      dealproduct = DealProduct.find(id)
      dealproduct.destroy

      domid = helpers.dom_id(dealproduct, helpers.dom_id(@deal))

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.remove(domid)
        end
        format.json { head :no_content }
      end
    end

    private

    def set_deal
      @deal = Deal.find(params[:id])
    end

    def deal_product_params
      params.require(:deal_product).permit(:product_id, :quantity, :discount_type, :discount_amount)
    end
  end
end
