require 'rails_helper'

RSpec.describe 'deleting a benefit', type: :system, js: true do
  before :example do
    user = create(:user)
    login_as(user, scope: :user)
    Benefit.create(name: 'Accomodation', category: 'inpatient')
    Benefit.create(name: 'Surgery', category: 'inpatient')
    Benefit.create(name: 'Surgery', category: 'outpatient')
    Benefit.create(name: 'Specialist Consultations', category: 'outpatient')
    Benefit.create(name: 'Physiotherapy', category: 'outpatient')
  end

  it 'allows a benefit to be deleted from the benefits index page' do
    visit benefits_path
    page.accept_confirm do
      find('#delete-accomodation-inpatient').click
    end
    expect(page).to have_content 'Benefit deleted!'
  end
end
