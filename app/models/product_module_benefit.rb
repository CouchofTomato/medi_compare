class ProductModuleBenefit < ApplicationRecord
  COVERAGE_OPTIONS = %w[paid_in_full capped_benefit].freeze

  belongs_to :product_module
  belongs_to :benefit

  validates :benefit_coverage, :explanation_of_benefit, :benefit_limit, presence: true
  validates :benefit_coverage, inclusion: { in: COVERAGE_OPTIONS, message: "%{value} is not a valid coverage option" }
end
