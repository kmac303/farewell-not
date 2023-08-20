class MessageSerializer < ActiveModel::Serializer
  attributes :id, :subject, :body

  has_many :recipients
end
