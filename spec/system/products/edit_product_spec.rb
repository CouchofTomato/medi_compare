require 'rails_helper'

RSpec.describe 'editing a product', type: :system do
  let(:insurer) { create(:insurer) }
  before :example do
    user = create(:user)
    login_as(user, scope: :user)
    create(:product, name: 'lifeline', insurer: insurer)
    create(:product, name: 'worldwide health options', insurer: insurer)
  end

  it 'allows a user to edit a product name' do
    visit insurer_path(insurer)
    find('#edit-lifeline').click
    fill_in 'product[name]', with: 'superior'
    click_on 'Submit'
    expect(page).to have_content 'Product Successfully Updated'
    expect(page).to have_content 'Superior'
  end

  it 'doesn\'t allow a user to update a product name as an empty string' do
    visit insurer_path(insurer)
    find('#edit-lifeline').click
    fill_in 'product[name]', with: ''
    click_on 'Submit'
    expect(page).to have_content 'Product could not be updated'
    expect(page).to have_content 'Name can\'t be blank'
  end
end
