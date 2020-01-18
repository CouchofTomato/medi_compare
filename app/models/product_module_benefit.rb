class ProductModuleBenefit < ApplicationRecord
  belongs_to :product_module
  belongs_to :benefit

  validates :benefit_coverage, :explanation_of_benefit, presence: true
end
