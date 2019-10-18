require 'rails_helper'

RSpec.describe 'editing a benefit', type: :system do
  before :example do
    user = create(:user)
    login_as(user, scope: :user)
    Benefit.create(name: 'Accomodation', category: 'inpatient')
    Benefit.create(name: 'Surgery', category: 'inpatient')
    Benefit.create(name: 'Surgery', category: 'outpatient')
    Benefit.create(name: 'Specialist Consultations', category: 'outpatient')
    Benefit.create(name: 'Physiotherapy', category: 'outpatient')
  end

  it 'allows a user to edit a benefit name' do
    visit benefits_path
    find('#edit-accomodation-inpatient').click
    fill_in 'benefit[name]', with: 'Medicines'
    click_on 'Submit'
    expect(page).to have_content 'Benefit Successfully Updated'
    expect(page).to have_content 'Medicines'
  end

  it 'allows a user to edit a benefit category' do
    visit benefits_path
    find('#edit-accomodation-inpatient').click
    select 'Outpatient', from: 'benefit[category]'
    click_on 'Submit'
    expect(page).to have_content 'Benefit Successfully Updated'
  end

  it 'doesn\'t allow a user to update a benefit name as an empty string' do
    visit benefits_path
    find('#edit-accomodation-inpatient').click
    fill_in 'benefit[name]', with: ''
    click_on 'Submit'
    expect(page).to have_content 'Benefit could not be updated.'
    expect(page).to have_content 'Name can\'t be blank'
  end
end
