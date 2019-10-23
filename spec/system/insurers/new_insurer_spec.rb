require 'rails_helper'

RSpec.describe 'adding a new Insurer', type: :system do
  before :example do
    user = create(:user)
    login_as(user, scope: :user)
  end

  it 'allows a user to create a new insurer' do
    visit insurers_path
    click_on 'Add New Insurer'
    fill_in "insurer[name]", with: 'BUPA Global'
    click_on 'Submit'
    expect(find('.notice')).to have_content 'New Insurer Created!'
    expect(page).to have_content 'Bupa Global'
  end

  it 'does not allow an insurer to be created without a name' do
    visit new_insurer_path
    click_on 'Submit'
    expect(page).to have_content 'Insurer could not be created'
    expect(page).to have_content 'Name can\'t be blank'
  end
end
