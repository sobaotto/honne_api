# frozen_string_literal: true

class AnswersController < ApplicationController
  def create
    return render_unauthorized if current_user.nil?

    begin
      @answer = Answer.create!(
        text: create_params[:text],
        question: target_question,
        user: current_user
      )
    rescue StandardError
      # 疑問：StandardErrorを使う時はどんなとき？ユーザーに返すのは、オブジェクトで返すべきな気がする？
      render_bad_request
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
