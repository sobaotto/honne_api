# frozen_string_literal: true

json.array! @questions, :id, :title, :text, :is_public, :user_id, :question_status, :created_at, :updated_at
