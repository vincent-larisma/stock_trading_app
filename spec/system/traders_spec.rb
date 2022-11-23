require 'rails_helper'

RSpec.describe "Traders", type: :system do
  before do
    driven_by(:rack_test)
  end

  context "when trader account status automatically redirects to a different page" do

    it "should load to unapproved page when trader account status is pending" do
      login_as(FactoryBot.create(:user, account_status: 'pending'))
      visit root_path
      expect(page).to have_content "You are Yet to be Approved..."
    end

    it "should load to my portfolio when trader account status is approved" do
      login_as(FactoryBot.create(:user, account_status: 'approved'))
      visit root_path
      expect(page).to have_content "Owned Stocks"
    end
    
  end

  context "when trader account status is not approved" do
    before(:each) do
      login_as(FactoryBot.create(:user, account_status: 'pending'))
      visit root_path
    end

    it "should not be able to access my portfolio" do
      visit stocks_path
      expect(page).to have_content "You need to be approved to continue."
    end   
    
    it "should not be able to access transactions" do
      visit transactions_path
      expect(page).to have_content "You need to be approved to continue."
    end
  end

  context "when trader account status is approved" do
    before(:each) do
      @user = FactoryBot.create(:user, account_status: 'approved')
      login_as(@user)
      visit root_path
    end
    
    it "should be able to find, buy stocks and verify if transactions were made" do
      click_on "+ Buy Stock"
      
      fill_in 'Search Stock', with: "AMZN"
      click_on "Search"
      
      expect(page).to have_content "BUYING"
      fill_in 'input amount', with: "2002"
      click_on "Buy Amazon.com Inc."
      
      expect(page).to have_content "Amazon.com Inc."
      
      click_on "Transactions"
      
      expect(page).to have_content "Amazon.com Inc."
      expect(page).to have_content "2002"
      expect(page).to have_content "buy"
    end
    
    it "should not be able to access admin pages" do
      [admin_users_path, new_admin_user_path, edit_admin_user_path(User.first.id), admin_user_path(User.first.id), admin_pending_index_path, admin_transactions_path ].each do |value|
        visit value
        expect(page).to have_content "You need to be an admin to continue."
      end
    end

    it "should be able to access Transactions Page" do
      click_on "Transactions"

      expect(page).to have_content "Transactions"
      expect(page).to have_content "Date"
      expect(page).to have_content "Type"
    end
    
    context "when trader wants to edit profile" do
      
      it "should be able to edit profile email" do
        click_on "edit_profile"
        
        fill_in "user_email", with: "1"+@user.email
        fill_in "user_current_password", with: @user.password

        click_on "Update"

        expect(page).to have_content "Your account has been updated successfully."
      end

      it "should be able to edit profile password" do
        click_on "edit_profile"
        
        fill_in "user_password", with: "1"+@user.email
        fill_in "user_password_confirmation", with: "1"+@user.email
        fill_in "user_current_password", with: @user.password

        click_on "Update"

        expect(page).to have_content "Your account has been updated successfully."
      end

      it "should not be able to edit profile password when password does not match" do
        click_on "edit_profile"
        
        fill_in "user_password", with: "1"+@user.email
        fill_in "user_password_confirmation", with: "2"+@user.email
        fill_in "user_current_password", with: @user.password

        click_on "Update"

        expect(page).to have_content "Password confirmation doesn't match Password"
      end

      it "should not be able to edit profile password when password is too short" do
        click_on "edit_profile"
        
        fill_in "user_password", with: "123"
        fill_in "user_password_confirmation", with: "123"
        fill_in "user_current_password", with: @user.password

        click_on "Update"

        expect(page).to have_content "Password is too short (minimum is 6 characters)"
      end
      
      it "should not be able to edit profile password when password is too short" do
        click_on "edit_profile"
        
        fill_in "user_password", with: "1"+@user.email
        fill_in "user_password_confirmation", with: "1"+@user.email
        fill_in "user_current_password", with: "1231231"

        click_on "Update"

        expect(page).to have_content "Current password is invalid"
      end


    end

    context "when trader buys and sells existing stock" do
      before(:each) do
        click_on "+ Buy Stock"
      
        fill_in 'Search Stock', with: "AMZN"
        click_on "Search"

        expect(page).to have_content "BUYING"
        fill_in 'input amount', with: "2002"
        click_on "Buy Amazon.com Inc."
        
        expect(page).to have_content "Amazon.com Inc."
      end

      it "should be able to purchase existing stock and verify if transactions were made" do
        click_on(class: 'btn-outline-success')

        expect(page).to have_content "BUYING"
        fill_in 'input amount', with: "2002"
        click_on "Buy Amazon.com Inc."

        expect(page).to have_content "4004"

        click_on "Transactions"

        expect(page).to have_content "Amazon.com Inc."
        expect(page).to have_content "4004"
        expect(page).to have_content "buy"
      end

      it "should be able to sell existing stock, verify if transactions were made and check if stock has been displayed in Owned Stocks if stock becomes zero" do
        click_on(class: 'btn-outline-danger')

        expect(page).to have_content "SELLING"
        fill_in 'input amount', with: "2002"
        click_on "Sell Amazon.com Inc."

        expect(page).not_to have_content "AMZN"

        click_on "Transactions"

        expect(page).to have_content "Amazon.com Inc."
        expect(page).to have_content "0"
        expect(page).to have_content "sell"

        click_on "My Portfolio"
        
        expect(page.find(class:'btn-success').nil?).to be false
      end
    end
  end

end
