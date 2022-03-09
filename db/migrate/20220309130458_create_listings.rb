class CreateListings < ActiveRecord::Migration[6.1]
  def change
    create_table :listings do |t|
      t.string :title
      t.string :description
      t.integer :price
      t.integer :condition
      t.integer :postcode
      t.string :brand
      t.string :model
      t.string :finish
      t.integer :capacity
      t.integer :height
      t.integer :width
      t.integer :depth
      t.integer :energy_efficiency
      t.boolean :sold, default: false
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
