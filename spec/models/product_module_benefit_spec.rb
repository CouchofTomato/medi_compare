require 'rails_helper'

RSpec.describe ProductModuleBenefit, type: :model do
  it { is_expected.to validate_presence_of :benefit_coverage }
  it { is_expected.to validate_inclusion_of(:benefit_coverage).in_array(ProductModuleBenefit::COVERAGE_OPTIONS).with_message("shoulda-matchers test string is not a valid coverage option") }
  it { is_expected.to validate_presence_of :explanation_of_benefit }
  it { is_expected.to validate_presence_of :benefit_limit }
end
