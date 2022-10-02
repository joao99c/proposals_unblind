class ApplicationController < ActionController::Base
  before_action :set_is_app
  before_action :authenticate_user!

  set_current_tenant_through_filter
  before_action :find_current_tenant

  def find_current_tenant
    set_current_tenant(current_user)
  end

  private

  # Overwriting the sign_in redirect path method
  def after_sign_in_path_for(resource_or_scope)
    admin_deals_path
  end

  def set_is_app
    @is_app = true
  end
end
