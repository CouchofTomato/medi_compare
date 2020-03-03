class AddBenefitLimitToProductModuleBenefits < ActiveRecord::Migration[6.0]
  def change
    add_column :product_module_benefits, :benefit_limit, :string
  end
end
