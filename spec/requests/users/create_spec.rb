require 'rails_helper'

RSpec.describe "POST /users", type: :request do
  it "新規にユーザー登録ができる" do
    params = { 
      name: 'user_a',
      email: 'user_a@example.com',
      password: 'password',
      password_confirmation: 'password'
    }

    post "/users", params: params
    expect(response).to have_http_status(:success)

    user = User.first
    expect(user.name).to eq(params[:name])
    expect(user.email).to eq(params[:email])
  end
end
