class ApplicationController < ActionController::Base
  before_action :set_is_app
  before_action :authenticate_user!

  private

  def set_is_app
    @is_app = true
  end
end
