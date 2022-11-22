require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#email' do
    it "should create a new user with email address" do
      user =  FactoryBot.build(:user)
      expect(user.nil?).to be false
    end

    it "should raise an error when email is taken" do
      begin
        user =  FactoryBot.create(:user, email: "test33@test.com")
        user1 =  FactoryBot.create(:user, email: "test33@test.com")
        expect(user.nil?).to be false
      rescue ActiveRecord::RecordInvalid
        expect(user1.nil?).to be true
      end
    end
  end

  describe "#password" do
    it "must need to be matched with password_confirmation" do
      user =  FactoryBot.create(:user, password: "HelloWorld", password_confirmation: "HelloWorld")
      expect(user.nil?).to be false
    end
    
    it "should raise an error if password is not matched with password_confirmation" do
      begin
        user =  FactoryBot.create(:user, password: "HelloWorld", password_confirmation: "HelloWorld!!!")
      rescue ActiveRecord::RecordInvalid
        expect(user.nil?).to be true
      end
    end
  end

  ["role", "account_status"].each do |value|
      describe "##{value}" do
      it "should initialize if #{value} has value" do
        user =  FactoryBot.create(:user, value => 1)
        expect(user.nil?).to be false
      end

      it "should raise an error if #{value} is nil" do
        begin
          user =  FactoryBot.create(:user, value => nil)
        rescue ActiveRecord::RecordInvalid
          expect(user.nil?).to be true
        end
      end
    end
  end
  

 
end
