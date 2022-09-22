class UsersController < ApplicationController
  def create
    if current_user.nil?
      User.create(create_params)
    end
  end

  private

  def create_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
