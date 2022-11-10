class Stock < ApplicationRecord
    has_many :transactions

    validates :symbol, :company_name, :shares, :cost_price , presence: true
end
