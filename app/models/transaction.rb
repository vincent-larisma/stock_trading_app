class Transaction < ApplicationRecord
    belongs_to :stock

    validates :action_type, :company_name, :shares, :cost_price , presence: true
end
