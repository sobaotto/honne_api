# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DELETE /questions', type: :request do
  describe '質問削除機能' do
    let(:user_a) { create(:user, name: 'user_a') }
    let(:user_b) { create(:user, name: 'user_b') }
    let(:question) { create(:question, user_id: user_a.id) }

    context 'ログイン状態の場合' do
      context 'user_aでログインしている場合' do
        before :each do
          login(user: user_a)
        end

        context '削除したい質問がある場合' do
          it '質問が削除でき、200が返ってくる' do
            delete "/questions/#{question.id}"
            expect(response).to have_http_status(:success)
          end
        end

        context '削除したい質問がない場合' do
          it '404が返ってくる' do
            delete "/questions/#{question.id + 1}"
            expect(response).to have_http_status(:not_found)

            parsed_response = JSON.parse(response.body, symbolize_names: true)
            errors = parsed_response[:errors]

            expect(errors[:message]).to eq('削除しようとした質問が見つかりません')
          end
        end
      end

      context 'user_bでログインしている場合' do
        before :each do
          login(user: user_b)
        end

        it '質問が削除できず、404が返ってくる' do
          delete "/questions/#{question.id}"
          expect(response).to have_http_status(:not_found)

          parsed_response = JSON.parse(response.body, symbolize_names: true)
          errors = parsed_response[:errors]

          expect(errors[:message]).to eq('削除しようとした質問が見つかりません(アクセス権限なし)')
        end
      end
    end

    context 'ログアウト状態の場合' do
      it '質問は削除できず、401が返ってくる' do
        delete "/questions/#{question.id}"
        expect(response).to have_http_status(:unauthorized)

        parsed_response = JSON.parse(response.body, symbolize_names: true)
        errors = parsed_response[:errors]

        expect(errors[:message]).to eq('ログインしてください')
      end
    end
  end
end
