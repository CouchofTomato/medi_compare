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
RSpec.describe ApplicationHelper, type: :helper do
  before do
    create(:product_module, name: 'Essential', category: 'core')
    create(:product_module, name: 'Classic', category: 'core')
    create(:product_module, name: 'Evacuation', category: 'evacuation_and_repatriation')
  end

  let(:input) { ProductModule.all }
  let(:product_module_categories) { ProductModule::CATEGORY_NAMES }

  describe '#group_by_category' do
    before do
      create(:product_module, name: 'Essential', category: 'core')
      create(:product_module, name: 'Classic', category: 'core')
      create(:product_module, name: 'Evacuation', category: 'evacuation_and_repatriation')
    end

    let(:input) { ProductModule.all }
    let(:product_module_categories) { ProductModule::CATEGORY_NAMES }

    it 'returns a hash of objects grouped by their category' do
      expect(helper.group_by_category(input)).to match(
        'core' => a_collection_including(
          an_object_having_attributes(name: 'Essential'),
          an_object_having_attributes(name: 'Classic'),
        ),
        'evacuation_and_repatriation' => a_collection_including(
          an_object_having_attributes(name: 'Evacuation')
        )
      )
    end
  end
end
