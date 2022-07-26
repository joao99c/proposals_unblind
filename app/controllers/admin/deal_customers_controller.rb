# frozen_string_literal: true

module Admin
  class DealCustomersController < ApplicationController
    before_action :set_deal
    before_action :build_customer, only: %w[new]

    def show
      redirect_to admin_new_deal_customer_path(@deal) if @deal&.customer.nil?
    end

    def new; end

    def save_existing_user
      save_existing_user_params = params.require(:deal).permit(:customer_id)
      respond_to do |format|
        if @deal.update!(save_existing_user_params)
          format.html { redirect_to admin_deal_customers_path(@deal), notice: 'Deal was successfully updated.' }
          format.json { render :show, status: :ok, location: @deal }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @deal.errors, status: :unprocessable_entity }
        end
      end
    end

    def save_new_user
      save_existing_user_params = params.require(:deal).permit(customer_attributes: %i[name email website responsable_name responsable_email responsable_tel])

      respond_to do |format|
        if @deal.update!(save_existing_user_params)
          format.html { redirect_to admin_deal_customers_path(@deal), notice: 'Deal was successfully updated.' }
          format.json { render :show, status: :ok, location: @deal }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @deal.errors, status: :unprocessable_entity }
        end
      end
    end

    private

    def set_deal
      @deal = Deal.find(params[:id])
    end

    def build_customer
      @deal.build_customer if @deal.customer.nil?
    end
  end
end
