require 'rails_helper'

RSpec.describe "GET /questions", type: :request do
  context 'ログイン状態の場合' do
    it "質問詳細が取得できる" do
      get "/questions/:id"
      expect(response).to have_http_status(:success)
    end
  end
end
