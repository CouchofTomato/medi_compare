class CreateProductModuleBenefits < ActiveRecord::Migration[6.0]
  def change
    create_table :product_module_benefits do |t|
      t.references :product_module, null: false, foreign_key: true
      t.references :benefit, null: false, foreign_key: true
      t.string :benefit_coverage
      t.string :explanation_of_benefit

      t.timestamps
    end
  end
end
