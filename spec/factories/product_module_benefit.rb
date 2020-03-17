# frozen_string_literal: true

FactoryBot.define do
  factory :product_module_benefit do
    product_module
    benefit
    benefit_coverage { 'paid_in_full' }
    explanation_of_benefit { 'standard private room' }
    benefit_limit { 'within overall limit' }
  end
end
