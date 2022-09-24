require 'rails_helper'

RSpec.describe "POST /login", type: :request do
  describe "ログイン機能" do
    let(:user) { create(:user) }

    it "ログイン状態になる" do
      login_params = { 
        name: user.name,
        email: user.email,
        password: user.password
      }
      post "/login", params: login_params

      expect(response).to have_http_status(:success)
      
      current_user = JSON.parse(response.body, symbolize_names: true)
      expect(current_user[:name]).to eq(user.name)
      expect(current_user[:email]).to eq(user.email)
    end
  end
end
