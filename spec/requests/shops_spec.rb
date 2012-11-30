require 'spec_helper'

describe "Shops home page" do
  it "shows home page banner content" do
    visit shops_path
    expect(page).to have_text("Find a nice place to work")
  end

  it "shows home page button text" do
    visit shops_path
    expect(page).to have_text("Find a nice coffee shop")
  end

  it "shows home page button text" do
    visit shops_path
    expect(page).to have_button("Sign up!")
  end

  it "shows home page button text" do
    visit shops_path
    expect(page).to have_text("Sign in")
  end
end


describe "Sign In Page" do
  it "shows sign in page" do
    user = FactoryGirl.create :user
    visit user_session_path
    fill_in "Email", :with => user.email
    fill_in "Password", :with => user.password
    click_button "Sign in"
    current_path.should eq(root_path)
  end

  xit "does not show 'Sign up!' button" do
    user = FactoryGirl.create :user
    visit user_session_path
    page.should_not have_button("Sign up!")
  end


  xit "does not show 'Sign in' link" do
    user = FactoryGirl.create :user
    visit user_session_path
    page.should_not have_link("Sign in")
  end
end

describe "Sign Up Page" do #, :js => true
  it "shows sign up page" do
    user = FactoryGirl.create :user
    visit new_user_registration_path
    within "#new_user" do
      fill_in "Email", :with => user.email
      fill_in "user_password", :with => user.password
      fill_in "user_password_confirmation", :with => user.password
      click_button "Sign up"
    end
    current_path.should eq(root_path)
  end

  xit "does not show 'Sign up!' button" do
    user = FactoryGirl.create :user
    visit new_user_registration_path
    page.should_not have_button("Sign up!")
  end


  xit "does not show 'Sign in' link" do
    user = FactoryGirl.create :user
    visit new_user_registration_path
    page.should_not have_link("Sign in")
  end
end