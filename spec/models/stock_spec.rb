require 'rails_helper'

RSpec.describe Stock, type: :model do

  ["symbol", "company_name", "shares", "cost_price"].each do |value|
    describe "##{value}" do
      it "should raise an error if there is no symbol or nil" do
        begin
          stock = FactoryBot.create(:stock, value => nil)
        rescue ActiveRecord::RecordInvalid
          expect(stock.nil?).to be true
        end
      end
    end
  end
end


