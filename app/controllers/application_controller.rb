class ApplicationController < ActionController::API
  include ActionController::Cookies

  private

  def authorize
    return render json: { error: "Not authorized" }, status: :unauthorized unless session.include?(:user_id)
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

end
