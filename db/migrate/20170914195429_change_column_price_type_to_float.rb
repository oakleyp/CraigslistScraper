class ChangeColumnPriceTypeToFloat < ActiveRecord::Migration[5.1]
  def change
    change_column :listings, :price, :float
  end
end
