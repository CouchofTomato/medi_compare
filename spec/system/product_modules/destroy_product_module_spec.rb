require 'rails_helper'

RSpec.describe 'deleting a product module', type: :system, js: true do
  let(:insurer) { create(:insurer, name: 'BUPA') }
  let(:product) { create(:product, name: 'Lifeline', insurer: insurer) }

  before do
    user = create(:user)
    login_as(user, scope: :user)
    create(:product_module, name: 'Gold', product: product)
  end

  it 'allows a product module to be deleted from the product show page' do
    visit insurer_path(insurer)
    click_on 'Lifeline'
    page.accept_confirm do
      find('#delete-gold').click
    end
    expect(page).to have_content 'Product Module deleted!'
  end
end
