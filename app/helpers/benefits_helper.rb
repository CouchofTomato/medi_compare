module BenefitsHelper
  def sort_by_category_and_name(benefits)
    benefits.sort_by {|benefit| [benefit[:category], benefit[:name]]}
  end
end
