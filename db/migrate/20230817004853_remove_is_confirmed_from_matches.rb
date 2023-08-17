class RemoveIsConfirmedFromMatches < ActiveRecord::Migration[6.1]
  def change
    remove_column :matches, :is_confirmed
  end
end
