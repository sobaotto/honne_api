# frozen_string_literal: true

class UsersController < ApplicationController
  def create
    return render_forbidden if current_user

    begin
      user = User.create!(create_params)
      session[:user_id] = user.id
    rescue ActiveRecord::RecordInvalid => e
      # TODO：レスポンスのテスト
      render_bad_request
    end
  end

  private

  def create_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
