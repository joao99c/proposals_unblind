# frozen_string_literal: true

module Admin::DataHelper

  # # def build_value_from_hash(hash)
  # #   val = ''
  # #   hash.each_key { |k| val += "[#{k}][#{hash[k]}]"}
  # #   val
  # # end

  # # # creates hidden inputs for the form to keep all the query params
  # # def hidden_query_inputs(f)
  # #   @legacy_params.each_key do |qp|
  # #     if @legacy_params[qp].present?
  # #       next if qp == :per
  # #       f.hidden_field qp
  # #     end
  # #   end
  # # end

  # # merges existing params for sorting/pagination/filters with new query params
  # def merged_params(new_params = {})
  #   # h = {resource_name: resource_name}.merge(new_params)
  #   @legacy_params.merge(new_params)
  # end

  # # checks if the mrethod is an association
  # def is_assoc?(method)
  #   @model.reflect_on_association(strip_id(method)).present?
  # end

  # # checks if method is an attribute
  # def is_attribute?(method)
  #   @model.new.attributes.keys.map(&:to_sym).include?(method)
  # end

  # # removes _id from method
  # # :user_id => 'user'
  # def strip_id(method)
  #   method.to_s.gsub(/_id/, '')
  # end

  # def resource_name
  #   @model.to_s.tableize
  # end

  # # displays the association with one of the display methods or id
  # def assoc_display(object, method)
  #   assoc = object.send(strip_id(method))
  #   display_methods = %i[full_name name last_name title email]
  #   display_method = display_methods.find {|m| assoc.respond_to?(m)} || :id
  #   assoc.send(display_method)
  # end

  # # :user => User
  # def column_name(method)
  #   method.to_s.humanize
  # end

  # # Order => 'orders'
  # def table_name
  #   @model.to_s.humanize.pluralize
  # end

  # # generates a set of filter options based on data type that a method returns
  # # string - A drop down for selecting “Contains”, “Equals”, “Starts with”, “Ends with” and an input for a value.
  # # date_range - A start and end date field with calendar inputs
  # # numeric - A drop down for selecting “Equal To”, “Greater Than” or “Less Than” and an input for a value.
  # # select - A drop down which filters based on a selected item in a collection or all.
  # # check_boxes - A list of check boxes users can turn on and off to filter
  # # returns a nested array [option1, option2, option3] where each option is an array option1 = [value1, text1]
  # def filter_options(method)
  #   raise_not_an_attribute_error(method) unless is_attribute?(method)

  #   data_types = {
  #     string: [['Contains', ''], ['Equals', ''], ['Starts with', ''], ['Ends with', '']],
  #     integer: [['Equal To', ''], ['Greater Than', ''], ['Less Than', '']],
  #     float: [['Equal To', ''], ['Greater Than', ''], ['Less Than', '']]
  #   }

  #   data_types[data_type(method)]
  # end

  # # determites which _filter_fields_xxxx partial to render based on method's data_type
  # def fields_set(method)
  #   type = data_type(method)

  #   data_types = {
  #     string: 'string',
  #     integer: 'numeric',
  #     float: 'numeric',
  #     datetime: 'date',
  #     enum: 'enum'
  #   }
  #   data_types[type]
  # end

  # # returns a data type that a method returns
  # def data_type(method)
  #   @model.type_for_attribute(method).type
  # end

  # def raise_not_an_attribute_error
  #   raise StandError, "#{method} is not an attribute of a model #{@model}"
  # end

  # # if the method is association builds a link to the show page of the association, otherwise displays the value
  # def index_td_content(object, method, options = {})
  #   if is_assoc?(method)
  #     link_to assoc_display(object, method), admin_data_show_path(resource_name: strip_id(method).pluralize, id: object.send(method)), class: options[:class]
  #   else
  #     content_tag(:span, object.send(method), class: options[:class])
  #   end
  # end

  # def index_td(object, method, options = {})
  #   content_tag(:td, index_td_content(object, method), class: options[:class])
  # end
end
