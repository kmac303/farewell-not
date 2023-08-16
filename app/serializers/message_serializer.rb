class MessageSerializer < ActiveModel::Serializer
  attributes :id, :subject, :body, :user_id, :recipient_id
  
  belongs_to :user
end
