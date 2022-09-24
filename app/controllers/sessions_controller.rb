class SessionsController < ApplicationController
  def create
    user = User.find_by(email: session_params[:email])

    if user.nil?
      render json: { message: 'ユーザー情報が見つかりませんでした。'}, status: :bad_request
    elsif user&.authenticate(session_params[:password])
      session[:user_id] = user.id
    else
      render json: { message: 'パスワードが違います。'}, status: :bad_request
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
