# frozen_string_literal: true

class ComparisonProduct
  include ActiveModel::Model

  attr_reader :insurer, :product, :product_modules
end
