require 'rails_helper'

RSpec.describe 'deleting an insurer', type: :system, js: true do
  before :example do
    user = create(:user)
    login_as(user, scope: :user)
    Insurer.create(name: 'BUPA Global')
    Insurer.create(name: 'AXA Global')
    Insurer.create(name: 'Aetna Global')
    Insurer.create(name: 'Now Health')
  end

  it 'allow an insurer to be deleted from the insurers index page' do
    visit insurers_path
    page.accept_confirm do
      find('#delete-bupa-global').click
    end
    expect(page).to have_content 'Insurer deleted!'
  end
end
