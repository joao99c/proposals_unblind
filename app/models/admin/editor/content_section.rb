# frozen_string_literal: true

module Admin
  module Editor
    class ContentSection < DealSection
      def initialize(attributes = nil)
        attributes ||= {}
        attributes[:section_id] ||= 7
        attributes[:heading] ||= 'Content'
        attributes[:text] ||= 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec euismod, nisi eu consectetur'

        attributes[:theme] ||= {}
        attributes[:theme][:colors] ||= {}
        attributes[:theme][:colors][:background] ||= '#f3f4f6'
        attributes[:theme][:colors][:heading] ||= '#000000'
        attributes[:theme][:colors][:text] ||= '#000000'
        attributes[:theme][:colors][:button_background] ||= '#ffffff'
        attributes[:theme][:colors][:button_text] ||= '#000000'
        super(attributes)
      end
    end
  end
end
