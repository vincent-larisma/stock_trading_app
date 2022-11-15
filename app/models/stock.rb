class Stock < ApplicationRecord
    belongs_to :user
    has_many :transactions

    validates :symbol, :company_name, :shares, :cost_price , presence: true
end
