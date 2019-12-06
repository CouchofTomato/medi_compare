class ProductModule < ApplicationRecord
  CATEGORY_NAMES =
    %w[
      core
      outpatient
      medicines_and_appliances
      wellness
      maternity
      dental_and_optical
      evacuation_and_repatriation
    ].freeze

  validates :name, presence: true
  validates :category, presence: true, inclusion: CATEGORY_NAMES

  belongs_to :product
end