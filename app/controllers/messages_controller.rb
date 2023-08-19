class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :update, :destroy]

  # GET /messages
  def index
    if current_user
      @messages = current_user.messages
      render json: @messages
    else
      render json: { error: "Not authorized" }, status: :unauthorized
    end
  end

  # GET /messages/1
  def show
    render json: @message
  end

  # POST /messages
  def create
    message_data = message_params

    # Create new recipients or find existing ones
    recipient_ids = message_data.delete(:recipients).map do |recipient_data|
        # Find an existing recipient by email or initialize a new one
        recipient = Recipient.find_or_initialize_by(email: recipient_data[:email])
        recipient.name = recipient_data[:name]  # Set or update the name
        recipient.save!
        recipient.id
    end

    # Create the new message
    message = Message.new(message_data.merge(user_id: current_user.id))
    message.recipient_ids = recipient_ids  # Associate the recipients with the message

    if message.save
        render json: message, status: :created
    else
        render json: { error: message.errors.full_messages }, status: :unprocessable_entity
    end
end


  # PATCH/PUT /messages/1
  def update
    if @message.update(message_params)
      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:subject, :body, :user_id, :recipient_id, recipients: [:name, :email])
    end
end
