# frozen_string_literal: true

module Admin
  module Editor
    class StepByStepSection
      def self.new(template)
        deal_section = GridSection.create(
          template:,
          heading: 'Passo a passo',
          text: 'Explore the whole collection of open-source web components and elements built with the utility classes from Tailwind',
          theme: { "colors": { "background": "#111928", "title": "#ffffff", "description": "#d1d5db", "background_items": "#111928", "border_items": "#f3f4f6", "items_title": "#ffffff", "items_description": "#d1d5db", "links": "#1c64f2" }, "border": { "width": "0px" }, "image": { "format": "rounded" }, "hidden": {} },
          deal_section_items: []
        )
        6.times do |i|
          dsi = DealSectionItem.create(
            parent: deal_section,
            child_attributes: {
              template:,
              parent_id: deal_section.id,
              heading: '%02i' % (i + 1),
              text: 'Definição de microestratégias a desenvolver mensalmente e formas de aplicação nas diferentes plataformas.',
              section_id: 5,
              child: true
            })
        end
        deal_section
      end
    end
  end
end
