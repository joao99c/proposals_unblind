# frozen_string_literal: true

module Admin
  module Editor
    class GridSection < DealSection

      def initialize(attributes = nil)
        attributes ||= {}
        attributes[:section_id] ||= 3
        attributes[:preHeading] ||= 'Isto é um texto antes da Grid'
        attributes[:heading] ||= 'Grid'
        attributes[:subHeading] ||= 'Isto é um texto depois da Grid'
        attributes[:text] ||= 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec euismod, nisi eu consectetur'
        attributes[:deal_section_items] ||= [create_item(1), create_item(2)]
        attributes[:mediaAlignment] ||= 'center'
        attributes[:theme] ||= {}
        attributes[:theme][:colors] ||= {}
        attributes[:theme][:colors][:background] ||= '#ffffff'
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
