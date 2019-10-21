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

  before_save { self.name.downcase! }
  validates :name, :category, presence: true
  validates_uniqueness_of :name, scope: :category, case_sensitive: false, message: 'with that category already exists'
  validates_inclusion_of :category, in: CATEGORY_NAMES

  scope :search, -> (search_term) { where("concat_ws(' ', name, category) ILIKE ?", "%#{search_term.squish}%") }
end
