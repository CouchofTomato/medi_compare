FactoryBot.define do
  factory :product_module do
    name { 'gold' }
    category { 'core' }
    sum_assured { 'USD 5000, GBP 3000, EUR 3500' }
    product
  end
end
