require 'rails_helper'

RSpec.describe "GET /questions", type: :request do
  context 'ログイン状態の場合' do
    it "質問一覧が取得できる" do
      get "/questions"
      expect(response).to have_http_status(:success)
    end

    it "自分の質問一覧が取得できる" do
      get "/questions?name="
      expect(response).to have_http_status(:success)
    end
  end

  context 'ログアウト状態の場合' do
    it "質問一覧が取得できる" do
      get "/questions"
      expect(response).to have_http_status(:success)
    end

    it "特定ユーザーの質問一覧が取得できない" do
      get "/questions?name="
      expect(response).to have_http_status(:success)
    end
  end
end
