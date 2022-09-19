require 'rails_helper'

RSpec.describe "POST /questions", type: :request do
  context 'ログイン状態の場合' do
    it "新規で質問が投稿できる" do
      post "/questions"
      expect(response).to have_http_status(:success)
    end
  end
end
