require 'rails_helper'

RSpec.describe Benefit, type: :model do
  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:category).with_message('Benefit already exists') }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :category }
  it { is_expected.to validate_inclusion_of(:category).in_array Benefit::CATEGORY_NAMES }
end
