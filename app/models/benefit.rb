class Benefit < ApplicationRecord
  CATEGORY_NAMES =
    %w[
      inpatient
      outpatient
      therapists
      medicines_and_appliances
      wellness
      evacuation_and_repatriation
      maternity
      dental
      optical
      additional
  ].freeze
  
  validates :name, :category, presence: true
  validates_uniqueness_of :name, scope: :category, message: 'Benefit already exists'
  validates_inclusion_of :category, in: CATEGORY_NAMES
end