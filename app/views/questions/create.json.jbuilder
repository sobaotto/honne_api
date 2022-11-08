# frozen_string_literal: true

if @question.present?
  json.extract! @question, :id, :title, :text, :is_public, :user_id, :question_status, :created_at,
                :updated_at
end
