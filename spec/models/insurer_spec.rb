require 'rails_helper'

RSpec.describe Insurer, type: :model do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to have_many :products }

  describe '.search' do
    let(:search_term) { 'BUP' }
    let!(:filtered_insurers) {[
      Insurer.create(name: 'BUPA Global')
    ]}
    Insurer.create(name: 'AXA Global')
    Insurer.create(name: 'Aetna Global Benefits')
    
    it 'returns the Insurers whose name or category matches the search term' do
      expect(Insurer.search(search_term)).to match_array(filtered_insurers)
    end

    it 'returns all Insurers if the search term is nil' do
      expect(Insurer.search(nil)).to match_array(Insurer.all)
    end
  end
end
