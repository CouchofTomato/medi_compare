class Product < ApplicationRecord
  validates_presence_of :name
  belongs_to :insurer

  def self.search(search_term)
    if search_term
      where("name ILIKE ?", "%#{search_term.squish}%")
    else
      Product.all
    end
  end
end
