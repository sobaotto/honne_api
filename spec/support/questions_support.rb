# frozen_string_literal: true

module QuestionsSupport
  def delete_question(question_id: nil)
    # 疑問：request_specで、直接レコードを消しているが大丈夫か？
    Question.find_by(id: question_id).destroy!
  end
end
