class MatchSerializer < ActiveModel::Serializer
  attributes :id, :date_of_passing, :obituary_url, :summary, :matched_on, :user_id
  
  belongs_to :user
end
