# frozen_string_literal: true

module Admin
  module Editor
    class ProposalSection < DealSection
      def initialize(attributes = nil)
        attributes ||= {}
        attributes[:section_id] ||= 2
        attributes[:heading] ||= 'A nossa proposta'
        attributes[:text] ||= 'Deliver great service experiences fast - without the complexity of traditional ITSM solutions.Accelerate critical development work, eliminate toil, and deploy changes with ease.'


        attributes['theme'] ||= {}
        attributes['theme']['colors'] ||= {}
        attributes['theme']['border'] ||= {}

        attributes['theme']['colors']['background'] = '#FFFFFF'
        attributes['theme']['colors']['title'] = '#111928'
        attributes['theme']['colors']['description'] = '#6B7280'
        attributes['theme']['colors']['table_border'] = '#E5E7EB'
        attributes['theme']['border']['width'] = '1px'

        attributes['theme']['colors']['background_table_title'] = '#F9FAFB'
        attributes['theme']['colors']['background_table'] = '#FFFFFF'
        attributes['theme']['colors']['table_title'] = '#6B7280'
        attributes['theme']['colors']['table_description'] = '#6B7280'
        super(attributes)
      end
    end
  end
end
