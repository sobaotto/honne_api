# frozen_string_literal: true

class ApplicationController < ActionController::API
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def render_not_found
    render json: { errors: { message: 'ページが見つかりません(アクセス権限なし)' } }, status: :not_found
  end
end
