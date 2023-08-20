class Recipient < ApplicationRecord
    has_many :message_recipients
    has_many :messages, through: :message_recipients
    # has_many :users, through: :messages
end
