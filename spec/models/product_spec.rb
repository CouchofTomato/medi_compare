require 'rails_helper'

RSpec.describe Product, type: :model do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to belong_to :insurer }
  it { is_expected.to have_many :product_modules }

  describe '.search' do
    before(:example) do
      create(:product, name: 'lifeline')
      create(:product, name: 'worldwide health options')
    end
    let(:search_term) {'lif'}
    let(:filtered_products) {Product.where(name: 'lifeline')}

    it 'returns the Products whose name matches the search term' do
      expect(Product.search(search_term)).to match_array(filtered_products)
    end

    it 'returns all Products if the search term if nil' do
      expect(Product.search(nil)).to match_array(Product.all)
    end
  end
end
