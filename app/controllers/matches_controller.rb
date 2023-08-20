class MatchesController < ApplicationController
  before_action :set_match, only: [:show, :update, :destroy, :index]

  def index
    @matches = Match.includes(user: { messages: :recipients }).all
    render json: @matches
  end

  def show
    @match = Match.includes(user: { messages: :recipients }).find(params[:id])
    render json: @match
end

  def create
    @match = Match.new(match_params)

    if @match.save
      render json: @match, status: :created, location: @match
    else
      render json: @match.errors, status: :unprocessable_entity
    end
  end

  def update
    if @match.update(match_params)
      render json: @match
    else
      render json: @match.errors, status: :unprocessable_entity
    end
  end

  # def destroy
  #   @match.destroy
  # end

  private
    def set_match
      @match = Match.find(params[:id])
    end

    def match_params
      params.fetch(:match, {})
    end
end
