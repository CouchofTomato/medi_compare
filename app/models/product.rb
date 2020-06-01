class Product < ApplicationRecord
  validates :name, presence: true
  belongs_to :insurer
  has_many :product_modules, dependent: :destroy

  def self.search(search_term)
    if search_term
      where("name ILIKE ?", "%#{search_term.squish}%")
    else
      Product.all
    end
  end
end
