# frozen_string_literal: true

module Admin
  module Editor
    class FaqsSection
      def self.new(template)
        deal_section = AccordionSection.create(
          template:,
          heading: 'Faq’s',
          text: '',
          theme: { "colors": { "background": '#f9fafb', "heading": '#000000', "text": '#000000', "button_background": '#ffffff', "button_text": '#000000', "title": '#111928', "description": '#6b7280', "items_title": '#111928', "items_description": '#6b7280', "links": '#000000', "border_images": '#000000' }, "border": { "width": '0px' }, "image": {}, "hidden": { "heading": '0', "text": '0', "button": '0' } },
          deal_section_items: []
        )
        6.times do |i|
          dsi = DealSectionItem.create(
            parent: deal_section,
            child_attributes: {
              template:,
              parent_id: deal_section.id,
              section_id: 5,
              heading: "Pergunta #{'%02i' % (i + 1)}",
              text: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Consequuntur debitis deleniti dolores dolorum excepturi iste iusto, laborum libero minima nobis, nulla odio perferendis quos repellat sed sit tenetur voluptate voluptatibus.
      Lorem ipsum dolor sit amet, consectetur adipisicing elit. Consequuntur debitis deleniti dolores dolorum excepturi iste iusto, laborum libero minima nobis, nulla odio perferendis quos repellat sed sit tenetur voluptate voluptatibus.",
              child: true
            })
        end
        deal_section
      end
    end
  end
end
