require 'rails_helper'

RSpec.describe Benefit, type: :model do
  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:category).case_insensitive.with_message('with that category already exists') }
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :category }
  it { is_expected.to validate_inclusion_of(:category).in_array Benefit::CATEGORY_NAMES }

  describe '.search' do 
    let(:search_term) { 'accom' }
    let!(:filtered_benefits) {[
        Benefit.create(name: 'Accomodation', category: 'inpatient'),
        Benefit.create(name: 'Parenting Accomodation', category: 'inpatient')
      ]}
    Benefit.create(name: 'Surgery', category: 'inpatient')

    it 'returns the Benefits whose name or category matches the method argument' do
      expect(Benefit.search(search_term)).to match_array(filtered_benefits)
    end
  end
end
