require 'rails_helper'

RSpec.describe 'adding a new Product', type: :system do
  let(:insurer) { create(:insurer) }

  before do
    user = create(:user)
    login_as(user, scope: :user)
  end

  it 'allows a user to create a new product' do
    visit insurer_path(insurer)
    click_on 'Add New Product'
    fill_in 'product[name]', with: 'lifeline'
    click_on 'Submit'
    expect(find('.notice')).to have_content 'New Product Created!'
    expect(page).to have_content 'Lifeline'
  end

  it 'does not allow a product to be created without a name' do
    visit insurer_path(insurer)
    click_on 'Add New Product'
    click_on 'Submit'
    expect(page).to have_content 'Product could not be created'
    expect(page).to have_content 'Name can\'t be blank'
  end
end
