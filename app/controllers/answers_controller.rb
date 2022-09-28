class AnswersController < ApplicationController
  def create
    return render json: { errors: { message: 'ログインしてください' } }, status: :unauthorized if current_user.nil?

    begin
      @answer = Answer.create!(
                  text: create_params[:text],
                  question: target_question,
                  user: current_user
                )
    rescue
      # 疑問：StandardErrorを使う時はどんなとき？ユーザーに返すのは、オブジェクトで返すべきな気がする？
      return render json: { errors: { message: '処理が失敗しました' } }, status: :bad_request
    end
  end

  private

  def create_params
    params.permit(:question_id, :text)
  end

  def target_question
    Question.find(create_params[:question_id]) if create_params
  end
end
