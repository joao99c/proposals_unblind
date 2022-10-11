# frozen_string_literal: true

module Admin
  module Editor
    class TeamSection
      def self.new(template)
        deal_section = GridSection.create(
          template:,
          heading: 'A Nossa Equipa',
          text: 'Explore the whole collection of open-source web components and elements built with the utility classes from Tailwind',
          theme: {
            colors: {
              background: '#F9FAFB',
              title: '#111928',
              description: '#6B7280',
              background_items: '#F3F4F6',
              border_items: '#F3F4F6',
              items_title: '#111928',
              items_description: '#6B7280',
              links: '#1C64F2'
            },
            border: {
              width: '0px'
            },
            image: {
              format: :rounded
            }
          },
          deal_section_items: []
        )
        5.times do
          dsi = DealSectionItem.create(
            parent: deal_section,
            child_attributes: {
              template:,
              parent_id: deal_section.id,
              heading: 'Bonnie Green',
              text: 'Senior Front-end Developer',
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
