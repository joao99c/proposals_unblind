# frozen_string_literal: true

module Admin
  module Editor
    class GallerySection < DealSection

      def initialize(attributes = nil)
        attributes ||= {}
        attributes[:section_id] ||= 6
        attributes[:preHeading] ||= nil
        attributes[:heading] ||= 'Título da Galeria'
        attributes[:subHeading] ||= nil
        attributes[:text] ||= 'Explore the whole collection of open-source web components and elements built with the utility classes from Tailwind'

        attributes[:mediaAlignment] ||= 'center'
        attributes[:headingAlignment] ||= 'center'
        attributes[:contentAlignment] ||= 'center'
        attributes[:contentLayout] ||= 'columns'
        attributes[:contentStyle] ||= 'plain'

        attributes[:theme] ||= {}
        attributes[:theme][:colors] ||= {}
        # attributes[:theme][:colors][:background] ||= '#f3f4f6'
        # attributes[:theme][:colors][:heading] ||= '#000000'
        # attributes[:theme][:colors][:text] ||= '#000000'
        # attributes[:theme][:colors][:button_background] ||= '#ffffff'
        # attributes[:theme][:colors][:button_text] ||= '#000000'

        super(attributes)
      end

    end
  end
end
