# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /login', type: :request do
  describe 'ログイン機能' do
    let(:user) { create(:user) }

    context '入力されたemailに紐づくユーザー情報が存在する場合' do
      context 'ログインされていない場合' do
        it '正しいパラメーターでログインでき、ユーザー情報が返ってくる' do
          login(user: user)
          expect(response).to have_http_status(:success)

          current_user = JSON.parse(response.body, symbolize_names: true)
          expect(current_user[:name]).to eq(user.name)
          expect(current_user[:email]).to eq(user.email)
        end

        it '誤ったパラメーターではログインできず、401が返ってくる' do
          login(user: user, password: 'wrong_password')
          expect(response).to have_http_status(:unauthorized)

          parsed_response = JSON.parse(response.body, symbolize_names: true)
          errors = parsed_response[:errors]

          expect(errors[:message]).to eq('ログインしてください')
        end
      end

      context 'すでにログインされている場合' do
        before :each do
          login(user: user)
          expect(response).to have_http_status(:success)
        end

        it '403が返ってくる' do
          login(user: user)
          expect(response).to have_http_status(:forbidden)

          parsed_response = JSON.parse(response.body, symbolize_names: true)
          errors = parsed_response[:errors]

          expect(errors[:message]).to eq('禁止されている処理です')
        end
      end
    end

    context '入力されたemailに紐づくユーザー情報が存在しない場合' do
      it 'ログインできず、404が返ってくる' do
        login(email: 'unknown@example.com')
        expect(response).to have_http_status(:not_found)

        parsed_response = JSON.parse(response.body, symbolize_names: true)
        errors = parsed_response[:errors]

        expect(errors[:message]).to eq('ページが見つかりません')
      end
    end
  end
end
