require 'rails_helper'

RSpec.describe ProductModule, type: :model do
  it { is_expected.to belong_to :product }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :category }
  it { is_expected.to validate_inclusion_of(:category).in_array ProductModule::CATEGORY_NAMES }
end
