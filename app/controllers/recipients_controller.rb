class RecipientsController < ApplicationController
  before_action :set_recipient, only: [:show, :update]

  def index
    @recipients = Recipient.all
    render json: @recipients
  end

  def show
    render json: @recipient
  end

  def create
    @recipient = Recipient.new(recipient_params)

    if @recipient.save
      render json: @recipient, status: :created, location: @recipient
    else
      render json: @recipient.errors, status: :unprocessable_entity
    end
  end

  def update
    if @recipient.update(recipient_params)
      render json: @recipient
    else
      render json: @recipient.errors, status: :unprocessable_entity
    end
  end

  private
    def set_recipient
      @recipient = Recipient.find(params[:id])
    end

    def recipient_params
      params.fetch(:recipient, {})
    end
end
