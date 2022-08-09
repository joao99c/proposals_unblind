# frozen_string_literal: true

module Admin
  class PdfController < ApplicationController
    def show
      @deal = Deal.find(params[:id])
      respond_to do |format|
        format.pdf do
          render pdf: 'proposal',
                 layout: 'pdf/pdf',
                 page_size: 'A4',
                 background: true,
                 margin: {
                   top: 0,
                   right: 0,
                   left: 0,
                   bottom: 0
                 },
                 header: {
                   spacing: 5,
                   html: {
                     template: 'layouts/pdf/header'
                   }
                 },
                 footer: {
                   html: {
                     template: 'layouts/pdf/footer'
                   }
                 }
        end
      end
    end

    def download
      html = render_to_string(action: :show)
      pdf = WickedPdf.new.pdf_from_string(html)

      send_data(pdf,
                filename: 'my_pdf_name.pdf',
                disposition: 'attachment')
    end
  end
end
