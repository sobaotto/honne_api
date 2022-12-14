# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /answers', type: :request do
  describe '回答投稿機能' do
    let(:respondent) { create(:user, name: 'respondent') }
    let(:questioner) { create(:user, name: 'questioner') }
    let(:question) { create(:question, user_id: questioner.id, respondent_id: respondent.id) }

    context 'respondentでログインしている場合' do
      before :each do
        login(user: respondent)
        expect(response).to have_http_status(:success)
      end

      it 'questionerの質問に、新規で回答でき、200が返ってくる' do
        params = { question_id: question.id, text: 'これは、回答本文です' }

        post '/answers', params: params
        expect(response).to have_http_status(:success)

        answer = JSON.parse(response.body, symbolize_names: true)
        expect(answer[:text]).to eq('これは、回答本文です')
      end

      it 'paramsが不足して、新規作成の処理が失敗した時は、400を返す' do
        post '/answers'
        expect(response).to have_http_status(:bad_request)

        parsed_response = JSON.parse(response.body, symbolize_names: true)
        errors = parsed_response[:errors]

        expect(errors[:message]).to eq('処理が失敗しました')
      end
    end

    context 'ログアウト状態の場合' do
      it 'questionerの質問に、新規で回答できず、401が返ってくる' do
        params = { question_id: question.id, text: 'これは、回答本文です' }

        post '/answers', params: params
        expect(response).to have_http_status(:unauthorized)

        parsed_response = JSON.parse(response.body, symbolize_names: true)
        errors = parsed_response[:errors]

        expect(errors[:message]).to eq('ログインしてください')
      end
    end
  end
end
