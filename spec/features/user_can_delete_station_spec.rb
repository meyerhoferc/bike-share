require_relative '../spec_helper'
require_relative 'load_database'

include LoadDatabase

describe 'user deletes station' do
  it 'can be deleted from show page' do
    LoadDatabase.load
    visit('/stations/2')
    click_on('Delete')

    page.has_xpath?('/stations')
    expect(Station.all.count).to eq(4)
  end

  # needs delete test for index page
end
