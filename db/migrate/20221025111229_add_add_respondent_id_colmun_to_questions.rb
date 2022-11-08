# frozen_string_literal: true

class AddAddRespondentIdColmunToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_reference :questions, :respondent, null: false, foreign_key: { to_table: :users }
  end
end
