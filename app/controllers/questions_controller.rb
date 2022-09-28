class QuestionsController < ApplicationController
  def index
    @questions = get_questions(user_to_search_for)
  end

  def show
    @question = get_question(show_params[:id])
  end

  def create
    return render json: { errors: { message: 'ログインしてください' } }, status: :unauthorized if current_user.nil?

    begin
      @question = Question.create!(create_params.merge(user: current_user))
    rescue
      # StandardErrorを使う時はどんなとき？ユーザーに返すのは、オブジェクトで返すべきな気がする？
      return render json: { errors: { message: '処理が失敗しました' } }, status: :bad_request
    end
  end

  private

  def create_params
    params.permit(:text, :title)
  end

  def index_params
    params.permit(:name)
  end

  def show_params
    params.permit(:id)
  end

  def user_to_search_for
    User.find_by(name: index_params[:name]) if index_params
  end

  def is_current_user(user)
    user.id === current_user.id
  end

  def get_questions(user)
    # 公開されている質問取得する
    return Question.is_public if user.nil?
    # 自分の質問を取得する
    return user.questions if is_current_user(user)
    # 特定のユーザーの公開されている質問を取得する
    return user.questions.is_public
  end

  def is_own_question(question)
    question.user_id == current_user.id
  end

  def get_question(id)
    question = Question.find(id)

    # 公開されている質問の場合
    return question if question.is_public
    # 自分の質問の場合
    return question if is_own_question(question)
    # アクセス権限がない場合は、404を返す
    render json: { errors: { message: 'ページが見つかりません' } }, status: :not_found
  end
end
