# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DELETE /questions', type: :request do
  describe '質問削除機能' do
    let(:questioner) { create(:user, name: 'questioner') }
    let(:respondent) { create(:user, name: 'respondent') }
    let!(:question) { create(:question, user_id: questioner.id, respondent_id: respondent.id) }

    context 'ログイン状態の場合' do
      context 'questionerでログインしている場合' do
        before :each do
          login(user: questioner)
        end

        context '削除したい質問がある場合' do
          it '質問が削除でき、200が返ってくる' do
            delete question_path(question.id)
            expect(response).to have_http_status(:success)
          end
        end

        context '削除したい質問がない場合' do
          it '404が返ってくる' do
            unexists_qustion_id = Question.last.id + 1

            delete question_path(unexists_qustion_id)
            expect(response).to have_http_status(:not_found)

            parsed_response = JSON.parse(response.body, symbolize_names: true)
            errors = parsed_response[:errors]

            expect(errors[:message]).to eq('ページが見つかりません')
          end
        end
      end

      context 'respondentでログインしている場合' do
        before :each do
          login(user: respondent)
        end

        it '質問が削除できず、404が返ってくる' do
          delete question_path(question.id)
          expect(response).to have_http_status(:not_found)

          parsed_response = JSON.parse(response.body, symbolize_names: true)
          errors = parsed_response[:errors]

          expect(errors[:message]).to eq('ページが見つかりません')
        end
      end
    end

    context 'ログアウト状態の場合' do
      it '質問は削除できず、401が返ってくる' do
        delete question_path(question.id)
        expect(response).to have_http_status(:unauthorized)

        parsed_response = JSON.parse(response.body, symbolize_names: true)
        errors = parsed_response[:errors]

        expect(errors[:message]).to eq('ログインしてください')
      end
    end
  end
end
