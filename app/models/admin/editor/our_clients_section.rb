# frozen_string_literal: true

module Admin
  module Editor
    class OurClientsSection
      def self.new(template)
        deal_section = GallerySection.create(
          template:,
          heading: 'Os nossos Clientes',
          text: 'Explore the whole collection of open-source web components and elements built with the utility classes from Tailwind',
          theme: { "colors": { "background": "#111928", "title": "#ffffff", "description": "#d1d5db", "background_items": "#F3F4F6", "border_items": "#F3F4F6", "items_title": "#111928", "items_description": "#6B7280", "links": "#1C64F2", "border_images": "#000000" }, "border": { "width": "0px" }, "image": { "organization": "equal" }, "hidden": {} },
          deal_section_items: []
        )
        6.times do
          dsi = DealSectionItem.create(
            parent: deal_section,
            child_attributes: {
              template:,
              parent_id: deal_section.id,
              section_id: 5,
              child: true
            })
          dsi.child.logo.attach(io: File.open(File.join(Rails.root, 'app/assets/images/unblind.png')), filename: 'unblind.png', content_type: 'image/png')
          dsi.child.save
        end
        deal_section
      end
    end
  end
end
