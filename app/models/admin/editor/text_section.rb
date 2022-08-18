# frozen_string_literal: true

module Admin
  module Editor
    class TextSection < DealSection
      def initialize(attributes = nil)
        attributes ||= {}
        attributes[:section_id] ||= 1
        attributes[:preHeading] ||= 'Isto é um texto antes do texto principal'
        attributes[:heading] ||= 'Texto principal'
        attributes[:subHeading] ||= 'Isto é um texto depois do texto principal'
        attributes[:text] ||= 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec euismod, nisi eu consectetur'
        attributes[:mediaAlignment] ||= 'left'
        attributes[:theme] ||= {}
        attributes[:theme][:colors] ||= {}
        attributes[:theme][:colors][:background] ||= '#ffffff'
        attributes[:theme][:colors][:heading] ||= '#000000'
        attributes[:theme][:colors][:text] ||= '#000000'
        attributes[:theme][:colors][:button_background] ||= '#ffffff'
        attributes[:theme][:colors][:button_text] ||= '#000000'
        super(attributes)
      end
    end
  end
end
