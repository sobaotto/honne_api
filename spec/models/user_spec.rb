# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '新規登録機能' do
    context '正しいパラメータが送られてきた場合' do
      let(:params) {{
        name: 'user',
        email: 'user@example.com',
        password: 'password',
        password_confirmation: 'password'
      }}

      it '新規にレコードが追加されている' do
        User.create!(params)

        user = User.first
        expect(user.name).to eq(params[:name])
        expect(user.email).to eq(params[:email])
      end
    end

    context '誤ったパラメータが送られてきた場合' do
      context 'パラメータが空の場合' do
        it '新規レコード作成に失敗し、ActiveRecord::RecordInvalidの例外を吐く' do
          User.create!
        rescue ActiveRecord::RecordInvalid => e
          expect(e.class).to eq(ActiveRecord::RecordInvalid)
        end
      end
    end
  end
end
