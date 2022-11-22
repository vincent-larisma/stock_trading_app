require 'rails_helper'

RSpec.describe Transaction, type: :model do

  ["action_type", "company_name", "shares", "cost_price"].each do |value|
    describe "##{value}" do
      it "should raise an error if there is no symbol or nil" do
        begin
          transaction = FactoryBot.create(:transaction, value => nil)
        rescue ActiveRecord::RecordInvalid
          expect(transaction.nil?).to be true
        end
      end
    end
  end
end
#   <--Before-->
#   describe "#action_type" do
#     it "should raise an error if there is no action_type or nil" do
#       begin
#         transaction = FactoryBot.create(:transaction, action_type: nil)
#       rescue ActiveRecord::RecordInvalid
#         expect(transaction.nil?).to be true
#       end
#     end
#   end

#   describe "#company_name" do
#     it "should raise an error if there is no company_name or nil" do
#       begin
#         transaction = FactoryBot.create(:transaction, company_name: nil)
#       rescue ActiveRecord::RecordInvalid
#         expect(transaction.nil?).to be true
#       end
#     end
#   end
  
  
#   describe "#shares" do
#     it "should raise an error if there is no shares or nil" do
#       begin
#         transaction = FactoryBot.create(:transaction, shares: nil)
#       rescue ActiveRecord::RecordInvalid
#         expect(transaction.nil?).to be true
#       end
#     end
#   end
  
  
#   describe "#cost_price" do
#     it "should raise an error if there is no cost_price or nil" do
#       begin
#         transaction = FactoryBot.create(:transaction, cost_price: nil)
#       rescue ActiveRecord::RecordInvalid
#         expect(transaction.nil?).to be true
#       end
#     end
#   end


