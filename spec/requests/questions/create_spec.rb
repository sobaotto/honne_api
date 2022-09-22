require 'rails_helper'

RSpec.describe "POST /questions", type: :request do
  let!(:user_a) { FactoryBot.create(:user, name: 'user_a') }

  describe '質問投稿機能' do
    context 'user_aでログインしている場合' do
      before :each do
        login_params = { 
          name: user_a.name,
          email: user_a.email,
          password: user_a.password
        }
        post "/login", params: login_params
      end
      
      it "新規で質問が投稿できる" do
        params = { text: 'これは、質問本文です。', title: 'これはタイトルです。' }

        post "/questions", params: params
        expect(response).to have_http_status(:success)
        
        question = Question.first
        expect(question.title).to eq(params[:title])
        expect(question.text).to eq(params[:text])
      end
    end
  end
end
