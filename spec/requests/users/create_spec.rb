require 'rails_helper'

RSpec.describe "POST /users", type: :request do
  context 'ログアウト状態の場合' do

    it "新規にユーザー登録ができる" do
      post "/users"
      expect(response).to have_http_status(:success)
    end
  end
end
