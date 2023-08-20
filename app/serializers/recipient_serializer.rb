class RecipientSerializer < ActiveModel::Serializer
  attributes :id, :name, :email
  # has_many :messages
end
