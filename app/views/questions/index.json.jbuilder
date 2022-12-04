# frozen_string_literal: true

json.question_items @questions do |question|
  json.question question, :id, :title, :text, :is_public, :respondent_id, :question_status, :created_at, :updated_at
  json.answer question.answer, :id, :text, :created_at, :updated_at if question.answer.present?
  json.respondent question.respondent, :name, :id
  json.questioner question.user, :name, :id
end
