module ComparisonProductsHelper
  def selected_modules(modules)
    modules.map(&:name).join(' + ')
  end

  def overall_sum_assured(modules)
    modules
      .find { |mod| mod.category == 'core' }
      .sum_assured
  end
end
