class UsersController < ApplicationController
  skip_before_action :authorize, only: [:create, :show]

  def show
    user = current_user
  
    if user
      render json: { 
        id: user.id,
        username: user.username,
        messages: user.messages || []  
      }
    else
      render json: {error: "Not authorized"}, status: :unauthorized
    end
  end

  def create
      user = User.create(user_params)
      if user.valid?
        session[:user_id] = user.id
        render json: user, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
  end

  private

    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation, :first_name, :last_name, :date_of_birth)
    end
end
