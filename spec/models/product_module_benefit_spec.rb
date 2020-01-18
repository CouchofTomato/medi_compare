require 'rails_helper'

RSpec.describe ProductModuleBenefit, type: :model do
  it { is_expected.to validate_presence_of :benefit_coverage }
  it { is_expected.to validate_presence_of :explanation_of_benefit }
end
