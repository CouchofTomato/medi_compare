module ProductsHelper
  def group_by_category(input)
    input.group_by(&:category)
  end
end
