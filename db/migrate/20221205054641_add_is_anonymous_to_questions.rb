# frozen_string_literal: true

class AddIsAnonymousToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :is_anonymous, :boolean, null: false, default: true
    add_index :questions, :is_anonymous
  end
end
