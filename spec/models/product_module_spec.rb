require 'rails_helper'

RSpec.describe ProductModule, type: :model do
  it { is_expected.to belong_to :product }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :category }
  it { is_expected.to validate_presence_of :sum_assured }
  it { is_expected.to validate_inclusion_of(:category).in_array ProductModule::CATEGORY_NAMES }
  it { is_expected.to have_many(:product_module_benefits).dependent(:destroy) }
  it { is_expected.to have_many(:benefits).through(:product_module_benefits) }
  it { is_expected.to accept_nested_attributes_for(:product_module_benefits) }
end
