class CreateProductModules < ActiveRecord::Migration[6.0]
  def change
    create_table :product_modules do |t|
      t.string :name
      t.string :category
      t.string :sum_assured
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
