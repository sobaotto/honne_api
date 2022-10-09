# frozen_string_literal: true

class AnswersController < ApplicationController
  def create
    return render_unauthorized if current_user.nil?
    return render_not_found if target_question.instance_of?(ActiveRecord::RecordNotFound)

    begin
      @answer = Answer.create!(
        text: create_params[:text],
        question: target_question,
        user: current_user
      )
    rescue ActiveRecord::RecordInvalid
      render_bad_request
    rescue StandardError
      render_bad_request
    end
  end

  private

  def create_params
    params.permit(:user_id, :question_id, :text)
  end

  def target_question
    Question.find_by!(id: create_params[:question_id])
  rescue ActiveRecord::RecordNotFound => e
    e
  rescue StandardError => e
    e
  end
end
