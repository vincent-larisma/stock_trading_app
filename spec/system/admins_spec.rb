require 'rails_helper'

RSpec.describe "Admins", type: :system do
  before do
    driven_by(:rack_test)
  end

    it "should redirect to admin user's index page" do
      login_as(FactoryBot.create(:user, role: "admin"))
      visit admin_users_path
      expect(page).to have_content "Traders"
      expect(page).to have_content "Pending"
      expect(page).to have_content "Create User"
    end

    it "should create a pending trader user" do
      login_as(FactoryBot.create(:user, role: "admin"))
      visit admin_users_path

      click_on "Create User"

      fill_in 'Email', with: "test@test.com"
      fill_in 'Password', with: "test123"
      fill_in 'Password confirmation', with: "test123"
      click_on "commit"

      expect(page).to have_content "User with email test@test.com successfully created."
    end

    it "should be able to show user's details " do 
      login_as(FactoryBot.create(:user, role: "admin"))
      visit admin_users_path

      click_on "Create User"

      fill_in 'Email', with: "test@test.com"
      fill_in 'Password', with: "test123"
      fill_in 'Password confirmation', with: "test123"
      click_on "commit"

      expect(page).to have_content "User with email test@test.com successfully created."

      click_on "Show"
      expect(page).to have_content "Details"
      expect(page).to have_content "test@test.com"
    end

    it "should be able to edit user's details " do 
      login_as(FactoryBot.create(:user, role: "admin"))
      visit admin_users_path

      click_on "Create User"

      fill_in 'Email', with: "test@test.com"
      fill_in 'Password', with: "test123"
      fill_in 'Password confirmation', with: "test123"
      click_on "commit"

      expect(page).to have_content "User with email test@test.com successfully created."

      click_on "Edit"
      expect(page).to have_content "Edit User"
  
      fill_in 'Email', with: "new_test@test.com"
      Capybara.page.find('.edit-user-details-fortest').click
      expect(page).to have_content "Approved"
    end

    it "should be able to delete a user " do 
      login_as(FactoryBot.create(:user, role: "admin"))
      visit admin_users_path

      click_on "Create User"

      fill_in 'Email', with: "test@test.com"
      fill_in 'Password', with: "test123"
      fill_in 'Password confirmation', with: "test123"
      click_on "commit"

      expect(page).to have_content "User with email test@test.com successfully created."
      click_on "Delete"
      expect(page).to have_content "User test@test.com has been deleted."
    end

    it "should be able to show pending users" do 
      login_as(FactoryBot.create(:user, role: "admin"))
      visit admin_users_path

      click_on "Create User"

      fill_in 'Email', with: "test@test.com"
      fill_in 'Password', with: "test123"
      fill_in 'Password confirmation', with: "test123"
      click_on "commit"

      expect(page).to have_content "User with email test@test.com successfully created."
      click_on "Pending"
      expect(page).to have_content "test@test.com"
    end

    it "should show all transactions" do
      login_as(FactoryBot.create(:user, role: "admin"))

      visit admin_users_path
      click_on "Transactions"
      expect(page).to have_content "No Records Found..."
    end

    # it "should be able to edit the admin's password" do
    #   login_as(FactoryBot.create(:user, role: "admin"))

    #   visit admin_users_path
    #   Capybara.page.find('#header-user-icon').click
    #   visit edit_user_password_path
    #   expect(page).to have_content "Password confirmation"
    
end
