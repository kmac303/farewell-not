class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :first_name, :last_name, :date_of_birth
end