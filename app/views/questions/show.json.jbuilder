# frozen_string_literal: true

json.extract! @question, :id, :title, :text, :public_flag, :user_id, :created_at, :updated_at if @question.present?
json.set! :message, @message if @message.present?