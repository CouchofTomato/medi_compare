require 'rails_helper'

RSpec.describe 'deleting a product', type: :system, js: true do
  let(:insurer) { create(:insurer) }
  before :example do
    user = create(:user)
    login_as(user, scope: :user)
    create(:product, name: 'lifeline', insurer: insurer)
    create(:product, name: 'worldwide health options', insurer: insurer)
  end

  it 'allows a product to be deleted from the insurers show page' do
    visit insurer_path(insurer)
    page.accept_confirm do
      find('#delete-lifeline').click
    end
    expect(page).to have_content 'Product deleted!'
  end
end
