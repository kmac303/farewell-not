class Message < ApplicationRecord
    belongs_to :user
    has_many :message_recipients
    has_many :recipients, through: :message_recipients

    def update_with_recipients(attributes, recipient_params)
        ActiveRecord::Base.transaction do
          update(attributes)
          message_recipients.destroy_all
      
          recipient_params.each do |params|
            recipient = Recipient.find_or_initialize_by(email: params[:email])
            recipient.name = params[:name]
            recipient.save!
      
            recipients << recipient
          end
        end
      end
      
    validates :subject, presence: true
    validates :body, presence: true
    # has_one_attached :file
end
