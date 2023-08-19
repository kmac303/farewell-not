class Message < ApplicationRecord
    belongs_to :user
    belongs_to :recipient
    validates :subject, presence: true
    validates :body, presence: true
    # has_one_attached :file
end
