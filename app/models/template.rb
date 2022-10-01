class Template < ApplicationRecord
  belongs_to :user
  has_many :deals
  has_many :deal_sections, -> { order(position: :asc).where(child: false) }, dependent: :destroy


  after_create_commit :create_default_sections

  def section_cabecalho
    deal_sections.where(section_id: 1).first
  end

  def section_propostas
    deal_sections.where(section_id: 2).first
  end

  private

  def create_default_sections
    Admin::Editor::HeadingSection.create(template: self)
    Admin::Editor::ProposalSection.create(template: self)
    Admin::Editor::ContactSection.create(template: self)
  end
end
