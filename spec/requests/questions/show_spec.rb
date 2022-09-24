require 'rails_helper'

RSpec.describe "GET /questions", type: :request do
  let(:user_a) { create(:user, name: 'user_a') }
  let(:user_b) { create(:user, name: 'user_b') }

  describe '質問詳細機能' do
    context 'user_aでログインしている場合' do
      before :each do
        login_params = { 
          name: user_a.name,
          email: user_a.email,
          password: user_a.password
        }
        post "/login", params: login_params
      end
      
      context '公開されている質問の場合' do
        let(:question) { create(:question, public_flag: true) }

        it "詳細が取得できる" do
          get "/questions/#{question.id}"
          expect(response).to have_http_status(:success)
  
          question_details = JSON.parse(response.body, symbolize_names: true)
  
          expect(question_details[:id]).to eq(question.id)
          expect(question_details[:title]).to eq(question.title)
          expect(question_details[:text]).to eq(question.text)
          expect(question_details[:public_flag]).to eq(question.public_flag)
        end
      end

      context '公開されていない質問の場合' do
        let(:question_of_user_a) { create(:question, public_flag: false, user: user_a) }
        let(:question_of_user_b) { create(:question, public_flag: false, user: user_b) }

        it "user_aの非公開質問の詳細が、取得できる" do
          get "/questions/#{question_of_user_a.id}"
          expect(response).to have_http_status(:success)

          question_details = JSON.parse(response.body, symbolize_names: true)

          expect(question_details[:id]).to eq(question_of_user_a.id)
          expect(question_details[:title]).to eq(question_of_user_a.title)
          expect(question_details[:text]).to eq(question_of_user_a.text)
          expect(question_details[:public_flag]).to eq(question_of_user_a.public_flag)
        end

        it "user_bの非公開質問の詳細は、取得できない" do
          get "/questions/#{question_of_user_b.id}"
          expect(response).to have_http_status(:success)

          parsed_response = JSON.parse(response.body, symbolize_names: true)
          expect(parsed_response[:message]).to eq('アクセス権限がありません')
        end
      end
    end
  end
end
