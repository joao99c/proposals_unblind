# frozen_string_literal: true

require 'grover'
module Admin
  class PdfController < ApplicationController
    before_action :set_deal
    before_action :cookies

    def show
      grover = Grover.new("#{admin_deal_editor_preview_url(@deal, hide_previews: 1)}", format: 'A4', cookies:)
      pdf = grover.to_pdf

      respond_to do |format|
        format.pdf do
          send_data(pdf, disposition: 'inline', filename: "#{@deal.customer.name} - Proposta ##{@deal.id}", type: 'application/pdf')
        end
      end
    end

    def download
      grover = Grover.new("#{admin_deal_editor_preview_url(@deal, hide_previews: 1)}", format: 'A4', cookies:)
      pdf = grover.to_pdf

      respond_to do |format|
        format.pdf do
          send_data(pdf, disposition: 'attachment', filename: "#{@deal.customer.name} - Proposta ##{@deal.id}", type: 'application/pdf')
        end
      end
    end

    def set_deal
      @deal = Deal.find(params[:id])
    end

    def cookies
      request.headers['Cookie'].split('; ').map do |cookie|
        key, value = cookie.split '='
        { name: key, value: value, domain: request.headers['Host'] }
      end
    end
  end

end
