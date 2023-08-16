class UsersController < ApplicationController
  # skip_before_action :authorize, only: [:user_longer_than]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  def show
      user = User.find_by(id: session[:user_id])
      if user
          render json: user
      else
          render json: {error: "Not authorized"}, status: :unathorized
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

  # Make a custom method in the user model that takes a number as an argument and gets all the users that have usernames longer than that. (In terms of characters).
  # def user_longer_than
  #     render json: User.user_longer_than(params[:n].to_i)
  # end


  private

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation, :first_name, :last_name, :date_of_birth)
    end
end
