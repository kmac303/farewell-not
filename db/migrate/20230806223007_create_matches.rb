class CreateMatches < ActiveRecord::Migration[6.1]
  def change
    create_table :matches do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date_of_passing
      t.string :source
      t.string :obituary_url
      t.text :summary
      t.date :matched_on
      t.boolean :is_confirmed, default: false

      t.timestamps
    end
  end
end
