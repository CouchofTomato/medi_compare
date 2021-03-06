# frozen_string_literal: true

module ProductsHelper
  def present_product_module_categories(categories, product_modules)
    categories.select do |category|
      present_categories(product_modules).include?(category)
    end
  end

  private

  def present_categories(product_modules)
    product_modules.map(&:category).uniq
  end
end
