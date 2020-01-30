require 'rails_helper'

RSpec.describe 'editing a product module', type: :system, js: true do
  let(:insurer) { create(:insurer) }
  let(:product) { create(:product, name: 'lifeline', insurer: insurer) }

  before do
    user = create(:user)
    login_as(user, scope: :user)
    create(:product_module, name: 'bronze', product: product)
  end

  it 'allows a user to edit a product module name' do
    visit insurer_path(insurer)
    click_link('Lifeline')
    find('#edit-bronze').click
    fill_in 'product_module[name]', with: 'silver'
    click_on 'Edit'
    expect(page).to have_content 'Product Module Successfully Updated'
    expect(page).to have_content 'Silver'
  end
end
