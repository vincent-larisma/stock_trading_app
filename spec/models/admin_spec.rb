require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe '#email' do
    it "should create a new user with email address" do
      user =  FactoryBot.build(:user, role: 1, account_status: 1)
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
end 
