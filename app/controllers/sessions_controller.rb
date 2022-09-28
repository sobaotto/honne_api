class SessionsController < ApplicationController
  def create
    user = User.find_by(email: session_params[:email])
    
    return render json: { errors: { message: 'ユーザー情報が見つかりませんでした' } }, status: :not_found  if user.nil?
    return render json: { errors: { message: 'パスワードが違います' } }, status: :unauthorized  unless user&.authenticate(session_params[:password])

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
