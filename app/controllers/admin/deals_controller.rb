# frozen_string_literal: true

module Admin
  class DealsController < Admin::BaseController
    before_action :set_deal, except: %i[new create index]

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

    def search_customer
      if params[:query].present?
        @customers = Customer.where('name LIKE ?', "%#{params[:query]}%")
      else
        render :choose_customer
      end
    end

    def choose_customer; end

    def save_choose_customer
      customer = Customer.find(params[:customer_id])
      @deal.customer = customer
      respond_to do |format|
        if @deal.save
          format.turbo_stream do
            render turbo_stream: turbo_stream.replace('choose_customer', partial: 'admin/deals/choose_customer', locals: { deal: @deal })
          end
        end
      end
    end

    def delete_choose_customer
      @deal.customer = nil

      respond_to do |format|
        if @deal.save
          format.turbo_stream do
            render turbo_stream: turbo_stream.replace('choose_customer', partial: 'admin/deals/choose_customer', locals: { deal: @deal })
          end
        end
      end
    end

    def search_product
      if params[:query].present?
        @products = Product.where('name LIKE ?', "%#{params[:query]}%")
      else
        render :choose_product
      end
    end

    def choose_product; end

    def save_choose_product
      product = Product.find(params[:product_id])
      dp = DealProduct.new(deal: @deal, product:)

      respond_to do |format|
        if dp.save
          format.turbo_stream do
            render turbo_stream: [
              turbo_stream.replace('choose_product', partial: 'admin/deals/choose_product', locals: { deal: @deal }),
              turbo_stream.append('dp_list', partial: 'admin/deals/dp_item', locals: { dp: })
            ]
          end
        end
      end
    end

    def delete_choose_product
      dp = @deal.deal_products.find(params[:dp_id])
      html_dom_id = helpers.dom_id(dp)
      dp&.destroy

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.remove(html_dom_id)
        end
      end
    end

    def update_dp
      dp = @deal.deal_products.find(params[:dp_id])
      total_price_dom_id = helpers.dom_id(dp, 'total_price')

      if params[:discount_amount]
        params[:discount_amount] = params[:discount_amount].delete('$ , €') # => "123456.00"
        dp.discount_amount = params[:discount_amount].nil? ? 0 : params[:discount_amount].to_f.round(2)
      end

      if params[:quantity]
        dp.quantity = params[:quantity].nil? ? 0 : params[:quantity]
      end

      respond_to do |format|
        if dp.save
          format.turbo_stream do
            render turbo_stream: [
              turbo_stream.update(total_price_dom_id, inline: helpers.number_to_currency(dp.price))
            ]
          end
        end
      end
    end

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
