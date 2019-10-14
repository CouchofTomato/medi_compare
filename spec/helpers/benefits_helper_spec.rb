require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the BenefitsHelper. For example:
#
# describe BenefitsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe BenefitsHelper, type: :helper do
  describe 'sort_by_category_and_name' do
      let(:benefits) {[
        {name: 'Surgery', category: 'inpatient'},
        {name: 'Consultations', category: 'outpatient'},
        {name: 'Accomodation', category: 'inpatient'}
      ]}

      let(:sorted_benefits) {[
        {name: 'Accomodation', category: 'inpatient'},
        {name: 'Surgery', category: 'inpatient'},
        {name: 'Consultations', category: 'outpatient'}
      ]}
    it 'sorts an array of hashes first by category and then by name' do
      expect(helper.sort_by_category_and_name(benefits)).to eq(sorted_benefits)
    end
  end
end
