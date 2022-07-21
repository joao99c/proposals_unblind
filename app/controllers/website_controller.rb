class WebsiteController < ActionController::Base
  before_action :set_is_app

  def index
  end

  private

  def set_is_app
    @is_app = false
  end
end
