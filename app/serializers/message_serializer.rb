class MessageSerializer < ActiveModel::Serializer
  attributes :id, :subject, :body
  # :user_id, :recipient_ids

  # belongs_to :user
  has_many :recipients
end
