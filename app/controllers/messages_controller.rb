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
    @message = Message.includes(:recipients).find(params[:id])
    
    # Check if the current user is the owner of the message
    if @message.user_id != current_user.id
      render json: { error: 'Not authorized' }, status: :forbidden
    else
      render json: @message
    end
  end

  # POST /messages
  def create
    @message = Message.new(message_params.except(:recipients))
    @message.user = current_user
  
    if @message.save
      # Handle recipients
      params[:message][:recipients].each do |recipient_params|
        recipient = Recipient.find_or_create_by(email: recipient_params[:email]) do |r|
          r.name = recipient_params[:name]
        end
  
        @message.recipients << recipient
      end
  
      render json: @message, status: :created
    else
      render json: { errors: @message.errors.full_messages }, status: :unprocessable_entity
    end
  end


  # PATCH/PUT /messages/1
  def update
    if @message.update_with_recipients(message_params.except(:recipients), params[:recipients])
      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  rescue => e
    render json: { error: e.message }, status: :internal_server_error
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
