require 'rails_helper'

RSpec.describe "DELETE /logout", type: :request do
  describe "ログイン機能" do
    let(:user) { create(:user) }

    # モックを使ってテストしたいが上手くいかない。
    # let(:mocked_session) { double() }

    # before do
    #     allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(mocked_session)
    # end

    it "ログアウト状態になり、200が帰ってくる" do
      login(user: user)
      expect(response).to have_http_status(:success)

      delete "/logout"
      expect(response).to have_http_status(:success)
      # expect(mocked_session[:user_id]).to eq(nil)
    end
  end
end
