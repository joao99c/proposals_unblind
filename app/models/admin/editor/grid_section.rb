# frozen_string_literal: true

module Admin
  module Editor
    class GridSection < DealSection

      def initialize(attributes = nil)
        attributes ||= {}
        attributes[:section_id] ||= 4
        attributes[:preHeading] ||= nil
        attributes[:heading] ||= 'Título da Grelha'
        attributes[:subHeading] ||= nil
        attributes[:text] ||= 'Explore the whole collection of open-source web components and elements built with the utility classes from Tailwind'
        attributes[:deal_section_items] ||= [create_item(1), create_item(2)]

        attributes[:mediaAlignment] ||= 'center'
        attributes[:headingAlignment] ||= 'center'
        attributes[:contentAlignment] ||= 'center'
        attributes[:contentLayout] ||= 'columns'
        attributes[:contentStyle] ||= 'plain'

        attributes[:theme] ||= {}
        attributes[:theme][:colors] ||= {}
        attributes[:theme][:colors][:background] ||= '#f3f4f6'
        attributes[:theme][:colors][:heading] ||= '#000000'
        attributes[:theme][:colors][:text] ||= '#000000'
        attributes[:theme][:colors][:button_background] ||= '#ffffff'
        attributes[:theme][:colors][:button_text] ||= '#000000'

        super(attributes)
      end

      private

      def create_item(number = 1)
        DealSectionItem.new(
          {
            child: DealSection.new(
              {
                section_id: 1,
                heading: "Item #{number}",
                preHeading: '',
                subHeading: '',
                child: true
              }
            )
          }
        )
      end
    end
  end
end
