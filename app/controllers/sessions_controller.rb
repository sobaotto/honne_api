class SessionsController < ApplicationController
  def create
    user = User.find_by(
      name: session_params[:name],
      email: session_params[:email]
    )
    
    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
    end
  end

  def destroy
    reset_session
  end

  private

  def session_params
    params.permit(:name, :email, :password)
  end
end
