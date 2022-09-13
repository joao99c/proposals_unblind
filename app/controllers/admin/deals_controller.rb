# frozen_string_literal: true

module Admin
  class DealsController < Admin::BaseController
    before_action :set_deal, only: %i[step_1 search_customer choose_customer save_choose_customer delete_choose_customer search_product choose_product save_choose_product delete_choose_product update_dp new_customer update_customer new_product update_product]

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

    def new_customer
      customer = Customer.new(params.require(:customer).permit(:name, :website, :logo, :responsable_name, :responsable_email, :responsable_tel))

      @deal.customer = customer

      respond_to do |format|
        if @deal.save
          format.turbo_stream do
            render turbo_stream: [
              turbo_stream.replace('choose_customer', partial: 'admin/deals/choose_customer', locals: { deal: @deal }),
              turbo_stream.remove('modal-backdrop')
            ]
          end
        end
      end
    end

    def update_customer
      customer = @deal.customer

      respond_to do |format|
        if customer.update(params.require(:customer).permit(:name, :website, :logo, :responsable_name, :responsable_email, :responsable_tel))
          format.turbo_stream do
            render turbo_stream: [
              turbo_stream.replace('choose_customer', partial: 'admin/deals/choose_customer', locals: { deal: @deal }),
              turbo_stream.remove('modal-backdrop')
            ]
          end
        end
      end
    end

    def new_product
      product = Product.new(params.require(:product).permit(:name, :description, :logo, :price))
      dp = DealProduct.new(deal: @deal, product:)

      respond_to do |format|
        if dp.save
          format.turbo_stream do
            render turbo_stream: [
              turbo_stream.replace('choose_product', partial: 'admin/deals/choose_product', locals: { deal: @deal }),
              turbo_stream.append('dp_list', partial: 'admin/deals/dp_item', locals: { dp: }),
              turbo_stream.remove('modal-backdrop')
            ]
          end
        end
      end
    end

    def update_product
      product_id = params.require(:product).permit(:product_id)[:product_id]
      deal_product_id = params.require(:product).permit(:deal_product_id)[:deal_product_id]
      product_params = params.require(:product).permit(:name, :description, :logo, :price)
      product = Product.find(product_id)
      dp = DealProduct.find(deal_product_id)
      product.assign_attributes(product_params)

      if product_params[:price]
        product_params[:price] = product_params[:price].delete('$ , €') # => "123456.00"
        product.price = product_params[:price].nil? ? 0 : product_params[:price].to_f.round(2)
      end

      respond_to do |format|
        if product.save
          format.turbo_stream do
            render turbo_stream: [
              turbo_stream.replace('choose_product', partial: 'admin/deals/choose_product', locals: { deal: @deal }),
              turbo_stream.replace(helpers.dom_id(dp), partial: 'admin/deals/dp_item', locals: { dp: }),
              turbo_stream.remove('modal-backdrop')
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
