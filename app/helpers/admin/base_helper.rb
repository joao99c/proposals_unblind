# frozen_string_literal: true

module Admin::BaseHelper
  # merges existing params for pagination/filters with new sort params
  def sort_params(method, order, legacy_params)
    return { q: { s: ["#{method} #{order}"] }, per: legacy_params[:per] } unless legacy_params[:q].present?

    { q: legacy_params[:q]&.merge({ s: ["#{method} #{order}"] }), per: legacy_params[:per] }
  end

  # checks if the mrethod is an association
  def is_assoc?(model, method)
    model.reflect_on_association(strip_id(method)).present?
  end

  # checks if method is an attribute
  def is_attribute?(model, method)
    model.new.attributes.keys.map(&:to_sym).include?(method)
  end

  # removes _id from method
  # :user_id => 'user'
  def strip_id(method)
    method.to_s.gsub(/_id/, '')
  end

  # Product => products
  def table_name(model)
    model.to_s.tableize
  end

  # displays the association with one of the display methods or id
  def assoc_display(object, method)
    assoc = object.send(strip_id(method))
    display_methods = %i[full_name name last_name title email]
    display_method = display_methods.find { |m| assoc.respond_to?(m) } || :id
    assoc.send(display_method)
  end

  # :user => 'User'
  def column_header(method)
    method.to_s.humanize
  end

  # Order => 'orders'
  def table_header(model)
    model.to_s.humanize.pluralize
  end

  # generates a set of filter options based on data type that a method returns
  # string - A drop down for selecting “Contains”, “Equals”, “Starts with”, “Ends with” and an input for a value.
  # date_range - A start and end date field with calendar inputs
  # numeric - A drop down for selecting “Equal To”, “Greater Than” or “Less Than” and an input for a value.
  # select - A drop down which filters based on a selected item in a collection or all.
  # check_boxes - A list of check boxes users can turn on and off to filter
  # returns a nested array [option1, option2, option3] where each option is an array option1 = [value1, text1]
  def filter_options(method)
    # raise_not_an_attribute_error(method) unless is_attribute?(method)

    data_types = {
      string: :i_cont,
      integer: ,
      float:
    }

    data_types[data_type(method)]
  end

  # determites which _filter_fields_xxxx partial to render based on method's data_type
  def fields_set(method)
    type = data_type(method)

    data_types = {
      string: 'string',
      integer: 'numeric',
      float: 'numeric',
      datetime: 'date',
      enum: 'enum'
    }
    data_types[type]
  end

  def raise_not_an_attribute_error
    raise StandError, "#{method} is not an attribute of a model #{@model}"
  end

  # TODO: change to a normal partial
  # if the method is association builds a link to the show page of the association, otherwise displays the value
  def index_td_content(model, object, method, options = {})
    if is_assoc?(model, method)
      link_to assoc_display(object, method), admin_show_path(controller: strip_id(method).pluralize, pars: {id: object.send(method)}), class: options[:class]
    else
      content_tag(:span, object.send(method), class: options[:class])
    end
  end

  def index_td(model, object, method, options = {}, &block)
    content_tag(:td, index_td_content(model, object, method), class: options[:class], data: { role: method.to_s }, &block)
  end

  def frame_name(model, parent = nil)
    return "search-#{model_part(model)}" unless parent.present?

    "search-#{parent_part(parent)}-#{model_part(model)}"
  end

  def admin_search_path(model, parent = nil, options = {})
    # prepare the url for the link
    args = ["search_admin_#{model_part(model)}_path"] unless parent.present?
    args = ["search_admin_#{parent_part(parent)}_#{model_part(model)}_path", parent.id] if parent.present?
    # add query parameters
    args << options[:pars] if options[:pars].present?
    public_send(*args)
  end

  def admin_new_path(model, parent = nil, options = {})
    # prepare the url for the link
    args = ["new_admin_#{model.to_s.downcase}_path"] unless parent.present?
    args = ["new_admin_#{parent.to_s.downcase}_#{model.to_s.downcase}_path", parent.id] if parent.present?
    # add query parameters
    args << options[:pars] if options[:pars].present?
    public_send(*args)
  end

  def table_id(model, parent = nil)
    return "#{model_part(model)}-table" unless parent.present?

    "#{parent_part(parent)}-#{model_part(model)}-table"
  end

  private

  def parent_part(parent)
    parent.class.to_element_s
  end

  def model_part(model)
    model.to_table_s
  end
end
