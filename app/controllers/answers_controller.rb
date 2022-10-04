# frozen_string_literal: true

class AnswersController < ApplicationController
  def create
    return render json: { errors: { message: 'ログインしてください' } }, status: :unauthorized if current_user.nil?
    return render json: { errors: { message: '回答しようとした質問が見つかりません' } }, status: :not_found if target_question.nil?

    begin
      @answer = Answer.create!(
        text: create_params[:text],
        question: target_question,
        user: current_user
      )
    rescue ActiveRecord::RecordInvalid => e
      render json: { errors: { message: '処理が失敗したので、再度行ってください' } }, status: :bad_request
    end
  end

  private

  def create_params
    params.permit(:user_id, :question_id, :text)
  end

  def target_question
    Question.find_by(id: create_params[:question_id])
  end
end
