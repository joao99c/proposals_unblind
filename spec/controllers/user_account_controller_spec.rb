require 'rails_helper'

RSpec.describe UserAccountController, type: :controller do

  describe "GET #profile" do
    it "returns http success" do
      get :profile
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #save_profile" do
    it "returns http success" do
      get :save_profile
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #notifications" do
    it "returns http success" do
      get :notifications
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #save_notifications" do
    it "returns http success" do
      get :save_notifications
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #password" do
    it "returns http success" do
      get :password
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #save_password" do
    it "returns http success" do
      get :save_password
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #delete" do
    it "returns http success" do
      get :delete
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #save_delete" do
    it "returns http success" do
      get :save_delete
      expect(response).to have_http_status(:success)
    end
  end

end
