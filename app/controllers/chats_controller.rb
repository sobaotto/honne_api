# frozen_string_literal: true

class ChatsController < ApplicationController
  def index
    return render_unauthorized if current_user.nil?

    @chats = Chat.where(question_id: params[:question_id])
  end

  def create
    return render_unauthorized if current_user.nil?

    begin
      @chat = Chat.create!(create_params)
    rescue ActiveRecord::RecordInvalid
      render_bad_request
    rescue StandardError
      render_bad_request
    end
  end

  private

  def create_params
    params.permit(:user_id, :text, :question_id)
  end
end
