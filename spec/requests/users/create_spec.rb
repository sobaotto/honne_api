# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /users', type: :request do
  it '新規にユーザー登録ができ、200が返ってくる' do
    params = {
      name: 'user',
      email: 'user@example.com',
      password: 'password',
      password_confirmation: 'password'
    }

    post '/users', params: params
    expect(response).to have_http_status(:success)
  end
end
