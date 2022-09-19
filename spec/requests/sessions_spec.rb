require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "POST /create" do
    it "ログイン状態になる" do
      post "/login"
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE /destroy" do
    it "ログアウト状態になる" do
      delete "/logout"
      expect(response).to have_http_status(:success)
    end
  end
end
