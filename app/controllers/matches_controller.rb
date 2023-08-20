class MatchesController < ApplicationController
  before_action :set_match, only: [:show, :update, :destroy]

  # GET /matches
  def index
    # Return matches for all users with their associated messages and recipients
    @matches = Match.includes(user: { messages: :recipients }).all
    render json: @matches
  end

  # GET /matches/1
  def show
    @match = Match.includes(user: { messages: :recipients }).find(params[:id])
    render json: @match
end

  # Match.create(user_id: user.id, matched_name: scraped_name)

  # POST /matches
  def create
    @match = Match.new(match_params)

    if @match.save
      render json: @match, status: :created, location: @match
    else
      render json: @match.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /matches/1
  def update
    if @match.update(match_params)
      render json: @match
    else
      render json: @match.errors, status: :unprocessable_entity
    end
  end

  # DELETE /matches/1
  def destroy
    @match.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_match
      @match = Match.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def match_params
      params.fetch(:match, {})
    end
end
