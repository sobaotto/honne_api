# frozen_string_literal: true

json.extract! @answer, :id, :text, :question_id, :user_id, :created_at, :updated_at if @answer.present?