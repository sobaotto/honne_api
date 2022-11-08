# frozen_string_literal: true

class AnswersController < ApplicationController
  def index
    return render_unauthorized if current_user.nil?

    @asked_questions = Question.includes(:answer).where(respondent_id: current_user.id)
  end

  def create
    return render_unauthorized if current_user.nil?

    begin
      @answer = Answer.create!(
        text: create_params[:text],
        question_id: target_question.id,
        user_id: current_user.id
      )
    rescue StandardError
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
