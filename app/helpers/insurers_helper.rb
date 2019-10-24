module InsurersHelper
  def kebab_case(string)
    string.downcase.strip.gsub(' ', '-')
  end
end
