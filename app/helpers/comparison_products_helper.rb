module ComparisonProductsHelper
  def selected_modules(modules)
    modules.map(&:name).join(' + ')
  end

  def overall_sum_assured(modules)
    modules
      .find { |mod| mod.category == 'core' }
      .sum_assured
  end

  def match_module_to_benefit(product_module_benefits, benefit_id)
    product_module_benefits.find { |module_benefit| module_benefit.benefit_id == benefit_id } || NullProductModuleBenefit.new
  end
end
