class QuestionsController < ApplicationController
  def index
    user_to_search_for = User.find_by(name: index_params[:name]) if index_params

    if user_to_search_for
      if user_to_search_for == current_user
        @questions = current_user.questions
      else
        @questions = user_to_search_for.questions.where(public_flag: true)
      end
    else
      @questions = Question.where(public_flag: true)
    end
  end

  def show
    target_question = Question.find(show_params[:id])
    if target_question.public_flag
      @question = target_question
    else
      if target_question.user_id == current_user.id
        @question = target_question
      else
        @message = 'アクセス権限がありません'
      end
    end
  end

  def create
    if current_user
      Question.create(create_params.merge(user: current_user))
    end
  end

  private

  def create_params
    params.permit(:text, :title)
  end

  def index_params
    params.permit(:name)
  end

  def show_params
    params.permit(:id)
  end
end
