class ScraperController < ApplicationController
    before_action :authorize
    before_action :restrict_access

    def start
        DeathSpider.process
        DeathSpider.compare_and_save_matches
    
        matches = Match.includes(user: {messages: :recipients}).all 
        render json: matches.to_json(include: { user: { include: { messages: { include: :recipients } } } })
    end

    private

    def restrict_access
        unless current_user && current_user.username == "admin"
          render json: { error: "You are not authorized to access this page." }, status: :forbidden
        end
      end
end
