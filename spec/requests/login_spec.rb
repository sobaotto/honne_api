require 'rails_helper'

RSpec.describe "POST /login", type: :request do
  describe "ログイン機能" do
    let(:user) { create(:user) }

    context "入力されたemailに紐づくユーザー情報が存在する場合" do
      it "正しいパラメーターでログイン状態になる" do
        login(user: user)
  
        expect(response).to have_http_status(:success)
        
        current_user = JSON.parse(response.body, symbolize_names: true)
        expect(current_user[:name]).to eq(user.name)
        expect(current_user[:email]).to eq(user.email)
      end

      it "誤ったパラメーターではログインできない" do
        login(user: user, password: 'wrong_password')

        expect(response).to have_http_status(:bad_request)
        
        error = JSON.parse(response.body, symbolize_names: true)
        expect(error[:message]).to eq('パスワードが違います。')
      end
    end

    context "入力されたemailに紐づくユーザー情報が存在しない場合" do
      it "ログインできない" do
        login(email: 'unknown@example.com')

        expect(response).to have_http_status(:bad_request)
        
        error = JSON.parse(response.body, symbolize_names: true)
        expect(error[:message]).to eq('ユーザー情報が見つかりませんでした。')
      end
    end
  end
end