# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    return render_forbidden if current_user

    user = referenced_user
    return render_not_found if user.instance_of?(ActiveRecord::RecordNotFound)
    return render_bad_request if user.instance_of?(StandardError)
    return render_unauthorized unless user.authenticate(params[:password])

    session[:user_id] = user.id
  end

  def destroy
    reset_session
  end

  private

  def referenced_user
    User.find_by!(email: params[:email])
  rescue ActiveRecord::RecordNotFound => e
    e
  rescue StandardError => e
    e
  end
end
