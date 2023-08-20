class ScraperController < ApplicationController
    before_action :authorize
    before_action :restrict_access

    def start
        DeathSpider.process
        DeathSpider.compare_and_save_matches
    
        # Assuming Match has a user_id column and you want to return matches related to the current user
        matches = Match.includes(:user).all # Adjust the limit as needed
    
        render json: matches
    end

    private

    def restrict_access
        unless current_user && current_user.username == "kmac"
          render json: { error: "You are not authorized to access this page." }, status: :forbidden
        end
      end
end
