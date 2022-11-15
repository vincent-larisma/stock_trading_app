class RemoveStockFromTransactions < ActiveRecord::Migration[6.1]
  def change
    remove_reference :transactions, :stock, null: false, foreign_key: true
  end
end
