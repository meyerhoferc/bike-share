require_relative '../spec_helper'

describe "When user visits index" do
  it "they see a station" do
    visit('/stations')

    save_and_open_page
    within('#station_greeting') do
      expect(page).to have_content("Stations")
    end
  end
end
