class WebsiteController < ActionController::Base
  before_action :set_is_app
  layout 'website'

  def index
    redirect_to admin_deals_path
  end

  private

  def set_is_app
    @is_app = false
  end
end
