require_relative "../spec_helper"

describe "when a user visits the new form page" do
  it "sees the form to create a new station" do
    visit "/stations/new"
    fill_in("station[name]", with: "SF")
    fill_in("station[dock_count]", with: "59")
    fill_in("station[city]", with: "Guadalajara")
    fill_in("station[installation_date]", with: "01/01/2017")
    click_on("Submit")
    expect(current_path).to eq("/stations/1")
    expect(page).to have_content("SF")
  end
end
