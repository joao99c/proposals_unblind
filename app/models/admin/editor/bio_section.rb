# frozen_string_literal: true

module Admin
  module Editor
    class BioSection < DealSection
      def initialize(attributes = nil)
        attributes ||= {}
        attributes[:section_id] ||= 2
        attributes[:preHeading] ||= 'Isto é um texto antes da Biografia'
        attributes[:heading] ||= 'Biografia'
        attributes[:subHeading] ||= 'Isto é um texto depois da Biografia'
        attributes[:text] ||= 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec euismod, nisi eu consectetur'
        attributes[:links] ||= {}
        super(attributes)
      end
    end
  end
end
