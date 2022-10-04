# frozen_string_literal: true

class UsersController < ApplicationController
  def create
    return render json: { errors: { message: 'すでにログインしています' } }, status: :forbidden if current_user

    begin
      user = User.create!(create_params)
      session[:user_id] = user.id
    rescue ActiveRecord::RecordInvalid => e
      # TODO：レスポンスのテスト
      render json: { errors: { message: '処理が失敗したので、再度行ってください' } }, status: :bad_request
    end
  end

  private

  def create_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
