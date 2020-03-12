require 'rails_helper'

RSpec.describe 'adding a new Product Module', type: :system, js: true do
  let(:insurer) { create(:insurer, name: 'BUPA') }

  before do
    user = create(:user)
    login_as(user, scope: :user)
    Benefit.create(name: 'Accomodation', category: 'inpatient')
    Benefit.create(name: 'Surgery', category: 'inpatient')
    Benefit.create(name: 'Surgery', category: 'outpatient')
    Benefit.create(name: 'Specialist Consultations', category: 'outpatient')
    Benefit.create(name: 'Physiotherapy', category: 'outpatient')
    Product.create(name: 'Lifeline', insurer: insurer)
  end

  it 'allows a user to create a new product module' do
    visit insurer_path(insurer)
    click_on 'Lifeline'
    click_on 'Add New Module'
    select 'Accomodation', from: 'benefits'
    click_on 'Add Benefits'
    fill_in 'product_module[name]', with: 'Gold'
    select 'Outpatient', from: 'product_module_category'
    fill_in 'product_module[sum_assured]', with: 'GBP 300,000'
    choose(option: 'paid_in_full')
    fill_in 'Benefit limit', with: 'Paid in full'
    fill_in 'Explanation of benefit', with: 'Private room'
    click_on 'Create'
    expect(page).to have_content 'New Product Module Created!'
  end

  it 'does not allow a user to create a new product module with a blank name' do
    visit insurer_path(insurer)
    click_on 'Lifeline'
    click_on 'Add New Module'
    select 'Outpatient', from: 'product_module_category'
    fill_in 'product_module[sum_assured]', with: 'GBP 300,000'
    click_on 'Create'
    expect(page).to have_content 'Product Module could not be created'
    expect(page).to have_content 'Name can\'t be blank'
  end

  it 'does not allow a user to create a new product module with a blank benefit coverage for the product_module_benefit' do
    visit insurer_path(insurer)
    click_on 'Lifeline'
    click_on 'Add New Module'
    select 'Accomodation', from: 'benefits'
    click_on 'Add Benefits'
    fill_in 'product_module[name]', with: 'Gold'
    select 'Outpatient', from: 'product_module_category'
    fill_in 'product_module[sum_assured]', with: 'GBP 300,000'
    fill_in 'Explanation of benefit', with: 'Private room'
    click_on 'Create'
    expect(page).to have_content 'Product Module could not be created'
    expect(page).to have_content 'Product module benefits benefit coverage can\'t be blank'
  end

  it 'does not allow a user to create a new product module with a blank explanation of benefit for the product_module_benefit' do
    visit insurer_path(insurer)
    click_on 'Lifeline'
    click_on 'Add New Module'
    select 'Accomodation', from: 'benefits'
    click_on 'Add Benefits'
    fill_in 'product_module[name]', with: 'Gold'
    select 'Outpatient', from: 'product_module_category'
    fill_in 'product_module[sum_assured]', with: 'GBP 300,000'
    choose(option: 'paid_in_full')
    fill_in 'Benefit limit', with: 'Paid in full'
    click_on 'Create'
    expect(page).to have_content 'Product Module could not be created'
    expect(page).to have_content 'Product module benefits explanation of benefit can\'t be blank'
  end
end
