module Admin::AdminResource

  module ClassMethods

    def column(method, options = {})
      list_column_templates << [method, options]
    end

    def list_columns(scope = nil)
      scope = :all if scope.blank?
      relation = send(*scope).extending do
        def trying
          map do |x|
            list_column_templates.map { |template| x.list_column(*template) }
          end
        end
      end
      relation.trying
    end

    def list_headers
      list_column_templates.map { |template| ListHeader.new(self, *template) }
    end

    def list_column_templates
      @list_column_templates ||= []
    end
  end

  module InstanceMethods
    def list_column(method, options)
      ListColumn.new(self, method, options)
    end
  end

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end
