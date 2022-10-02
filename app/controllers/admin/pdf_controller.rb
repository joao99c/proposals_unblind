# frozen_string_literal: true

module Admin
  class PdfController < ApplicationController
    def show
      @deal = Deal.find(params[:id])
      respond_to do |format|
        format.pdf do
          render pdf: 'proposal',
                 layout: 'pdf',
                 template: 'admin/pdf/preview',
                 page_size: 'A4',
                 show_as_html: params.key?('debug'),
                 margin: {
                   top: 0, # default 10 (mm)
                   bottom: 0,
                   left: 0,
                   right: 0
                 },
                 padding: {
                   top: 0, # default 10 (mm)
                   bottom: 0,
                   left: 0,
                   right: 0
                 }
        end
      end
    end

    def download
      @deal = Deal.find(params[:id])
      html = render_to_string(template: 'admin/pdf/preview', layout: 'pdf/pdf')
      pdf = WickedPdf.new.pdf_from_string(html)

      send_data(pdf,
                filename: 'my_pdf_name.pdf',
                disposition: 'attachment')
    end
  end
end
