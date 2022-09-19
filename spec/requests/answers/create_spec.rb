require 'rails_helper'

RSpec.describe "POST /answers", type: :request do
  # こういうユーザーの機能制限は、基本フロントで担保する？
  context 'ログイン状態の場合' do
    
    it "新規に回答の投稿ができる" do
      post "/answers"
      expect(response).to have_http_status(:success)
    end
  end
end