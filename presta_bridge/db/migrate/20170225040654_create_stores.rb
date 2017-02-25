class CreateStores < ActiveRecord::Migration[5.0]
  def change
    create_table :stores do |t|
      t.references :user, foreign_key: true
      t.string :name, null: false
      t.string :url, null: false
      t.string :api_key, null: false

      t.timestamps
    end
  end
end
