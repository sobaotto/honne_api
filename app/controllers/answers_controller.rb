class AnswersController < ApplicationController
  def create
    if current_user
      question = Question.find(create_params[:question_id])

      Answer.create(
        text: create_params[:text],
        question: question,
        user: current_user
      )
      @message = '回答しました'
    else
      @message = 'ログインしてください'
    end
  end

  private

  def create_params
    params.permit(:question_id, :text)
  end
end
