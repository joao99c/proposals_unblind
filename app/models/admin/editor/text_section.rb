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
        super(attributes)
      end
    end
  end
end
