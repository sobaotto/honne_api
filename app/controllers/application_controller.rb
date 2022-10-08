# frozen_string_literal: true

class ApplicationController < ActionController::API
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def render_bad_request
    render json: { errors: { message: '処理が失敗しました' } }, status: :bad_request
  end

  def render_unauthorized
    render json: { errors: { message: 'ログインしてください' } }, status: :unauthorized
  end

  def render_forbidden
    render json: { errors: { message: '禁止されている処理です' } }, status: :forbidden
  end

  def render_not_found
    render json: { errors: { message: 'ページが見つかりません' } }, status: :not_found
  end
end
