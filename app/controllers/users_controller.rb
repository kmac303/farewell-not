class UsersController < ApplicationController
  # skip_before_action :authorize, only: [:create, :show]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  def show
    user = User.find_by(id: session[:user_id])
    if user
      render json: { 
        id: user.id,
        username: user.username,
        # ... any other user properties ...
        messages: user.messages || []  # ensure messages is always an array
      }
    else
      render json: {error: "Not authorized"}, status: :unauthorized
    end
  end

  def create
      user = User.create(user_params)
      if user.valid?
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
