require 'rails_helper'

RSpec.describe "POST /answers", type: :request do
  let(:user_a) { create(:user, name: 'user_a') }
  let(:user_b) { create(:user, name: 'user_b') }
  let(:question) { create(:question, user: user_b) }

  describe '回答投稿機能' do
    context 'user_aでログインしている場合' do
      before :each do
        login_params = { 
          email: user_a.email,
          password: user_a.password
        }
        post "/login", params: login_params
      end
  
      it "user_bの質問に、新規で回答できる" do
        params = { question_id: question.id, text: 'これは、回答本文です。' }

        post "/answers", params: params
        expect(response).to have_http_status(:success)
        
        answer = Answer.find_by(question_id: question.id, user_id: user_a.id)
        expect(answer.text).to eq(params[:text])

        res = JSON.parse(response.body, symbolize_names: true)
        expect(res[:message]).to eq('回答しました')
      end
    end

    context 'ログアウト状態の場合' do
      it "user_bの質問に、新規で回答できない" do
        params = { question_id: question.id, text: 'これは、回答本文です。' }

        post "/answers", params: params
        expect(response).to have_http_status(:success)
        
        answer = Answer.find_by(question_id: question.id, user_id: user_a.id)
        expect(answer).to eq(nil)

        parsed_response = JSON.parse(response.body, symbolize_names: true)
        expect(parsed_response[:message]).to eq('ログインしてください')
      end
    end
  end
end