require 'spec_helper'

describe 'Visits' do
  it "loads visits" do
    visit(visits_path)
    page.should have_content 'Home'
  end
end

describe "Visits" do
  describe "GET /visits" do
    it "loads the visits page" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit visits_path
      page.should have_content('Home')
    end
  end

  describe "Create new visit" do
    it "shows a new visit form" do
      visit new_visit_path
      expect(page).to have_text("Sign in")
    end
  end





end
