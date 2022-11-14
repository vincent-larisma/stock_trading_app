class AddDefaultValueToShares < ActiveRecord::Migration[6.1]
  def change
    change_column_default :stocks, :shares , 0

  end
end
