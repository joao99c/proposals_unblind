module Admin::Editor::EditorHelper
  def render_section_preview(deal_section)
    partial = "admin/editor/sections/#{deal_section.section.name.underscore}"
    render partial:, locals: { deal_section: }
  end
end
