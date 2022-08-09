class Admin::Editor::EditorController < ApplicationController
  layout 'editor'
  before_action :set_deal

  def index; end

  def preview; end

  def sections; end

  # def create_text_section
  #   ds = DealSection.new(deal_text_section_params)
  #   ds.deal = @deal
  #   ds.section = Section.find_by(name: 'text')
  #   ds.save
  #
  #   respond_to do |format|
  #     format.turbo_stream do
  #       render turbo_stream: turbo_stream.append("deal_sections_preview", inline: helpers.render_section_preview(ds))
  #     end
  #   end
  # end

  private

  def set_deal
    @deal = Deal.find(params[:deal_id])
  end

  def deal_text_section_params
    params.require(:deal_section).permit(:preHeading, :heading, :subHeading)
  end
end
