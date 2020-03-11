# frozen_string_literal: true

class ProductModuleBenefitDecorator < SimpleDelegator
  def icon
    case benefit_coverage
    when 'paid_in_full'
      "<span class='icon'><i class='fa fa-check green-check'></i></span>"
    when 'capped_benefit'
      "<span class='icon'><i class='fa fa-circle-notch orange-circle-notch'></i></span>"
    end
  end
end
