class ApplicationController < ActionController::API
  include ActionController::Cookies

  before_action :authorize

  private

  def authorize
    return render json: { error: "Not authorized" }, status: :unauthorized unless session.include?(:user_id)
  end

  # def current_user
  #   @current_user ||= User.find_by(id: session[:user_id])
  # end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end
