require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  before :each do
    visit new_user_url
  end

  scenario 'has a new user page' do
    expect(page).to have_content('New User')
  end

  feature 'signing up a user' do
    before :each do
      visit new_user_url
      fill_in "Username", with: "Bobbert"
      fill_in "Password", with: "password"
      click_on "Create New User"
    end

    scenario 'shows username on the homepage after signup' do
      expect(page).to have_content("Bobbert")
    end

    scenario 'redirects to goals page' do
      expect(current_path).to eq(goals_path)
    end

  end
end

feature 'logging in' do
  user = User.create!(username: "Bobbert", password: 'password')

  scenario 'has a log in page' do
    visit new_session_url
    expect(page).to have_content('Log In')
  end

  before :each do
    visit new_session_url
    fill_in "Username", with: "Bobbert"
    fill_in "Password", with: "password"
    click_on "Sign In"
  end

  scenario 'shows username on the homepage after login' do
    expect(page).to have_content("Bobbert")
  end

end

feature 'logging out' do
  user = User.create!(username: "Bobbert", password: 'password')

  scenario 'should have log out button while logged in' do
    visit new_session_url
    fill_in "Username", with: "Bobbert"
    fill_in "Password", with: "password"
    click_on "Sign In"
    expect(page).to have_content("Log Out")
  end

  scenario 'should have username at top if logged in' do
    visit new_session_url
    fill_in "Username", with: "Bobbert"
    fill_in "Password", with: "password"
    click_on "Sign In"
    expect(page).to have_content("Bobbert")
  end

  scenario 'has login link while logged out' do
    visit new_session_url
    expect(page).to have_content("Log In")
  end

  # before :each do
  #   visit goals_url
  #   click_on "Log Out"
  #   visit new_session_url
  #   fill_in "Username", with: "Bobbert"
  #   fill_in "Password", with: "password"
  #   click_on "Sign In"
  # end

  scenario 'doesn\'t show username on the homepage after logout' do
    visit new_session_url
    expect(page).not_to have_content("Bobbert")
  end

end
