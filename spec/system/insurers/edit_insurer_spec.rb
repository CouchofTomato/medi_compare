require 'rails_helper'

RSpec.describe 'editing an insurer', type: :system do
  before :example do
    user = create(:user)
    login_as(user, scope: :user)
    Insurer.create(name: 'BUPA Global')
    Insurer.create(name: 'AXA Global')
    Insurer.create(name: 'Aetna Global')
    Insurer.create(name: 'Now Health')
  end

  it 'allows a user to edit an insurer name' do
    visit insurers_path
    find('#edit-bupa-global').click
    fill_in 'insurer[name]', with: 'William Russell'
    click_on 'Submit'
    expect(page).to have_content 'Insurer Successfully Updated'
    expect(page).to have_content 'William Russell'
  end

  it 'doesn\'t allow a user to update an insurer name as an empty string' do
    visit insurers_path
    find('#edit-bupa-global').click
    fill_in 'insurer[name]', with: ''
    click_on 'Submit'
    expect(page).to have_content 'Insurer could not be updated'
    expect(page).to have_content 'Name can\'t be blank'
  end
end
