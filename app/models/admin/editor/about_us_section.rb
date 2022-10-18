# frozen_string_literal: true

module Admin
  module Editor
    class AboutUsSection
      def self.new(template)
        deal_section = ContentSection.create(
          template:,
          heading: 'Sobre Nós',
          text: 'Deliver great service experiences fast - without the complexity of traditional ITSM solutions.Accelerate critical development work, eliminate toil, and deploy changes with ease.',
          theme: { "colors": { "background": '#f9fafb', "heading": '#000000', "text": '#000000', "button_background": '#ffffff', "button_text": '#000000', "title": '#111928', "description": '#6b7280', "items_title": '#111928', "items_description": '#6b7280', "links": '#000000', "border_images": '#000000' }, "border": { "width": '0px' }, "image": {}, "hidden": { "heading": '0', "text": '0', "button": '0' } }
        )
        dsi = DealSectionItem.create(
          parent: deal_section,
          child_attributes: {
            template:,
            parent_id: deal_section.id,
            heading: 'We invest in the world’s potential',
            text: 'Deliver great service experiences fast - without the complexity of traditional ITSM solutions.Accelerate critical development work, eliminate toil, and deploy changes with ease.',
            section_id: 5,
            child: true,
            theme: { "image": { "organization": 'left' } },
          })
        dsi.child.logo.attach(io: File.open(File.join(Rails.root, 'app/assets/images/sections/about_us/img.png')), filename: 'about_us.png', content_type: 'image/png')
        dsi.child.save
        deal_section
      end
    end
  end
end
