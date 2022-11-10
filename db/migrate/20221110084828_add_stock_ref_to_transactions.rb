class AddStockRefToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_reference :transactions, :stock, null: false, foreign_key: true
  end
end
