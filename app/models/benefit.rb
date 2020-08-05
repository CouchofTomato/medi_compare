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
  validates :name, uniqueness: { scope: :category, case_sensitive: false, message: 'with that category already exists' }
  validates :category, inclusion: CATEGORY_NAMES

  scope :alphabetize_by_name, -> { order(:name) }

  def self.search(search_term)
    if search_term
      where("concat_ws(' ', name, category) ILIKE ?", "%#{search_term.squish}%") 
    else
      Benefit.all
    end
  end

  def self.group_by_category
    alphabetize_by_name.group_by(&:category)
  end
end
