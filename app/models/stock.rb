class Stock < ApplicationRecord
    belongs_to :user
    has_many :transactions, dependent: :destroy

    validates :symbol, :company_name, :shares, :cost_price , presence: true
end
