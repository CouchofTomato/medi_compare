require 'rails_helper'

RSpec.describe ComparisonProductsHelper, type: :helper do
  let(:product_modules) do
    [
      create(:product_module, name: 'Gold', sum_assured: 'USD 5000'),
      create(:product_module, name: 'Advance', category: 'outpatient')
    ]
  end

  describe '#selected_modules' do
    it 'returns a string of the modules names joined by +' do
      expect(helper.selected_modules(product_modules)).to eq('Gold + Advance')
    end
  end

  describe '#overall_sum_assured' do
    it 'returns the sum assured from the core model' do
      expect(helper.overall_sum_assured(product_modules)).to eq('USD 5000')
    end
  end

  describe '#match_module_to_benefit' do
    let(:benefit) { create(:benefit, id: 1, name: "Test") }
    let(:product_module) { create(:product_module) }
    let(:product_module_benefit) { create(:product_module_benefit, benefit: benefit, product_module: product_module) }
    let(:product_module_benefits) { [product_module_benefit] }

    it 'returns the ProductModuleBenefit contains the benefit id' do
      expect(helper.match_module_to_benefit(product_module_benefits, 1)).to eq(product_module_benefit)
    end

    it 'returns a NullProductModuleBenefit when no benefit matches the id' do
      expect(helper.match_module_to_benefit(product_module_benefits, 1000)).to be_a NullProductModuleBenefit
    end
  end
end
