# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /questions', type: :request do
  describe '質問投稿機能' do
    let(:user) { create(:user) }

    context 'ログインしている場合' do
      before :each do
        login(user: user)
        expect(response).to have_http_status(:success)
      end
      context '正しいパラメータが送られてきた場合' do
        let(:params) { { user_id: user.id, text: 'これは、質問本文です', title: 'これはタイトルです' } }

        it '新規で質問が投稿でき、200が返ってくる' do  
          post '/questions', params: params
          expect(response).to have_http_status(:success)
  
          question = JSON.parse(response.body, symbolize_names: true)
          expect(question[:text]).to eq('これは、質問本文です')
          expect(question[:title]).to eq('これはタイトルです')
        end
      end

      context '誤ったパラメータが送られてきた場合' do
        context 'パラメータが空の場合' do
          it 'paramsが不足して、新規作成の処理が失敗した時は、400を返す' do
            post '/questions'
            expect(response).to have_http_status(:bad_request)
    
            parsed_response = JSON.parse(response.body, symbolize_names: true)
            errors = parsed_response[:errors]
    
            expect(errors[:message]).to eq('処理が失敗したので、再度行ってください')
          end
        end
      end

    end

    context 'ログアウトしている場合' do
      it '新規で質問が投稿できず、401が返ってくる' do
        params = { text: 'これは、質問本文です', title: 'これはタイトルです' }

        post '/questions', params: params
        expect(response).to have_http_status(:unauthorized)

        parsed_response = JSON.parse(response.body, symbolize_names: true)
        errors = parsed_response[:errors]

        expect(errors[:message]).to eq('ログインしてください')
      end
    end
  end
end
