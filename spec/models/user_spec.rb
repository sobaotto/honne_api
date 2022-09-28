require 'rails_helper'

RSpec.describe User, type: :model do
  describe '新規登録機能' do
    context '正しいパラメータが送られてきた場合' do
      it '新規にレコードが追加されている' do
        params = { 
          name: 'user',
          email: 'user@example.com',
          password: 'password',
          password_confirmation: 'password'
        }  
        User.create!(params)

        user = User.first
        expect(user.name).to eq(params[:name])
        expect(user.email).to eq(params[:email])
      end
    end

    context '誤ったパラメータが送られてきた場合' do
      it '新規レコード作成に失敗した時は、例外処理が行われる' do
        begin
          User.create!()
        rescue => e
          expect(e.present?).to eq(true)
        end
      end
    end
  end
end
