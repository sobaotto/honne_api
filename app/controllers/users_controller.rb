class UsersController < ApplicationController
  def create
    if current_user.nil?
      user = User.create(create_params)
      session[:user_id] = user.id
    end
  end

  private

  def create_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
