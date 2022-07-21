class Admin::BaseController < ApplicationController
  before_action :set_model, only: %i[index search show create update destroy]
  before_action :set_parent, only: %i[index search], if: :parent?
  before_action :set_object, only: %i[show update destroy]
  before_action :set_legacy_params, only: %i[index search]
  before_action :set_lists_list_options, only: %i[show]
  rescue_from ActionController::MissingExactTemplate, with: :standard_view

  def index
    base = @parent.present? ? @parent.public_send(@model.to_table_sym) : @model
    @q = base.ransack(params[:q])
    @queries = %i[result index_set]
    paginate_objects
    p "===========@queries", @queries
    p @objects = @queries.inject(@q) { |o, a| o.send(*a) }
    set_list_options
  end

  def show; end

  def new
  end

  def edit
  end

  def search
    index
    render :index
  end

  private

  def set_list_options
    @list_options = {
      model: @model,
      objects: @objects,
      parent: @parent,
      q: @q,
      legacy_params: @legacy_params
    }
  end

  def set_legacy_params
    @legacy_params = {
      per: params[:per],
      q: {}
    }
    @legacy_params[:q] = params[:q].to_unsafe_h if params[:q].present?
  end

  def paginate_objects
    @queries << [:page, params[:page]]
    @queries << [:per, params[:per]]
  end

  def set_model
    @model = params[:model]&.s_to_model || controller_name.s_to_model
  end

  def set_object
    # Take model from "set_model"
    # User.find(1)
    @object = @model.find(params[:id])
  end

  def set_parent
    parent_model = params[:parent_model].s_to_model
    parent_id = params[params[:parent_model].foreign_key]
    @parent = parent_model.find(parent_id)
  end

  def parent?
    params[:parent_model].present?
  end

  # creates instance_variables i.e @products_list_options in order to render show lists of @object
  def set_lists_list_options
    @object.show_lists.each do |list|
      objects = @object.public_send(list).page(1)
      list_options = {
        model: list.s_to_model,
        objects:,
        parent: @object,
        q: objects.ransack({}),
        legacy_params: {}
      }
      instance_variable_set(:"@#{list}_list_options", list_options)
    end
  end

  # render a standard view from a base folder if there is no specific template
  def standard_view
    render "admin/base/#{action_name}"
  end
end
