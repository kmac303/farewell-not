class ModifyMessageRecipientsForeignKey < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :message_recipients, :messages
    add_foreign_key :message_recipients, :messages, on_delete: :cascade
  end
end
