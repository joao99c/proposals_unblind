module Admin::Editor::EditorHelper
  def render_section_preview(deal_section)
    partial = "admin/editor/sections/#{ActiveSupport::Inflector.transliterate(deal_section.section.name.underscore).to_s}"
    render partial:, locals: { deal_section: }
  end
end
