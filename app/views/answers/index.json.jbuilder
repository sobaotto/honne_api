# frozen_string_literal: true

json.asked_questions @asked_questions do |asked_question|
  json.question asked_question, :id, :title, :text, :is_public, :respondent_id, :question_status, :created_at,
                :updated_at
  json.answer asked_question.answer, :id, :text, :created_at, :updated_at if asked_question.answer.present?
  if asked_question.user.present?
    json.questioner do
      json.is_anonymous asked_question.is_anonymous
      json.id asked_question.user.id unless asked_question.is_anonymous
      json.name asked_question.is_anonymous ? '匿名の質問' : asked_question.user.name
    end
  end
  json.respondent asked_question.respondent, :id, :name if asked_question.respondent.present?
end
