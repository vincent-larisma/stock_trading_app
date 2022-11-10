class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.string :type
      t.string :company_name
      t.string :shares
      t.integer :cost_price

      t.timestamps
    end
  end
end
