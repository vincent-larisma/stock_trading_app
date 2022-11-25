class Stock < ApplicationRecord
    belongs_to :user
    has_many :transactions, dependent: :destroy

    scope :shares_by, -> (symbol) { find_or_initialize_by(symbol: symbol).shares.to_f }
    scope :bought_stock, -> { where("shares > ?", 0).order(updated_at: :desc) }
    scope :previously_bought_stock, -> { where("shares = ?", 0).order(updated_at: :desc) }

    validates :symbol, :company_name, :shares, :cost_price , presence: true

end
