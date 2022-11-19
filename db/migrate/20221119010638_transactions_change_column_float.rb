class TransactionsChangeColumnFloat < ActiveRecord::Migration[6.1]
  def change
    change_column(:transactions, :cost_price, :float)
    change_column(:stocks, :cost_price, :float)
  end
end
