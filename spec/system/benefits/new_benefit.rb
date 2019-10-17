require 'rails_helper'

RSpec.describe 'adding a new Benefit', type: :system do
  before :each do
    user = create(:user)
    login_as(user, scope: :user)
  end

  it 'allows a user to create a new benefit' do
    visit benefits_path
    click_on 'Add New Benefit'
    fill_in 'benefit[name]', with: 'Accomodation'
    select 'Inpatient', from: 'benefit[category]'
    click_on 'Submit'
    expect(find('.notice')).to have_content 'New Benefit Created!'
    expect(page).to have_content 'Accomodation'
  end

  it 'does not allow a benefit that already exists with the same name and category to be created' do
    create(:benefit, name: 'Child Birth', category: 'maternity')

    visit new_benefit_path
    fill_in 'benefit[name]', with: 'Child Birth'
    select 'Maternity', from: 'benefit[category]'
    click_on 'Submit'
    expect(page).to have_content 'Benefit could not be created.'
    expect(page).to have_content 'Name Benefit already exists'
  end

  it 'does not allow a benefit to be created without a name' do
    visit new_benefit_path
    select 'Maternity', from: 'benefit[category]'
    click_on 'Submit'
    expect(page).to have_content 'Benefit could not be created.'
    expect(page).to have_content 'Name can\'t be blank'
  end
end
