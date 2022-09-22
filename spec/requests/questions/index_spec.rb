require 'rails_helper'

RSpec.describe "GET /questions", type: :request do
  let(:user_a) { FactoryBot.create(:user, name: 'user_a') }
  let(:user_b) { FactoryBot.create(:user, name: 'user_b') }

  describe '質問一覧機能' do
    context 'user_aでログインしている場合' do
      before :each do
        login_params = { 
          name: user_a.name,
          email: user_a.email,
          password: user_a.password
        }
        post "/login", params: login_params
      end
  
      it "公開されている質問一覧が取得できる" do
        2.times { FactoryBot.create(:question, public_flag: true) }

        get "/questions"
        expect(response).to have_http_status(:success)
  
        questions = JSON.parse(response.body, symbolize_names: true)

        expect(questions.size).to eq(2)
      end
  
      it "user_aの質問だけ一覧で取得できる" do
        2.times { FactoryBot.create(:question, user: user_a) }
        FactoryBot.create(:question, public_flag: true, user: user_b)

        get "/questions?name=#{user_a.name}"
        expect(response).to have_http_status(:success)

        questions = JSON.parse(response.body, symbolize_names: true)
        
        expect(questions.size).to eq(2)
        questions.each do |question|
          expect(question[:user_id]).to eq(user_a.id)
        end
      end
  
      it "user_bの公開されている質問だけ一覧で取得できる" do
        FactoryBot.create(:question, public_flag: false, user: user_b)
        2.times { FactoryBot.create(:question, public_flag: true, user: user_b) }

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
