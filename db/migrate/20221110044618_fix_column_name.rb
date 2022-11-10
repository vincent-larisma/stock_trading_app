class FixColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :transactions, :type, :action_type
  end
end
