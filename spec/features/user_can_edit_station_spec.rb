require_relative '../spec_helper'
require_relative 'load_database'

include LoadDatabase

describe 'user edits station' do
  it 'redirects to /new for a form' do
    LoadDatabase.load
    visit('/stations/2')
    click_on('Edit')

    page.has_xpath?('/stations/2/edit')
  end

  it 'fills in new information in form' do
    LoadDatabase.load
    visit('/stations/2/edit')
    fill_in('station[name]', :with => "New Name")
    fill_in('station[city]', :with => "New City")
    fill_in('station[dock_count]', :with => "38")
    fill_in('station[installation_date]', :with => "07/07/2016")
    click_on('submit')

    page.has_xpath?('/stations/2/edit')
    expect(page).to have_content('New Name')
    expect(page).to have_content('New City')
    expect(page).to have_content('38')
    expect(page).to have_content('2016-07-07')
  end
end
