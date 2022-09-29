# frozen_string_literal: true

module Admin
  module Editor
    class HeadingSection < DealSection
      def initialize(attributes = nil)
        attributes ||= {}
        attributes[:section_id] ||= 1
        attributes[:heading] ||= 'Hero title'
        attributes[:text] ||= 'Explore the whole collection of open-source web components and elements built with the utility classes from Tailwind'

        attributes['theme'] ||= {}
        attributes['theme']['colors'] ||= {}

        attributes['theme']['colors']['background'] = '#111928'
        attributes['theme']['colors']['overlay'] = '#FFFFFF'
        attributes['theme']['colors']['title'] = '#FFFFFF'
        attributes['theme']['colors']['description'] = '#FFFFFF'
        attributes['theme']['colors']['client_name'] = '#FFFFFF'
        attributes['theme']['colors']['date'] = '#FFFFFF'
        super(attributes)
      end
    end
  end
end
