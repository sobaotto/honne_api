# frozen_string_literal: true

class QuestionsController < ApplicationController
  def index
    user = target_user

    return render_not_found if user.instance_of?(ActiveRecord::RecordNotFound)
    return render_bad_request if user.instance_of?(StandardError)

    @questions = get_questions(user)
  end

  def show
    @question = get_question(params[:id])

    return render_not_found if @question.instance_of?(ActiveRecord::RecordNotFound)
    return render_bad_request if @question.instance_of?(StandardError)
    return render_not_found_for_unauthorized_user if @question.nil?
  end

  def create
    return render_unauthorized if current_user.nil?

    begin
      @question = Question.create!(create_params)
    rescue ActiveRecord::RecordInvalid
      render_bad_request
    rescue StandardError
      render_bad_request
    end
  end

  def destroy
    return render_unauthorized if current_user.nil?

    question = target_question
    return render_not_found if question.instance_of?(ActiveRecord::RecordNotFound)
    return render_not_found_for_unauthorized_user unless question.own_question?(current_user)

    begin
      question.destroy!
    rescue ActiveRecord::RecordNotDestroyed
      render_bad_request
    rescue StandardError
      render_bad_request
    end
  end

  private

  def create_params
    params.permit(:user_id, :text, :title, :is_public, :respondent_id)
  end

  def target_user
    target_user_name = params[:name]

    return nil unless target_user_name

    begin
      User.find_by!(name: target_user_name)
    rescue ActiveRecord::RecordNotFound => e
      e
    rescue StandardError => e
      e
    end
  end

  def target_question
    Question.find_by!(id: params[:id])
  rescue ActiveRecord::RecordNotFound => e
    e
  rescue StandardError => e
    e
  end

  def get_questions(user)
    return Question.includes(:answer, :respondent).is_public if user.nil?
    return user.questions.includes(:answer, :respondent) if user.equals?(current_user)

    user.questions.includes(:answer, :respondent).is_public
  end

  def get_question(id)
    begin
      question = Question.find_by!(id: id)
    rescue ActiveRecord::RecordNotFound => e
      return e
    rescue StandardError => e
      return e
    end

    return question if question.is_public
    return question if question.own_question?(current_user)
  end
end
