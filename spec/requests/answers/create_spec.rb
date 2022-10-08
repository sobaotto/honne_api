# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /answers', type: :request do
  describe '回答投稿機能' do
    let(:user_a) { create(:user, name: 'user_a') }
    let(:user_b) { create(:user, name: 'user_b') }
    let(:question) { create(:question, user: user_b) }

    context 'ログイン状態の場合' do
      context 'user_aでログインしている場合' do
        before :each do
          login(user: user_a)
          expect(response).to have_http_status(:success)
        end

        context '正しいパラメータが送られてきた場合' do
          let(:params) { { user_id: user_a.id, question_id: question.id, text: 'これは、回答本文です' } }

          context '回答しようとしている質問がある場合' do
            it 'user_bの質問に、新規回答でき、200が返ってくる' do
              post '/answers', params: params
              expect(response).to have_http_status(:success)
    
              answer = JSON.parse(response.body, symbolize_names: true)
              expect(answer[:text]).to eq('これは、回答本文です')
            end
          end
    
          context '回答しようとしている質問がない場合(削除された場合)' do
            before :each do
              delete_question(question_id: question.id)
            end
    
            it '新規回答の処理が失敗し、404を返す' do
              post '/answers', params: params
              # 疑問：POSTで404って変じゃないか？
              expect(response).to have_http_status(:not_found)
    
              parsed_response = JSON.parse(response.body, symbolize_names: true)
              errors = parsed_response[:errors]
    
              expect(errors[:message]).to eq('ページが見つかりません')
            end
          end
        end

        context '誤ったパラメータが送られてきた場合' do
          let(:params) { { question_id: question.id } }

          it 'user_bの質問に、新規回答できず、400が返ってくる' do
            post '/answers', params: params
            expect(response).to have_http_status(:bad_request)

            parsed_response = JSON.parse(response.body, symbolize_names: true)
            errors = parsed_response[:errors]
  
            expect(errors[:message]).to eq('処理が失敗しました')
          end
        end
      end
    end

    context 'ログアウト状態の場合' do
      let(:params) { { user_id: user_a.id, question_id: question.id, text: 'これは、回答本文です' } }

      it 'user_bの質問に、新規で回答できず、401が返ってくる' do
        post '/answers', params: params
        expect(response).to have_http_status(:unauthorized)

        parsed_response = JSON.parse(response.body, symbolize_names: true)
        errors = parsed_response[:errors]

        expect(errors[:message]).to eq('ログインしてください')
      end
    end
  end
end
