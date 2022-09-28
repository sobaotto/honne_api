require 'rails_helper'

RSpec.describe "GET /questions", type: :request do
  describe '質問詳細機能' do
    let(:user_a) { create(:user, name: 'user_a') }
    let(:user_b) { create(:user, name: 'user_b') }
  
    context 'user_aでログインしている場合' do
      before :each do
        login(user: user_a)
      end
      
      context '公開されている質問の場合' do
        let(:question) { create(:question, is_public: true) }

        it "詳細が取得できる" do
          get "/questions/#{question.id}"
          expect(response).to have_http_status(:success)
  
          question_details = JSON.parse(response.body, symbolize_names: true)
  
          expect(question_details[:id]).to eq(question.id)
          expect(question_details[:title]).to eq(question.title)
          expect(question_details[:text]).to eq(question.text)
          expect(question_details[:is_public]).to eq(question.is_public)
        end
      end

      context '公開されていない質問の場合' do
        let(:question_of_user_a) { create(:question, is_public: false, user: user_a) }
        let(:question_of_user_b) { create(:question, is_public: false, user: user_b) }

        it "user_aの非公開質問の詳細が取得できる" do
          get "/questions/#{question_of_user_a.id}"
          expect(response).to have_http_status(:success)

          question_details = JSON.parse(response.body, symbolize_names: true)

          expect(question_details[:id]).to eq(question_of_user_a.id)
          expect(question_details[:title]).to eq(question_of_user_a.title)
          expect(question_details[:text]).to eq(question_of_user_a.text)
          expect(question_details[:is_public]).to eq(question_of_user_a.is_public)
        end

        it "user_bの非公開質問の詳細が取得できず、404が返ってくる" do
          get "/questions/#{question_of_user_b.id}"
          expect(response).to have_http_status(:not_found)

          parsed_response = JSON.parse(response.body, symbolize_names: true)
          errors = parsed_response[:errors]

          expect(errors[:message]).to eq('ページが見つかりません')
        end
      end
    end
  end
end
