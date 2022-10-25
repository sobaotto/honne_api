# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    return render_unauthorized if current_user.nil?

    @users = User.where.not(id: current_user.id)
  end

  def create
    return render_forbidden if current_user

    begin
      user = User.create!(create_params)
      session[:user_id] = user.id
    rescue ActiveRecord::RecordInvalid
      render_bad_request
    rescue StandardError
      render_bad_request
    end
  end

  private

  def create_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
