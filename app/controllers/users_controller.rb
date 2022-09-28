class UsersController < ApplicationController
  def create
    # TODO:ログイン状態の場合は、エラーを返す
    return render json: { errors: { message: 'すでにログインしています' } }, status: :forbidden if current_user
    
    begin
      user = User.create!(create_params)
      session[:user_id] = user.id
    rescue
      # StandardErrorを使う時はどんなとき？ユーザーに返すのは、オブジェクトで返すべきな気がする？
      return render json: { errors: { message: '処理が失敗しました' } }, status: :bad_request
    end
  end

  private

  def create_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
