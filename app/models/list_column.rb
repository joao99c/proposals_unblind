require 'action_view'

# options
# class - html class of the td content or html class of each item of the content
# td_class - for itterables - htmk class of a td tag

class ListColumn
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::UrlHelper

  DISPLAY_METHODS = %i[full_name name title last_name first_name email id].freeze

  attr_reader :name, :object, :model, :options, :method

  def initialize(object, method, options = {})
    @object = object
    @method = method
    @model = options[:model] || object.class
    @options = options
    # @sortable = options[:sortable] || true
  end

  def header
    options[:header] || method.to_s.humanize
  end

  def th
    return content_tag(:th, header) unless sortable?

    content_tag(:th) do
      content_tag(:span, header)
      render
    end
  end

  def td
    if iterable?
      content_tag(:td, td_multiple_content, class: options[:td_class])
    else
      content_tag(:td, td_single_content, class: options[:td_class])
    end
  end

  def td_single_content
    if assoc?
      link_to display_value, admin_show_path, class: options[:class]
    else
      content_tag(:span, value, class: options[:class])
    end
  end

  def td_multiple_content
    if assoc?
      build_lts
    else
      build_spans
    end
  end

  def build_lts
    safe_join(value.map { |val| link_to display_value(val), admin_show_path(val), class: options[:class] })
  end

  def build_spans
    safe_join(value.map { |val| raw content_tag(:span, val, class: options[:class]) })
  end

  def display_method(val = nil)
    val = value if val.blank?

    options[:display_method] || default_display_method(val)
  end

  def display_value(val = nil)
    val = value if val.blank?
    val.send(display_method(val))
  end

  def value
    object.send(method)
  end

  def assoc?
    model.reflect_on_association(method).present?
  end

  def default_display_method(val = nil)
    val = value if val.blank?
    DISPLAY_METHODS.find { |m| val.respond_to?(m) }
  end

  def admin_show_path(assoc = nil)
    return unless assoc?

    assoc = value if assoc.blank?

    router = Rails.application.routes.url_helpers
    path = :"admin_#{prefix}_path"
    router.public_send(path, assoc.id)
  end

  def default_prefix
    method.to_s.singularize
  end

  def prefix
    options[:prefix] || default_prefix
  end

  def iterable?
    value.is_a?(ActiveRecord::Relation) || value.is_a?(Array)
  end

  # def sortable?
  #   @sortable
  # end
end
