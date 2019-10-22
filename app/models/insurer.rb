class Insurer < ApplicationRecord
  validates :name, presence: true

  scope :search, -> (search_term) {
    if search_term
      where("name ILIKE ?", "%#{search_term.squish}%")
    else
      Insurer.all
    end
  }
end
