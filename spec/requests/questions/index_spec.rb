# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /questions', type: :request do
  describe '質問一覧機能' do
    let(:user_a) { create(:user, name: 'user_a') }
    let(:user_b) { create(:user, name: 'user_b') }

    context 'user_aでログインしている場合' do
      before :each do
        login(user: user_a)
        expect(response).to have_http_status(:success)
      end

      it '公開されている質問一覧が取得できる' do
        2.times { create(:question, is_public: true) }

        get '/questions'
        expect(response).to have_http_status(:success)

        questions = JSON.parse(response.body, symbolize_names: true)

        expect(questions.size).to eq(2)
      end

      it 'user_aの質問だけ一覧で取得できる' do
        2.times { create(:question, user: user_a) }
        create(:question, is_public: true, user: user_b)

        get "/questions?name=#{user_a.name}"
        expect(response).to have_http_status(:success)

        questions = JSON.parse(response.body, symbolize_names: true)

        expect(questions.size).to eq(2)
        questions.each do |question|
          expect(question[:user_id]).to eq(user_a.id)
        end
      end

      it 'user_bの公開されている質問だけ一覧で取得できる' do
        create(:question, is_public: false, user: user_b)
        2.times { create(:question, is_public: true, user: user_b) }

        get "/questions?name=#{user_b.name}"
        expect(response).to have_http_status(:success)

        questions = JSON.parse(response.body, symbolize_names: true)

        expect(questions.size).to eq(2)
        questions.each do |question|
          expect(question[:user_id]).to eq(user_b.id)
        end
      end
    end
  end
end
