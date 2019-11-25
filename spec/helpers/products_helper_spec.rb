require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ProductsHelper. For example:
#
# describe ProductsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ProductsHelper, type: :helper do
  before do
    create(:product_module, name: 'Essential', category: 'core')
    create(:product_module, name: 'Classic', category: 'core')
    create(:product_module, name: 'Evacuation', category: 'evacuation_and_repatriation')
  end

  let(:input) { ProductModule.all }
  let(:product_module_categories) { ProductModule::CATEGORY_NAMES }

  describe '#present_product_module_categories' do
    it 'returns an array of categories that exist in @product_modules' do
      expect(helper.present_product_module_categories(product_module_categories, input))
        .to match_array(['core', 'evacuation_and_repatriation'])
    end
  end
end
