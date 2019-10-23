class Insurer < ApplicationRecord
  validates :name, presence: true

  def self.search(search_term)
    if search_term
      where("name ILIKE ?", "%#{search_term.squish}%")
    else
      Insurer.all
    end
  end
end
