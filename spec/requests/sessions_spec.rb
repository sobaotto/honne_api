require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "ログイン機能" do
    let(:user) { FactoryBot.create(:user) }


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

    it "ログアウト状態になる" do
      login_params = { 
        name: user.name,
        email: user.email,
        password: user.password
      }
      
      post "/login", params: login_params
      expect(response).to have_http_status(:success)

      delete "/logout"
      expect(response).to have_http_status(:success)

      # ログアウトをどうやってテストするのか分からない。
    end
  end
end
