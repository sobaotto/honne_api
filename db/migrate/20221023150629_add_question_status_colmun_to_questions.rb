class AddQuestionStatusColmunToQuestions < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :question_status, :string, null: false, default: 'unresolved'
  end
end
