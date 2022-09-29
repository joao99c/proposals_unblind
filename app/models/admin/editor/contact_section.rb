# frozen_string_literal: true

module Admin
  module Editor
    class ContactSection < DealSection
      def initialize(attributes = nil)
        attributes ||= {}
        attributes[:section_id] ||= 3
        attributes[:heading] ||= 'Contacte-nos'
        attributes[:text] ||= 'Deliver great service experiences fast - without the complexity of traditional ITSM solutions.Accelerate critical development work, eliminate toil, and deploy changes with ease.'

        attributes['theme'] ||= {}
        attributes['theme']['colors'] ||= {}
        attributes['theme']['contacto'] ||= {}

        attributes['theme']['contacto']['email'] = "example@example.com"
        attributes['theme']['contacto']['tel'] =  "(+123) 123 123 123"

        attributes['address'] = 'Rua da Avenida, 100 Portugal'
        attributes['theme']['colors']['background'] = '#111928'
        attributes['theme']['colors']['title'] = '#FFFFFF'
        attributes['theme']['colors']['description'] ='#FFFFFF'
        attributes['theme']['colors']['contacto_title'] ='#FFFFFF'
        attributes['theme']['colors']['contacto_description'] ='#1C64F2'

        super(attributes)
      end
    end
  end
end
