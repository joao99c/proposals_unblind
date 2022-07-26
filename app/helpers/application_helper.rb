module ApplicationHelper

  # returns array of controllers namespased with 'admin/' in form of 'products'
  def admin_controllers
    controllers = Rails.application.routes.routes.map do |route|
      route.defaults[:controller]
    end.uniq
    controllers.compact.select { |x| x.match? 'admin/' }.map { |x| x.gsub('admin/', '') }
  end

  # returns an index path of the specified controller or same controller
  # OPTIONS: controller - the admin controller name in form of 'products', pars: parameters of the link in for of hash
  def admin_index_path(options = {})
    controller = options[:controller] || controller_name
    args = [:"admin_#{controller}_path"]
    args << options[:pars] if options[:pars].present?
    public_send(*args)
  end

  def admin_show_path(options = {})
    controller = options[:controller] || controller_name
    args = [:"admin_#{controller.singularize}_path"]
    args << options[:pars] if options[:pars].present?
    public_send(*args)
  end

  def flatten_hash(hash = params, ancestor_names = [])
    flat_hash = {}
    hash.each do |k, v|
      names = Array.new(ancestor_names)
      names << k
      if v.is_a?(Hash)
        flat_hash.merge!(flatten_hash(v, names))
      else
        key = flat_hash_key(names)
        key += "[]" if v.is_a?(Array)
        flat_hash[key] = v
      end
    end
    flat_hash
  end

  def flat_hash_key(names)
    names = Array.new(names)
    name = names.shift.to_s.dup
    names.each do |n|
      name << "[#{n}]"
    end
    name
  end

  def hash_as_hidden_fields(hash = params)
    hidden_fields = []
    flatten_hash(hash).each do |name, value|
      value = [value] unless value.is_a?(Array)
      value.each do |v|
        hidden_fields << hidden_field_tag(name, v.to_s, id: nil)
      end
    end
    hidden_fields.join("\n")
  end

  def error_message_for(obj, attr_name)
    render partial: "shared/input_error_message", locals: { obj: obj, attr_name: attr_name }
  end
end
