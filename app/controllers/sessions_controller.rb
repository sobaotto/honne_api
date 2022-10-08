# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    user = User.find_by(email: session_params[:email])

    return render_forbidden if current_user
    return render_not_found if user.nil?
    return render_unauthorized unless user&.authenticate(session_params[:password])

    session[:user_id] = user.id
  end

  def destroy
    reset_session
  end

  private

  def session_params
    params.permit(:name, :email, :password)
  end
end
