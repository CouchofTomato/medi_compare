module ApplicationHelper
  def group_by_category(input)
    input.group_by(&:category)
  end

  def options_for_benefits_select(input)
    group_by_category(input).map do |category, benefits|
      [category.titleize, benefits.map { |benefit| [benefit.name.titleize, benefit.id] }]
    end.to_h
  end
end
