# frozen_string_literal: true

json.extract! @question, :id, :title, :text, :is_public, :user_id, :created_at, :updated_at if @question.present?