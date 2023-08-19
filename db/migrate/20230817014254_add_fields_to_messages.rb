class AddFieldsToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :days_countdown, :integer
    add_column :messages, :time_to_send, :time
  end
end
