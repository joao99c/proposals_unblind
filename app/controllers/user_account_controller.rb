# frozen_string_literal: true

class UserAccountController < ApplicationController
  def index; end

  def profile; end

  def save_profile
    respond_to do |format|
      if current_user.update(params.require(:user).permit(:first_name, :last_name, :email, :avatar, :company_avatar, :company_name, :iva))
        format.html { redirect_to user_account_profile_path }
      else
        format.html { render :profile, status: :unprocessable_entity }
      end
    end
  end

  def notifications; end

  def save_notifications; end

  def password; end

  def save_password; end

  def delete; end

  def save_delete; end
end
